-- Create Repair

USE service_center;

DROP PROCEDURE IF EXISTS create_repair;
DELIMITER $$
CREATE PROCEDURE create_repair(

	-- Customer Data
	customer_name VARCHAR(255),
	customer_phone VARCHAR(255),
	customer_email VARCHAR(255),
	customer_address VARCHAR(255),
	customer_type BIGINT,
-- -- 
-- 	-- Technic data
-- 	brand_name VARCHAR(255),
-- 	model VARCHAR(255),
-- 	serial_num VARCHAR(255),
-- 	tech_type BIGINT,
-- 
-- 	-- Reepair data
-- 	defect VARCHAR(255),
-- 	is_repeated_repair BIT,
-- 	need_transfer_to_service BIT,
-- 	need_transfer_from_service BIT,
-- 	repair_type BIGINT,
	
	-- Exception
	OUT transaction_error VARCHAR(255)
	
)
BEGIN
	
	DECLARE customer_id BIGINT;
	
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
	
		-- Create or Get user
		SET customer_id = (SELECT id FROM customers WHERE email = customer_email);
	
		IF customer_id IS NULL THEN
			INSERT INTO customers (full_name, phone, email, address, customer_type_id)
				VALUES (customer_name, customer_phone, customer_email, customer_address, customer_type);
		
			SET customer_id = LAST_INSERT_ID();
		
			SELECT 'New User';
			SELECT customer_id;
		
		ELSE 
			SELECT 'User Exists';
		END IF;
	
		SELECT customer_id AS 'Customer';
	
	IF transaction_failed THEN
		ROLLBACK;
	ELSE 
		COMMIT;
	END IF;
	

END;
$$
DELIMITER ;

CALL create_repair(
	'Vasiliy Pupkin',
	'0953753753',
	'Vasiliy.Pupkin@gmail.com',
	'15, Ivanov str., ap. 12',
	1, @transaction_error);

SELECT @transaction_error AS 'Error';


