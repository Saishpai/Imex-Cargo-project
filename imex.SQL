/*
Created: 11/28/2018
Modified: 12/16/2018
Model: MySQL 5.7
Database: MySQL 5.7
*/


-- Create tables section -------------------------------------------------

-- Table company

CREATE TABLE `company`
(
  `company_id` Char(20) NOT NULL,
  `email` Char(20),
  `contact` Char(20),
  `street` Char(20),
  `apartment` Char(20),
  `city` Char(20),
  `state` Char(20),
  `zipcode` Char(20),
  `country` Char(20),
  `country_code` Char(20),
  `first_name` Char(20),
  `Last_name` Char(20)
)
;

ALTER TABLE `company` ADD PRIMARY KEY (`company_id`)
;

-- Table customer

CREATE TABLE `customer`
(
  `customer_id` Int NOT NULL AUTO_INCREMENT,
  `First_name` Varchar(50),
  `Last_name` Varchar(50),
  `street` Varchar(50),
  `apartment` Varchar(20),
  `city` Varchar(50),
  `state` Varchar(50),
  `country` Varchar(50),
  `zipcode` Int,
  `contact_number` Double,
  `country_code` Int,
  `company_name` Varchar(20),
  `email_id` Varchar(50),
  PRIMARY KEY (`customer_id`)
)
;

-- Table flight

CREATE TABLE `flight`
(
  `flight_id` Varchar(50) NOT NULL,
  `airline` Varchar(50),
  `awb` Varchar(50),
  `departure_timestamp` Datetime,
  `arrival_timestamp` Datetime,
  `flight_number` Varchar(20)
)
;

ALTER TABLE `flight` ADD PRIMARY KEY (`flight_id`)
;

-- Table cargo

CREATE TABLE `cargo`
(
  `cargo_id` Int NOT NULL AUTO_INCREMENT,
  `Length` Float,
  `Breadth` Float,
  `Height` Float,
  `Priority Delivery` Enum('yes','no') NOT NULL,
  `Temprature Controlled Service` Enum('yes','no') NOT NULL,
  `Perishable` Enum('yes','no') NOT NULL,
  `Stackable` Enum('yes','no') NOT NULL,
  `Package insured` Enum('yes','no') NOT NULL,
  `Package contains Liquid` Enum('yes','no') NOT NULL,
  `Fragile` Enum('yes','no') NOT NULL,
  `Dangerous goods` Enum('yes','no') NOT NULL,
  `Doc_ID` Varchar(50),
  `Class_Dangerous_goods` Varchar(50),
  `UN#` Varchar(50),
  `Commodity` Varchar(50),
  `Origin` Varchar(50),
  `Destination` Varchar(50),
  `gross_weight` Double,
  `chargable_weight` Double,
  `deck` Enum('ML','LD','ULD'),
  `status` Enum('Booked','Re-Booked','Cancelled','Quote-Request','on-hold'),
  `order_id` Int NOT NULL,
  `net_rate_per_kg` Double,
  `min_rate` Double,
  `cost` Double,
  `sc_dg` Double,
  `sc_fcs` Double,
  `sc_handling` Double,
  `sc_customs` Double,
  `sc_security` Double,
  `sc_screening` Double,
  PRIMARY KEY (`cargo_id`)
)
;

CREATE INDEX `IX_Relationship12` ON `cargo` (`order_id`)
;

-- Table orders

CREATE TABLE `orders`
(
  `order_id` Int NOT NULL AUTO_INCREMENT,
  `Ready_date` Datetime,
  `max_arrival_date` Datetime,
  `customer_id` Int NOT NULL,
  PRIMARY KEY (`order_id`)
)
;

CREATE INDEX `IX_Relationship1` ON `orders` (`customer_id`)
;

-- Table cost

CREATE TABLE `cost`
(
  `cost_id` Int NOT NULL,
  `net_rate/kg` Double,
  `min_rate` Double,
  `amount` Double,
  `surcharge_type` Enum('Handling','FCS','DG','Customs','Security','Screening'),
  `surcharge_amount` Double,
  `cargo_id` Int NOT NULL
)
;

CREATE INDEX `IX_Relationship8` ON `cost` (`cargo_id`)
;

ALTER TABLE `cost` ADD PRIMARY KEY (`cost_id`)
;

-- Table cargo_flight_tbl

CREATE TABLE `cargo_flight_tbl`
(
  `cargo_id` Int NOT NULL,
  `flight_id` Varchar(50) NOT NULL
)
;

ALTER TABLE `cargo_flight_tbl` ADD PRIMARY KEY (`cargo_id`,`flight_id`)
;

-- Table Invoice

CREATE TABLE `Invoice`
(
  `Invoice_id` Int NOT NULL AUTO_INCREMENT,
  `order_id` Int NOT NULL,
  `customer_id` Int NOT NULL,
  `amount` Float,
  `invoice_date` Datetime,
  `invoice_status` Varchar(20),
  PRIMARY KEY (`Invoice_id`)
)
;

CREATE INDEX `IX_Relationship10` ON `Invoice` (`order_id`)
;

CREATE INDEX `IX_Relationship11` ON `Invoice` (`customer_id`)
;

-- Table surcharge

CREATE TABLE `surcharge`
(
  `surcharge_id` Char(20) NOT NULL
)
;

ALTER TABLE `surcharge` ADD PRIMARY KEY (`surcharge_id`)
;

-- Create foreign keys (relationships) section ------------------------------------------------- 


ALTER TABLE `orders` ADD CONSTRAINT `customer_order` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `cargo_flight_tbl` ADD CONSTRAINT `cargo_lookup` FOREIGN KEY (`cargo_id`) REFERENCES `cargo` (`cargo_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `cargo_flight_tbl` ADD CONSTRAINT `flight_lookup` FOREIGN KEY (`flight_id`) REFERENCES `flight` (`flight_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `cost` ADD CONSTRAINT `cost_cargo` FOREIGN KEY (`cargo_id`) REFERENCES `cargo` (`cargo_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `Invoice` ADD CONSTRAINT `order_invoice` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `Invoice` ADD CONSTRAINT `Customer_invoice` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE `cargo` ADD CONSTRAINT `orders_cargo` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


