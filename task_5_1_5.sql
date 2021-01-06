CREATE DATABASE IF NOT EXISTS homework_5_1_5;

USE homework_5_1_5;

-- Cleanup database
DROP TABLE IF EXISTS catalogs;

CREATE TABLE catalogs(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255)
);

INSERT INTO catalogs (name) VALUES
	('AAZ'),
	('BCA'),
	('QWR'),
	('MNB'),
	('OPL'),
	('GHJ'),
	('TYB'),
	('CVN'),
	('ERY');
	
-- Check insertion result
SELECT * FROM catalogs;

-- Check filtered & sorted result
SELECT * FROM catalogs 
WHERE id IN (5, 1, 2)
ORDER BY FIELD(id, 5, 1, 2);


-- Cleanup
DROP DATABASE IF EXISTS homework_5_1_5;


