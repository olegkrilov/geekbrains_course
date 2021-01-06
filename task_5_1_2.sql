CREATE DATABASE IF NOT EXISTS homework_5_1_2;

USE homework_5_1_2;

-- Cleanup database
DROP TABLE IF EXISTS users;

-- Create table 'users' and fill it with some values with broken date columns
CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	created_at VARCHAR(255),
	updated_at VARCHAR(255)
);

INSERT INTO users (first_name, last_name, created_at, updated_at) VALUES
	('Jorik', 'Lastochkin', '13-02-1992', '01-01-2001'),
	('Mikola', 'Piterskyi', '29-12-2001', '10-03-2013'),
	('Vahtang', 'Marmeladze', '07-09-2013', '09-07-2022');

SELECT * FROM users;

-- Update table & change 
ALTER TABLE users 
	RENAME COLUMN created_at TO created_at_str,
	RENAME COLUMN updated_at TO updated_at_str,
	ADD COLUMN created_at DATE,
	ADD COLUMN updated_at DATE;

UPDATE users SET 
	created_at=STR_TO_DATE(created_at_str, '%d-%m-%Y'),
	updated_at=STR_TO_DATE(updated_at_str, '%d-%m-%Y');
	
ALTER TABLE users 
	DROP COLUMN created_at_str,
	DROP COLUMN updated_at_str;

-- Check results
SELECT * FROM users;


-- Cleanup
DROP DATABASE IF EXISTS homework_5_1_2;



