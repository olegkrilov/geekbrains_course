CREATE DATABASE IF NOT EXISTS homework_5_1_1;

USE homework_5_1_1;

-- Cleanup database
DROP TABLE IF EXISTS users;

-- Create table 'users' and fill oit with some values without DATE fields
CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	created_at DATE DEFAULT NULL,
	updated_at DATE DEFAULT NULL
);

INSERT INTO users (first_name, last_name) VALUES
	('Jorik', 'Lastochkin'),
	('Mikola', 'Piterskyi'),
	('Vahatang', 'Marmeladze');

-- Show current results
SELECT * FROM users;

-- Solution itself
UPDATE users SET 
	created_at=NOW(), 
	updated_at=NOW();

-- Check update result
SELECT * FROM users;
	

-- Cleanup
DROP DATABASE IF EXISTS homework_5_1_1;
