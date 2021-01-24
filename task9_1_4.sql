-- 1-4) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет
-- устаревшие записи из таблицы, оставляя только 5 самых свежих записей.


CREATE DATABASE IF NOT EXISTS homework_9_1_4;
USE homework_9_1_4;


-- Create & fill table
CREATE TABLE IF NOT EXISTS some_table(
	id SERIAL PRIMARY KEY,
	created_at DATE
);

DROP PROCEDURE IF EXISTS fill_dates;
DELIMITER |
CREATE PROCEDURE fill_dates()
	BEGIN
		DECLARE from_val INT;
		DECLARE to_val INT;
	
		SET from_val = 1;
		SET to_val = 31;
		
		WHILE from_val <= to_val DO
			INSERT INTO some_table (created_at) VALUES (CONCAT('2020-12-', from_val));
			SET from_val = from_val + 1;
		END WHILE;
	END;
|
DELIMITER ;

CALL fill_dates();

CREATE VIEW recent_items AS SELECT
	some_table.id AS row_id,
	some_table.created_at AS the_date
	FROM some_table
	ORDER BY some_table.created_at DESC
	LIMIT 5;


-- Check initial states
SELECT * FROM some_table;
SELECT * FROM recent_items;


-- Solution
START TRANSACTION;

DELETE some_table
	FROM some_table 
	LEFT JOIN recent_items ON some_table.id = recent_items.row_id
	WHERE recent_items.row_id IS NULL;

COMMIT;

SELECT * FROM some_table AS after_delete;


-- Cleanup
DROP DATABASE IF EXISTS homework_9_1_4;
DROP PROCEDURE IF EXISTS fill_dates;
