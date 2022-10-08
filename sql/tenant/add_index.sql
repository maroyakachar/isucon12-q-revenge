CREATE INDEX IF NOT EXISTS player_score_tenant_comp_idx ON player_score (tenant_id, competition_id);
CREATE INDEX IF NOT EXISTS player_score_player_idx ON player_score (player_id);
CREATE INDEX IF NOT EXISTS player_score_rank_idx ON player_score (competition_id, rank);
CREATE INDEX IF NOT EXISTS competition_tenant_idx ON competition (tenant_id, created_at DESC);
