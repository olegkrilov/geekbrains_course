-- 3. Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.


CREATE DATABASE IF NOT EXISTS homework_7_3;

USE homework_7_3;


-- Create tables
CREATE TABLE IF NOT EXISTS cities(
	label VARCHAR(255),
	name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS flights(
	id SERIAL PRIMARY KEY,
	going_from VARCHAR(255),
	going_to VARCHAR(255)
);


-- Fill tables
INSERT INTO cities (label, name) VALUES
	('Moscow', 'Москва'),
	('Krasnodar', 'Краснодар'),
	('Perm', 'Пермь'),
	('Ekaterinburg', 'Екатеринбург'),
	('Irkutsk', 'Иркутск'),
	('Ukhta', 'Ухта'),
	('Saint-Petersburg', 'Санкт-Петербург');

INSERT INTO flights (going_from, going_to) VALUES
	('Moscow', 'Saint-Petersburg'),
	('Moscow', 'Krasnodar'),
	('Krasnodar', 'Irkutsk'),
	('Perm', 'Moscow'),
	('Ekaterinburg', 'Saint-Petersburg'),
	('Irkutsk', 'Ukhta'),
	('Ukhta', 'Perm'),
	('Saint-Petersburg', 'Moscow');


-- Solution
SELECT 
	id AS flight_number,
	(SELECT name FROM cities WHERE label = flights.going_from) AS going_from,
	(SELECT name FROM cities WHERE label = flights.going_to) AS going_to
	FROM flights;


-- Cleanup
DROP DATABASE IF EXISTS homework_7_3;

