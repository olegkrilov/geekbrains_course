-- Scenario #2
-- Item issued without repair

SET @model = 'HM-1043';
SET @serial_num = '715AS123123A';
SET @repair_id = 0;
SET @engineer_id = 3;
SET @no_neeed_to_repair_status = 7;

-- 1) Item received
CALL create_repair(

	-- Customer Data
	'Vladimir Ivanov',
	'0953123764',
	'Vladimir.Ivanov@yandex.ru',
	'9, Petrovskaya str., ap. 332',
	1, -- Customer type

	-- Technic Data
	'Samsung',
	@model,
	@serial_num,
	1, -- Technic type,
	
	-- Reepair Data
	'No heating, extremal noise',
	0, -- need_transfer_to_service BIT
	0, -- need_transfer_from_service BIT
	2, -- repair_type BIGINT
	
	@error
);

SET @repair_id = (
	SELECT repairs.id FROM repairs 
		WHERE (repairs.model = @model) 
		AND (repairs.serial_num = @serial_num)
		ORDER BY received_at DESC
		LIMIT 1
);

-- 2) Engineer assigns repair and makes diagnostics
CALL assign_repair(@repair_id, @engineer_id, @error);


-- 3) Defect was not found, customer is mentioneed about
UPDATE repairs 
	SET repair_description = 'Diagnostics only. Defect was not found, possible problems with mains voltage'
	WHERE repairs.id = @repair_id;


-- 4) Item issued without repair
CALL close_repair(@repair_id, @no_neeed_to_repair_status, @error);


-- 5) Observe results
SELECT @error AS 'Error';
SELECT * FROM repair_events WHERE repair_events.repair_id = @repair_id;


-- End Scenario

