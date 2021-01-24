-- �������� �������� ������� hello(), ������� ����� ���������� �����������, � ����������� �� �������� ������� �����.
-- � 6:00 �� 12:00 ������� ������ ���������� ����� "������ ����", � 12:00 �� 18:00 ������� ������ ���������� ����� 
-- "������ ����", � 18:00 �� 00:00 � "������ �����", � 00:00 �� 6:00 � "������ ����".

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

