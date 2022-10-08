DROP TABLE IF EXISTS competition;
DROP TABLE IF EXISTS player;
DROP TABLE IF EXISTS player_score;
DROP TABLE IF EXISTS billing_report;

CREATE TABLE competition (
  id VARCHAR(255) NOT NULL PRIMARY KEY,
  tenant_id BIGINT NOT NULL,
  title TEXT NOT NULL,
  finished_at BIGINT NULL,
  created_at BIGINT NOT NULL,
  updated_at BIGINT NOT NULL
);

CREATE TABLE player (
  id VARCHAR(255) NOT NULL PRIMARY KEY,
  tenant_id BIGINT NOT NULL,
  display_name TEXT NOT NULL,
  is_disqualified BOOLEAN NOT NULL,
  created_at BIGINT NOT NULL,
  updated_at BIGINT NOT NULL
);

CREATE TABLE player_score (
  id VARCHAR(255) NOT NULL PRIMARY KEY,
  tenant_id BIGINT NOT NULL,
  player_id VARCHAR(255) NOT NULL,
  competition_id VARCHAR(255) NOT NULL,
  score BIGINT NOT NULL,
  row_num BIGINT NOT NULL,
  created_at BIGINT NOT NULL,
  updated_at BIGINT NOT NULL,
  rank BIGINT NOT NULL DEFAULT 0
);

CREATE TABLE billing_report (
  competition_id VARCHAR(255) NOT NULL,
  competition_title VARCHAR(255) NOT NULL,
  player_count BIGINT UNSIGNED NOT NULL,
  visitor_count BIGINT UNSIGNED NOT NULL,
  billing_player_yen BIGINT UNSIGNED NOT NULL,
  billing_visitor_yen BIGINT UNSIGNED NOT NULL,
  created_at BIGINT NOT NULL,
  updated_at BIGINT NOT NULL,
);

CREATE INDEX IF NOT EXISTS player_score_tenant_comp_idx ON player_score (tenant_id, competition_id);
CREATE INDEX IF NOT EXISTS player_score_player_idx ON player_score (player_id);
CREATE INDEX IF NOT EXISTS player_score_rank_idx ON player_score (competition_id, rank);
CREATE INDEX IF NOT EXISTS competition_tenant_idx ON competition (tenant_id, created_at DESC);
