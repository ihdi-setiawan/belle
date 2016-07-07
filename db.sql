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
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Dumping data for table ds_bella.device_token: 3 rows
DELETE FROM `device_token`;
/*!40000 ALTER TABLE `device_token` DISABLE KEYS */;
INSERT INTO `device_token` (`device_id`, `client_id`, `user_id`, `device_token`, `created_date`, `ended_date`) VALUES
	(9, 'android', 3, '33131231', '2016-07-07 13:52:00', '3014-06-07 00:00:00'),
	(8, 'android', 3, '2333131231', '2016-07-07 13:51:47', '3014-06-07 00:00:00'),
	(7, 'android', 3, '233131231', '2016-07-07 13:51:18', '3014-06-07 00:00:00');
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

-- Dumping data for table ds_bella.oauth_access_tokens: 21 rows
DELETE FROM `oauth_access_tokens`;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` (`access_token`, `client_id`, `user_id`, `expires`, `scope`) VALUES
	('c4a281a729dd59fcad10981fcebfab97c8b1b05f', 'android', 3, '2017-07-07 13:07:46', NULL),
	('5f9ed9a73376202251afedcc0f789ca4abeb989d', 'android', 3, '2017-07-07 13:01:01', NULL),
	('405b6ee515cd62fadb7f3f1b060d9d687b7a4898', 'android', 3, '2017-07-07 12:39:00', NULL),
	('3672c191d064191859b02de4dff2ac9fb8443dee', 'android', 3, '2017-07-07 13:14:51', NULL),
	('6549d9411b999c71709ed7232feb7282cc25776d', 'android', 3, '2017-07-07 13:24:51', NULL),
	('2a3c4ce09155f70a6b3534954f37122751c99942', 'android', 3, '2017-07-07 13:25:15', NULL),
	('9fd865583683a9de0584c50a92647faad15101e3', 'android', 3, '2017-07-07 13:28:02', NULL),
	('84bcf359f1d0c9734b99100944e3bac254d524b1', 'android', 3, '2017-07-07 13:28:20', NULL),
	('319aa9fdf51ac716abcf52071dfd7461b8c50155', 'android', 3, '2017-07-07 13:29:22', NULL),
	('2c8ade048e4e04a23c3275ae25f1d9181eb43731', 'android', 3, '2017-07-07 13:33:32', NULL),
	('0fdc424aa9bd1297140077bc4224ce414cf0b191', 'android', 3, '2017-07-07 13:33:34', NULL),
	('46519cda4f5c551b3c6aedb81e158da4ba2a29c4', 'android', 3, '2017-07-07 13:33:39', NULL),
	('7d42d02e0b29fe68b8d4f7c136fbd0415bf77c11', 'android', 3, '2017-07-07 13:38:23', NULL),
	('fadc90368aefc322de5fad7ce6b82c53813e4f6b', 'android', 3, '2017-07-07 13:38:29', NULL),
	('c65bddd25e94bd6556f634d06d4c7b491ea20afb', 'android', 3, '2017-07-07 13:51:05', NULL),
	('90087d11fca7a380bea1130dad495cdf0a8f44dd', 'android', 3, '2017-07-07 13:51:18', NULL),
	('c328de1dfd92ba2d730141a43f564c560ad0d8a2', 'android', 3, '2017-07-07 13:51:27', NULL),
	('afda59dcce4eca5fc229c0497e6f35395f2c75ab', 'android', 3, '2017-07-07 13:51:37', NULL),
	('ab558c7e0ba1d859299750bf70035bb0f1381b3a', 'android', 3, '2017-07-07 13:51:47', NULL),
	('7f72a7fb2662b640b9a8843cc3726d5002da4c06', 'android', 3, '2017-07-07 13:51:55', NULL),
	('6eb5ceb95b31b009680bce5d0dd0f424b587e5ea', 'android', 3, '2017-07-07 13:52:00', NULL);
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
  `user_name` varchar(64) DEFAULT NULL,
  `email` varchar(64) NOT NULL,
  `password` varchar(60) NOT NULL,
  `first_name` varchar(64) NOT NULL,
  `last_name` varchar(64) DEFAULT NULL,
  `contact_no` varchar(16) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `ended_date` datetime DEFAULT '3014-12-31 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '1',
  `ended_by` int(11) DEFAULT NULL,
  `modified_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_ak1` (`email`,`ended_date`),
  KEY `user_ie1` (`created_date`),
  KEY `user_ie2` (`created_by`),
  KEY `user_ie3` (`ended_date`),
  KEY `user_ie4` (`ended_by`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Tabel User';

-- Dumping data for table ds_bella.user: ~2 rows (approximately)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `user_name`, `email`, `password`, `first_name`, `last_name`, `contact_no`, `created_date`, `ended_date`, `created_by`, `ended_by`, `modified_date`) VALUES
	(1, 'sapisuper', 'satria11t2@gmail.com', '8e48e79f034412463afcbaa00561e193', 'Satria Dwi', 'Putra', '081296453700', '2016-07-04 17:33:45', '3014-12-31 00:00:00', 1, NULL, '2016-07-05 23:54:15'),
	(3, 'tesss', 'ihdi.setiawan@gmail.com', '$2y$10$wqmkuw8xEsQ/odddXMTeweahFNjqTmv.KoIlPQ40VTr5yba6G8O5W', 'Admin', 'Bella', '081296453700', '2016-07-04 17:33:45', '3014-12-31 00:00:00', 1, NULL, '2016-07-05 23:54:13');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;


-- Dumping structure for table ds_bella.user_attribute
CREATE TABLE IF NOT EXISTS `user_attribute` (
  `user_id` int(11) NOT NULL,
  `birthdate` date DEFAULT NULL,
  `age` int(3) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL COMMENT 'M : Male,F : Female',
  `weight` int(3) DEFAULT NULL,
  `height` int(3) DEFAULT NULL,
  `push_notification` tinyint(2) DEFAULT '1' COMMENT '1: active, 0: inactive',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabel attribute user';

-- Dumping data for table ds_bella.user_attribute: ~1 rows (approximately)
DELETE FROM `user_attribute`;
/*!40000 ALTER TABLE `user_attribute` DISABLE KEYS */;
INSERT INTO `user_attribute` (`user_id`, `birthdate`, `age`, `sex`, `weight`, `height`, `push_notification`) VALUES
	(2, '1994-12-11', 21, 'M', 54, 173, 1);
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
