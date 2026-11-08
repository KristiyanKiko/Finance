-- Run once in the D1 console (after 0002) BEFORE deploying the matching code.
CREATE TABLE IF NOT EXISTS loan_payments (
  id TEXT PRIMARY KEY,
  loan_id TEXT NOT NULL REFERENCES loans(id) ON DELETE CASCADE,
  user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  amount REAL NOT NULL CHECK(amount > 0),
  date TEXT NOT NULL,
  note TEXT NOT NULL DEFAULT '',
  created_at INTEGER NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_loan_payments_loan ON loan_payments(loan_id, date DESC);
