-- 1-3) ����� ������� ������� � ����������� ����� created_at. � ��� ��������� ���������� ����������� ������
-- �� ������ 2018 ���� '2018-08-01', '2016-08-04', '2018-08-16' � 2018-08-17. ��������� ������, 
-- ������� ������� ������ ������ ��� �� ������, ��������� � �������� ���� �������� 1,
-- ���� ���� ������������ � �������� ������� � 0, ���� ��� �����������.


CREATE DATABASE IF NOT EXISTS homework_9_1_3;
USE homework_9_1_3;

CREATE TABLE IF NOT EXISTS dates_some(
	id SERIAL PRIMARY KEY,
	created_at DATE
);

CREATE TABLE IF NOT EXISTS dates_full(
	id SERIAL PRIMARY KEY,
	created_at DATE
);

INSERT INTO dates_some(created_at) VALUES
	('2018-08-01'),
	('2018-08-04'),
	('2018-08-16'),
	('2018-08-17');

DROP PROCEDURE IF EXISTS fill_dates;
DELIMITER |
CREATE PROCEDURE fill_dates()
	BEGIN
		DECLARE from_val INT;
		DECLARE to_val INT;
	
		SET from_val = 1;
		SET to_val = 31;
		
		WHILE from_val <= to_val DO
			INSERT INTO dates_full (created_at) VALUES (CONCAT('2018-08-', from_val));
			SET from_val = from_val + 1;
		END WHILE;
	END;
|
DELIMITER ;

CALL fill_dates();


-- Observe existing tables
SELECT * FROM dates_full;
SELECT * FROM dates_some;


-- Solution
CREATE VIEW dates_marked AS 
	SELECT
		dates_full.created_at AS the_date,
		if(dates_some.created_at IS NOT NULL, 1, 0) AS state
		FROM dates_full
		LEFT JOIN dates_some
		ON dates_some.created_at = dates_full.created_at;

SELECT * FROM dates_marked;


-- Cleanup
DROP DATABASE IF EXISTS homework_9_1_3;
DROP PROCEDURE IF EXISTS fill_dates;

