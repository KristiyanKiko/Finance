-- WARNING: deletes ALL data (users, sessions, entries, loans, payments) and
-- recreates the complete current schema in one go. Replaces 0001 + 0002 + 0003.
-- Export your CSV first. Afterwards, register the first profile again.
DROP TABLE IF EXISTS loan_payments;
DROP TABLE IF EXISTS loans;
DROP TABLE IF EXISTS entries;
DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id TEXT PRIMARY KEY,
  username TEXT NOT NULL UNIQUE COLLATE NOCASE,
  password_salt TEXT NOT NULL,
  password_hash TEXT NOT NULL,
  created_at INTEGER NOT NULL
);
CREATE TABLE sessions (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  token_hash TEXT NOT NULL UNIQUE,
  expires_at INTEGER NOT NULL
);
CREATE INDEX idx_sessions_token_expiry ON sessions(token_hash, expires_at);
CREATE TABLE entries (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  kind TEXT NOT NULL CHECK(kind IN ('in','out')),
  amount REAL NOT NULL CHECK(amount > 0),
  currency TEXT NOT NULL CHECK(currency IN ('EUR','BGN')),
  date TEXT NOT NULL,
  note TEXT NOT NULL DEFAULT '',
  category TEXT NOT NULL DEFAULT '',
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);
CREATE INDEX idx_entries_user_date ON entries(user_id, date DESC);
CREATE TABLE loans (
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
CREATE INDEX idx_loans_user ON loans(user_id, created_at DESC);
CREATE TABLE loan_payments (
  id TEXT PRIMARY KEY,
  loan_id TEXT NOT NULL REFERENCES loans(id) ON DELETE CASCADE,
  user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  amount REAL NOT NULL CHECK(amount > 0),
  date TEXT NOT NULL,
  note TEXT NOT NULL DEFAULT '',
  created_at INTEGER NOT NULL
);
CREATE INDEX idx_loan_payments_loan ON loan_payments(loan_id, date DESC);
