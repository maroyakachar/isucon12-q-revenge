DELETE FROM tenant WHERE id > 100;
DELETE FROM simple_visit_history WHERE created_at >= '1654041600';
TRUNCATE billing_report;
UPDATE id_generator SET id=2678400000 WHERE stub='a';
ALTER TABLE id_generator AUTO_INCREMENT=2678400000;
