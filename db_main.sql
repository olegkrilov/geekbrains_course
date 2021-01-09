DROP DATABASE IF EXISTS service_center;
CREATE DATABASE IF NOT EXISTS service_center;

USE service_center;

-- Static Dictionaries
CREATE TABLE IF NOT EXISTS tech_types(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(255),
	code VARCHAR(10),
	description VARCHAR(255)
);
INSERT INTO tech_types (name, code, description) VALUES
	('Microwave Oven', 'MW', 'Microwave Oven repair, with parts, no parts, renovation, cleaning.'),
	('Washing Machine', 'WM', 'Washing Machine repair, with parts, no parts, installation, connection.'),
	('Refrigerator', 'REF', 'Refrigerator repair, with parts, no parts, installation, refuelling.'),
	('Freezer', 'FRE', 'Freezer repair, with parts, no parts, installation, refuelling.'),
	('Air Conditioner', 'AC', 'Air Conditioner, with parts, no parts, installation, refuelling.'),
	('Multihead Air Conditioner', 'MAC', 'Multihead Air Conditioner, with parts, no parts, installation, refuelling.'),
	('Water Heater', 'WH', 'Water Heater, with parts, no parts, installation,  connection.'),
	('Vacuum Cleaner', 'VC', 'Vacuum Cleaner, with parts, no parts, cleaning.'),
	('Small Kitchen Appliances', 'SKA', 'Small Kitchen Appliances, with parts, no parts, write-off acts.'),
	('Small Household Appliances', 'SKA', 'Small Household Appliances, with parts, no parts, write-off acts.');
	

CREATE TABLE IF NOT EXISTS customer_types(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(255),
	code VARCHAR(10),
	description VARCHAR(255)
);
INSERT INTO customer_types (name, code, description) VALUES
	('End User', 'EU', 'Item was in serve for self & family usage.'),
	('Business User', 'BU', 'Item was in serve for business usage.'),
	('Seller', 'SE', 'Item was not in use or was returned by the Customer.');


CREATE TABLE IF NOT EXISTS repair_statuses(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(40),
	description VARCHAR(255) 
);
INSERT INTO repair_statuses (name, description) VALUES
	('Received', 'Item came to the service, Ñustomer took Receipt.'),
	('Engineer Appointed', 'Engineer appointed, diagnostics started.'),
	('Waiting for Parts', 'Diagnostics completed, item is waiting for Parts to be replaced.'),
	('Repair in progress', 'Work is in progress.'),
	('Waiting for defect', 'Declared defect was not found.'),
	('Waiting for Customer', 'Item is ready, waiting for customer.'),
	('Issued without repair', 'Item issued as unrepairable or Customer reject to repair it.'),
	('Issued', 'Item issued, Customer has no complaints.'),
	('Written off', 'Item is unrepairable, Customer received the Write-Off Act.');


CREATE TABLE IF NOT EXISTS repair_types(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(20),
	code VARCHAR(10),
	description VARCHAR(255) 
);
INSERT INTO repair_types (name, code, description) VALUES
	('Guarantee repair', 'GR', 'Repair paid by the Manufacturer.'),
	('Non-guarantee repair', 'NGR', 'Repair paid by the Customer.'),
	('Pre-sale Preparation', 'PSP', 'Repair paid by the Seller.');


CREATE TABLE IF NOT EXISTS order_statuses(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(20),
	description VARCHAR(255) 
);
INSERT INTO order_statuses (name, description) VALUES
	('Created', 'Order was created.'),
	('Sent', 'Order was sent.'),
	('Canceled', 'Order was canceled by Service.'),
	('Declined', 'Order was canceled by Manufacturer.'),
	('Received full', 'Parts was received according to the Order.'),
	('Received partially', 'Parts was not received according to the Order.'),
	('Re-sent', 'Parts recceived inapoppriated or tainted, order repeated.');
	

-- People Tables 
CREATE TABLE IF NOT EXISTS customers(
	id INT PRIMARY KEY AUTO_INCREMENT,
	type_id INT DEFAULT 0,
	full_name VARCHAR(255),
	phone VARCHAR(20),
	email VARCHAR(255),
	address VARCHAR(255),
	
	additional_information VARCHAR(255),
	
	FOREIGN KEY (type_id) REFERENCES customer_types(id)
);

CREATE TABLE IF NOT EXISTS engineers(
	id INT PRIMARY KEY AUTO_INCREMENT,
	full_name VARCHAR(255),
	phone VARCHAR(20),
	email VARCHAR(255),
	address VARCHAR(255),
	
	additional_information VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS admittance(
	engineer_id INT,
	tech_type_id INT,

	FOREIGN KEY (engineer_id) REFERENCES engineers(id),
	FOREIGN KEY (tech_type_id) REFERENCES tech_types(id)	
);


-- Storage & orders
CREATE TABLE IF NOT EXISTS orders(
	id INT PRIMARY KEY AUTO_INCREMENT,
	status_id INT,
	created_at DATETIME DEFAULT NOW(),
	closed_at DATETIME,
	
	FOREIGN KEY (status_id) REFERENCES order_statuses(id)
);

CREATE TABLE IF NOT EXISTS storage(
	id INT PRIMARY KEY AUTO_INCREMENT,
	order_id INT,
	part_number VARCHAR(255),
	part_description VARCHAR(255),
	quantity INT NOT NULL,
	price FLOAT, -- Could be null, in some extra cases,
	
	additional_information VARCHAR(255),
	
	FOREIGN KEY (order_id) REFERENCES orders(id)
);


-- Repairs & Parts
CREATE TABLE IF NOT EXISTS repairs(
	id INT PRIMARY KEY AUTO_INCREMENT,
	
	customer_id INT,
	engineer_id INT,
	repair_status_id INT,
	repair_type_id INT,
	
	tech_type_id INT,
	brand_name VARCHAR(255),
	model VARCHAR(255),
	serial_num VARCHAR(255),
	
	defect VARCHAR(255),
	repair_description VARCHAR(255),
	is_repeated_repair BOOL DEFAULT false,
	parts_were_used BOOL DEFAULT false,
	
	need_transfer_to_service BOOL DEFAULT false,
	need_transfer_from_service BOOL DEFAULT false,
	
	additional_information VARCHAR(255),
	
	received_at DATETIME DEFAULT NOW(),
	finished_at DATETIME DEFAULT NULL,
	issued_at DATETIME DEFAULT NULL,

	FOREIGN KEY (customer_id) REFERENCES customers(id),
	FOREIGN KEY (engineer_id) REFERENCES engineers(id),
	FOREIGN KEY (repair_status_id) REFERENCES repair_statuses(id),
	FOREIGN KEY (repair_type_id) REFERENCES repair_types(id),
	FOREIGN KEY (tech_type_id) REFERENCES tech_types(id)
);



CREATE TABLE IF NOT EXISTS parts_usage(
	repair_id INT,
	storage_id INT,
	parts_quantity INT DEFAULT 1,
	
	FOREIGN KEY (repair_id) REFERENCES repairs(id),
	FOREIGN KEY (storage_id) REFERENCES storage(id)
);
