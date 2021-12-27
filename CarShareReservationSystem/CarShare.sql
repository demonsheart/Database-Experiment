/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : CarShare

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 27/12/2021 13:02:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for acs_centers
-- ----------------------------
DROP TABLE IF EXISTS `acs_centers`;
CREATE TABLE `acs_centers` (
  `loc_id` int NOT NULL,
  `street_address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `telephone_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`loc_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of acs_centers
-- ----------------------------
BEGIN;
INSERT INTO `acs_centers` VALUES (59, '1400 W Peachtree NE', '404-897-0021');
INSERT INTO `acs_centers` VALUES (60, '800 Cherokee Drive', '404-776-1022');
INSERT INTO `acs_centers` VALUES (61, '2238 Perkerson Road', '404-223-1056');
COMMIT;

-- ----------------------------
-- Table structure for cars
-- ----------------------------
DROP TABLE IF EXISTS `cars`;
CREATE TABLE `cars` (
  `car_id` int NOT NULL,
  `make` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `model` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `capacity` int NOT NULL,
  `description` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price_per_hour` float unsigned NOT NULL,
  `price_per_day` float unsigned NOT NULL,
  `pic_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`car_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of cars
-- ----------------------------
BEGIN;
INSERT INTO `cars` VALUES (101, 'Subaru', 'Impreza', 5, '4 Door 4WD Sedan', 3.9, 39, 'https://cdn.jsdelivr.net/gh/demonsheart/Pic@main/car/car1.jpg');
INSERT INTO `cars` VALUES (102, 'Lexus', 'IS250', 5, '4 Door Luxury Sedan', 5, 50, 'https://cdn.jsdelivr.net/gh/demonsheart/Pic@main/car/car2.jpg');
INSERT INTO `cars` VALUES (103, 'Smart', 'Passion', 2, '2 Door Microcar', 4, 40, 'https://cdn.jsdelivr.net/gh/demonsheart/Pic@main/car/car3.jpg');
INSERT INTO `cars` VALUES (104, 'Toyota', 'Prius Liftback', 5, '4 Door Hybrid', 5.5, 55, 'https://cdn.jsdelivr.net/gh/demonsheart/Pic@main/car/car4.jpg');
INSERT INTO `cars` VALUES (105, 'Honda', 'Element', 5, '5 Door SUV', 3.9, 39, 'https://cdn.jsdelivr.net/gh/demonsheart/Pic@main/car/car5.jpg');
COMMIT;

-- ----------------------------
-- Table structure for customers
-- ----------------------------
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `cus_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `credit_card` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_student` tinyint NOT NULL,
  `tickets` int NOT NULL,
  `license` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `state` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `last_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `first_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `hometown` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `telephone` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cell_phone` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`cus_id`) USING BTREE,
  UNIQUE KEY `cus_id_un` (`cus_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of customers
-- ----------------------------
BEGIN;
INSERT INTO `customers` VALUES ('B-17', 'demodemo', '443376562837', 0, 0, '67556', 'GA', NULL, 'Berry', 'Anna', '9 Pleasant Way', '404-887-4673', '404-876-3376', 'aberry@hotmail.com');
INSERT INTO `customers` VALUES ('bank', 'demodemo', '232', 1, 5, '3232', 'NY', '2021-12-27', 'Dw', 'Dwe', 'Dwe dwe', 'dwed', 'dwe', 'dwed');
INSERT INTO `customers` VALUES ('F-59', 'demodemo', '443398764532', 0, 0, '88765', 'GA', '2015-08-09', 'Franco', 'Gianne', '1012 Peachtree St', '404-887-2342', '404-765-1263', 'gf59@gmail.com');
INSERT INTO `customers` VALUES ('L-29', 'demodemo', '443352635423', 0, 0, '76789', 'GA', '2011-03-15', 'Lopato', 'Maria', '5490 West 5th', '404-234-8876', '569-001-0989', 'mrl@hotmail.com');
INSERT INTO `customers` VALUES ('M-62', 'demodemo', '443355463212', 1, 2, '92019', 'NY', '2012-06-06', 'Murray', 'Annabelle', '59 W. Central Ave', '404-998-3928', '404-887-3829', 'belle@comcast.net');
INSERT INTO `customers` VALUES ('P-91', 'demodemo', '443367256543', 0, 0, '12332', 'GA', '2015-07-11', 'Pao', 'Jack', '89 Orchard', '404-887-9238', '404-342-9087', 'pao@comcast.net');
INSERT INTO `customers` VALUES ('Q-13', 'demodemo', '443398765439', 1, 1, '87678', 'GA', '2013-09-01', 'Quinn', 'Sean', '54 Oak Ave', '404-987-3427', '569-984-3894', 'quinn45@gmail.com');
INSERT INTO `customers` VALUES ('S-63', 'demodemo', '443398762534', 1, 2, '76877', 'PA', '2011-05-01', 'Smith', 'Patricia', '1700 E. Lincoln Ave', '404-765-3342', '404-121-4736', 'patti1@gmail.com');
INSERT INTO `customers` VALUES ('Z-30', 'demodemo', '443357643254', 0, 0, '56876', 'GA', '2010-04-30', 'Zern', 'John', '58 W. Central Ave', '404-675-0091', '404-776-4536', 'zern@comcast.net');
COMMIT;

-- ----------------------------
-- Table structure for rentals
-- ----------------------------
DROP TABLE IF EXISTS `rentals`;
CREATE TABLE `rentals` (
  `rental_id` varchar(20) NOT NULL,
  `rental_date` date DEFAULT NULL,
  `pick_up_time` datetime DEFAULT NULL,
  `drop_off_time` datetime DEFAULT NULL,
  `cus_id` varchar(10) NOT NULL,
  `car_id` int NOT NULL,
  `loc_id` int NOT NULL,
  `total_price` float NOT NULL,
  PRIMARY KEY (`rental_id`),
  KEY `rentals_car_fk` (`car_id`),
  KEY `rentals_cus_fk` (`cus_id`),
  KEY `rentals_loc_fk` (`loc_id`),
  CONSTRAINT `rentals_car_fk` FOREIGN KEY (`car_id`) REFERENCES `cars` (`car_id`),
  CONSTRAINT `rentals_cus_fk` FOREIGN KEY (`cus_id`) REFERENCES `customers` (`cus_id`),
  CONSTRAINT `rentals_loc_fk` FOREIGN KEY (`loc_id`) REFERENCES `acs_centers` (`loc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of rentals
-- ----------------------------
BEGIN;
INSERT INTO `rentals` VALUES ('Dec-112', '2021-12-27', '2021-12-27 09:33:40', '2021-12-27 13:33:00', 'B-17', 102, 59, 19.9167);
INSERT INTO `rentals` VALUES ('Dec-113', '2021-12-27', '2021-12-27 10:38:29', '2021-12-27 10:40:00', 'B-17', 104, 60, 0.0916667);
INSERT INTO `rentals` VALUES ('Dec-114', '2021-12-27', '2021-12-27 10:40:57', '2021-12-27 12:40:00', 'B-17', 101, 61, 7.735);
INSERT INTO `rentals` VALUES ('Dec-115', '2021-12-27', '2021-12-27 11:20:24', '2021-12-27 23:21:00', 'B-17', 105, 60, 46.8);
INSERT INTO `rentals` VALUES ('Dec-116', '2021-12-27', '2021-12-28 11:27:00', '2021-12-28 11:28:00', 'bank', 101, 60, 0.065);
INSERT INTO `rentals` VALUES ('Dec-117', '2021-12-27', '2021-12-27 11:35:42', '2021-12-27 11:36:00', 'bank', 103, 61, 0);
INSERT INTO `rentals` VALUES ('Dec-118', '2021-12-27', '2021-12-27 11:38:36', '2021-12-27 11:45:00', 'bank', 104, 59, 0.55);
INSERT INTO `rentals` VALUES ('Dec-119', '2021-12-27', '2021-12-27 12:59:59', '2021-12-27 13:59:00', 'bank', 103, 60, 3.93333);
INSERT INTO `rentals` VALUES ('Dec-120', '2021-12-27', '2021-12-27 13:01:12', '2021-12-27 20:02:00', 'bank', 104, 61, 38.5);
INSERT INTO `rentals` VALUES ('Feb-101', '2010-02-03', '2010-02-03 09:00:00', '2010-02-03 12:00:00', 'M-62', 101, 60, 11.7);
INSERT INTO `rentals` VALUES ('Feb-102', '2010-02-03', '2010-02-03 13:00:00', '2010-02-03 17:00:00', 'F-59', 101, 59, 15.6);
INSERT INTO `rentals` VALUES ('Feb-103', '2010-02-04', '2010-02-04 08:00:00', '2010-02-04 17:00:00', 'Q-13', 103, 60, 36);
INSERT INTO `rentals` VALUES ('Feb-104', '2010-02-05', '2010-02-05 12:00:00', '2010-02-07 12:00:00', 'L-29', 105, 60, 78);
INSERT INTO `rentals` VALUES ('Feb-105', '2010-02-07', '2010-02-07 10:00:00', '2010-02-07 16:00:00', 'Z-30', 104, 61, 33);
INSERT INTO `rentals` VALUES ('Feb-106', '2010-02-10', '2010-02-10 11:00:00', '2010-02-10 13:00:00', 'S-63', 102, 60, 10);
INSERT INTO `rentals` VALUES ('Feb-107', '2010-02-10', '2010-02-10 08:00:00', '2010-02-10 11:30:00', 'Q-13', 103, 60, 14);
INSERT INTO `rentals` VALUES ('Feb-108', '2010-02-15', '2010-02-15 14:00:00', '2010-02-16 14:00:00', 'S-63', 102, 59, 50);
INSERT INTO `rentals` VALUES ('Feb-109', '2010-02-15', '2010-02-15 10:00:00', '2010-02-15 20:00:00', 'P-91', 105, 60, 39);
INSERT INTO `rentals` VALUES ('Feb-110', '2010-02-15', '2010-02-15 09:00:00', '2010-02-15 17:00:00', 'B-17', 101, 60, 28.8);
INSERT INTO `rentals` VALUES ('Feb-111', '2010-02-17', '2010-02-17 09:00:00', '2010-02-17 17:00:00', 'B-17', 101, 60, 31.2);
COMMIT;

-- ----------------------------
-- Procedure structure for cus_on_probation
-- ----------------------------
DROP PROCEDURE IF EXISTS `cus_on_probation`;
delimiter ;;
CREATE PROCEDURE `cus_on_probation`()
  READS SQL DATA 
  SQL SECURITY INVOKER
BEGIN
  SELECT last_name, first_name, email
	FROM customers
	WHERE is_student = 1 OR tickets > 0;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for increase_price
-- ----------------------------
DROP PROCEDURE IF EXISTS `increase_price`;
delimiter ;;
CREATE PROCEDURE `increase_price`(IN hourly_increase float, IN daily_increase float)
  MODIFIES SQL DATA 
  SQL SECURITY INVOKER
BEGIN
  UPDATE cars
	SET price_per_hour = price_per_hour + hourly_increase, price_per_day = price_per_day + daily_increase;
	
	SELECT * FROM cars;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for number_of_passengers
-- ----------------------------
DROP PROCEDURE IF EXISTS `number_of_passengers`;
delimiter ;;
CREATE PROCEDURE `number_of_passengers`(IN cus_num int)
  READS SQL DATA 
  SQL SECURITY INVOKER
BEGIN
  SELECT *
	FROM cars
	WHERE capacity >= cus_num;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for popular_locations
-- ----------------------------
DROP PROCEDURE IF EXISTS `popular_locations`;
delimiter ;;
CREATE PROCEDURE `popular_locations`()
  READS SQL DATA 
  SQL SECURITY INVOKER
BEGIN
  SELECT ac.loc_id, ac.street_address, ac.telephone_number, COUNT(*) AS number_of_rentals
	FROM acs_centers AS ac, rentals as r
	WHERE ac.loc_id = r.loc_id
	GROUP BY ac.loc_id
	ORDER BY number_of_rentals DESC;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for rental_trends
-- ----------------------------
DROP PROCEDURE IF EXISTS `rental_trends`;
delimiter ;;
CREATE PROCEDURE `rental_trends`()
  READS SQL DATA 
  SQL SECURITY INVOKER
BEGIN
	SELECT c.make, c.model, s.is_student, COUNT(*) as number_of_times_rented 
	FROM cars c,customers s, rentals r
	WHERE c.car_id = r.car_id and r.cus_id = s.cus_id
	GROUP BY c.make, c.model ,s.is_student
	ORDER BY s.is_student DESC;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table rentals
-- ----------------------------
DROP TRIGGER IF EXISTS `init_pk`;
delimiter ;;
CREATE TRIGGER `init_pk` BEFORE INSERT ON `rentals` FOR EACH ROW BEGIN
  # create pk
	DECLARE month varchar(10);
	DECLARE n int;
	
	SELECT count(*) into n FROM rentals;
	
	set month = left(MONTHNAME(new.rental_date), 3);
	set new.rental_id = concat(month,"-",n + 101);
	
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table rentals
-- ----------------------------
DROP TRIGGER IF EXISTS `init_price`;
delimiter ;;
CREATE TRIGGER `init_price` BEFORE INSERT ON `rentals` FOR EACH ROW BEGIN

DECLARE hourly_price, day_price, interval_min, day_num, hour_num float;

SELECT price_per_hour INTO hourly_price from cars where new.car_id = cars.car_id;
SELECT price_per_day INTO day_price from cars where new.car_id = cars.car_id;

set interval_min = TIMESTAMPDIFF(MINUTE, new.pick_up_time, new.drop_off_time);
set day_num = floor(interval_min / 1440);
set hour_num = interval_min / 60 - day_num * 24;
set new.total_price = hour_num * hourly_price + day_num * day_price;

END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
