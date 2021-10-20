-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: booking_db
-- ------------------------------------------------------
-- Server version	8.0.26

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
-- Table structure for table `booking_history`
--

DROP TABLE IF EXISTS `booking_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_history` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Искусственный ключ',
  `place_id` int unsigned NOT NULL COMMENT 'Ссылка на место размещения',
  `effective_from` datetime NOT NULL COMMENT 'Дата начала брони',
  `effective_to` datetime NOT NULL COMMENT 'Дата окончания брони',
  `user_id` int unsigned NOT NULL COMMENT 'Ссылка арендатора',
  `status_id` int unsigned NOT NULL COMMENT 'Ссылка на статус брони',
  `type_id` int unsigned NOT NULL COMMENT 'Ссылка на тип брони',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления строки',
  PRIMARY KEY (`id`),
  KEY `booking_history_user` (`user_id`),
  KEY `booking_history_status` (`status_id`),
  KEY `booking_history_type` (`type_id`),
  KEY `booking_history_place` (`place_id`),
  CONSTRAINT `booking_history_place` FOREIGN KEY (`place_id`) REFERENCES `places` (`id`),
  CONSTRAINT `booking_history_status` FOREIGN KEY (`status_id`) REFERENCES `booking_status` (`id`),
  CONSTRAINT `booking_history_type` FOREIGN KEY (`type_id`) REFERENCES `booking_types` (`id`),
  CONSTRAINT `booking_history_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица с периодами брони на места проживания';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_history`
--

