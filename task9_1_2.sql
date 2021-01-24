-- 1-2) Создайте представление, которое выводит название name товарной позиции из таблицы
-- products и соответствующее название каталога name из таблицы catalogs.

CREATE DATABASE IF NOT EXISTS homework_9_1_2;

USE homework_9_1_2;

-- Create required tables
CREATE TABLE IF NOT EXISTS catalogs(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	description VARCHAR(255) DEFAULT '-'
);


CREATE TABLE IF NOT EXISTS products(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	quantity BIGINT DEFAULT 1,
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


-- Create required view
CREATE VIEW shop_offers (
	product_id,
	product_name,
	product_type,
	qty
) AS SELECT 
	products.id AS product_id,
	products.name AS product_name,
	catalogs.name AS product_type,
	products.quantity AS qty
	FROM products
	JOIN catalogs
	ON products.type_id = catalogs.id
	ORDER BY catalogs.id, products.id;

SELECT * FROM shop_offers;


-- Cleanup
DROP DATABASE IF EXISTS homework_9_1_2;
