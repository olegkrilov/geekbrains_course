CREATE DATABASE IF NOT EXISTS homework_5_1_3;

USE homework_5_1_3;

-- Cleanup database
DROP TABLE IF EXISTS storehouses_products;

-- Create storage table and fill it with some random values
CREATE TABLE storehouses_products(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	value BIGINT DEFAULT 0
);

INSERT INTO storehouses_products (name, value) VALUES
	('Rice', 0),
	('Buckwheat', 1000),
	('Millet', 956),
	('Oat', 200),
	('Rye', 359),
	('Soya', 0);


-- Unsorted selection
SELECT name, value FROM storehouses_products;

-- Sorted selection
SELECT name, value FROM storehouses_products ORDER BY (value = 0), value;


-- Cleanup
DROP DATABASE IF EXISTS homework_5_1_3;

