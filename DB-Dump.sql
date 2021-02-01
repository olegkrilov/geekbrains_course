-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: service_center
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admittance`
--

DROP TABLE IF EXISTS `admittance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admittance` (
  `engineer_id` bigint unsigned DEFAULT NULL,
  `tech_type_id` bigint unsigned DEFAULT NULL,
  KEY `engineer_id` (`engineer_id`),
  KEY `tech_type_id` (`tech_type_id`),
  CONSTRAINT `admittance_ibfk_1` FOREIGN KEY (`engineer_id`) REFERENCES `engineers` (`id`),
  CONSTRAINT `admittance_ibfk_2` FOREIGN KEY (`tech_type_id`) REFERENCES `tech_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admittance`
--

LOCK TABLES `admittance` WRITE;
/*!40000 ALTER TABLE `admittance` DISABLE KEYS */;
/*!40000 ALTER TABLE `admittance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_types`
--

DROP TABLE IF EXISTS `customer_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_types`
--

LOCK TABLES `customer_types` WRITE;
/*!40000 ALTER TABLE `customer_types` DISABLE KEYS */;
INSERT INTO `customer_types` VALUES (1,'End User','EU','Item was in serve for self & family usage.'),(2,'Business User','BU','Item was in serve for business usage.'),(3,'Seller','SE','Item was not in use or was returned by the Customer.');
/*!40000 ALTER TABLE `customer_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_type_id` bigint unsigned DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `additional_information` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `email` (`email`),
  KEY `customer_type_id` (`customer_type_id`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`customer_type_id`) REFERENCES `customer_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engineers`
--

DROP TABLE IF EXISTS `engineers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `engineers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `additional_information` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engineers`
--

