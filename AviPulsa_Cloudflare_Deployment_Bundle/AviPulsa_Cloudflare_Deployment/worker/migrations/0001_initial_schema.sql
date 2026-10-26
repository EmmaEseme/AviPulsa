-- Preparation only: not used by the current browser-only frontend.
-- Do not treat this schema as production-ready until authentication,
-- authorization, append-only audit enforcement, validation and backup policy exist.
CREATE TABLE IF NOT EXISTS farms (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS flock_records (
  id TEXT PRIMARY KEY,
  farm_id TEXT NOT NULL,
  flock_id TEXT NOT NULL,
  record_date TEXT NOT NULL,
  payload_json TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (farm_id, flock_id, record_date),
  FOREIGN KEY (farm_id) REFERENCES farms(id)
);

CREATE TABLE IF NOT EXISTS audit_events (
  id TEXT PRIMARY KEY,
  farm_id TEXT NOT NULL,
  record_id TEXT,
  event_type TEXT NOT NULL,
  operator_id TEXT,
  device_id TEXT,
  reason TEXT,
  previous_value_json TEXT,
  new_value_json TEXT,
  occurred_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);
