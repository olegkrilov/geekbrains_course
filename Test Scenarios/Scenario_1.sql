-- Scenario #1
-- Repair with parts replacement

USE service_center;

SET @model = 'WMD-80180N';
SET @serial_num = '404QWER123456';
SET @repair_id = 0;
SET @engineer_id = 2;
SET @order_id = 0;
SET @repair_is_done_status = 8;

SET @part_1 = 0;
SET @part_2 = 0;
SET @part_3 = 0;


-- 1) Service Center receives technic
CALL create_repair(

	-- Customer Data
	'Vasiliy Pupkin',
	'0953753753',
	'Vasiliy.Pupkin@gmail.com',
	'15, Ivanov str., ap. 12',
	1, -- Customer type

	-- Technic Data
	'LG',
	@model,
	@serial_num,
	2, -- Technic type,
	
	-- Reepair Data
	'Spinning noise, drain not working',
	0, -- need_transfer_to_service BIT
	0, -- need_transfer_from_service BIT
	2, -- repair_type BIGINT

	
	@error
);

SET @repair_id = (
	SELECT id FROM repairs 
		WHERE (repairs.model = @model) 
		AND (repairs.serial_num = @serial_num)
		ORDER BY received_at DESC
		LIMIT 1
);


-- 2) Engineer assigns repair and makes diagnostics
CALL assign_repair(@repair_id, @engineer_id, @error);


-- 3) Engineer creates parts order
CALL create_urgent_order(@repair_id, @error);

SET @order_id = (
	SELECT id FROM orders 
		WHERE orders.repair_id = @repair_id
		ORDER BY created_at DESC
		LIMIT 1
);

CALL add_parts_to_order(@order_id, '[Water Pump] std', 1, @error);
CALL add_parts_to_order(@order_id, '[Seal] std', 1, @error);
CALL add_parts_to_order(@order_id, '[Bearing Ball Set] std', 1, @error);
CALL send_order(@order_id, @error);

-- 4) Storekeeper receives parts
CALL receive_parts(@order_id, @error);

SET @part_1 = (
	SELECT storage.id FROM storage 
		WHERE (storage.part_number = '[Water Pump] std')
		AND (storage.order_id = @order_id)
);

SET @part_2 = (
	SELECT storage.id FROM storage 
		WHERE (storage.part_number = '[Seal] std')
		AND (storage.order_id = @order_id)
);

SET @part_3 = (
	SELECT storage.id FROM storage 
		WHERE (storage.part_number = '[Bearing Ball Set] std')
		AND (storage.order_id = @order_id)
);


-- 5) Engineer repalce parts
CALL use_part(@part_1, @repair_id, 1, @error);
CALL use_part(@part_2, @repair_id, 1, @error);
CALL use_part(@part_3, @repair_id, 1, @error);


-- 6) Repair is done
UPDATE repairs 
	SET repair_description = 'Replaced pump and seal/bearing complect.'
	WHERE repairs.id = @repair_id;

CALL close_repair(@repair_id, @repair_is_done_status, @error);


-- 7) Observe results
SELECT @error AS 'Error';
SELECT * FROM repair_events WHERE repair_events.repair_id = @repair_id;

-- End Scenario



