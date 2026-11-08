-- Run once in the D1 console BEFORE deploying the matching code.
ALTER TABLE entries ADD COLUMN category TEXT NOT NULL DEFAULT '';
CREATE TABLE IF NOT EXISTS loans (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  total REAL NOT NULL CHECK(total > 0),
  paid REAL NOT NULL DEFAULT 0 CHECK(paid >= 0),
  monthly REAL NOT NULL DEFAULT 0 CHECK(monthly >= 0),
  currency TEXT NOT NULL CHECK(currency IN ('EUR','BGN')),
  date TEXT NOT NULL DEFAULT '',
  note TEXT NOT NULL DEFAULT '',
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_loans_user ON loans(user_id, created_at DESC);
