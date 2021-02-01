-- Storage & Parts Procedures Collection

USE service_center;


-- Create Order for non specified repair (frequently used parts)
DROP PROCEDURE IF EXISTS create_spare_order;
DELIMITER $$
CREATE PROCEDURE create_spare_order()
BEGIN
	INSERT INTO orders (repair_id) VALUES (0);
END;
$$
DELIMITER ;


-- Create Order for specified repair
DROP PROCEDURE IF EXISTS create_urgent_order;
DELIMITER $$
CREATE PROCEDURE create_urgent_order(
	repair_id BIGINT UNSIGNED,
	OUT transaction_error VARCHAR(255)
)
BEGIN
	DECLARE repair_description VARCHAR(255);
	DECLARE repair_waiting_status INT DEFAULT 3;

	DECLARE transaction_failed BIT DEFAULT 0;
	DECLARE err_code VARCHAR(100);
	DECLARE err_message VARCHAR(100);
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET STACKED DIAGNOSTICS CONDITION 1	
			err_code = RETURNED_SQLSTATE,
			err_message = MESSAGE_TEXT;

		SET transaction_failed = 1;
		SET transaction_error = CONCAT('ERROR: ', err_code, '. ', err_message);
	END;
	START TRANSACTION;
	
		SET repair_description = (SELECT repairs.repair_description FROM repairs WHERE repairs.id = repair_id);
	
		INSERT INTO orders (repair_id) VALUES (repair_id);
	
		INSERT INTO repair_events (repair_id, event) VALUES (
			repair_id,
			CONCAT(
				(SELECT description FROM repair_statuses WHERE repair_statuses.id = repair_waiting_status),
				CHAR(10),
				CONCAT('Order number ', LAST_INSERT_ID())
			)
		);
	
	IF transaction_failed THEN
		ROLLBACK;
		SELECT transaction_error AS 'Error';
	ELSE 
		COMMIT;
		SELECT 
			'Order created' AS 'Message',
			LAST_INSERT_ID() AS 'ID';
	END IF;

END;
$$
DELIMITER ;


-- Add parts to order
DROP PROCEDURE IF EXISTS add_parts_to_order;
DELIMITER $$
CREATE PROCEDURE add_parts_to_order(
	order_id BIGINT UNSIGNED,
	part_number VARCHAR(255),
	quantity INT,
	OUT transaction_error VARCHAR(255)
)
BEGIN
	DECLARE repair_id BIGINT UNSIGNED DEFAULT 0;
	
	DECLARE transaction_failed BIT DEFAULT 0;
	DECLARE err_code VARCHAR(100);
	DECLARE err_message VARCHAR(100);
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET STACKED DIAGNOSTICS CONDITION 1	
			err_code = RETURNED_SQLSTATE,
			err_message = MESSAGE_TEXT;

		SET transaction_failed = 1;
		SET transaction_error = CONCAT('ERROR: ', err_code, '. ', err_message);
	END;
	START TRANSACTION;

		SET repair_id = (SELECT orders.repair_id FROM orders WHERE orders.id = order_id);

		INSERT INTO ordered_parts (order_id, part_number, quantity) 
			VALUES (order_id, part_number, quantity);
		
	
		IF repair_id > 0 THEN
			INSERT INTO repair_events (repair_id, event) VALUES (
				repair_id,
				CONCAT('Ordered part(s)', ': ', part_number, ' x ', quantity)
			);
		
		END IF;	
	
	IF transaction_failed THEN
		ROLLBACK;
		SELECT transaction_error AS 'Error';
	ELSE 
		COMMIT;
		SELECT 
			'Order updated' AS 'Message',
			LAST_INSERT_ID() AS 'ID';
	END IF;

END;
$$
DELIMITER ;


-- Send order
DROP PROCEDURE IF EXISTS send_order;
DELIMITER $$
CREATE PROCEDURE send_order(
	order_id BIGINT UNSIGNED,
	OUT transaction_error VARCHAR(255)
)
BEGIN
	DECLARE repair_id BIGINT UNSIGNED DEFAULT 0;
	DECLARE order_sent_status INT DEFAULT 2;
	
	DECLARE transaction_failed BIT DEFAULT 0;
	DECLARE err_code VARCHAR(100);
	DECLARE err_message VARCHAR(100);
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET STACKED DIAGNOSTICS CONDITION 1	
			err_code = RETURNED_SQLSTATE,
			err_message = MESSAGE_TEXT;

		SET transaction_failed = 1;
		SET transaction_error = CONCAT('ERROR: ', err_code, '. ', err_message);
	END;
	START TRANSACTION;

		SET repair_id = (SELECT orders.repair_id FROM orders WHERE orders.id = order_id);
		
		UPDATE orders 
			SET orders.status_id = order_sent_status
			WHERE orders.id = order_id;
		
		IF repair_id > 0 THEN
			INSERT INTO repair_events (repair_id, event) VALUES (
				repair_id,
				CONCAT('Parts order number ', order_id, ' was sent')
			);

		END IF;	
	
	IF transaction_failed THEN
		ROLLBACK;
		SELECT transaction_error AS 'Error';
	ELSE 
		COMMIT;
		SELECT 
			'Order updated' AS 'Message',
			LAST_INSERT_ID() AS 'ID';
	END IF;

