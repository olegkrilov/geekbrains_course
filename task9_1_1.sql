-- 1-1) В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.


-- Build testable infrastrucutre
CREATE DATABASE IF NOT EXISTS shop;
CREATE DATABASE IF NOT EXISTS sample;
SET @user_id = 1;


CREATE TABLE IF NOT EXISTS shop.users(
	id SERIAL PRIMARY KEY,
	firstname VARCHAR(255),
	lastname VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS sample.users(
	id SERIAL PRIMARY KEY,
	firstname VARCHAR(255),
	lastname VARCHAR(255)
);

INSERT 
	INTO shop.users (firstname, lastname) 
	VALUES ('Vasiliy', 'Pupkin');

SELECT 
	CONCAT('First check that user exists in DB "shop"') AS Info,
	CONCAT(firstname, ', ', lastname) AS User
	FROM shop.users 
	WHERE id = @user_id;


-- Migrate data with using transactions
START TRANSACTION;

SELECT
	CONCAT('Save transfering data to the variables.') AS Info,
	@firstname := shop.users.firstname AS firstname,
	@lastname := shop.users.lastname
	FROM shop.users 
	WHERE id = @user_id;

INSERT 
	INTO sample.users (firstname, lastname) 
	VALUES (@firstname, @lastname);

DELETE 
	FROM shop.users 
	WHERE id = @user_id;

COMMIT;


-- Now check results
SELECT 
	CONCAT('Check that user removed from DB "shop"') AS Info,
	CONCAT(firstname, ', ', lastname) AS User
	FROM shop.users 
	WHERE id = @user_id;

SELECT 
	CONCAT('Check that user were added into DB "sample"') AS Info,
	CONCAT(firstname, ', ', lastname) AS User
	FROM shop.users 
	WHERE firstname = @firstname AND lastname = @lastname ;


-- Cleanup
DROP DATABASE IF EXISTS shop;
DROP DATABASE IF EXISTS sample;


