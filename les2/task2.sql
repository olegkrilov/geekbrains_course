-- Task 2
-- Создайте базу данных example, разместите в ней таблицу users,
-- состоящую из двух столбцов, числового id и строкового name.

CREATE DATABASE IF NOT EXISTS example;

SHOW DATABASES;

USE example;

CREATE TABLE IF NOT EXISTS users(id INT, name CHAR);

DESCRIBE users;
