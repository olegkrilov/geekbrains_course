-- Fill tables with static data 

USE service_center;

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

INSERT INTO customer_types (name, code, description) VALUES
	('End User', 'EU', 'Item was in serve for self & family usage.'),
	('Business User', 'BU', 'Item was in serve for business usage.'),
	('Seller', 'SE', 'Item was not in use or was returned by the Customer.');

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

INSERT INTO repair_types (name, code, description) VALUES
	('Guarantee repair', 'GR', 'Repair paid by the Manufacturer.'),
	('Non-guarantee repair', 'NGR', 'Repair paid by the Customer.'),
	('Pre-sale Preparation', 'PSP', 'Repair paid by the Seller.');

INSERT INTO order_statuses (name, description) VALUES
	('Created', 'Order was created.'),
	('Sent', 'Order was sent.'),
	('Canceled', 'Order was canceled by Service.'),
	('Declined', 'Order was canceled by Manufacturer.'),
	('Received full', 'Parts was received according to the Order.'),
	('Received partially', 'Parts was not received according to the Order.'),
	('Re-sent', 'Parts recceived inapoppriated or tainted, order repeated.');

