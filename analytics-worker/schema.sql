CREATE TABLE IF NOT EXISTS page_views (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  path TEXT NOT NULL,
  title TEXT NOT NULL,
  visited_at INTEGER NOT NULL,
  country TEXT NOT NULL,
  referrer_host TEXT NOT NULL,
  device_type TEXT NOT NULL,
  visitor_hash TEXT NOT NULL,
  subnet_bucket TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_page_views_path_time ON page_views(path, visited_at DESC);
CREATE INDEX IF NOT EXISTS idx_page_views_country ON page_views(country);
CREATE INDEX IF NOT EXISTS idx_page_views_referrer ON page_views(referrer_host);

CREATE TABLE IF NOT EXISTS page_visitors (
  path TEXT NOT NULL,
  visitor_hash TEXT NOT NULL,
  first_seen INTEGER NOT NULL,
  PRIMARY KEY (path, visitor_hash)
);

CREATE TABLE IF NOT EXISTS page_totals (
  path TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  total_views INTEGER NOT NULL DEFAULT 0,
  unique_visitors INTEGER NOT NULL DEFAULT 0,
  updated_at INTEGER NOT NULL
);

-- AI crawler traffic: counted separately, not mixed into human totals
CREATE TABLE IF NOT EXISTS ai_visits (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  path TEXT NOT NULL,
  title TEXT NOT NULL,
  visited_at INTEGER NOT NULL,
  country TEXT NOT NULL,
  user_agent_hint TEXT NOT NULL,
  subnet_bucket TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_ai_visits_path_time ON ai_visits(path, visited_at DESC);
CREATE INDEX IF NOT EXISTS idx_ai_visits_country ON ai_visits(country);

CREATE TABLE IF NOT EXISTS ai_totals (
  path TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  total_visits INTEGER NOT NULL DEFAULT 0,
  updated_at INTEGER NOT NULL
);
