CREATE DATABASE IF NOT EXISTS homework_5_1_5;

USE homework_5_1_5;

-- Cleanup database
DROP TABLE IF EXISTS catalogs;

CREATE TABLE catalogs(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	value INT
);

INSERT INTO catalogs (name, value) VALUES
	('AAZ', 1),
	('BCA', 4),
	('QWR', 3),
	('MNB', 5),
	('OPL', 8),
	('GHJ', 2),
	('TYB', 7),
	('CVN', 3),
	('ERY', 5);

-- Show full table
SELECT name, value FROM catalogs ORDER BY value;

-- Show calculated value
SELECT ROUND(EXP(SUM(LOG(value)))) AS multiplied_value from catalogs;


-- Cleanup
DROP DATABASE IF EXISTS homework_5_2_3;