END;
$$
DELIMITER ;


-- Add parts to storage
DROP PROCEDURE IF EXISTS receive_parts;
DELIMITER $$
CREATE PROCEDURE receive_parts(
	order_id BIGINT UNSIGNED,
	OUT transaction_error VARCHAR(255)
)
BEGIN
	DECLARE repair_id BIGINT UNSIGNED DEFAULT 0;
	DECLARE order_received_status INT DEFAULT 5;
	
	DECLARE transaction_failed BIT DEFAULT 0;
	DECLARE err_code VARCHAR(100);
	DECLARE err_message VARCHAR(100);
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET STACKED DIAGNOSTICS CONDITION 1	
			err_code = RETURNED_SQLSTATE,
			err_message = MESSAGE_TEXT;

		SET transaction_failed = 1;
		SET transaction_error = CONCAT('ERROR: ', err_code, '. ', err_message);
	END;
	START TRANSACTION;

		SET repair_id = (SELECT orders.repair_id FROM orders WHERE orders.id = order_id);

		INSERT INTO storage (
			order_id,
			part_number,
			part_description,
			quantity
		) SELECT 
			ordered_parts.order_id,
			ordered_parts.part_number,
			repair_id,
			ordered_parts.quantity	
		FROM ordered_parts
		WHERE ordered_parts.order_id = order_id;
	
		UPDATE orders SET orders.status_id = order_received_status;
	
		IF repair_id > 0 THEN
			INSERT INTO repair_events (repair_id, event) VALUES (
				repair_id,
				CONCAT('Parts order number ', order_id, ' was received')
			);
		END IF;	
		
	IF transaction_failed THEN
		ROLLBACK;
		SELECT transaction_error AS 'Error';
	ELSE 
		COMMIT;
		SELECT 
			'Storage updated' AS 'Message',
			LAST_INSERT_ID() AS 'ID';
	END IF;

END;
$$
DELIMITER ;


-- Get parts from storage
DROP PROCEDURE IF EXISTS use_part;
DELIMITER $$
CREATE PROCEDURE use_part(
	stroage_id BIGINT UNSIGNED,
	repair_id BIGINT UNSIGNED,
	required_quantity INT,
	OUT transaction_error VARCHAR(255)
)
BEGIN
	DECLARE part_number VARCHAR(255);
	DECLARE available_quantity INT;
	DECLARE remaining_quantity INT;
	
	DECLARE transaction_failed BIT DEFAULT 0;
	DECLARE err_code VARCHAR(100);
	DECLARE err_message VARCHAR(100);
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET STACKED DIAGNOSTICS CONDITION 1	
			err_code = RETURNED_SQLSTATE,
			err_message = MESSAGE_TEXT;

		SET transaction_failed = 1;
		SET transaction_error = CONCAT('ERROR: ', err_code, '. ', err_message);
	END;
	START TRANSACTION;
		
		SELECT storage.part_number, storage.quantity 
			INTO part_number, available_quantity
			FROM storage
			WHERE storage.id = stroage_id;
		
		SET remaining_quantity = available_quantity - required_quantity;
		
		IF remaining_quantity < 0 THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Not enough parts.';
		
		ELSEIF remaining_quantity = 0 THEN
			DELETE FROM storage WHERE storage.id = stroage_id;
		
		ELSE 
			UPDATE storage 
				SET storage.quantity = remaining_quantity
				WHERE storage.id = stroage_id;
		END IF;
	
		INSERT INTO parts_usage (repair_id, storage_id, part_number, quantity) 
			VALUES (
				repair_id,
				storage_id,
				part_number,
				required_quantity
			);
		
		INSERT INTO repair_events (repair_id, event) VALUES (
			repair_id,
			CONCAT('Replaced part(s) ', part_number, ' x ', required_quantity)
		);
		
	IF transaction_failed THEN
		ROLLBACK;
		SELECT transaction_error AS 'Error';
	ELSE 
		COMMIT;
		SELECT 
			'Storage updated' AS 'Message',
			LAST_INSERT_ID() AS 'ID';
	END IF;

END;
$$
DELIMITER ;

