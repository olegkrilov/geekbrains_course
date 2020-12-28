-- II. Ќаписать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном пор€дке

USE vk;

-- Filtered & sorted list
SELECT DISTINCT firstname FROM users ORDER BY firstname ASC;

-- Full list to compare
SELECT firstname FROM users;