/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : CarShareSys

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 17/12/2021 22:45:14
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
  `car_id` int NOT NULL,
  `make` varchar(20) NOT NULL,
  `model` varchar(30) NOT NULL,
  `price_per_hour` float NOT NULL,
  `price_per_day` float NOT NULL,
  `capacity` int NOT NULL,
  PRIMARY KEY (`car_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of cars
-- ----------------------------
BEGIN;
INSERT INTO `cars` VALUES (101, 'Subaru', 'Impreza', 3.9, 39, 5);
INSERT INTO `cars` VALUES (102, 'Lexus', 'IS250', 5, 50, 5);
INSERT INTO `cars` VALUES (103, 'Smart', 'Passion', 4, 40, 3);
INSERT INTO `cars` VALUES (104, 'Toyota', 'Prius Liftback', 5.5, 55, 5);
INSERT INTO `cars` VALUES (105, 'Honda', 'Element', 3.9, 39, 4);
INSERT INTO `cars` VALUES (106, 'Alfa Romeo', 'Saloon', 4.2, 42, 4);
INSERT INTO `cars` VALUES (107, 'Audi', 'Hatchback', 4.5, 45, 3);
INSERT INTO `cars` VALUES (108, 'Bentley', 'SUV', 5.6, 56, 5);
INSERT INTO `cars` VALUES (109, 'Chevrolet', 'Station Wagon', 7.8, 78, 8);
INSERT INTO `cars` VALUES (110, 'Dodge', 'Sedan', 3.9, 39, 4);
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
INSERT INTO `customers` VALUES (889, 'Murray', 'Annabelle', 'ShangHai', '1111111', 'belle@comcast.net', '0903333', 1, '129038', 'invalid', NULL);
INSERT INTO `customers` VALUES (890, 'Smith', 'Patricia', 'NanNing', '3333333', 'patti1@gmail.com', '3223232', 0, '878787', 'valid', '2029-12-11');
INSERT INTO `customers` VALUES (900, 'Quinn', 'Sean', 'ShenZhen', '2222222', 'quinn45@gmail.com', '3243244', 0, '787878', 'valid', '2026-12-17');
INSERT INTO `customers` VALUES (901, 'Theodore', 'Jay', 'ChongQing', '7878939', 'jicwhv@gmail.com', '8989898', 0, '647633', 'valid', '2022-07-21');
INSERT INTO `customers` VALUES (902, 'Arthur', 'Mike', 'Alaska', '3737333', 'hajhd@twitter.com', '7832733', 1, NULL, NULL, NULL);
INSERT INTO `customers` VALUES (903, 'Luna', 'Smiss', 'California', '883333', 'Luna@appple.com', '7238728', 0, NULL, NULL, NULL);
INSERT INTO `customers` VALUES (904, 'Riley', 'Zhou', 'Georgia', '823444', 'Rilley@qq.com', '8333323', 1, NULL, NULL, NULL);
INSERT INTO `customers` VALUES (905, 'Victoria', 'Zoe', 'Illinois', '672633', 'Viddd@appleid.com', '2738464', 0, '232323', 'invalid', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of punishments
-- ----------------------------
BEGIN;
INSERT INTO `punishments` VALUES (2, 888, '2021-12-17 20:40:26', 'Running red light');
INSERT INTO `punishments` VALUES (3, 889, '2021-12-17 21:19:32', 'Drunk driving');
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
  PRIMARY KEY (`rental_id`),
  KEY `rentals_car_fk` (`car_id`),
  KEY `rentals_cus_fk` (`cus_id`),
  KEY `rentals_drop_fk` (`drop_off_loc_id`),
  KEY `rentals_pick_fk` (`pick_up_loc_id`),
  CONSTRAINT `rentals_car_fk` FOREIGN KEY (`car_id`) REFERENCES `cars` (`car_id`),
  CONSTRAINT `rentals_cus_fk` FOREIGN KEY (`cus_id`) REFERENCES `customers` (`cus_id`),
  CONSTRAINT `rentals_drop_fk` FOREIGN KEY (`drop_off_loc_id`) REFERENCES `acs_centers` (`loc_id`),
  CONSTRAINT `rentals_pick_fk` FOREIGN KEY (`pick_up_loc_id`) REFERENCES `acs_centers` (`loc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of rentals
-- ----------------------------
BEGIN;
INSERT INTO `rentals` VALUES (1, 888, 101, 222, 111, '2021-12-17 22:32:13', 'hour', 5);
INSERT INTO `rentals` VALUES (2, 889, 102, 111, 111, '2021-12-16 22:29:13', 'day', 2);
INSERT INTO `rentals` VALUES (3, 890, 103, 333, 222, '2021-12-08 22:39:08', 'hour', 4);
INSERT INTO `rentals` VALUES (4, 900, 104, 222, 333, '2021-12-13 22:40:11', 'day', 3);
INSERT INTO `rentals` VALUES (5, 901, 105, 222, 222, '2021-11-11 19:40:50', 'hour', 5);
INSERT INTO `rentals` VALUES (6, 902, 106, 333, 111, '2021-10-21 18:41:34', 'day', 6);
INSERT INTO `rentals` VALUES (7, 903, 107, 111, 333, '2020-12-17 22:42:44', 'hour', 4);
INSERT INTO `rentals` VALUES (8, 904, 108, 222, 333, '2021-12-15 18:43:16', 'day', 3);
INSERT INTO `rentals` VALUES (9, 905, 109, 333, 333, '2021-12-10 16:40:42', 'hour', 2);
INSERT INTO `rentals` VALUES (10, 906, 110, 222, 222, '2021-09-17 22:31:19', 'hour', 6);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
