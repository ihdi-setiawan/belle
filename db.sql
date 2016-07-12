-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.9 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table ds_bella.daily_journey_log
CREATE TABLE IF NOT EXISTS `daily_journey_log` (
  `d_date` date NOT NULL,
  `journey_id` int(11) NOT NULL,
  `key` varchar(24) NOT NULL,
  `value` text,
  `created_date` datetime NOT NULL,
  `created_by` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`d_date`,`journey_id`,`key`),
  KEY `daily_journey_log_ie1` (`journey_id`),
  KEY `daily_journey_log_ie2` (`key`),
  KEY `daily_journey_log_ie3` (`created_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabel daily log journey';

-- Dumping data for table ds_bella.daily_journey_log: ~9 rows (approximately)
DELETE FROM `daily_journey_log`;
/*!40000 ALTER TABLE `daily_journey_log` DISABLE KEYS */;
INSERT INTO `daily_journey_log` (`d_date`, `journey_id`, `key`, `value`, `created_date`, `created_by`) VALUES
	('2016-07-15', 1, 'Basal Temperatur', '37,1', '2016-07-04 17:33:49', 1),
	('2016-07-15', 1, 'Embryo Transfer', 'Belum dilakukan', '2016-07-04 17:33:49', 1),
	('2016-07-15', 1, 'Injections', 'Sudah ke 2 kali', '2016-07-04 17:33:49', 1),
	('2016-07-15', 1, 'Insemination', 'Sudah dilakukan', '2016-07-04 17:33:49', 1),
	('2016-07-15', 1, 'Intercourse', 'Yes', '2016-07-04 17:33:49', 1),
	('2016-07-15', 1, 'Medicines', 'Jaga kebersihan alat kelamin', '2016-07-04 17:33:49', 1),
	('2016-07-15', 1, 'Ovum Pick Up', 'Belum dilakukan', '2016-07-04 17:33:49', 1),
	('2016-07-15', 1, 'Pain', 'No', '2016-07-04 17:33:49', 1),
	('2016-07-15', 1, 'Visit Doctor', 'Yes', '2016-07-04 17:33:49', 1);
/*!40000 ALTER TABLE `daily_journey_log` ENABLE KEYS */;


-- Dumping structure for table ds_bella.device_token
CREATE TABLE IF NOT EXISTS `device_token` (
  `device_id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` varchar(80) NOT NULL,
  `user_id` int(11) NOT NULL,
  `device_token` varchar(80) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ended_date` datetime NOT NULL DEFAULT '3014-06-07 00:00:00',
  PRIMARY KEY (`device_id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

-- Dumping data for table ds_bella.device_token: 3 rows
DELETE FROM `device_token`;
/*!40000 ALTER TABLE `device_token` DISABLE KEYS */;
INSERT INTO `device_token` (`device_id`, `client_id`, `user_id`, `device_token`, `created_date`, `ended_date`) VALUES
	(13, 'android', 3, '123131231', '2016-07-07 17:03:32', '2016-07-09 00:02:37'),
	(16, 'android', 10, '123131231', '2016-07-09 15:54:57', '3014-06-07 00:00:00'),
	(17, 'android', 12, '123131231', '2016-07-09 15:56:58', '2016-07-12 18:31:18');
/*!40000 ALTER TABLE `device_token` ENABLE KEYS */;


-- Dumping structure for table ds_bella.journey
CREATE TABLE IF NOT EXISTS `journey` (
  `journey_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `menstrual_cycle_id` int(11) NOT NULL COMMENT 'Refer to tabel menstrual_cycle',
  `last_menstrual_date` datetime DEFAULT NULL,
  `start_period` datetime NOT NULL,
  `end_period` datetime NOT NULL,
  `note` text,
  `created_date` datetime NOT NULL,
  `ended_date` datetime DEFAULT '3014-12-31 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '1',
  `ended_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`journey_id`),
  UNIQUE KEY `journey_ak1` (`user_id`,`ended_date`),
  KEY `journey_ie1` (`created_date`),
  KEY `journey_ie2` (`created_by`),
  KEY `journey_ie3` (`ended_date`),
  KEY `journey_ie4` (`ended_by`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Tabel master journey';

-- Dumping data for table ds_bella.journey: ~0 rows (approximately)
DELETE FROM `journey`;
/*!40000 ALTER TABLE `journey` DISABLE KEYS */;
INSERT INTO `journey` (`journey_id`, `user_id`, `menstrual_cycle_id`, `last_menstrual_date`, `start_period`, `end_period`, `note`, `created_date`, `ended_date`, `created_by`, `ended_by`) VALUES
	(1, 2, 1, '2016-06-24 10:00:00', '2016-07-06 00:00:00', '2016-07-10 00:00:00', 'Note write here', '2016-07-04 17:33:48', '3014-12-31 00:00:00', 1, NULL);
/*!40000 ALTER TABLE `journey` ENABLE KEYS */;


-- Dumping structure for table ds_bella.journey_detail
CREATE TABLE IF NOT EXISTS `journey_detail` (
  `journey_detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `journey_id` int(11) NOT NULL,
  `fertile_date` date NOT NULL,
  `is_visit` tinyint(2) NOT NULL DEFAULT '0',
  `is_intercource` tinyint(2) NOT NULL DEFAULT '0',
  `is_ovulation` tinyint(2) NOT NULL DEFAULT '0',
  `created_date` datetime NOT NULL,
  `ended_date` datetime DEFAULT '3014-12-31 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '1',
  `ended_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`journey_detail_id`),
  KEY `journey_detail_ie1` (`journey_id`),
  KEY `journey_detail_ie2` (`fertile_date`),
  KEY `journey_detail_ie3` (`is_visit`),
  KEY `journey_detail_ie4` (`is_intercource`),
  KEY `journey_detail_ie5` (`is_ovulation`),
  KEY `journey_detail_ie6` (`created_date`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Tabel journey detail';

-- Dumping data for table ds_bella.journey_detail: ~5 rows (approximately)
DELETE FROM `journey_detail`;
/*!40000 ALTER TABLE `journey_detail` DISABLE KEYS */;
INSERT INTO `journey_detail` (`journey_detail_id`, `journey_id`, `fertile_date`, `is_visit`, `is_intercource`, `is_ovulation`, `created_date`, `ended_date`, `created_by`, `ended_by`) VALUES
	(1, 1, '2016-07-15', 1, 0, 0, '2016-07-04 17:33:49', '3014-12-31 00:00:00', 1, NULL),
	(2, 1, '2016-07-16', 1, 1, 0, '2016-07-04 17:33:49', '3014-12-31 00:00:00', 1, NULL),
	(3, 1, '2016-07-17', 1, 0, 1, '2016-07-04 17:33:49', '3014-12-31 00:00:00', 1, NULL),
	(4, 1, '2016-07-18', 1, 0, 0, '2016-07-04 17:33:49', '3014-12-31 00:00:00', 1, NULL),
	(5, 1, '2016-07-19', 1, 0, 0, '2016-07-04 17:33:49', '3014-12-31 00:00:00', 1, NULL);
/*!40000 ALTER TABLE `journey_detail` ENABLE KEYS */;


-- Dumping structure for table ds_bella.menstrual_cycle
CREATE TABLE IF NOT EXISTS `menstrual_cycle` (
  `menstrual_cycle_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  `cycle_day` int(11) NOT NULL,
  `ended_date` datetime DEFAULT '3014-12-31 00:00:00',
  `ended_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`menstrual_cycle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Tabel Master Menstrual cycle';

-- Dumping data for table ds_bella.menstrual_cycle: ~2 rows (approximately)
DELETE FROM `menstrual_cycle`;
/*!40000 ALTER TABLE `menstrual_cycle` DISABLE KEYS */;
INSERT INTO `menstrual_cycle` (`menstrual_cycle_id`, `name`, `description`, `cycle_day`, `ended_date`, `ended_by`) VALUES
	(1, 'Normal', NULL, 24, '3014-12-31 00:00:00', NULL),
	(2, 'Irregular', NULL, 24, '3014-12-31 00:00:00', NULL);
/*!40000 ALTER TABLE `menstrual_cycle` ENABLE KEYS */;


-- Dumping structure for table ds_bella.oauth_access_tokens
CREATE TABLE IF NOT EXISTS `oauth_access_tokens` (
  `access_token` varchar(40) NOT NULL,
  `client_id` varchar(80) NOT NULL,
  `user_id` int(11) NOT NULL,
  `expires` timestamp NOT NULL,
  `scope` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`access_token`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table ds_bella.oauth_access_tokens: 23 rows
DELETE FROM `oauth_access_tokens`;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` (`access_token`, `client_id`, `user_id`, `expires`, `scope`) VALUES
	('5be1be0951d6b1865b64f6ce961e4fe3d66a65e8', 'android', 12, '2017-07-09 15:58:36', NULL),
	('523de00fb20c86984df8c8f4f65e183da03f0dba', 'android', 12, '2017-07-09 15:58:24', NULL),
	('a8c16d6fcd11efe1ad91cc5ee2aaf7adc78917c8', 'android', 12, '2017-07-09 15:57:57', NULL),
	('82443d9a7490c57d6dfe814010ff1e0ada750aa0', 'android', 12, '2017-07-09 15:57:46', NULL),
	('b5c10400b2b4038dfe6a3a447d8a1a3370918366', 'android', 12, '2017-07-09 15:57:36', NULL),
	('67ac22d4a04fdf3a32e865ddf51c47a6970dc36f', 'android', 12, '2017-07-09 15:57:32', NULL),
	('6b33f50950249ca71e0b8db1bc3f26beaff87770', 'android', 12, '2017-07-09 15:56:58', NULL),
	('1c937af29177d327d470f9a4473b42dc8bd27fca', 'android', 10, '2017-07-09 15:54:57', NULL),
	('908269e2ce629fa38eb6bbe6808450231aaa30b9', 'android', 3, '2017-07-09 15:10:10', NULL),
	('60cc5dffef6c60aa3f8f4aba9618ac7fd8087b8c', 'android', 3, '2017-07-09 14:56:09', NULL),
	('c164ccfa27930e7ee933ad70d2f0214979e7fa0d', 'android', 3, '2017-07-09 13:10:59', NULL),
	('6d357f9af1ba253720ab4f6cf4c597bc4867b0c7', 'android', 3, '2017-07-09 00:10:19', NULL),
	('2ba9247e259bf6184aa8088f12bc56dea8ce23fa', 'android', 3, '2017-07-08 23:52:00', NULL),
	('379d95993d5b79d284cd1d0221f425b2525d08aa', 'android', 3, '2017-07-08 23:47:22', NULL),
	('12e185e4c8cb6770f07a3af0b981f780c7d82618', 'android', 3, '2017-07-08 23:45:29', NULL),
	('34c0d40c7b3eec334347815adb0a6a089ae96adb', 'android', 3, '2017-07-08 23:45:23', NULL),
	('af07e73dbe4fda19e06d01a2bd13c586d9772649', 'android', 3, '2017-07-08 23:41:59', NULL),
	('3205c0ac1475507cf2bb46aefe57db7b2cda0ff0', 'android', 3, '2017-07-08 23:35:23', NULL),
	('57f2887f367e385b2c2211d3cfb353136a2b2a8d', 'android', 3, '2017-07-08 23:35:13', NULL),
	('63c1555d239847c47a1e7b5327449f93d29e209e', 'android', 3, '2017-07-08 23:33:06', NULL),
	('8c6f1fdbdd5e09f1056a7b4678eec3c629082a48', 'android', 3, '2017-07-08 21:59:38', NULL),
	('9b42ab2c240d0844c56d6dc0f467a663165980b1', 'android', 3, '2017-07-08 22:02:38', NULL),
	('a8934f57616e5201c54aaddd1affa61fe7cd6b79', 'android', 3, '2017-07-08 23:05:24', NULL);
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;


-- Dumping structure for table ds_bella.oauth_clients
CREATE TABLE IF NOT EXISTS `oauth_clients` (
  `client_id` varchar(80) NOT NULL,
  `client_secret` varchar(80) DEFAULT NULL,
  `redirect_uri` varchar(2000) NOT NULL,
  `grant_types` varchar(80) DEFAULT NULL,
  `scope` varchar(100) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_mobile` tinyint(2) NOT NULL,
  `ended_date` datetime NOT NULL DEFAULT '3016-07-07 00:00:00',
  PRIMARY KEY (`client_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table ds_bella.oauth_clients: 2 rows
DELETE FROM `oauth_clients`;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` (`client_id`, `client_secret`, `redirect_uri`, `grant_types`, `scope`, `user_id`, `is_mobile`, `ended_date`) VALUES
	('android', 'belle', '/', 'password', NULL, NULL, 1, '3016-07-07 00:00:00'),
	('iPhone', 'belle', '/', 'password', NULL, NULL, 1, '3016-07-07 00:00:00');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;


-- Dumping structure for table ds_bella.oauth_scopes
CREATE TABLE IF NOT EXISTS `oauth_scopes` (
  `scope` varchar(80) NOT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`scope`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table ds_bella.oauth_scopes: 0 rows
DELETE FROM `oauth_scopes`;
/*!40000 ALTER TABLE `oauth_scopes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_scopes` ENABLE KEYS */;


-- Dumping structure for table ds_bella.type
CREATE TABLE IF NOT EXISTS `type` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(45) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  `ended_date` datetime DEFAULT '3014-12-31 00:00:00',
  `ended_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Tabel Master Type';

-- Dumping data for table ds_bella.type: ~2 rows (approximately)
DELETE FROM `type`;
/*!40000 ALTER TABLE `type` DISABLE KEYS */;
INSERT INTO `type` (`type_id`, `type_name`, `description`, `ended_date`, `ended_by`) VALUES
	(1, 'Trying to Concieve', 'Get pregnant faster and heal', '3014-12-31 00:00:00', NULL),
	(2, 'Avoiding Pregnancy', 'Track your cycle and birth control', '3014-12-31 00:00:00', NULL),
	(3, 'Vitro Fertilization', 'Manage your fertility medications, IUI and IVF treatments', '3014-12-31 00:00:00', NULL);
/*!40000 ALTER TABLE `type` ENABLE KEYS */;


-- Dumping structure for table ds_bella.user
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(64) NOT NULL,
  `password` varchar(60) NOT NULL,
  `first_name` varchar(64) NOT NULL,
  `last_name` varchar(64) DEFAULT NULL,
  `contact_no` varchar(16) DEFAULT NULL,
  `created_date` datetime NOT NULL,
  `ended_date` datetime NOT NULL DEFAULT '3014-12-31 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '1',
  `ended_by` int(11) DEFAULT NULL,
  `modified_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_ak1` (`email`,`ended_date`),
  KEY `user_ie1` (`created_date`),
  KEY `user_ie2` (`created_by`),
  KEY `user_ie3` (`ended_date`),
  KEY `user_ie4` (`ended_by`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='Tabel User';

-- Dumping data for table ds_bella.user: ~3 rows (approximately)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `email`, `password`, `first_name`, `last_name`, `contact_no`, `created_date`, `ended_date`, `created_by`, `ended_by`, `modified_date`) VALUES
	(1, 'satria11t2@gmail.com', '8e48e79f034412463afcbaa00561e193', 'Satria Dwi', 'Putra', '081296453700', '2016-07-04 17:33:45', '3014-12-31 00:00:00', 1, NULL, '2016-07-05 23:54:15'),
	(3, 'ihdi.setiawan@gmail.com', '$2y$10$O/srSUOYg8kOq1SmjlwQyeJwAjhkBZ7aT33CHcbo5krgfH7iTz/5O', 'Admin', 'Bella', '081296453700', '2016-07-04 17:33:45', '3014-12-31 00:00:00', 1, NULL, '2016-07-09 15:10:08'),
	(12, 'ihdi12.setiawan@gmail.com', '$2y$10$Uab0fbmFVaQDA6z7GTMoDe7yE6RGTOkpRGFK/4ME2T39bJbBf3Kmm', 'john', 'doe', NULL, '2016-07-09 15:56:57', '3014-12-31 00:00:00', 1, NULL, '2016-07-09 15:56:57');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;


-- Dumping structure for table ds_bella.user_attribute
CREATE TABLE IF NOT EXISTS `user_attribute` (
  `user_id` int(11) NOT NULL,
  `birthdate` date DEFAULT NULL,
  `sex` char(1) DEFAULT NULL COMMENT 'M : Male,F : Female',
  `weight` int(3) DEFAULT NULL,
  `height` int(3) DEFAULT NULL,
  `push_notification` tinyint(2) DEFAULT '1' COMMENT '1: active, 0: inactive',
  `modified_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabel attribute user';

-- Dumping data for table ds_bella.user_attribute: ~1 rows (approximately)
DELETE FROM `user_attribute`;
/*!40000 ALTER TABLE `user_attribute` DISABLE KEYS */;
INSERT INTO `user_attribute` (`user_id`, `birthdate`, `sex`, `weight`, `height`, `push_notification`, `modified_date`) VALUES
	(3, '1994-12-11', 'M', 54, 173, 1, '2016-07-09 15:12:54'),
	(12, '1999-02-20', NULL, NULL, NULL, 1, '2016-07-09 15:56:57');
/*!40000 ALTER TABLE `user_attribute` ENABLE KEYS */;


-- Dumping structure for table ds_bella.user_type
CREATE TABLE IF NOT EXISTS `user_type` (
  `user_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `status` char(1) DEFAULT NULL COMMENT 'A: Active, D: Deleted',
  `created_date` datetime NOT NULL,
  `mail_verified_date` datetime DEFAULT NULL,
  `ended_date` datetime DEFAULT '3014-12-31 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '1',
  `mail_verified_by` int(11) DEFAULT NULL,
  `ended_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_type_id`),
  UNIQUE KEY `user_type_ak1` (`user_id`,`ended_date`),
  KEY `user_type_ie1` (`user_id`),
  KEY `user_type_ie2` (`type_id`),
  KEY `user_type_ie3` (`status`),
  KEY `user_type_ie4` (`created_date`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Tabel mapping user with type';

-- Dumping data for table ds_bella.user_type: ~0 rows (approximately)
DELETE FROM `user_type`;
/*!40000 ALTER TABLE `user_type` DISABLE KEYS */;
INSERT INTO `user_type` (`user_type_id`, `user_id`, `type_id`, `status`, `created_date`, `mail_verified_date`, `ended_date`, `created_by`, `mail_verified_by`, `ended_by`) VALUES
	(1, 2, 1, 'A', '2016-07-04 17:33:46', NULL, '3014-12-31 00:00:00', 1, NULL, NULL);
/*!40000 ALTER TABLE `user_type` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
