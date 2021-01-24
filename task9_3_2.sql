-- ¬ таблице products есть два текстовых пол€: name с названием товара и description с его описанием.
-- ƒопустимо присутствие обоих полей или одно из них. —итуаци€, когда оба пол€ принимают неопределенное
-- значение NULL неприемлема. »спользу€ триггеры, добейтесь того, чтобы одно из этих полей или оба пол€
-- были заполнены. ѕри попытке присвоить пол€м NULL-значение необходимо отменить операцию.


DROP DATABASE IF EXISTS homework_9_3_2;
CREATE DATABASE IF NOT EXISTS homework_9_3_2;
USE homework_9_3_2;

CREATE TABLE IF NOT EXISTS products(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) DEFAULT NULL,
	description VARCHAR(255) DEFAULT NULL
);

DROP TRIGGER IF EXISTS addition_guard;
DELIMITER |
CREATE TRIGGER addition_guard BEFORE INSERT ON products
FOR EACH ROW
	BEGIN
		IF (NEW.name IS NULL AND NEW.description IS NULL) 
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Invalid data'; 
		END IF;
	END;
|
DELIMITER ;

INSERT INTO products(name, description) VALUES ('pr1', 'awesome pr1');

INSERT INTO products(description) VALUES ('incredible pr2');

INSERT INTO products(name) VALUES ('pr3');

INSERT INTO products(name, description) VALUES (NULL, NULL);

SELECT * FROM products;


-- Cleanup
DROP DATABASE IF EXISTS homework_9_3_2;
DROP TRIGGER IF EXISTS addition_guard;