LOCK TABLES `engineers` WRITE;
/*!40000 ALTER TABLE `engineers` DISABLE KEYS */;
INSERT INTO `engineers` VALUES (1,'NOT_ASSIGNED','- -','- -',NULL,NULL),(2,'Ivan Petrov','0990951932','Ivan.Petrov@mail.ru',NULL,NULL),(3,'Petr Ivanov','0950543227','Petr.Ivanov@gmail.com',NULL,NULL),(4,'Fedor Michailovich','03711122233','Fedor.Michailovich@yandex.ru',NULL,NULL),(5,'Michail Fedorovich','05712313232','Michail.Fedorovich@yzoho.com',NULL,NULL);
/*!40000 ALTER TABLE `engineers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_statuses`
--

DROP TABLE IF EXISTS `order_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_statuses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_statuses`
--

LOCK TABLES `order_statuses` WRITE;
/*!40000 ALTER TABLE `order_statuses` DISABLE KEYS */;
INSERT INTO `order_statuses` VALUES (1,'Created','Order was created.'),(2,'Sent','Order was sent.'),(3,'Canceled','Order was canceled by Service.'),(4,'Declined','Order was canceled by Manufacturer.'),(5,'Received full','Parts was received according to the Order.'),(6,'Received partially','Parts was not received according to the Order.'),(7,'Re-sent','Parts recceived inapoppriated or tainted, order repeated.');
/*!40000 ALTER TABLE `order_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordered_parts`
--

DROP TABLE IF EXISTS `ordered_parts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordered_parts` (
  `order_id` bigint unsigned DEFAULT NULL,
  `part_number` varchar(255) DEFAULT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  KEY `order_id` (`order_id`),
  CONSTRAINT `ordered_parts_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordered_parts`
--

LOCK TABLES `ordered_parts` WRITE;
/*!40000 ALTER TABLE `ordered_parts` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordered_parts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `repair_id` bigint unsigned DEFAULT NULL,
  `status_id` bigint unsigned DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `closed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `status_id` (`status_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `order_statuses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parts_usage`
--

DROP TABLE IF EXISTS `parts_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parts_usage` (
  `repair_id` bigint unsigned DEFAULT NULL,
  `storage_id` bigint unsigned DEFAULT NULL,
  `part_number` varchar(255) DEFAULT NULL,
  `quantity` bigint DEFAULT '1',
  KEY `repair_id` (`repair_id`),
  KEY `storage_id` (`storage_id`),
  CONSTRAINT `parts_usage_ibfk_1` FOREIGN KEY (`repair_id`) REFERENCES `repairs` (`id`),
  CONSTRAINT `parts_usage_ibfk_2` FOREIGN KEY (`storage_id`) REFERENCES `storage` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parts_usage`
--

LOCK TABLES `parts_usage` WRITE;
/*!40000 ALTER TABLE `parts_usage` DISABLE KEYS */;
/*!40000 ALTER TABLE `parts_usage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repair_events`
--

DROP TABLE IF EXISTS `repair_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repair_events` (
  `repair_id` bigint unsigned DEFAULT NULL,
  `event` varchar(255) DEFAULT NULL,
  `occured_at` datetime DEFAULT CURRENT_TIMESTAMP,
  KEY `repair_id` (`repair_id`),
  CONSTRAINT `repair_events_ibfk_1` FOREIGN KEY (`repair_id`) REFERENCES `repairs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repair_events`
--

LOCK TABLES `repair_events` WRITE;
/*!40000 ALTER TABLE `repair_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `repair_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repair_statuses`
--

DROP TABLE IF EXISTS `repair_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repair_statuses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repair_statuses`
--

LOCK TABLES `repair_statuses` WRITE;
/*!40000 ALTER TABLE `repair_statuses` DISABLE KEYS */;
INSERT INTO `repair_statuses` VALUES (1,'Received','Item came to the service, Сustomer took Receipt.'),(2,'Engineer Appointed','Engineer appointed, diagnostics started.'),(3,'Waiting for Parts','Diagnostics completed, item is waiting for Parts to be replaced.'),(4,'Repair in progress','Work is in progress.'),(5,'Waiting for defect','Declared defect was not found.'),(6,'Waiting for Customer','Item is ready, waiting for customer.'),(7,'Issued without repair','Item issued as unrepairable or Customer reject to repair it.'),(8,'Issued','Item issued, Customer has no complaints.'),(9,'Written off','Item is unrepairable, Customer received the Write-Off Act.');
/*!40000 ALTER TABLE `repair_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repair_types`
--

DROP TABLE IF EXISTS `repair_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repair_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repair_types`
--

LOCK TABLES `repair_types` WRITE;
/*!40000 ALTER TABLE `repair_types` DISABLE KEYS */;
INSERT INTO `repair_types` VALUES (1,'Guarantee repair','GR','Repair paid by the Manufacturer.'),(2,'Non-guarantee repair','NGR','Repair paid by the Customer.'),(3,'Pre-sale Preparation','PSP','Repair paid by the Seller.');
/*!40000 ALTER TABLE `repair_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repairs`
--

DROP TABLE IF EXISTS `repairs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repairs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned DEFAULT NULL,
  `engineer_id` bigint unsigned DEFAULT '1',
  `repair_status_id` bigint unsigned DEFAULT '1',
  `repair_type_id` bigint unsigned DEFAULT NULL,
  `tech_type_id` bigint unsigned DEFAULT NULL,
  `brand_name` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `serial_num` varchar(255) DEFAULT NULL,
  `defect` varchar(255) DEFAULT NULL,
  `is_repeated_repair` bit(1) DEFAULT b'0',
  `repair_description` text,
  `parts_were_used` bit(1) DEFAULT b'0',
  `need_transfer_to_service` bit(1) DEFAULT b'0',
  `need_transfer_from_service` bit(1) DEFAULT b'0',
  `additional_information` varchar(255) DEFAULT NULL,
  `received_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `finished_at` datetime DEFAULT NULL,
  `issued_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `engineer_id` (`engineer_id`),
  KEY `repair_status_id` (`repair_status_id`),
  KEY `repair_type_id` (`repair_type_id`),
  KEY `tech_type_id` (`tech_type_id`),
  CONSTRAINT `repairs_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `repairs_ibfk_2` FOREIGN KEY (`engineer_id`) REFERENCES `engineers` (`id`),
  CONSTRAINT `repairs_ibfk_3` FOREIGN KEY (`repair_status_id`) REFERENCES `repair_statuses` (`id`),
  CONSTRAINT `repairs_ibfk_4` FOREIGN KEY (`repair_type_id`) REFERENCES `repair_types` (`id`),
  CONSTRAINT `repairs_ibfk_5` FOREIGN KEY (`tech_type_id`) REFERENCES `tech_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repairs`
--

LOCK TABLES `repairs` WRITE;
/*!40000 ALTER TABLE `repairs` DISABLE KEYS */;
/*!40000 ALTER TABLE `repairs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storage`
--

DROP TABLE IF EXISTS `storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storage` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned DEFAULT NULL,
  `part_number` varchar(255) DEFAULT NULL,
  `part_description` varchar(255) DEFAULT NULL,
  `quantity` int NOT NULL,
  `price` float DEFAULT NULL,
  `additional_information` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `storage_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storage`
--

LOCK TABLES `storage` WRITE;
/*!40000 ALTER TABLE `storage` DISABLE KEYS */;
/*!40000 ALTER TABLE `storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tech_types`
--

DROP TABLE IF EXISTS `tech_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tech_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tech_types`
--

LOCK TABLES `tech_types` WRITE;
/*!40000 ALTER TABLE `tech_types` DISABLE KEYS */;
INSERT INTO `tech_types` VALUES (1,'Microwave Oven','MW','Microwave Oven repair, with parts, no parts, renovation, cleaning.'),(2,'Washing Machine','WM','Washing Machine repair, with parts, no parts, installation, connection.'),(3,'Refrigerator','REF','Refrigerator repair, with parts, no parts, installation, refuelling.'),(4,'Freezer','FRE','Freezer repair, with parts, no parts, installation, refuelling.'),(5,'Air Conditioner','AC','Air Conditioner, with parts, no parts, installation, refuelling.'),(6,'Multihead Air Conditioner','MAC','Multihead Air Conditioner, with parts, no parts, installation, refuelling.'),(7,'Water Heater','WH','Water Heater, with parts, no parts, installation,  connection.'),(8,'Vacuum Cleaner','VC','Vacuum Cleaner, with parts, no parts, cleaning.'),(9,'Small Kitchen Appliances','SKA','Small Kitchen Appliances, with parts, no parts, write-off acts.'),(10,'Small Household Appliances','SKA','Small Household Appliances, with parts, no parts, write-off acts.');
/*!40000 ALTER TABLE `tech_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'service_center'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_parts_to_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_parts_to_order`(
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `assign_repair` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `assign_repair`(
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
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `close_repair` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `close_repair`(
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
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_repair` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_repair`(

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
	

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_spare_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_spare_order`()
BEGIN
	INSERT INTO orders (repair_id) VALUES (0);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_urgent_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_urgent_order`(
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_repairs_list` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_repairs_list`(
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_repair_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_repair_details`(id BIGINT UNSIGNED)
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
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_repair_events` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_repair_events`(repair_id BIGINT)
BEGIN
	SELECT 
		repair_events.event AS 'event',
		repair_events.occured_at AS 'occured_at'
		FROM repair_events
		WHERE repair_events.repair_id = repair_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `receive_parts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `receive_parts`(
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `send_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `send_order`(
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `use_part` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `use_part`(
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-01 12:48:16
