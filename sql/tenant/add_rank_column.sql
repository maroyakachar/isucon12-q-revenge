ALTER TABLE player_score ADD COLUMN rank BIGINT NOT NULL DEFAULT 0;

CREATE TEMP TABLE player_score_rank (
	id VARCHAR(255) NOT NULL PRIMARY KEY,
	rank BIGINT NOT NULL DEFAULT 0
);

INSERT INTO player_score_rank (id, rank)
SELECT id, RANK () OVER (PARTITION BY competition_id ORDER BY score DESC, row_num ASC)
FROM player_score;

UPDATE player_score
SET rank = (SELECT rank FROM player_score_rank WHERE player_score.id = player_score_rank.id);

DROP TABLE player_score_rank;
