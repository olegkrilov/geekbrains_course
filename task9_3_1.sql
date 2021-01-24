-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу 
-- "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

CREATE DATABASE IF NOT EXISTS homework_9_3_1;
USE homework_9_3_1;


-- Solution 
DROP FUNCTION IF EXISTS justified_greetings;
DELIMITER |
CREATE FUNCTION justified_greetings()
RETURNS VARCHAR(255) DETERMINISTIC
	BEGIN
		DECLARE curr_time TIME DEFAULT NOW();
		DECLARE curr_hour INT;
		DECLARE response VARCHAR(255);
	
		SET curr_hour = HOUR(curr_time);
		SET response = 'Good';
		
		IF (curr_hour >= 6 AND curr_hour < 12) THEN SET response = 'Morning';
		ELSEIF (curr_hour >= 12 AND curr_hour < 18) THEN SET response = 'Afternoon';
		ELSEIF (curr_hour >= 18 AND curr_hour < 24) THEN SET response = 'Evening';
		ELSE SET response = 'Night';
		END IF;
	
		RETURN CONCAT('Good ', response, '!');
		
	END;
|
DELIMITER ;

SELECT justified_greetings();

-- Cleanup
DROP DATABASE IF EXISTS homework_9_3_1;
DROP FUNCTION IF EXISTS justified_greetings;

