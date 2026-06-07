const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
  "Access-Control-Allow-Headers": "Content-Type"
};

export default {
  async fetch(request, env) {
    if (request.method === "OPTIONS") {
      return new Response(null, { headers: corsHeaders });
    }

    const url = new URL(request.url);

    if (request.method === "POST" && url.pathname === "/api/track") {
      return trackPageView(request, env);
    }

    if (request.method === "GET" && url.pathname === "/api/count") {
      return getPageCount(url, env);
    }

    if (request.method === "GET" && url.pathname === "/api/top") {
      return getTopPages(url, env);
    }

    return json({ ok: false, error: "Not found" }, 404);
  }
};

async function trackPageView(request, env) {
  if (!env.ANALYTICS_DB) {
    return json({ ok: false, error: "Missing ANALYTICS_DB binding" }, 500);
  }

  let body;
  try {
    body = await request.json();
  } catch {
    return json({ ok: false, error: "Invalid JSON body" }, 400);
  }

  const path = normalizePath(body.path);
  const title = typeof body.title === "string" ? body.title.slice(0, 255) : path;
  const now = Date.now();
  const country = request.cf && request.cf.country ? request.cf.country : "ZZ";
  const referrerHost = getReferrerHost(request.headers.get("referer"));
  const userAgent = request.headers.get("user-agent") || "";
  const deviceType = getDeviceType(userAgent);
  const ipAddress = getIpAddress(request.headers);
  const salt = env.ANALYTICS_SALT || "local-dev-salt";
  const visitorHash = await sha256Hex(ipAddress + "|" + userAgent + "|" + salt);
  const subnetBucket = getSubnetBucket(ipAddress);

  const visitorInsert = await env.ANALYTICS_DB.prepare(
    "INSERT OR IGNORE INTO page_visitors (path, visitor_hash, first_seen) VALUES (?, ?, ?)"
  ).bind(path, visitorHash, now).run();

  const isNewVisitor = Boolean(visitorInsert.meta && visitorInsert.meta.changes > 0);

  await env.ANALYTICS_DB.prepare(
    "INSERT INTO page_views (path, title, visited_at, country, referrer_host, device_type, visitor_hash, subnet_bucket) VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
  ).bind(path, title, now, country, referrerHost, deviceType, visitorHash, subnetBucket).run();

  await env.ANALYTICS_DB.prepare(
    "INSERT INTO page_totals (path, title, total_views, unique_visitors, updated_at) VALUES (?, ?, 1, ?, ?) " +
      "ON CONFLICT(path) DO UPDATE SET title = excluded.title, total_views = page_totals.total_views + 1, unique_visitors = page_totals.unique_visitors + excluded.unique_visitors, updated_at = excluded.updated_at"
  ).bind(path, title, isNewVisitor ? 1 : 0, now).run();

  const totals = await env.ANALYTICS_DB.prepare(
    "SELECT path, title, total_views AS totalViews, unique_visitors AS uniqueVisitors, updated_at AS updatedAt FROM page_totals WHERE path = ?"
  ).bind(path).first();

  return json({ ok: true, path, country, totalViews: totals.totalViews || 0, uniqueVisitors: totals.uniqueVisitors || 0, updatedAt: totals.updatedAt || now });
}

async function getPageCount(url, env) {
  const path = normalizePath(url.searchParams.get("path") || "/");
  const totals = await env.ANALYTICS_DB.prepare(
    "SELECT path, title, total_views AS totalViews, unique_visitors AS uniqueVisitors, updated_at AS updatedAt FROM page_totals WHERE path = ?"
  ).bind(path).first();

  return json({
    ok: true,
    path,
    totalViews: totals ? totals.totalViews : 0,
    uniqueVisitors: totals ? totals.uniqueVisitors : 0,
    updatedAt: totals ? totals.updatedAt : null
  });
}

async function getTopPages(url, env) {
  const limit = Math.min(Math.max(Number(url.searchParams.get("limit") || 10), 1), 50);
  const results = await env.ANALYTICS_DB.prepare(
    "SELECT path, title, total_views AS totalViews, unique_visitors AS uniqueVisitors, updated_at AS updatedAt FROM page_totals ORDER BY total_views DESC LIMIT ?"
  ).bind(limit).all();

  return json({ ok: true, pages: results.results || [] });
}

function normalizePath(path) {
  if (typeof path !== "string" || path.length === 0) {
    return "/";
  }

  let normalized = path.trim();
  normalized = normalized.replace(/\/index\.html$/, "/");
  normalized = normalized.replace(/\/+/g, "/");

  if (!normalized.startsWith("/")) {
    normalized = "/" + normalized;
  }

  if (normalized.length > 1 && normalized.endsWith("/")) {
    normalized = normalized.slice(0, -1);
  }

  return normalized || "/";
}

function getReferrerHost(referrer) {
  if (!referrer) {
    return "direct";
  }

  try {
    return new URL(referrer).hostname || "direct";
  } catch {
    return "direct";
  }
}

function getDeviceType(userAgent) {
  const ua = userAgent.toLowerCase();
  if (ua.includes("bot") || ua.includes("spider") || ua.includes("crawl")) {
    return "bot";
  }
  if (ua.includes("tablet") || ua.includes("ipad")) {
    return "tablet";
  }
  if (ua.includes("mobi") || ua.includes("iphone") || ua.includes("android")) {
    return "mobile";
  }
  return "desktop";
}

function getIpAddress(headers) {
  const forwarded = headers.get("cf-connecting-ip") || headers.get("x-forwarded-for") || "unknown";
  return forwarded.split(",")[0].trim();
}

function getSubnetBucket(ipAddress) {
  if (/^\d+\.\d+\.\d+\.\d+$/.test(ipAddress)) {
    const parts = ipAddress.split(".");
    return parts.slice(0, 3).join(".") + ".0/24";
  }

  if (ipAddress.includes(":")) {
    const parts = ipAddress.split(":").filter(Boolean);
    return parts.slice(0, 4).join(":") + "::/64";
  }

  return "unknown";
}

async function sha256Hex(input) {
  const data = new TextEncoder().encode(input);
  const digest = await crypto.subtle.digest("SHA-256", data);
  return Array.from(new Uint8Array(digest))
    .map((value) => value.toString(16).padStart(2, "0"))
    .join("");
}

function json(payload, status = 200) {
  return new Response(JSON.stringify(payload, null, 2), {
    status,
    headers: {
      "Content-Type": "application/json; charset=utf-8",
      ...corsHeaders
    }
  });
}
