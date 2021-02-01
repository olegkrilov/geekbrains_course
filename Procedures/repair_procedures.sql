-- Repair Procedures Collection

USE service_center;

-- Create Repair
DROP PROCEDURE IF EXISTS create_repair;
DELIMITER $$
CREATE PROCEDURE create_repair(

	-- Customer Data
	customer_name VARCHAR(255),
	customer_phone VARCHAR(255),
	customer_email VARCHAR(255),
	customer_address VARCHAR(255),
	customer_type BIGINT,
 
	-- Technic data
	brand_name VARCHAR(255),
	model VARCHAR(255),
	serial_num VARCHAR(255),
	tech_type BIGINT,
	
	-- Reepair data
	defect VARCHAR(255),
	need_transfer_to_service BIT,
	need_transfer_from_service BIT,
	repair_type BIGINT,
	
	-- Exception
	OUT transaction_error VARCHAR(255)
	
)
BEGIN
	
	DECLARE customer BIGINT;
	DECLARE is_repeated_repair BIT;
	DECLARE repair_id BIGINT UNSIGNED;
	
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
		SET customer = (
			SELECT id FROM customers 
				WHERE (customers.email = customer_email) 
				OR (customers.phone = customer_phone)
		);
	
		IF customer IS NULL THEN
			INSERT INTO customers (full_name, phone, email, address, customer_type_id)
				VALUES (customer_name, customer_phone, customer_email, customer_address, customer_type);
		
			SET customer = LAST_INSERT_ID();
		END IF;

		-- Define if item was already being repaired
		SET is_repeated_repair = (
			SELECT id FROM repairs 
				WHERE (repairs.model = model)
				AND (repairs.serial_num = serial_num)
				AND (repairs.brand_name = brand_name)
		) IS NOT NULL;
		
	
		-- Create repair
		INSERT INTO repairs (
			customer_id, repair_type_id, tech_type_id,
			brand_name, model, serial_num, defect,
			is_repeated_repair, need_transfer_to_service, need_transfer_from_service
		) VALUES (
			customer, repair_type, tech_type,
			brand_name, model, serial_num, defect,
			is_repeated_repair, need_transfer_to_service, need_transfer_from_service
		);
	
		SET repair_id = LAST_INSERT_ID(); 
	
		-- Register event
		INSERT INTO repair_events (repair_id, event) VALUES (repair_id, 'Received');	
	
	
	IF transaction_failed THEN
		ROLLBACK;
		SELECT transaction_error AS 'Error';
	ELSE 
		COMMIT;
		SELECT 
			'Repair registered' AS 'Message',
			repair_id AS 'ID';
	END IF;
	

END;
$$
DELIMITER ;


-- Get list of repairs
DROP PROCEDURE IF EXISTS get_repairs_list;
DELIMITER $$
CREATE PROCEDURE get_repairs_list(
	page_limit INT,
	page_offset INT
)
BEGIN
	SELECT 
		repairs.id AS id,
		
		repairs.brand_name AS brand,
		repairs.model AS model,
		repairs.serial_num AS serial_num,
		repair_statuses.name AS status,
		
		customers.id AS customer_id,
		customers.full_name AS customer_name,
		customers.phone AS customer_phone
		
	FROM repairs
	JOIN customers ON repairs.customer_id = customers.id
	JOIN repair_statuses ON repairs.repair_status_id = repair_statuses.id
	
	LIMIT page_limit
	OFFSET page_offset;

END;
$$
DELIMITER ;


-- Get repair details (by id)
DROP PROCEDURE IF EXISTS get_repair_details;
DELIMITER $$
CREATE PROCEDURE get_repair_details(id BIGINT UNSIGNED)
BEGIN
	SELECT
		repairs.id AS repair_id,
		repairs.brand_name AS brand,
		repairs.model AS model,
		repairs.serial_num AS serial_num,
		repairs.defect AS defect,
		repairs.repair_description AS repair_description,
		
		repair_statuses.name AS status,
		
		repair_types.name AS repair_type,

		customers.id AS customer_id,
		customers.full_name AS customer_name,
		customers.phone AS customer_phone,
		customers.email AS customer_email,
		engineers.full_name AS assigned_engineeer
		
	FROM repairs
	JOIN repair_statuses ON repair_statuses.id = repairs.repair_status_id
	JOIN repair_types ON repair_types.id = repairs.repair_type_id
	JOIN customers ON customers.id = repairs.customer_id
	JOIN engineers ON engineers.id = repairs.engineer_id
	
	WHERE repairs.id = id;
	
END;
$$
DELIMITER ;


-- Assign repair to engineer
DROP PROCEDURE IF EXISTS assign_repair;
DELIMITER $$
CREATE PROCEDURE assign_repair(
	repair_id BIGINT UNSIGNED, 
	engineer_id BIGINT UNSIGNED,
	OUT transaction_error VARCHAR(255)
)
BEGIN
	DECLARE repair_assigned_status INT DEFAULT 2;
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

		UPDATE repairs 
			SET repairs.engineer_id = engineer_id
			WHERE repairs.id = repair_id;
		
		INSERT INTO repair_events (repair_id, event) VALUES (
			repair_id,
			(SELECT description FROM repair_statuses WHERE repair_statuses.id = repair_assigned_status)
		);
		
	
	IF transaction_failed THEN
		ROLLBACK;
		SELECT transaction_error AS 'Error';
	ELSE 
		COMMIT;
		SELECT 
			'Repair Updated' AS 'Message',
			LAST_INSERT_ID() AS 'ID';
	END IF;
	
END;
$$
DELIMITER ;


-- Close repair
DROP PROCEDURE IF EXISTS close_repair;
DELIMITER $$
CREATE PROCEDURE close_repair(
	repair_id BIGINT UNSIGNED, 
	status_id BIGINT UNSIGNED,
	OUT transaction_error VARCHAR(255)
)
BEGIN
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

		UPDATE repairs 
			SET repairs.repair_status_id = status_id
			WHERE repairs.id = repair_id;
		
		INSERT INTO repair_events (repair_id, event) VALUES (
			repair_id,
			(SELECT description FROM repair_statuses WHERE repair_statuses.id = status_id)
		);
		
	IF transaction_failed THEN
		ROLLBACK;
		SELECT transaction_error AS 'Error';
	ELSE 
		COMMIT;
		SELECT 
			'Repair Closed' AS 'Message',
			LAST_INSERT_ID() AS 'ID';
	END IF;
	
END;
$$
DELIMITER ;


-- Get repair events
DROP PROCEDURE IF EXISTS get_repair_events;
DELIMITER $$
CREATE PROCEDURE get_repair_events (repair_id BIGINT)
BEGIN
	SELECT 
		repair_events.event AS 'event',
		repair_events.occured_at AS 'occured_at'
		FROM repair_events
		WHERE repair_events.repair_id = repair_id;
END;
$$
DELIMITER ;


