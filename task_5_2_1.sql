CREATE DATABASE IF NOT EXISTS homework_5_2_1;

USE homework_5_2_1;

-- Cleanup database
DROP TABLE IF EXISTS users;

CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(255),
	last_name VARCHAR(255), 
	day_of_birth DATE
);

INSERT INTO users (first_name, last_name, day_of_birth) VALUES
	('Jorik', 'Lastochkin', STR_TO_DATE('13-02-1992', '%d-%m-%Y')),
	('Mikola', 'Piterskyi', STR_TO_DATE('29-12-2001', '%d-%m-%Y')),
	('Vahtang', 'Marmeladze', STR_TO_DATE('07-09-2013', '%d-%m-%Y')),
	('Abumba', 'Mbwanbe', STR_TO_DATE('10-03-2013', '%d-%m-%Y')),
	('Michaela', 'N\'anzo', STR_TO_DATE('09-08-2022', '%d-%m-%Y')),
	('Yoshiro', 'Kakayama', STR_TO_DATE('10-05-2013', '%d-%m-%Y')),
	('Lee', 'Wong', STR_TO_DATE('09-08-2019', '%d-%m-%Y'));

-- Full result
SELECT 
	CONCAT(last_name, ', ', first_name) AS full_name, 
	DATE_FORMAT(day_of_birth, '%M, %d %Y') AS birthday 
FROM users;

-- Calculate average age
SELECT
	CONCAT(
		ROUND(AVG(YEAR(NOW()) - YEAR(day_of_birth))),
		' year(s)'
	) AS average_age 
FROM users;


-- Cleanup
DROP DATABASE IF EXISTS homework_5_2_1;

