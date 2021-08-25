DROP DATABASE IF EXISTS `accidents`;

CREATE DATABASE `accidents`;

USE accidents;

DROP TABLE IF EXISTS `accident`;
CREATE TABLE `accident` (
  `acc_id` int NOT NULL AUTO_INCREMENT,
  `lum` int(1) DEFAULT NULL,
  `dep` varchar(5) DEFAULT NULL,
  `agg` int(1) DEFAULT NULL,
  `atm` int(1) DEFAULT NULL,
  `date` DATE DEFAULT NULL,
  `cat_time` int(4) DEFAULT NULL,
  `journee` varchar(10) DEFAULT NULL,
  `zone` varchar(5) DEFAULT NULL,
  `grav_moy` float(10) DEFAULT NULL,
  `vac` varchar(10) DEFAULT NULL,
  `grav_class` int(1) DEFAULT NULL,
  PRIMARY KEY (`acc_id`)
);