LOCK TABLES `booking_history` WRITE;
/*!40000 ALTER TABLE `booking_history` DISABLE KEYS */;
INSERT INTO `booking_history` VALUES (1,3,'2022-05-05 15:46:06','2022-06-04 15:46:06',2,3,2,'2021-10-19 15:19:43','2021-10-19 15:52:00'),(2,2,'2022-07-23 15:46:06','2022-07-28 15:46:06',5,1,2,'2021-10-19 15:19:43','2021-10-19 15:52:00'),(3,2,'2022-01-20 15:46:06','2022-02-11 15:46:06',2,1,2,'2021-10-19 15:19:43','2021-10-19 15:52:00'),(4,3,'2022-09-15 15:46:06','2022-09-20 15:46:06',4,1,2,'2021-10-19 15:19:43','2021-10-19 15:52:00'),(5,5,'2021-01-03 15:39:17','2021-01-20 15:39:17',3,4,2,'2021-10-19 15:19:43','2021-10-19 15:52:00'),(6,4,'2022-09-10 15:46:06','2022-09-21 15:46:06',5,1,2,'2021-10-19 15:19:43','2021-10-19 15:52:00'),(7,2,'2022-08-01 15:46:06','2022-08-03 15:46:06',2,3,1,'2021-10-19 15:19:43','2021-10-19 15:52:00'),(8,1,'2022-01-31 15:46:06','2022-02-09 15:46:06',2,3,2,'2021-10-19 15:19:43','2021-10-19 15:52:00'),(9,5,'2021-07-18 15:39:17','2021-07-26 15:39:17',4,2,2,'2021-10-19 15:19:43','2021-10-19 15:52:00'),(10,1,'2021-07-28 15:39:17','2021-08-11 15:39:17',5,4,2,'2021-10-19 15:19:43','2021-10-19 15:52:00'),(11,5,'2021-10-29 15:46:06','2021-11-12 15:46:06',5,1,2,'2021-10-19 15:19:43','2021-10-19 15:52:00'),(12,5,'2022-01-14 15:46:06','2022-02-12 15:46:06',3,3,1,'2021-10-19 15:19:43','2021-10-19 15:52:00'),(13,4,'2021-08-03 15:39:17','2021-08-16 15:39:17',3,2,1,'2021-10-19 15:19:43','2021-10-19 15:52:00'),(14,3,'2021-07-07 15:39:17','2021-07-14 15:39:17',5,2,1,'2021-10-19 15:19:43','2021-10-19 15:52:00'),(15,4,'2021-12-11 15:46:06','2022-01-07 15:46:06',2,1,1,'2021-10-19 15:19:43','2021-10-19 15:52:00'),(16,5,'2021-02-13 15:39:17','2021-03-06 15:39:17',2,4,1,'2021-10-19 15:19:43','2021-10-19 15:52:00'),(17,3,'2021-01-02 15:39:17','2021-01-28 15:39:17',1,4,1,'2021-10-19 15:19:43','2021-10-19 15:52:00'),(18,3,'2021-10-23 15:46:06','2021-10-30 15:46:06',4,1,1,'2021-10-19 15:19:43','2021-10-19 15:52:00'),(19,5,'2022-05-19 15:46:06','2022-06-03 15:46:06',5,3,1,'2021-10-19 15:19:43','2021-10-19 15:52:00'),(20,2,'2021-10-16 15:39:17','2021-11-10 15:39:17',1,4,2,'2021-10-19 15:19:43','2021-10-19 15:52:00');
/*!40000 ALTER TABLE `booking_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_status`
--

DROP TABLE IF EXISTS `booking_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_status` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Искусственный ключ',
  `status_name` varchar(25) NOT NULL COMMENT 'Статус бронирования - броньзаездне заезд',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица статусов бронирования';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_status`
--

LOCK TABLES `booking_status` WRITE;
/*!40000 ALTER TABLE `booking_status` DISABLE KEYS */;
INSERT INTO `booking_status` VALUES (1,'Бронь','2021-10-14 19:14:41','2021-10-14 19:14:41'),(2,'Заселение','2021-10-14 19:14:41','2021-10-14 19:14:41'),(3,'Отмена','2021-10-14 19:14:41','2021-10-14 19:14:41'),(4,'Незаезд','2021-10-14 19:14:41','2021-10-14 19:14:41');
/*!40000 ALTER TABLE `booking_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_types`
--

DROP TABLE IF EXISTS `booking_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Искусственный ключ',
  `type_name` varchar(25) NOT NULL COMMENT 'Тип бронирования - отдыхкомандировка',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица типов бронирования';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_types`
--

LOCK TABLES `booking_types` WRITE;
/*!40000 ALTER TABLE `booking_types` DISABLE KEYS */;
INSERT INTO `booking_types` VALUES (1,'Отдых','2021-10-14 19:14:44','2021-10-14 19:14:44'),(2,'Командировка','2021-10-14 19:14:44','2021-10-14 19:14:44');
/*!40000 ALTER TABLE `booking_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency_type`
--

DROP TABLE IF EXISTS `currency_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currency_type` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Искусственный ключ',
  `currency_name` varchar(100) NOT NULL COMMENT 'Название валюты',
  `сurrency_code` varchar(10) NOT NULL COMMENT 'Универсальный код валюты (EUR,USD)',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица валют';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency_type`
--

LOCK TABLES `currency_type` WRITE;
/*!40000 ALTER TABLE `currency_type` DISABLE KEYS */;
INSERT INTO `currency_type` VALUES (1,'Российский рубль','RUR','2021-10-14 19:14:19','2021-10-14 19:14:19'),(2,'Доллар США','USD','2021-10-14 19:14:19','2021-10-14 19:14:19'),(3,'Евро','EUR','2021-10-14 19:14:19','2021-10-14 19:14:19');
/*!40000 ALTER TABLE `currency_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `genius_users`
--

DROP TABLE IF EXISTS `genius_users`;
/*!50001 DROP VIEW IF EXISTS `genius_users`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `genius_users` AS SELECT 
 1 AS `first_name`,
 1 AS `middle_name`,
 1 AS `last_name`,
 1 AS `email`,
 1 AS `phone`,
 1 AS `gender`,
 1 AS `age`,
 1 AS `country`,
 1 AS `status_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `object_type`
--

DROP TABLE IF EXISTS `object_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `object_type` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Искусственный ключ',
  `type_name` varchar(100) NOT NULL COMMENT 'Название типа объекта размещения (гостиница, дом, хостел и т.д.)',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица типов объектов размещения';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `object_type`
--

LOCK TABLES `object_type` WRITE;
/*!40000 ALTER TABLE `object_type` DISABLE KEYS */;
INSERT INTO `object_type` VALUES (1,'Квартира','2021-10-14 19:14:24','2021-10-14 19:14:24'),(2,'Хостел','2021-10-14 19:14:24','2021-10-14 19:14:24'),(3,'Гостиница','2021-10-14 19:14:24','2021-10-14 19:14:24'),(4,'Гостевой дом','2021-10-14 19:14:24','2021-10-14 19:14:24');
/*!40000 ALTER TABLE `object_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objects`
--

DROP TABLE IF EXISTS `objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `objects` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Искусственный ключ',
  `object_name` varchar(100) NOT NULL COMMENT 'Название объекта размещения',
  `description` text NOT NULL COMMENT 'Описание объекта',
  `GPS_lattitude` float NOT NULL COMMENT 'Широта расположения объекта в десятичном выражении',
  `GPS_longitude` float NOT NULL COMMENT 'Широта расположения объекта в десятичном выражении',
  `country` varchar(100) NOT NULL COMMENT 'Страна объекта размещения',
  `city` varchar(100) NOT NULL COMMENT 'Город объекта размещения',
  `type_id` int unsigned NOT NULL COMMENT 'Ссылка на справочник типов объектов',
  `owner_id` int unsigned NOT NULL COMMENT 'Ссылка на владельца объекта',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления строки',
  PRIMARY KEY (`id`),
  KEY `objects_owner_id` (`owner_id`),
  KEY `objects_type_id` (`type_id`),
  CONSTRAINT `objects_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `owners` (`id`),
  CONSTRAINT `objects_type_id` FOREIGN KEY (`type_id`) REFERENCES `object_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица объектов размещения';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objects`
--

LOCK TABLES `objects` WRITE;
/*!40000 ALTER TABLE `objects` DISABLE KEYS */;
INSERT INTO `objects` VALUES (1,'ex','Omnis id eaque voluptatum autem dolores quo et. Eum voluptatum laborum eaque. Rem iusto culpa perferendis sapiente eligendi inventore nulla.',13.2808,14.2475,'USA','New York',1,8,'1984-06-13 02:41:20','2021-10-19 15:42:16'),(2,'quibusdam','Perspiciatis praesentium iure nihil odit ea praesentium qui nihil. Molestias vel deleniti ad dolorum. Veritatis aspernatur aliquam autem et. Deleniti in possimus tenetur quas.',18.8496,11.1891,'USA','New York',4,10,'1974-07-29 18:44:48','2021-10-19 15:42:16'),(3,'voluptates','Et doloremque qui eos quas eos. Quos odit est qui harum omnis ut voluptatum. Cumque deleniti placeat ducimus eligendi. Voluptas maxime sit est facilis dolorum.',14.4054,13.2027,'USA','New York',3,7,'1991-08-13 13:40:44','2021-10-19 15:42:16'),(4,'expedita','Eum incidunt autem velit repudiandae aliquid optio vitae hic. Qui sunt quos quo quas.',15.4783,12.4464,'GERMANY','Berlin',2,9,'1973-12-20 21:30:04','2021-10-19 15:42:59'),(5,'maxime','Itaque praesentium quas occaecati vel rerum blanditiis. Debitis et magnam et voluptatem. Explicabo sequi non mollitia neque veritatis maiores.',14.1753,12.6237,'RUSSIA','Moscow',3,10,'2003-07-05 02:25:39','2021-10-19 15:42:38'),(6,'aut','Consequatur impedit placeat qui iste ut minima et consequatur. Dolor earum autem numquam rerum dolore accusamus. Sit atque optio quis et dolor id. Optio numquam maiores cum nemo alias assumenda tenetur.',14.4417,15.7793,'RUSSIA','Moscow',3,8,'2007-12-19 14:10:02','2021-10-19 15:42:38'),(7,'non','Sapiente sunt aut in ratione impedit qui et numquam. Qui adipisci molestiae voluptatum minus voluptas omnis odit. Cumque ipsum modi perferendis possimus et. Iure ut eaque sed corporis.',19.6825,11.0255,'RUSSIA','Moscow',1,8,'1995-10-26 16:25:37','2021-10-19 15:42:38'),(8,'aliquid','Aut repudiandae ullam accusantium tempora amet laboriosam qui quo. Molestias dolores recusandae et quae deleniti rerum. Aut et unde et quia.',15.0873,17.7898,'GERMANY','Berlin',1,8,'1975-09-09 22:45:30','2021-10-19 15:42:59'),(9,'dolor','Dolores perferendis officia ut sit. Consequuntur sit fugiat voluptas.',16.3889,15.8722,'GERMANY','Berlin',3,10,'1990-01-03 19:07:37','2021-10-19 15:42:59'),(10,'magni','Quam dolor quos aut doloribus accusantium nulla quia. Pariatur tenetur fugiat quia. Ex culpa enim maxime possimus dolores sed et. Quos doloremque repellendus et omnis sed temporibus.',16.6829,15.9917,'RUSSIA','Moscow',4,5,'1984-01-20 04:15:58','2021-10-19 15:42:38');
/*!40000 ALTER TABLE `objects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `owners`
--

DROP TABLE IF EXISTS `owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `owners` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Искусственный ключ',
  `first_name` varchar(50) NOT NULL COMMENT 'Имя владельца',
  `middle_name` varchar(50) DEFAULT NULL COMMENT 'Отчество владельца',
  `last_name` varchar(50) NOT NULL COMMENT 'Отчество владельца',
  `email` varchar(100) NOT NULL COMMENT 'Email владельца',
  `phone` varchar(100) NOT NULL COMMENT 'Номер телефона владельца',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  CONSTRAINT `сheck_phone` CHECK (regexp_like(`phone`,_utf8mb4'^\\+7[0-9]{10}$'))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица владельцев объектов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owners`
--

LOCK TABLES `owners` WRITE;
/*!40000 ALTER TABLE `owners` DISABLE KEYS */;
INSERT INTO `owners` VALUES (1,'Clare','omnis','Maggio','murphy.flatley@example.org','+79418509103','1989-08-28 16:55:03','2021-10-14 19:22:06'),(2,'Eusebio','quia','Ritchie','brady.stoltenberg@example.com','+79176207568','2016-05-05 23:17:16','2021-10-14 19:22:06'),(3,'Billie','voluptatum','Nader','brent03@example.org','+79625510562','1981-12-01 17:06:25','2021-10-14 19:22:06'),(4,'Ricky','minima','O\'Conner','don42@example.org','+79598930138','2003-03-06 22:45:43','2021-10-14 19:22:06'),(5,'Chaim','et','Lebsack','electa.lang@example.com','+79118119035','1974-01-20 01:11:53','2021-10-14 19:22:06'),(6,'Janet','doloremque','Auer','runte.delaney@example.com','+79793804793','1998-03-14 23:48:54','2021-10-14 19:22:06'),(7,'Reta','quis','White','zdouglas@example.com','+79614666894','1979-04-25 11:59:33','2021-10-14 19:22:06'),(8,'Koby','explicabo','Hand','auer.concepcion@example.com','+79691920120','1997-07-13 01:20:38','2021-10-14 19:22:06'),(9,'Anya','quis','Lockman','reinger.myriam@example.net','+79615599950','2011-09-05 14:01:26','2021-10-14 19:22:06'),(10,'Gaylord','expedita','West','shaina.wiza@example.net','+79002239424','2014-11-09 07:26:14','2021-10-14 19:22:06');
/*!40000 ALTER TABLE `owners` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `owner_phone_format_ins` BEFORE INSERT ON `owners` FOR EACH ROW BEGIN
	CALL phone_format(NEW.phone);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `owner_phone_format_upd` BEFORE UPDATE ON `owners` FOR EACH ROW BEGIN
	CALL phone_format(NEW.phone);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `parametrs`
--

DROP TABLE IF EXISTS `parametrs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parametrs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Искусственный ключ',
  `parametr_name` varchar(25) NOT NULL COMMENT 'Оцениваемая характеристика',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица оцениваемых характеристик';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parametrs`
--

LOCK TABLES `parametrs` WRITE;
/*!40000 ALTER TABLE `parametrs` DISABLE KEYS */;
INSERT INTO `parametrs` VALUES (1,'Чистота','2021-10-14 19:14:47','2021-10-14 19:14:47'),(2,'Близость к центру','2021-10-14 19:14:47','2021-10-14 19:14:47'),(3,'Удобная кровать','2021-10-14 19:14:47','2021-10-14 19:14:47'),(4,'Хозяева','2021-10-14 19:14:47','2021-10-14 19:14:47'),(5,'Тишина','2021-10-14 19:14:47','2021-10-14 19:14:47');
/*!40000 ALTER TABLE `parametrs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pictures`
--

DROP TABLE IF EXISTS `pictures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pictures` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Искусственный ключ',
  `target_id` int unsigned NOT NULL COMMENT 'Ссылка на объект фото (объект размещения или место размещения)',
  `target_type_id` int unsigned NOT NULL COMMENT 'Ссылка на вид объекта фото (объект размещения или место размещения)',
  `pic_url` varchar(100) NOT NULL COMMENT 'Ссылка на размещение фото',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления строки',
  PRIMARY KEY (`id`),
  KEY `pictures_target_type` (`target_type_id`),
  CONSTRAINT `pictures_target_type` FOREIGN KEY (`target_type_id`) REFERENCES `target_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица с фото объектов и мест размещения';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pictures`
--

LOCK TABLES `pictures` WRITE;
/*!40000 ALTER TABLE `pictures` DISABLE KEYS */;
INSERT INTO `pictures` VALUES (1,9,2,'http://murray.com/','1974-03-09 17:46:42','2013-03-26 21:43:13'),(2,2,1,'http://kris.org/','1998-09-17 18:47:23','1975-10-09 00:15:23'),(3,7,1,'http://www.bernierschuppe.com/','2010-06-19 07:31:19','1983-04-15 06:12:21'),(4,3,2,'http://www.kiehndeckow.info/','2018-10-29 11:02:38','1978-09-26 13:36:08'),(5,3,1,'http://www.spinka.com/','1978-04-09 12:41:19','2017-08-08 22:31:41'),(6,7,2,'http://pagac.com/','2015-10-11 03:10:19','2003-03-05 12:02:48'),(7,8,1,'http://www.gottliebschneider.org/','2002-01-18 23:46:30','1983-11-16 15:33:47'),(8,4,2,'http://haley.com/','1982-05-13 14:24:28','2005-11-27 18:45:28'),(9,4,2,'http://lockmanruecker.com/','1977-01-02 22:29:47','2019-06-08 05:03:28'),(10,3,1,'http://kuhlman.info/','2003-07-21 10:59:09','1982-04-03 17:16:47');
/*!40000 ALTER TABLE `pictures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `place_rating`
--

DROP TABLE IF EXISTS `place_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `place_rating` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Искусственный ключ',
  `booking_id` int unsigned NOT NULL COMMENT 'Ссылка на бронь',
  `rate_id` int unsigned NOT NULL COMMENT 'Ссылка на оценку',
  `parametr_id` int unsigned NOT NULL COMMENT 'Ссылка на оцениваемую характеристику',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления строки',
  PRIMARY KEY (`id`),
  KEY `place_rating_booking` (`booking_id`),
  KEY `place_rating_rate` (`rate_id`),
  KEY `place_rating_parametr` (`parametr_id`),
  CONSTRAINT `place_rating_booking` FOREIGN KEY (`booking_id`) REFERENCES `booking_history` (`id`),
  CONSTRAINT `place_rating_parametr` FOREIGN KEY (`parametr_id`) REFERENCES `parametrs` (`id`),
  CONSTRAINT `place_rating_rate` FOREIGN KEY (`rate_id`) REFERENCES `rates` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица с оценками арендаторов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `place_rating`
--

LOCK TABLES `place_rating` WRITE;
/*!40000 ALTER TABLE `place_rating` DISABLE KEYS */;
INSERT INTO `place_rating` VALUES (32,5,5,3,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(33,13,3,3,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(34,14,9,2,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(35,19,7,3,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(36,5,10,5,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(37,12,4,1,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(38,7,5,5,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(39,16,9,5,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(40,2,6,3,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(41,20,4,5,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(42,16,9,5,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(43,2,6,3,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(44,4,2,2,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(45,1,4,3,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(46,3,4,3,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(47,1,9,2,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(48,17,2,3,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(49,3,2,1,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(50,2,2,4,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(51,17,1,5,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(52,5,4,2,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(53,4,1,5,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(54,5,4,1,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(55,10,1,5,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(56,7,10,4,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(57,6,6,1,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(58,15,5,5,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(59,2,9,1,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(60,14,2,4,'2021-10-19 16:37:59','2021-10-19 16:37:59'),(61,9,9,1,'2021-10-19 16:37:59','2021-10-19 16:37:59');
/*!40000 ALTER TABLE `place_rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `place_review`
--

DROP TABLE IF EXISTS `place_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `place_review` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Искусственный ключ',
  `booking_id` int unsigned NOT NULL COMMENT 'Ссылка на бронь',
  `body` text NOT NULL COMMENT 'Текст отзыва',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `booking_id` (`booking_id`),
  CONSTRAINT `place_review_booking` FOREIGN KEY (`booking_id`) REFERENCES `booking_history` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица с отзывами арендаторов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `place_review`
--

LOCK TABLES `place_review` WRITE;
/*!40000 ALTER TABLE `place_review` DISABLE KEYS */;
INSERT INTO `place_review` VALUES (1,1,'Libero velit fugit deserunt eos nihil laboriosam assumenda. Aut aperiam nihil rem necessitatibus sunt dolor omnis. Aut accusantium omnis exercitationem nam ipsum voluptates enim. Expedita quisquam enim voluptas velit accusamus.','2021-10-19 19:44:06','2021-10-19 19:44:06'),(2,2,'Et doloribus repudiandae et omnis totam. Voluptatem commodi rerum beatae exercitationem. Omnis ratione aut consequatur qui quasi deleniti.','2021-10-19 19:44:06','2021-10-19 19:44:06'),(3,3,'Voluptatum at provident cumque at. Ut quis quidem exercitationem ex quas reiciendis. Est eos est optio rerum delectus dignissimos ut consequuntur. Qui consequatur vel ea maiores assumenda.','2021-10-19 19:44:06','2021-10-19 19:44:06'),(4,4,'Omnis placeat omnis praesentium facere iusto rerum et. Eos ipsam est tenetur numquam commodi incidunt. Excepturi est molestiae beatae sunt. Sed est maiores quidem sit recusandae veritatis.','2021-10-19 19:44:06','2021-10-19 19:44:06'),(5,5,'Similique ad aut possimus rerum. Explicabo consequatur soluta molestias ex. Consequatur laboriosam libero est maxime similique.','2021-10-19 19:44:06','2021-10-19 19:44:06'),(6,6,'Ab sit sit ullam porro in. Illo vitae quos magnam eius vel eligendi eum ipsum. Possimus quod quia maiores libero architecto.','2021-10-19 19:44:06','2021-10-19 19:44:06'),(7,7,'Consectetur molestiae occaecati quo at laborum odit. Nisi qui ratione vel illo molestias hic sit. Nihil repudiandae similique nihil deleniti aut a quia. Aperiam laudantium nisi aspernatur.','2021-10-19 19:44:06','2021-10-19 19:44:06'),(8,8,'Laborum voluptates rerum asperiores ipsam aut. Nostrum dolores laboriosam incidunt tempora suscipit.','2021-10-19 19:44:06','2021-10-19 19:44:06'),(9,9,'In nesciunt aut ea nostrum cumque quisquam. In quia quibusdam placeat excepturi debitis aut. Recusandae amet eveniet voluptatem.','2021-10-19 19:44:06','2021-10-19 19:44:06'),(10,10,'Natus ipsum aut itaque explicabo et sunt. Placeat id dolore aut architecto excepturi optio. Excepturi doloremque recusandae doloribus.','2021-10-19 19:44:06','2021-10-19 19:44:06'),(11,11,'Libero velit fugit deserunt eos nihil laboriosam assumenda. Aut aperiam nihil rem necessitatibus sunt dolor omnis. Aut accusantium omnis exercitationem nam ipsum voluptates enim. Expedita quisquam enim voluptas velit accusamus.','2021-10-19 19:44:06','2021-10-19 19:44:06'),(12,12,'Et doloribus repudiandae et omnis totam. Voluptatem commodi rerum beatae exercitationem. Omnis ratione aut consequatur qui quasi deleniti.','2021-10-19 19:44:06','2021-10-19 19:44:06'),(13,13,'Voluptatum at provident cumque at. Ut quis quidem exercitationem ex quas reiciendis. Est eos est optio rerum delectus dignissimos ut consequuntur. Qui consequatur vel ea maiores assumenda.','2021-10-19 19:44:06','2021-10-19 19:44:06'),(14,14,'Omnis placeat omnis praesentium facere iusto rerum et. Eos ipsam est tenetur numquam commodi incidunt. Excepturi est molestiae beatae sunt. Sed est maiores quidem sit recusandae veritatis.','2021-10-19 19:44:06','2021-10-19 19:44:06'),(15,15,'Similique ad aut possimus rerum. Explicabo consequatur soluta molestias ex. Consequatur laboriosam libero est maxime similique.','2021-10-19 19:44:06','2021-10-19 19:44:06'),(16,16,'Ab sit sit ullam porro in. Illo vitae quos magnam eius vel eligendi eum ipsum. Possimus quod quia maiores libero architecto.','2021-10-19 19:44:06','2021-10-19 19:44:06'),(17,17,'Consectetur molestiae occaecati quo at laborum odit. Nisi qui ratione vel illo molestias hic sit. Nihil repudiandae similique nihil deleniti aut a quia. Aperiam laudantium nisi aspernatur.','2021-10-19 19:44:06','2021-10-19 19:44:06'),(18,18,'Laborum voluptates rerum asperiores ipsam aut. Nostrum dolores laboriosam incidunt tempora suscipit.','2021-10-19 19:44:06','2021-10-19 19:44:06'),(19,19,'In nesciunt aut ea nostrum cumque quisquam. In quia quibusdam placeat excepturi debitis aut. Recusandae amet eveniet voluptatem.','2021-10-19 19:44:06','2021-10-19 19:44:06'),(20,20,'Natus ipsum aut itaque explicabo et sunt. Placeat id dolore aut architecto excepturi optio. Excepturi doloremque recusandae doloribus.','2021-10-19 19:44:06','2021-10-19 19:44:06');
/*!40000 ALTER TABLE `place_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `place_x_utility`
--

DROP TABLE IF EXISTS `place_x_utility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `place_x_utility` (
  `place_id` int unsigned NOT NULL COMMENT 'Ссылка на место размещения',
  `utility_id` int unsigned NOT NULL COMMENT 'Ссылка на удобство',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления строки',
  PRIMARY KEY (`place_id`,`utility_id`) COMMENT 'Составной первичный ключ',
  KEY `place_x_utility_utility_id` (`utility_id`),
  CONSTRAINT `place_x_utility_place_id` FOREIGN KEY (`place_id`) REFERENCES `places` (`id`),
  CONSTRAINT `place_x_utility_utility_id` FOREIGN KEY (`utility_id`) REFERENCES `utilities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица связи мест размещения и удобств в них';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `place_x_utility`
--

LOCK TABLES `place_x_utility` WRITE;
/*!40000 ALTER TABLE `place_x_utility` DISABLE KEYS */;
INSERT INTO `place_x_utility` VALUES (1,1,'2021-10-19 13:56:21','2021-10-19 13:56:21'),(1,2,'2021-10-19 13:56:21','2021-10-19 13:56:21'),(1,4,'2021-10-19 13:56:21','2021-10-19 13:56:21'),(1,6,'2021-10-19 13:56:21','2021-10-19 13:56:21'),(3,1,'2021-10-19 13:56:21','2021-10-19 13:56:21'),(3,2,'2021-10-19 13:56:21','2021-10-19 13:56:21'),(3,3,'2021-10-19 13:56:21','2021-10-19 13:56:21'),(3,4,'2021-10-19 13:56:21','2021-10-19 13:56:21'),(4,1,'2021-10-19 13:56:21','2021-10-19 13:56:21'),(4,5,'2021-10-19 13:56:21','2021-10-19 13:56:21'),(4,6,'2021-10-19 13:56:21','2021-10-19 13:56:21'),(5,1,'2021-10-19 13:56:21','2021-10-19 13:56:21'),(5,3,'2021-10-19 13:56:21','2021-10-19 13:56:21'),(5,4,'2021-10-19 13:56:21','2021-10-19 13:56:21'),(5,6,'2021-10-19 13:56:21','2021-10-19 13:56:21'),(7,2,'2021-10-19 13:56:21','2021-10-19 13:56:21'),(7,3,'2021-10-19 13:56:21','2021-10-19 13:56:21'),(8,1,'2021-10-19 13:56:21','2021-10-19 13:56:21'),(8,2,'2021-10-19 13:56:21','2021-10-19 13:56:21'),(8,3,'2021-10-19 13:56:21','2021-10-19 13:56:21'),(9,1,'2021-10-19 13:56:21','2021-10-19 13:56:21'),(9,2,'2021-10-19 13:56:21','2021-10-19 13:56:21'),(9,3,'2021-10-19 13:56:21','2021-10-19 13:56:21');
/*!40000 ALTER TABLE `place_x_utility` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `places`
--

DROP TABLE IF EXISTS `places`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `places` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Искусственный ключ',
  `place_name` varchar(100) NOT NULL COMMENT 'Название места размещения в объекте - комната в доме, номер в отеле и т.д.',
  `description` text NOT NULL COMMENT 'Описание места размещения',
  `object_id` int unsigned NOT NULL COMMENT 'Ссылка на объект размещения',
  `capacity` int unsigned NOT NULL COMMENT 'Вместимость места размещения (кол-во спальных мест)',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления строки',
  PRIMARY KEY (`id`),
  KEY `places_object_id` (`object_id`),
  CONSTRAINT `places_object_id` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица мест размещения внутри объектов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `places`
--

LOCK TABLES `places` WRITE;
/*!40000 ALTER TABLE `places` DISABLE KEYS */;
INSERT INTO `places` VALUES (1,'комната','Ex eos tenetur ullam modi commodi eligendi. Qui quaerat quasi vero in sed consequatur. Aut ut qui molestiae. Dolorem deleniti id vero sapiente.',3,3,'2001-12-02 20:42:38','2021-10-19 17:11:35'),(2,'дом','Quidem tempore quidem suscipit. Aut quia rerum cupiditate sed necessitatibus. Tempora alias hic labore quam enim officia.',4,1,'1998-01-11 01:28:45','2021-10-19 17:11:35'),(3,'комната','Qui atque error nihil sit molestias. Suscipit ipsum sint magnam ut et et. Est autem sequi facilis.',3,3,'2018-02-21 01:01:49','2021-10-19 17:11:35'),(4,'студия','Molestiae vel quas non dolores. Ad expedita facere unde quo aut. Illum sed iure repellendus praesentium. Eum dolorem in nihil ut. Aspernatur qui assumenda ut tenetur occaecati et facilis.',5,1,'1980-04-01 03:33:38','2021-10-19 17:10:52'),(5,'комната','Quia perspiciatis placeat labore aliquam nisi nobis. At enim officia quia eum alias.',3,4,'1985-10-21 18:47:28','2021-10-19 17:11:35'),(6,'студия','Modi aliquam quae aliquam. Accusantium quam magnam minima consectetur. Natus quia consequatur voluptate dolorem aut est quia.',6,5,'2008-04-20 12:50:32','2021-10-19 17:11:35'),(7,'апартамент','Sunt illo vitae accusamus ad dolores earum omnis. Aut labore optio omnis dignissimos. In delectus sequi et culpa molestiae. Ratione ipsam fugit consequatur et quo animi. Iusto rerum dolore tempore quaerat voluptatem dolorum voluptate et.',6,1,'2019-03-19 22:08:55','2021-10-19 17:11:35'),(8,'кровать в общей комнате','Iste eius aut repudiandae est ut. Eaque laborum repellendus doloribus veniam voluptas qui sed. Doloremque eligendi pariatur natus magni omnis. Ut incidunt exercitationem sit vel quibusdam non.',3,1,'2011-08-03 10:48:05','2021-10-19 17:11:37'),(9,'кровать в общей комнате','Voluptas consectetur quia quas qui nostrum qui aut. Et quo alias occaecati voluptatem quia velit ut. Et reiciendis ipsam quaerat quas et.',3,1,'2003-09-18 18:19:16','2021-10-19 17:11:37'),(10,'дом','Error aliquid porro sint adipisci inventore ipsum. Repudiandae dicta alias doloremque. Cupiditate incidunt possimus aperiam dolorem eum totam similique.',3,3,'1988-09-21 11:29:01','2021-10-19 17:10:36');
/*!40000 ALTER TABLE `places` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `price_type`
--

DROP TABLE IF EXISTS `price_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `price_type` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Искусственный ключ',
  `price_name` varchar(25) NOT NULL COMMENT 'Название типа цены - гостьместо',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица типов цен';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price_type`
--

LOCK TABLES `price_type` WRITE;
/*!40000 ALTER TABLE `price_type` DISABLE KEYS */;
INSERT INTO `price_type` VALUES (1,'За гостя','2021-10-14 19:14:28','2021-10-14 19:14:28'),(2,'За место размещения','2021-10-14 19:14:28','2021-10-14 19:14:28');
/*!40000 ALTER TABLE `price_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices`
--

DROP TABLE IF EXISTS `prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Искусственный ключ',
  `price` float NOT NULL COMMENT 'Цена места размещения',
  `currency_id` int unsigned NOT NULL COMMENT 'Ссылка на валюту',
  `place_id` int unsigned NOT NULL COMMENT 'Ссылка на место размещения',
  `type_id` int unsigned NOT NULL COMMENT 'Ссылка на тип цены (за гостяза место целиком)',
  `effective_from` datetime NOT NULL COMMENT 'Дата начала действия цены',
  `effective_to` datetime NOT NULL COMMENT 'Дата окончания действия цены',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления строки',
  PRIMARY KEY (`id`),
  KEY `prices_place_id` (`place_id`),
  KEY `prices_type_id` (`type_id`),
  KEY `prices_curr_id` (`currency_id`),
  CONSTRAINT `prices_curr_id` FOREIGN KEY (`currency_id`) REFERENCES `currency_type` (`id`),
  CONSTRAINT `prices_place_id` FOREIGN KEY (`place_id`) REFERENCES `places` (`id`),
  CONSTRAINT `prices_type_id` FOREIGN KEY (`type_id`) REFERENCES `price_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица цен за место размещения внутри объекта';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices`
--

LOCK TABLES `prices` WRITE;
/*!40000 ALTER TABLE `prices` DISABLE KEYS */;
INSERT INTO `prices` VALUES (31,184.279,3,1,1,'1900-01-01 00:00:00','4000-01-01 00:00:00','2021-10-14 20:05:56','2021-10-14 20:05:56'),(32,600.51,2,2,2,'1900-01-01 00:00:00','4000-01-01 00:00:00','2021-10-14 20:05:56','2021-10-14 20:05:56'),(33,65.2498,1,3,2,'1900-01-01 00:00:00','4000-01-01 00:00:00','2021-10-14 20:05:56','2021-10-14 20:05:56'),(34,6.22046,3,4,1,'1900-01-01 00:00:00','4000-01-01 00:00:00','2021-10-14 20:05:56','2021-10-14 20:05:56'),(35,735.894,1,5,2,'1900-01-01 00:00:00','4000-01-01 00:00:00','2021-10-14 20:05:56','2021-10-14 20:05:56'),(36,703.597,3,6,1,'1900-01-01 00:00:00','4000-01-01 00:00:00','2021-10-14 20:05:56','2021-10-14 20:05:56'),(37,418.641,3,7,2,'1900-01-01 00:00:00','4000-01-01 00:00:00','2021-10-14 20:05:56','2021-10-14 20:05:56'),(38,494.15,1,8,1,'1900-01-01 00:00:00','4000-01-01 00:00:00','2021-10-14 20:05:56','2021-10-14 20:05:56'),(39,228.719,3,9,1,'1900-01-01 00:00:00','4000-01-01 00:00:00','2021-10-14 20:05:56','2021-10-14 20:05:56'),(40,955.448,3,10,1,'1900-01-01 00:00:00','4000-01-01 00:00:00','2021-10-14 20:05:56','2021-10-14 20:05:56');
/*!40000 ALTER TABLE `prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rates`
--

DROP TABLE IF EXISTS `rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Искусственный ключ',
  `rating_name` varchar(25) NOT NULL COMMENT 'Оценка',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица видов оценок';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rates`
--

LOCK TABLES `rates` WRITE;
/*!40000 ALTER TABLE `rates` DISABLE KEYS */;
INSERT INTO `rates` VALUES (1,'1','1982-11-22 14:51:06','2010-12-23 10:45:53'),(2,'2','2012-06-26 14:55:02','1995-11-02 22:30:11'),(3,'3','2004-03-21 20:38:20','1996-09-13 14:35:58'),(4,'4','1976-09-21 16:35:51','1985-08-15 12:12:09'),(5,'5','1996-07-03 05:11:35','1992-09-08 08:36:57'),(6,'6','2000-11-17 22:31:08','2005-03-29 07:42:00'),(7,'7','2010-05-25 12:32:10','2001-10-21 12:50:53'),(8,'8','2009-07-08 05:05:08','2013-04-27 15:51:39'),(9,'9','1979-12-18 12:05:43','1980-10-18 03:43:04'),(10,'10','1998-09-17 08:37:50','1976-12-24 14:20:55');
/*!40000 ALTER TABLE `rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `target_types`
--

DROP TABLE IF EXISTS `target_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `target_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Искусственный ключ',
  `target_name` varchar(50) NOT NULL COMMENT 'Ссылка на объект фото (объект размещения или место размещения)',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица видов объектов для привязки фото (сам обект размещения или место размещения внутри объекта)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `target_types`
--

LOCK TABLES `target_types` WRITE;
/*!40000 ALTER TABLE `target_types` DISABLE KEYS */;
INSERT INTO `target_types` VALUES (1,'Объект размещения','2021-10-14 19:14:35','2021-10-14 19:14:35'),(2,'Место размещения','2021-10-14 19:14:35','2021-10-14 19:14:35');
/*!40000 ALTER TABLE `target_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `unpopular_objects`
--

DROP TABLE IF EXISTS `unpopular_objects`;
/*!50001 DROP VIEW IF EXISTS `unpopular_objects`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `unpopular_objects` AS SELECT 
 1 AS `object_name`,
 1 AS `first_name`,
 1 AS `middle_name`,
 1 AS `last_name`,
 1 AS `phone`,
 1 AS `email`,
 1 AS `booking_cnt`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `user_status`
--

DROP TABLE IF EXISTS `user_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_status` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Искусственный ключ',
  `status_name` varchar(25) NOT NULL COMMENT 'Статус лояльности',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица статусов арендатора в программе лояльности';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_status`
--

LOCK TABLES `user_status` WRITE;
/*!40000 ALTER TABLE `user_status` DISABLE KEYS */;
INSERT INTO `user_status` VALUES (1,'Genius10','2021-10-14 19:14:39','2021-10-14 19:14:39'),(2,'Genius15','2021-10-14 19:14:39','2021-10-14 19:14:39'),(3,'Обычный','2021-10-14 19:14:39','2021-10-14 19:14:39');
/*!40000 ALTER TABLE `user_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Искусственный ключ',
  `first_name` varchar(50) NOT NULL COMMENT 'Имя арендатора',
  `middle_name` varchar(50) DEFAULT NULL COMMENT 'Отчество арендатора',
  `last_name` varchar(50) NOT NULL COMMENT 'Отчество арендатора',
  `email` varchar(100) NOT NULL COMMENT 'Email арендатора',
  `phone` varchar(100) NOT NULL COMMENT 'Номер телефона арендатора',
  `gender` varchar(10) NOT NULL COMMENT 'Пол арендатора',
  `birth_dt` date NOT NULL COMMENT 'Дата рождения арендатора',
  `country` varchar(100) NOT NULL COMMENT 'Страна местонахождения арендатора',
  `status_id` int unsigned NOT NULL COMMENT 'Ссылка статус арендатора',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `user_status` (`status_id`),
  CONSTRAINT `user_status` FOREIGN KEY (`status_id`) REFERENCES `user_status` (`id`),
  CONSTRAINT `сheck_phone_user` CHECK (regexp_like(`phone`,_utf8mb4'^\\+7[0-9]{10}$'))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица арендаторов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Jeremy','ea','Conroy','emclaughlin@example.com','+79521973023','Female','1972-04-23','USA',2,'1973-08-21 08:40:41','2021-10-19 14:46:11'),(2,'Luella','non','Nicolas','lschulist@example.net','+79607293086','Female','2017-03-26','USA',2,'1979-08-11 01:36:23','2021-10-19 14:46:11'),(3,'Karli','veritatis','Hudson','hswift@example.net','+79470546392','Female','2009-05-20','USA',3,'1980-05-14 12:12:12','2021-10-19 14:46:11'),(4,'Shaylee','perspiciatis','Bartell','baby84@example.net','+79530852735','Male','1986-10-01','GERMANY',1,'2015-11-28 12:03:49','2021-10-19 14:44:52'),(5,'Lauryn','ut','Marvin','graciela.stark@example.com','+79242624533','Male','1998-11-29','RUSSIA',3,'1990-12-13 08:34:30','2021-10-19 14:46:11'),(6,'Ruben','in','Lynch','ncollins@example.org','+79620564488','Male','1986-02-09','RUSSIA',3,'2020-02-15 19:28:12','2021-10-19 14:46:11'),(7,'Lionel','deleniti','Bode','dhilll@example.net','+79374948875','Male','2007-01-20','RUSSIA',1,'1981-08-11 21:34:07','2021-10-19 14:44:52'),(8,'Katherine','quis','Jacobi','hermiston.ellis@example.org','+79013050944','Male','1987-09-18','GERMANY',1,'1999-12-06 17:54:30','2021-10-19 14:44:52'),(9,'Amelia','quaerat','Kshlerin','viviane02@example.org','+79940408123','Male','2021-03-01','GERMANY',1,'2009-09-27 15:08:57','2021-10-19 14:44:52'),(10,'Zita','sed','Torp','cortney06@example.com','+79662887819','Male','1986-01-30','RUSSIA',2,'1977-08-22 10:13:04','2021-10-19 14:46:11');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `user_phone_format_ins` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
	CALL phone_format(NEW.phone);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `user_phone_format_upd` BEFORE UPDATE ON `users` FOR EACH ROW BEGIN
	CALL phone_format(NEW.phone);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `utilities`
--

DROP TABLE IF EXISTS `utilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilities` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Искусственный ключ',
  `utility_name` varchar(25) NOT NULL COMMENT 'Название удобства (кондиционер, белье, холодильник и т.д.)',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица типов удобств в местах размещения';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilities`
--

LOCK TABLES `utilities` WRITE;
/*!40000 ALTER TABLE `utilities` DISABLE KEYS */;
INSERT INTO `utilities` VALUES (1,'Ванна','2021-10-14 19:14:31','2021-10-14 19:14:31'),(2,'Кондиционер','2021-10-14 19:14:31','2021-10-14 19:14:31'),(3,'Фен','2021-10-14 19:14:31','2021-10-14 19:14:31'),(4,'Холодильник','2021-10-14 19:14:31','2021-10-14 19:14:31'),(5,'Москитные сетки','2021-10-14 19:14:31','2021-10-14 19:14:31'),(6,'Wi-Fi','2021-10-14 19:14:31','2021-10-14 19:14:31');
/*!40000 ALTER TABLE `utilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `genius_users`
--

/*!50001 DROP VIEW IF EXISTS `genius_users`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `genius_users` AS select upper(`us`.`first_name`) AS `first_name`,upper(`us`.`middle_name`) AS `middle_name`,upper(`us`.`last_name`) AS `last_name`,`us`.`email` AS `email`,`us`.`phone` AS `phone`,`us`.`gender` AS `gender`,timestampdiff(YEAR,`us`.`birth_dt`,now()) AS `age`,`us`.`country` AS `country`,`uss`.`status_name` AS `status_name` from (`users` `us` join `user_status` `uss` on((`us`.`status_id` = `uss`.`id`))) where (upper(`uss`.`status_name`) like '%GENIUS%') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `unpopular_objects`
--

/*!50001 DROP VIEW IF EXISTS `unpopular_objects`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `unpopular_objects` AS select `ob`.`object_name` AS `object_name`,upper(`ow`.`first_name`) AS `first_name`,upper(`ow`.`middle_name`) AS `middle_name`,upper(`ow`.`last_name`) AS `last_name`,`ow`.`phone` AS `phone`,`ow`.`email` AS `email`,sum(if((`bh`.`id` is null),0,1)) AS `booking_cnt` from (((`objects` `ob` join `places` `pl` on((`ob`.`id` = `pl`.`object_id`))) join `owners` `ow` on((`ob`.`owner_id` = `ow`.`id`))) left join `booking_history` `bh` on(((`bh`.`place_id` = `pl`.`id`) and (`bh`.`created_at` >= makedate(year(now()),1))))) where (`bh`.`id` is null) group by `ob`.`object_name`,`ow`.`first_name`,`ow`.`middle_name`,`ow`.`last_name`,`ow`.`phone`,`ow`.`email` having (sum(if((`bh`.`id` is null),0,1)) = 0) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-20 17:25:27
