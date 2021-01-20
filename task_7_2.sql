-- 2) Выведите список товаров products и разделов catalogs, который соответствует товару.

CREATE DATABASE IF NOT EXISTS homework_7_2;

USE homework_7_2;


-- Create tables
CREATE TABLE IF NOT EXISTS catalogs(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	description VARCHAR(255) DEFAULT '-'
);

CREATE TABLE IF NOT EXISTS products(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	quantity BIGINT DEFAULT 0,
	type_id BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (type_id) REFERENCES catalogs(id)
);


-- Fill tables with data
INSERT INTO catalogs(name, description) VALUES
	('Grocery', 'Dry food'),
	('Buthcery', 'Meat'),
	('Seafood', 'Fish, squids, shrimps etc.');

INSERT INTO products(name, quantity, type_id) VALUES
	('Tea', 1000, 1),
	('Veal', 100, 2),
	('Shark meat', 30, 3),
	('Pork', 200, 2),
	('Pepper', 30, 1),
	('Coffee', 500, 1),
	('Sea bass', 50, 3);


-- Solution
SELECT 
	id, 
	name,
	(SELECT CONCAT(name, ' (', description, ')') FROM catalogs WHERE id = products.type_id) AS pr_type,
	quantity AS qty
	FROM products
	ORDER BY type_id, quantity;


-- Cleanup
DROP DATABASE IF EXISTS homework_7_2;

	

