-- 12_1_2 Создайте SQL-запрос, который помещает в таблицу users миллион записей.

CREATE DATABASE IF NOT EXISTS homework_11_1_2;
USE homework_11_1_2;

-- Create Users Table
CREATE TABLE IF NOT EXISTS users(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255)
);

-- Create Insertion Procedure
DROP PROCEDURE IF EXISTS add_test_users;
DELIMITER $$
CREATE PROCEDURE add_test_users(lim BIGINT)
	BEGIN
		DECLARE current_index BIGINT DEFAULT 0;
	
		SELECT NOW() AS 'Started at';
		
		WHILE current_index < lim DO
			INSERT INTO users (name) VALUES (CONCAT('User_', current_index));
			SET current_index = current_index + 1;
		END WHILE;
	
		SELECT NOW() AS 'Done at';
	END;
$$
DELIMITER ;

-- Test 
CALL add_test_users(1000000);
SELECT COUNT(*) AS 'Added rows' FROM users;


-- Cleanup
DROP PROCEDURE IF EXISTS add_test_users;
DROP DATABASE IF EXISTS homework_11_1_2;



