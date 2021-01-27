-- 12_1_1) —оздайте таблицу logs типа Archive. ѕусть при каждом создании записи в таблицах users, catalogs
-- и products в таблицу logs помещаетс€ врем€ и дата создани€ записи, название таблицы, идентификатор 
-- первичного ключа и содержимое пол€ name.

CREATE DATABASE IF NOT EXISTS homework_11_1_1;
USE homework_11_1_1;

-- Create tables
CREATE TABLE IF NOT EXISTS users(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS catalogs(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	description VARCHAR(255) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS products(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	description VARCHAR(255) DEFAULT NULL,
	type_id BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (type_id) REFERENCES catalogs(id)
);

CREATE TABLE IF NOT EXISTS logs(
	item_id BIGINT UNSIGNED NOT NULL,	
	added_at DATETIME NOT NULL,
	table_name CHAR(20),
	name VARCHAR(255) NOT NULL
) ENGINE=ARCHIVE;


-- Create Insertion Procedure
DROP PROCEDURE IF EXISTS register_log;
DELIMITER $$
CREATE PROCEDURE register_log(
	item_id BIGINT,	
	added_at DATETIME,
	table_name CHAR(20),
	name VARCHAR(255)
)
	BEGIN
		INSERT INTO logs (item_id, added_at, table_name, name) 
			VALUES (item_id, added_at, table_name, name);
	END;

$$
DELIMITER ;


-- Create Triggers
DROP TRIGGER IF EXISTS on_users_insert;
DELIMITER $$
CREATE TRIGGER on_users_insert AFTER INSERT ON users
FOR EACH ROW
	BEGIN
		CALL register_log(LAST_INSERT_ID(), NOW(), 'users', NEW.name);
	END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS on_catalogs_insert;
DELIMITER $$
CREATE TRIGGER on_catalogs_insert AFTER INSERT ON catalogs
FOR EACH ROW
	BEGIN
		CALL register_log(LAST_INSERT_ID(), NOW(), 'catalogs', NEW.name);
	END;
$$
DELIMITER ;

DROP TRIGGER IF EXISTS on_products_insert;
DELIMITER $$
CREATE TRIGGER on_products_insert AFTER INSERT ON products
FOR EACH ROW
	BEGIN
		CALL register_log(LAST_INSERT_ID(), NOW(), 'products', NEW.name);
	END;
$$
DELIMITER ;


-- Test Triggers
INSERT INTO users (name) VALUES ('Vasiliy Pupkin');
INSERT INTO catalogs (name, description) VALUES ('Brand New Category', 'This is the category');
INSERT INTO products (name, description, type_id) VALUES ('Awesome Product', 'The Awesome Product', 1);
 

SELECT * FROM users;
SELECT * FROM catalogs;
SELECT * FROM products;
SELECT * FROM logs;



-- Cleanup 
DROP PROCEDURE IF EXISTS register_log;
DROP TRIGGER IF EXISTS on_users_insert;
DROP TRIGGER IF EXISTS on_catalogs_insert;
DROP TRIGGER IF EXISTS on_products_insert;
DROP DATABASE IF EXISTS homework_11_1_1;