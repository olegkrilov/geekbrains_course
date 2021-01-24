-- Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи называется
-- последовательность в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.


DROP DATABASE IF EXISTS homework_9_3_3;
CREATE DATABASE IF NOT EXISTS homework_9_3_3;
USE homework_9_3_3;


DROP FUNCTION IF EXISTS fib_number;
DELIMITER |
CREATE FUNCTION fib_number(lim INT)
RETURNS INT DETERMINISTIC 
	BEGIN
		DECLARE val INT DEFAULT 0;
		DECLARE prev_val INT DEFAULT 1;
		DECLARE response_val INT DEFAULT 1;
		DECLARE iteration INT DEFAULT 0;
	
		WHILE iteration < lim DO
			SET response_val = val + prev_val;
			SET prev_val = val;
			SET val = response_val;
			SET iteration = iteration + 1;
		END WHILE;
	
		RETURN response_val;
	END
|
DELIMITER ;

-- SELECT fib_number(10);
SELECT fib_number(3);


DROP DATABASE IF EXISTS homework_9_3_3;
DROP FUNCTION IF EXISTS fib_number;
