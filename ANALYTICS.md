# B1C3 Blog Analytics

This setup adds a privacy-first traffic counter to the static blog using:
- GitHub Pages for static delivery
- A Cloudflare Worker as the analytics API
- Cloudflare D1 for storage
- A tiny frontend script for pageview tracking and a visible read counter on post pages

## What It Tracks

The worker stores:
- `path`
- `title`
- `visited_at`
- `country`
- `referrer_host`
- `device_type`
- `visitor_hash` (salted hash of IP + user agent)
- `subnet_bucket` (coarse network grouping)

## Privacy Model

- Country comes from Cloudflare edge metadata. It does **not** require manual subnet extraction.
- Subnet buckets are stored only as coarse groupings for later aggregation and anti-abuse heuristics.
- Raw IPs are not written to the database.
- Visible UI is just a simple per-post read counter.

## Deploy Steps

### 1. Install Wrangler

```bash
npm install -g wrangler
```

### 2. Log in to Cloudflare

```bash
wrangler login
```

### 3. Create the D1 database

```bash
wrangler d1 create b1c3-blog-analytics
```

Copy the returned `database_id` into [analytics-worker/wrangler.toml](analytics-worker/wrangler.toml).

### 4. Apply the schema

```bash
wrangler d1 execute b1c3-blog-analytics --remote --file=analytics-worker/schema.sql
```

### 5. Set a real salt

Replace `ANALYTICS_SALT` in [analytics-worker/wrangler.toml](analytics-worker/wrangler.toml) with a long random string.

### 6. Deploy the worker

```bash
cd analytics-worker
wrangler deploy
```

After deploy, copy the worker URL, for example:
- `https://b1c3-blog-analytics.your-subdomain.workers.dev`

### 7. Enable tracking on the site

Edit [js/analytics-config.js](js/analytics-config.js):

```js
window.B1C3AnalyticsConfig = {
  enabled: true,
  endpoint: "https://your-real-worker-url.workers.dev"
};
```

Commit and push that config change.

## API Endpoints

### `POST /api/track`
Records a page view and returns updated counts.

Request body:

```json
{
  "path": "/B1C3-BLOG/posts/halla-hojd-the-cost-of-staying-current.html",
  "title": "Håll Höjd: The Cost of Staying Current | B1C3 Blog"
}
```

### `GET /api/count?path=...`
Returns counts for one page.

### `GET /api/top?limit=10`
Returns top pages by views.

## Frontend Behavior

- On every page load, the browser posts one analytics event to the worker.
- On post pages, the script injects a simple `Reads: N` counter under the publication date.
- The tooltip on the counter shows approximate unique visitors when available.

## Why Country Does Not Require Subnet Extraction

Cloudflare already provides country-level geolocation on the request object.
That means:
- Use `request.cf.country` for country metrics.
- Use subnet buckets only if you later want coarse network grouping or abuse heuristics.
- Do not store raw IPs unless you have a very strong reason.
