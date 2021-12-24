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

 Date: 24/12/2021 10:53:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for acs_centers
-- ----------------------------
DROP TABLE IF EXISTS `acs_centers`;
CREATE TABLE `acs_centers` (
  `loc_id` int NOT NULL,
  `street_address` varchar(100) NOT NULL,
  `telephone_number` varchar(20) NOT NULL,
  PRIMARY KEY (`loc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of acs_centers
-- ----------------------------
BEGIN;
INSERT INTO `acs_centers` VALUES (111, 'SZU', '88888888');
INSERT INTO `acs_centers` VALUES (222, 'NanShan Hospital', '120');
INSERT INTO `acs_centers` VALUES (333, 'Software Industry Base', '99999999');
COMMIT;

-- ----------------------------
-- Table structure for cars
-- ----------------------------
DROP TABLE IF EXISTS `cars`;
CREATE TABLE `cars` (
  `car_id` int NOT NULL AUTO_INCREMENT,
  `make` varchar(20) NOT NULL,
  `model` varchar(30) NOT NULL,
  `price_per_hour` float NOT NULL,
  `price_per_day` float NOT NULL,
  `pic_url` varchar(255) DEFAULT NULL,
  `capacity` int NOT NULL,
  PRIMARY KEY (`car_id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of cars
-- ----------------------------
BEGIN;
INSERT INTO `cars` VALUES (101, 'Subaru', 'Impreza', 3.9, 39, 'https://cdn.jsdelivr.net/gh/demonsheart/Pic@main/car/car1.jpg', 5);
INSERT INTO `cars` VALUES (102, 'Lexus', 'IS250', 5, 50, 'https://cdn.jsdelivr.net/gh/demonsheart/Pic@main/car/car2.jpg', 5);
INSERT INTO `cars` VALUES (103, 'Smart', 'Passion', 4, 40, 'https://cdn.jsdelivr.net/gh/demonsheart/Pic@main/car/car3.jpg', 3);
INSERT INTO `cars` VALUES (104, 'Toyota', 'Prius Liftback', 5.5, 55, 'https://cdn.jsdelivr.net/gh/demonsheart/Pic@main/car/car4.jpg', 5);
INSERT INTO `cars` VALUES (105, 'Honda', 'Element', 3.9, 39, 'https://cdn.jsdelivr.net/gh/demonsheart/Pic@main/car/car5.jpg', 4);
INSERT INTO `cars` VALUES (106, 'Alfa Romeo', 'Saloon', 4.2, 42, 'https://cdn.jsdelivr.net/gh/demonsheart/Pic@main/car/car6.jpg', 4);
INSERT INTO `cars` VALUES (107, 'Audi', 'Hatchback', 4.5, 45, 'https://cdn.jsdelivr.net/gh/demonsheart/Pic@main/car/car7.jpg', 3);
INSERT INTO `cars` VALUES (108, 'Bentley', 'SUV', 5.6, 56, 'https://cdn.jsdelivr.net/gh/demonsheart/Pic@main/car/car8.jpg', 5);
INSERT INTO `cars` VALUES (109, 'Chevrolet', 'Station Wagon', 7.8, 78, 'https://cdn.jsdelivr.net/gh/demonsheart/Pic@main/car/car9.jpg', 8);
INSERT INTO `cars` VALUES (110, 'Dodge', 'Sedan', 3.9, 39, 'https://cdn.jsdelivr.net/gh/demonsheart/Pic@main/car/car10.jpg', 4);
COMMIT;

-- ----------------------------
-- Table structure for cus_pw
-- ----------------------------
DROP TABLE IF EXISTS `cus_pw`;
CREATE TABLE `cus_pw` (
  `cp_id` int NOT NULL AUTO_INCREMENT,
  `cus_id` int NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`cp_id`),
  UNIQUE KEY `cus_id` (`cus_id`),
  CONSTRAINT `cus_pw_fk` FOREIGN KEY (`cus_id`) REFERENCES `customers` (`cus_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of cus_pw
-- ----------------------------
BEGIN;
INSERT INTO `cus_pw` VALUES (1, 888, '888888');
INSERT INTO `cus_pw` VALUES (2, 889, '889889');
INSERT INTO `cus_pw` VALUES (3, 890, '890890');
INSERT INTO `cus_pw` VALUES (4, 900, '900900');
INSERT INTO `cus_pw` VALUES (5, 901, '901901');
INSERT INTO `cus_pw` VALUES (6, 902, '902902');
INSERT INTO `cus_pw` VALUES (7, 903, '903903');
INSERT INTO `cus_pw` VALUES (8, 904, '904904');
INSERT INTO `cus_pw` VALUES (9, 905, '905905');
INSERT INTO `cus_pw` VALUES (10, 906, '906906');
COMMIT;

-- ----------------------------
-- Table structure for cus_token
-- ----------------------------
DROP TABLE IF EXISTS `cus_token`;
CREATE TABLE `cus_token` (
  `ct_id` int NOT NULL AUTO_INCREMENT,
  `cus_id` int NOT NULL,
  `token` varchar(50) NOT NULL,
  PRIMARY KEY (`ct_id`),
  UNIQUE KEY `cus_id` (`cus_id`),
  CONSTRAINT `cus_token_fk` FOREIGN KEY (`cus_id`) REFERENCES `customers` (`cus_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of cus_token
-- ----------------------------
BEGIN;
INSERT INTO `cus_token` VALUES (1, 888, '888888');
INSERT INTO `cus_token` VALUES (2, 889, '889889');
INSERT INTO `cus_token` VALUES (3, 890, '890890');
INSERT INTO `cus_token` VALUES (4, 900, '900900');
INSERT INTO `cus_token` VALUES (5, 901, '901901');
INSERT INTO `cus_token` VALUES (6, 902, '902902');
INSERT INTO `cus_token` VALUES (7, 903, '903903');
INSERT INTO `cus_token` VALUES (8, 904, '904904');
INSERT INTO `cus_token` VALUES (9, 905, '905905');
INSERT INTO `cus_token` VALUES (10, 906, '906906');
COMMIT;

-- ----------------------------
-- Table structure for customers
-- ----------------------------
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `cus_id` int NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `hometown` varchar(50) NOT NULL,
  `cell_phone` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `credit_card` varchar(20) DEFAULT NULL,
  `is_student` tinyint(1) NOT NULL,
  `license_number` varchar(20) DEFAULT NULL,
  `license_state` enum('valid','invalid') DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  PRIMARY KEY (`cus_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of customers
-- ----------------------------
BEGIN;
INSERT INTO `customers` VALUES (888, 'RJ', 'H', 'GuangDong', '7758258', '2509875617@qq.com', '0438038', 1, '888888', 'valid', '2027-12-17');
INSERT INTO `customers` VALUES (889, 'Murray', 'Annabelle', 'ShangHai', '1111111', 'belle@comcast.net', '0903333', 0, '129038', 'invalid', NULL);
INSERT INTO `customers` VALUES (890, 'Smith', 'Patricia', 'NanNing', '3333333', 'patti1@gmail.com', '3223232', 0, '878787', 'valid', '2029-12-11');
INSERT INTO `customers` VALUES (900, 'Quinn', 'Sean', 'ShenZhen', '2222222', 'quinn45@gmail.com', '3243244', 0, '787878', 'valid', '2026-12-17');
INSERT INTO `customers` VALUES (901, 'Theodore', 'Jay', 'ChongQing', '7878939', 'jicwhv@gmail.com', '8989898', 0, '647633', 'valid', '2022-07-21');
INSERT INTO `customers` VALUES (902, 'Arthur', 'Mike', 'Alaska', '3737333', 'hajhd@twitter.com', '7832733', 1, NULL, NULL, NULL);
INSERT INTO `customers` VALUES (903, 'Luna', 'Smiss', 'California', '883333', 'Luna@appple.com', '7238728', 0, NULL, NULL, NULL);
INSERT INTO `customers` VALUES (904, 'Riley', 'Zhou', 'Georgia', '823444', 'Rilley@qq.com', '8333323', 0, NULL, NULL, NULL);
INSERT INTO `customers` VALUES (905, 'Victoria', 'Zoe', 'Illinois', '672633', 'Viddd@appleid.com', '2738464', 1, '232323', 'invalid', NULL);
INSERT INTO `customers` VALUES (906, 'Elizabeth', 'Ruby', 'Maryland', '743874', '834665@163.com', '3672534', 1, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for punishments
-- ----------------------------
DROP TABLE IF EXISTS `punishments`;
CREATE TABLE `punishments` (
  `punish_id` int NOT NULL AUTO_INCREMENT,
  `cus_id` int NOT NULL,
  `punish_time` datetime NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`punish_id`),
  KEY `punishments_fk` (`cus_id`),
  CONSTRAINT `punishments_fk` FOREIGN KEY (`cus_id`) REFERENCES `customers` (`cus_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of punishments
-- ----------------------------
BEGIN;
INSERT INTO `punishments` VALUES (2, 888, '2021-12-17 20:40:26', 'Running red light');
INSERT INTO `punishments` VALUES (3, 889, '2021-12-17 21:19:32', 'Drunk driving');
INSERT INTO `punishments` VALUES (4, 901, '2021-12-15 10:15:01', 'Drunk driving');
INSERT INTO `punishments` VALUES (5, 904, '2018-12-13 10:20:37', 'Running red light');
COMMIT;

-- ----------------------------
-- Table structure for rentals
-- ----------------------------
DROP TABLE IF EXISTS `rentals`;
CREATE TABLE `rentals` (
  `rental_id` int NOT NULL AUTO_INCREMENT,
  `cus_id` int NOT NULL,
  `car_id` int NOT NULL,
  `pick_up_loc_id` int NOT NULL,
  `drop_off_loc_id` int NOT NULL,
  `start_time` datetime NOT NULL,
  `billed_type` enum('hour','day') NOT NULL,
  `billed_count` int NOT NULL,
  `total_price` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`rental_id`),
  KEY `rentals_car_fk` (`car_id`),
  KEY `rentals_cus_fk` (`cus_id`),
  KEY `rentals_drop_fk` (`drop_off_loc_id`),
  KEY `rentals_pick_fk` (`pick_up_loc_id`),
  CONSTRAINT `rentals_car_fk` FOREIGN KEY (`car_id`) REFERENCES `cars` (`car_id`),
  CONSTRAINT `rentals_cus_fk` FOREIGN KEY (`cus_id`) REFERENCES `customers` (`cus_id`),
  CONSTRAINT `rentals_drop_fk` FOREIGN KEY (`drop_off_loc_id`) REFERENCES `acs_centers` (`loc_id`),
  CONSTRAINT `rentals_pick_fk` FOREIGN KEY (`pick_up_loc_id`) REFERENCES `acs_centers` (`loc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of rentals
-- ----------------------------
BEGIN;
INSERT INTO `rentals` VALUES (1, 888, 101, 222, 111, '2021-12-17 22:32:13', 'hour', 5, 19.5);
INSERT INTO `rentals` VALUES (2, 889, 102, 111, 111, '2021-12-16 22:29:13', 'day', 2, 100);
INSERT INTO `rentals` VALUES (3, 890, 103, 333, 222, '2021-12-08 22:39:08', 'hour', 4, 16);
INSERT INTO `rentals` VALUES (4, 900, 104, 222, 333, '2021-12-13 22:40:11', 'day', 3, 165);
INSERT INTO `rentals` VALUES (5, 901, 105, 222, 222, '2021-11-11 19:40:50', 'hour', 5, 19.5);
INSERT INTO `rentals` VALUES (6, 902, 106, 333, 111, '2021-10-21 18:41:34', 'day', 6, 252);
INSERT INTO `rentals` VALUES (7, 903, 107, 111, 333, '2020-12-17 22:42:44', 'hour', 4, 18);
INSERT INTO `rentals` VALUES (8, 904, 108, 222, 333, '2021-12-15 18:43:16', 'day', 3, 168);
INSERT INTO `rentals` VALUES (9, 905, 109, 333, 333, '2021-12-10 16:40:42', 'hour', 2, 15.6);
INSERT INTO `rentals` VALUES (10, 906, 110, 222, 222, '2021-09-17 22:31:19', 'hour', 6, 23.4);
INSERT INTO `rentals` VALUES (11, 888, 105, 222, 333, '2021-12-18 14:33:00', 'day', 4, 156);
INSERT INTO `rentals` VALUES (12, 889, 103, 111, 111, '2021-10-18 14:33:27', 'hour', 4, 16);
INSERT INTO `rentals` VALUES (13, 890, 101, 333, 222, '2021-12-16 16:33:55', 'day', 3, 117);
INSERT INTO `rentals` VALUES (14, 900, 109, 333, 111, '2021-12-18 14:34:27', 'hour', 6, 46.8);
INSERT INTO `rentals` VALUES (15, 901, 108, 222, 222, '2021-10-20 14:34:49', 'day', 4, 224);
INSERT INTO `rentals` VALUES (16, 888, 101, 222, 222, '2021-12-18 14:47:31', 'day', 3, 117);
INSERT INTO `rentals` VALUES (17, 888, 101, 222, 222, '2021-10-18 14:49:33', 'day', 1, 39);
INSERT INTO `rentals` VALUES (18, 888, 106, 222, 222, '2021-12-20 09:55:52', 'hour', 3, 12.6);
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
	FROM customers AS c LEFT JOIN punishments AS p
	ON c.cus_id = p.cus_id
	WHERE c.is_student = 1 
	OR ((p.punish_id IS NOT NULL) AND (p.punish_time > DATE_SUB(CURDATE(),INTERVAL 3 YEAR)));
END
;;
delimiter ;

-- ----------------------------
-- Function structure for get_car_per_price
-- ----------------------------
DROP FUNCTION IF EXISTS `get_car_per_price`;
delimiter ;;
CREATE FUNCTION `get_car_per_price`(id int,  billed_type enum('hour', 'day'))
 RETURNS float
  READS SQL DATA 
  SQL SECURITY INVOKER
BEGIN
  		DECLARE per_price FLOAT;
		SET per_price = 0;

		IF billed_type = 'hour' THEN
		SELECT price_per_hour INTO per_price FROM cars WHERE car_id = id;
		ELSEIF billed_type = 'day' THEN
		SELECT price_per_day INTO per_price FROM cars WHERE car_id = id;
		END IF;
		
		RETURN per_price;
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
-- Procedure structure for init_total_price
-- ----------------------------
DROP PROCEDURE IF EXISTS `init_total_price`;
delimiter ;;
CREATE PROCEDURE `init_total_price`()
  MODIFIES SQL DATA 
  SQL SECURITY INVOKER
BEGIN
  DECLARE c_id INT DEFAULT 0;
	DECLARE r_id INT DEFAULT 0;
	DECLARE type VARCHAR(10) DEFAULT '';
	DECLARE num INT DEFAULT 0;
	DECLARE done BOOLEAN DEFAULT 0;
	DECLARE rentals_cursor CURSOR FOR SELECT rental_id, car_id, billed_type, billed_count FROM rentals;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
	
OPEN rentals_cursor;
REPEAT
	FETCH rentals_cursor INTO r_id, c_id, type, num;
	IF done != 1 THEN
	  UPDATE rentals SET total_price = get_car_per_price(c_id, type) * num WHERE rental_id = r_id;
	END IF;
UNTIL done END REPEAT;
CLOSE rentals_cursor;

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
	WHERE ac.loc_id = r.pick_up_loc_id
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
  SELECT c.make, c.model, cus.is_student, COUNT(*) AS number_of_times_rented
	FROM customers AS cus, rentals AS r, cars AS c
	WHERE cus.cus_id = r.cus_id AND r.car_id = c.car_id
	GROUP BY c.make, c.model, cus.is_student
	ORDER BY cus.is_student;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table rentals
-- ----------------------------
DROP TRIGGER IF EXISTS `insert_total_price`;
delimiter ;;
CREATE TRIGGER `insert_total_price` BEFORE INSERT ON `rentals` FOR EACH ROW BEGIN
	SET new.total_price = get_car_per_price(new.car_id, new.billed_type) * new.billed_count;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
