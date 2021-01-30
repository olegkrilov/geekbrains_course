-- Database creation, Tables creation
CREATE DATABASE IF NOT EXISTS service_center;

USE service_center;

-- Static Dictionaries
CREATE TABLE IF NOT EXISTS tech_types(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	code VARCHAR(10),
	description VARCHAR(255)
);
	

CREATE TABLE IF NOT EXISTS customer_types(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	code VARCHAR(10),
	description VARCHAR(255)
);


CREATE TABLE IF NOT EXISTS repair_statuses(
	id SERIAL PRIMARY KEY,
	name VARCHAR(40),
	description VARCHAR(255) 
);


CREATE TABLE IF NOT EXISTS repair_types(
	id SERIAL PRIMARY KEY,
	name VARCHAR(20),
	code VARCHAR(10),
	description VARCHAR(255) 
);


CREATE TABLE IF NOT EXISTS order_statuses(
	id SERIAL PRIMARY KEY,
	name VARCHAR(20),
	description VARCHAR(255) 
);
	

-- People Tables 
CREATE TABLE IF NOT EXISTS customers(
	id SERIAL PRIMARY KEY,
	customer_type_id BIGINT,
	full_name VARCHAR(255),
	phone VARCHAR(20) UNIQUE,
	email VARCHAR(255) UNIQUE,
	address VARCHAR(255),
	
	additional_information VARCHAR(255),
	
	FOREIGN KEY (type_id) REFERENCES customer_types(id)
);

CREATE TABLE IF NOT EXISTS engineers(
	id SERIAL PRIMARY KEY,
	full_name VARCHAR(255),
	phone VARCHAR(20) UNIQUE,
	email VARCHAR(255) UNIQUE,
	address VARCHAR(255),
	
	additional_information VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS admittance(
	engineer_id BIGINT,
	tech_type_id BIGINT,

	FOREIGN KEY (engineer_id) REFERENCES engineers(id),
	FOREIGN KEY (tech_type_id) REFERENCES tech_types(id)	
);


-- Storage & orders
CREATE TABLE IF NOT EXISTS orders(
	id SERIAL PRIMARY KEY,
	status_id BIGINT,
	created_at DATETIME DEFAULT NOW(),
	closed_at DATETIME,
	
	FOREIGN KEY (status_id) REFERENCES order_statuses(id)
);

CREATE TABLE IF NOT EXISTS storage(
	id SERIAL PRIMARY KEY,
	order_id BIGINT,
	part_number VARCHAR(255),
	part_description VARCHAR(255),
	quantity INT NOT NULL,
	price FLOAT, -- Could be null, in some extra cases,
	
	additional_information VARCHAR(255),
	
	FOREIGN KEY (order_id) REFERENCES orders(id)
);


-- Repairs & Parts
CREATE TABLE IF NOT EXISTS repairs(
	id SERIAL PRIMARY KEY,
	
	customer_id BIGINT,
	engineer_id BIGINT,
	repair_status_id BIGINT,
	repair_type_id BIGINT,
	tech_type_id BIGINT,
	
	brand_name VARCHAR(255),
	model VARCHAR(255),
	serial_num VARCHAR(255),
	defect VARCHAR(255),
	is_repeated_repair BIT DEFAULT 0,
	
	repair_description VARCHAR(255),
	parts_were_used BIT DEFAULT 0,
	
	need_transfer_to_service BIT DEFAULT 0,
	need_transfer_from_service BIT DEFAULT 0,
	
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
	repair_id BIGINT,
	storage_id BIGINT,
	parts_quantity BIGINT DEFAULT 1,
	
	FOREIGN KEY (repair_id) REFERENCES repairs(id),
	FOREIGN KEY (storage_id) REFERENCES storage(id)
);
