-- 1) —оставьте список пользователей users, которые осуществили хот€ бы один заказ orders в интернет магазине.

CREATE DATABASE IF NOT EXISTS homework_7_1;

USE homework_7_1;


-- Create tables
CREATE TABLE IF NOT EXISTS users(
	id SERIAL PRIMARY KEY,
	firstname VARCHAR(255),
	lastname VARCHAR(255),
	email VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS products(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	price DECIMAL(10, 2),
	quantity BIGINT
);

CREATE TABLE IF NOT EXISTS orders(
	id SERIAL PRIMARY KEY,
	client_id BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (client_id) REFERENCES users(id)
);


CREATE TABLE IF NOT EXISTS ordered_products(
	order_id BIGINT UNSIGNED NOT NULL,
	product_id BIGINT UNSIGNED NOT NULL,
	quantity BIGINT DEFAULT 1,
	
	FOREIGN KEY (order_id) REFERENCES orders(id),
	FOREIGN KEY (product_id) REFERENCES products(id)
);


-- Fill tables with some random data
INSERT INTO users (firstname, lastname, email) VALUES
	('Vasiliy', 'Pupkin', 'Vasiliy.Pupkin@gmail.com'),
	('Fedor', 'Bubkin', 'Fedor.Bubkin@mail.ru'),
	('Ivan', 'Petrov', 'Ivan.Petrov@gmail.com'),
	('Petr', 'Ivanov', 'Petr.Ivanov@yandex.com');

INSERT INTO products (name, price, quantity) VALUES
	('Rice', 35.50, 1000),
	('Milk', 29.14, 2000),
	('Eggs', 22.60, 20000);

INSERT INTO orders (client_id) VALUES
	(1),
	(1),
	(3),
	(3),
	(3),
	(3),
	(4);

INSERT INTO ordered_products(order_id, product_id, quantity) VALUES
	(1, 2, 10),
	(1, 3, 10),
	(2, 1, 20),
	(2, 2, 20),
	(3, 1, 10),
	(4, 3, 40),
	(5, 2, 20),
	(5, 3, 30),
	(6, 1, 10),
	(7, 2, 20);


-- Solution
SELECT DISTINCT
	(SELECT CONCAT(lastname, ',', firstname) FROM users WHERE id = orders.client_id) AS username , 
	COUNT(*) AS total_orders
	FROM orders 
	GROUP BY client_id
	ORDER BY total_orders;


-- Cleanup
DROP DATABASE IF EXISTS homework_7_1;


