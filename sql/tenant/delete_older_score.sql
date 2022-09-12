CREATE INDEX player_score_idx ON player_score (competition_id, player_id, row_num);
DELETE FROM player_score AS t1
WHERE row_num <> (SELECT MAX(row_num) FROM player_score AS t2 WHERE t1.competition_id = t2.competition_id AND t1.player_id = t2.player_id);
