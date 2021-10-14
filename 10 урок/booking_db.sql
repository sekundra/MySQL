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
  CONSTRAINT `booking_history_status` FOREIGN KEY (`status_id`) REFERENCES `booking_status` (`id`),
  CONSTRAINT `booking_history_type` FOREIGN KEY (`type_id`) REFERENCES `booking_types` (`id`),
  CONSTRAINT `booking_history_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица с периодами брони на места проживания';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_history`
--

LOCK TABLES `booking_history` WRITE;
/*!40000 ALTER TABLE `booking_history` DISABLE KEYS */;
INSERT INTO `booking_history` VALUES (1,1,'1984-05-10 17:32:46','1983-02-05 14:08:45',1,1,1,'2007-12-17 12:50:42','2020-03-24 01:35:01'),(2,2,'1977-08-17 21:59:30','2015-05-08 03:50:05',2,2,2,'2010-11-08 00:18:56','2014-09-14 22:52:39'),(3,3,'1991-02-04 23:32:25','1990-08-15 05:55:48',3,3,3,'2012-08-27 15:47:06','2015-12-07 08:44:23'),(4,4,'2014-07-05 01:38:13','2016-09-14 13:07:07',4,4,4,'2002-06-22 11:57:02','2010-11-10 20:40:23'),(5,5,'1977-06-29 08:03:12','1995-12-31 20:46:28',5,5,5,'1985-03-30 12:03:41','1973-10-12 20:49:05'),(6,6,'1994-09-15 14:15:35','1983-09-30 20:22:46',6,6,6,'2020-01-11 07:23:40','1995-04-05 19:40:05'),(7,7,'2016-09-17 14:32:58','1999-07-05 11:30:21',7,7,7,'2003-08-02 23:18:24','2020-11-16 23:06:54'),(8,8,'2003-06-24 06:08:43','2000-11-18 14:19:49',8,8,8,'2016-03-09 06:54:16','1974-12-05 16:13:28'),(9,9,'1992-06-11 01:56:59','1986-01-21 15:41:25',9,9,9,'1986-01-09 03:10:46','2019-11-11 09:03:21'),(10,10,'2000-04-09 16:22:28','2016-11-27 03:00:40',10,10,10,'1995-02-13 11:38:09','2000-12-14 22:05:09');
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица статусов бронирования';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_status`
--

LOCK TABLES `booking_status` WRITE;
/*!40000 ALTER TABLE `booking_status` DISABLE KEYS */;
INSERT INTO `booking_status` VALUES (1,'Sint occaecati enim dolor','1992-01-28 08:54:23','1998-11-09 05:08:11'),(2,'Qui nostrum velit tempore','2017-08-30 07:53:56','1971-08-21 15:19:45'),(3,'Et unde error occaecati e','1976-07-04 00:48:59','1997-02-27 22:42:31'),(4,'Assumenda inventore rerum','2010-07-29 07:06:41','2006-06-11 08:24:40'),(5,'Et rerum et sunt. Repella','1985-08-30 17:00:12','2003-09-18 15:08:00'),(6,'Numquam delectus recusand','2018-09-26 12:31:41','1979-06-08 14:56:11'),(7,'Ut aut quaerat amet est. ','2001-03-02 15:54:02','2009-05-07 02:01:23'),(8,'Deleniti pariatur qui eni','1983-05-12 01:03:41','2005-11-27 12:50:15'),(9,'Ut consequatur tempore qu','2011-02-19 09:35:17','1991-01-21 00:14:41'),(10,'Et sed modi quis dolore. ','1981-04-25 16:59:29','1987-06-07 12:27:41'),(11,'Бронь','2021-10-11 19:41:52','2021-10-11 19:41:52'),(12,'Заселение','2021-10-11 19:41:52','2021-10-11 19:41:52'),(13,'Отмена','2021-10-11 19:41:52','2021-10-11 19:41:52'),(14,'Незаезд','2021-10-11 19:41:52','2021-10-11 19:41:52');
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица типов бронирования';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_types`
--

LOCK TABLES `booking_types` WRITE;
/*!40000 ALTER TABLE `booking_types` DISABLE KEYS */;
INSERT INTO `booking_types` VALUES (1,'corporis','2010-08-31 04:37:35','1996-03-18 06:09:26'),(2,'deleniti','1998-09-14 00:31:01','1980-09-03 13:59:16'),(3,'consectetur','1995-11-19 06:43:21','1985-01-20 16:39:27'),(4,'aliquid','2018-12-21 05:05:31','1986-10-08 20:38:24'),(5,'dolor','2008-06-29 00:45:40','2017-08-10 20:49:03'),(6,'quis','1984-09-26 21:01:29','1999-03-10 12:06:25'),(7,'voluptatem','2020-01-02 02:26:37','1999-08-11 06:07:53'),(8,'occaecati','1976-07-03 01:01:28','1989-01-19 05:56:03'),(9,'optio','1974-11-28 05:44:54','1992-08-05 02:51:27'),(10,'dolorem','1996-05-28 13:04:48','1994-06-01 04:43:33'),(11,'Отдых','2021-10-11 19:42:44','2021-10-11 19:42:44'),(12,'Командировка','2021-10-11 19:42:44','2021-10-11 19:42:44');
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
INSERT INTO `currency_type` VALUES (1,'Российский рубль','RUR','2021-10-11 19:29:20','2021-10-11 19:29:20'),(2,'Доллар США','USD','2021-10-11 19:29:20','2021-10-11 19:29:20'),(3,'Евро','EUR','2021-10-11 19:29:20','2021-10-11 19:29:20');
/*!40000 ALTER TABLE `currency_type` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица типов объектов размещения';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `object_type`
--

LOCK TABLES `object_type` WRITE;
/*!40000 ALTER TABLE `object_type` DISABLE KEYS */;
INSERT INTO `object_type` VALUES (1,'nemo','1973-07-02 13:01:52','1996-11-20 18:18:11'),(2,'adipisci','1980-12-07 11:09:38','2020-03-18 12:00:57'),(3,'totam','1986-09-04 08:54:17','1990-01-18 11:41:07'),(4,'quas','1978-03-28 12:19:48','1998-12-03 21:43:31'),(5,'error','1999-10-29 23:22:40','2000-06-16 02:59:43'),(6,'unde','1986-11-14 04:55:42','1979-12-04 18:01:36'),(7,'adipisci','1971-09-09 08:59:00','1972-03-07 06:53:09'),(8,'voluptatibus','2018-04-22 05:25:13','2009-08-12 12:43:05'),(9,'assumenda','2020-10-24 06:23:19','2019-05-30 02:27:17'),(10,'laudantium','1997-02-18 14:48:58','1977-08-26 23:05:56'),(11,'Квартира','2021-10-11 19:33:06','2021-10-11 19:33:06'),(12,'Хостел','2021-10-11 19:33:06','2021-10-11 19:33:06'),(13,'Гостиница','2021-10-11 19:33:06','2021-10-11 19:33:06'),(14,'Гостевой дом','2021-10-11 19:33:06','2021-10-11 19:33:06');
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
  KEY `objects_type_id` (`type_id`),
  KEY `objects_owner_id` (`owner_id`),
  CONSTRAINT `objects_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `owners` (`id`),
  CONSTRAINT `objects_type_id` FOREIGN KEY (`type_id`) REFERENCES `object_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица объектов размещения';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objects`
--

LOCK TABLES `objects` WRITE;
/*!40000 ALTER TABLE `objects` DISABLE KEYS */;
INSERT INTO `objects` VALUES (1,'ex','Omnis id eaque voluptatum autem dolores quo et. Eum voluptatum laborum eaque. Rem iusto culpa perferendis sapiente eligendi inventore nulla.',0,0,'886227900','Port Kamronland',1,1,'1984-06-13 02:41:20','2007-02-19 02:34:00'),(2,'quibusdam','Perspiciatis praesentium iure nihil odit ea praesentium qui nihil. Molestias vel deleniti ad dolorum. Veritatis aspernatur aliquam autem et. Deleniti in possimus tenetur quas.',0,0,'6212','Bertramville',2,2,'1974-07-29 18:44:48','1998-12-18 01:24:54'),(3,'voluptates','Et doloremque qui eos quas eos. Quos odit est qui harum omnis ut voluptatum. Cumque deleniti placeat ducimus eligendi. Voluptas maxime sit est facilis dolorum.',0,0,'','Lake Kenstad',3,3,'1991-08-13 13:40:44','2015-08-27 20:02:38'),(4,'expedita','Eum incidunt autem velit repudiandae aliquid optio vitae hic. Qui sunt quos quo quas.',0,0,'','Port Jon',4,4,'1973-12-20 21:30:04','1988-01-28 00:24:09'),(5,'maxime','Itaque praesentium quas occaecati vel rerum blanditiis. Debitis et magnam et voluptatem. Explicabo sequi non mollitia neque veritatis maiores.',0,0,'234331273','New Heathershire',5,5,'2003-07-05 02:25:39','2016-01-08 20:16:25'),(6,'aut','Consequatur impedit placeat qui iste ut minima et consequatur. Dolor earum autem numquam rerum dolore accusamus. Sit atque optio quis et dolor id. Optio numquam maiores cum nemo alias assumenda tenetur.',0,0,'','Port Ari',6,6,'2007-12-19 14:10:02','1984-08-22 23:03:36'),(7,'non','Sapiente sunt aut in ratione impedit qui et numquam. Qui adipisci molestiae voluptatum minus voluptas omnis odit. Cumque ipsum modi perferendis possimus et. Iure ut eaque sed corporis.',0,0,'1','New Angelitaview',7,7,'1995-10-26 16:25:37','1984-01-01 02:34:06'),(8,'aliquid','Aut repudiandae ullam accusantium tempora amet laboriosam qui quo. Molestias dolores recusandae et quae deleniti rerum. Aut et unde et quia.',0,0,'','Jedediahside',8,8,'1975-09-09 22:45:30','2013-09-26 04:54:33'),(9,'dolor','Dolores perferendis officia ut sit. Consequuntur sit fugiat voluptas.',0,0,'46','Robelmouth',9,9,'1990-01-03 19:07:37','1976-08-04 03:10:59'),(10,'magni','Quam dolor quos aut doloribus accusantium nulla quia. Pariatur tenetur fugiat quia. Ex culpa enim maxime possimus dolores sed et. Quos doloremque repellendus et omnis sed temporibus.',0,0,'650','Port Sabina',10,10,'1984-01-20 04:15:58','2004-08-15 17:41:10');
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
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица владельцев объектов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owners`
--

LOCK TABLES `owners` WRITE;
/*!40000 ALTER TABLE `owners` DISABLE KEYS */;
INSERT INTO `owners` VALUES (1,'Clare','omnis','Maggio','murphy.flatley@example.org','+90(2)5401629236','1989-08-28 16:55:03','2001-11-03 13:25:58'),(2,'Eusebio','quia','Ritchie','brady.stoltenberg@example.com','338-080-4975','2016-05-05 23:17:16','1983-11-26 02:03:27'),(3,'Billie','voluptatum','Nader','brent03@example.org','(974)241-0584','1981-12-01 17:06:25','2003-05-29 18:34:33'),(4,'Ricky','minima','O\'Conner','don42@example.org','1-159-733-0445x456','2003-03-06 22:45:43','1985-05-03 02:07:21'),(5,'Chaim','et','Lebsack','electa.lang@example.com','(054)270-6971x9344','1974-01-20 01:11:53','2020-09-22 22:02:27'),(6,'Janet','doloremque','Auer','runte.delaney@example.com','573-763-3277x4204','1998-03-14 23:48:54','1983-07-29 04:21:44'),(7,'Reta','quis','White','zdouglas@example.com','+69(7)3589540000','1979-04-25 11:59:33','1992-11-18 17:22:00'),(8,'Koby','explicabo','Hand','auer.concepcion@example.com','(037)975-1030','1997-07-13 01:20:38','2003-08-18 22:14:29'),(9,'Anya','quis','Lockman','reinger.myriam@example.net','07134225578','2011-09-05 14:01:26','2005-03-20 11:43:34'),(10,'Gaylord','expedita','West','shaina.wiza@example.net','801-302-9179','2014-11-09 07:26:14','1975-06-04 16:38:27');
/*!40000 ALTER TABLE `owners` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица оцениваемых характеристик';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parametrs`
--

LOCK TABLES `parametrs` WRITE;
/*!40000 ALTER TABLE `parametrs` DISABLE KEYS */;
INSERT INTO `parametrs` VALUES (1,'distinctio','1974-04-07 15:04:18','1979-08-06 05:27:55'),(2,'voluptatem','2020-10-26 21:28:19','2017-01-16 04:42:33'),(3,'hic','2013-07-21 14:04:56','2004-11-21 03:11:14'),(4,'ut','2008-05-21 20:06:29','1971-03-03 06:39:15'),(5,'omnis','1994-06-10 20:14:52','2001-06-17 22:06:43'),(6,'id','2003-03-18 04:31:08','2002-07-03 08:27:44'),(7,'et','2002-02-19 19:47:17','1988-02-06 12:04:19'),(8,'corrupti','1973-09-25 11:33:48','1973-11-26 20:35:56'),(9,'quia','1982-03-06 08:13:51','1993-01-08 17:39:13'),(10,'quae','2006-11-05 21:30:53','1980-03-17 18:52:15'),(16,'Чистота','2021-10-11 19:49:11','2021-10-11 19:49:11'),(17,'Близость к центру','2021-10-11 19:49:11','2021-10-11 19:49:11'),(18,'Удобная кровать','2021-10-11 19:49:11','2021-10-11 19:49:11'),(19,'Хозяева','2021-10-11 19:49:11','2021-10-11 19:49:11'),(20,'Тишина','2021-10-11 19:49:11','2021-10-11 19:49:11');
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
INSERT INTO `pictures` VALUES (1,0,1,'http://murray.com/','1974-03-09 17:46:42','2013-03-26 21:43:13'),(2,0,2,'http://kris.org/','1998-09-17 18:47:23','1975-10-09 00:15:23'),(3,0,3,'http://www.bernierschuppe.com/','2010-06-19 07:31:19','1983-04-15 06:12:21'),(4,0,4,'http://www.kiehndeckow.info/','2018-10-29 11:02:38','1978-09-26 13:36:08'),(5,0,5,'http://www.spinka.com/','1978-04-09 12:41:19','2017-08-08 22:31:41'),(6,0,6,'http://pagac.com/','2015-10-11 03:10:19','2003-03-05 12:02:48'),(7,0,7,'http://www.gottliebschneider.org/','2002-01-18 23:46:30','1983-11-16 15:33:47'),(8,0,8,'http://haley.com/','1982-05-13 14:24:28','2005-11-27 18:45:28'),(9,0,9,'http://lockmanruecker.com/','1977-01-02 22:29:47','2019-06-08 05:03:28'),(10,0,10,'http://kuhlman.info/','2003-07-21 10:59:09','1982-04-03 17:16:47');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица с оценками арендаторов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `place_rating`
--

LOCK TABLES `place_rating` WRITE;
/*!40000 ALTER TABLE `place_rating` DISABLE KEYS */;
INSERT INTO `place_rating` VALUES (1,1,1,1,'1981-06-28 06:14:51','1978-10-22 00:10:27'),(2,2,2,2,'2019-05-27 14:49:26','1985-05-20 08:05:31'),(3,3,3,3,'1975-03-07 15:54:48','2020-01-21 11:34:58'),(4,4,4,4,'2011-09-25 01:23:58','2018-01-28 11:24:58'),(5,5,5,5,'2017-10-08 18:46:08','2013-11-15 11:35:03'),(6,6,6,6,'1985-10-01 10:40:15','2015-11-13 23:26:43'),(7,7,7,7,'1971-08-17 06:30:15','2015-02-13 19:34:28'),(8,8,8,8,'1977-10-24 02:46:00','1983-03-12 05:48:03'),(9,9,9,9,'1972-03-22 04:40:25','2010-04-15 08:44:11'),(10,10,10,10,'2012-09-19 00:51:02','1979-11-15 21:04:34');
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
  KEY `place_review_booking` (`booking_id`),
  CONSTRAINT `place_review_booking` FOREIGN KEY (`booking_id`) REFERENCES `booking_history` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица с отзывами арендаторов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `place_review`
--

LOCK TABLES `place_review` WRITE;
/*!40000 ALTER TABLE `place_review` DISABLE KEYS */;
INSERT INTO `place_review` VALUES (1,1,'Libero velit fugit deserunt eos nihil laboriosam assumenda. Aut aperiam nihil rem necessitatibus sunt dolor omnis. Aut accusantium omnis exercitationem nam ipsum voluptates enim. Expedita quisquam enim voluptas velit accusamus.','1992-11-05 02:55:20','1998-11-08 21:10:52'),(2,2,'Et doloribus repudiandae et omnis totam. Voluptatem commodi rerum beatae exercitationem. Omnis ratione aut consequatur qui quasi deleniti.','2019-11-05 12:29:41','2002-12-05 03:48:39'),(3,3,'Voluptatum at provident cumque at. Ut quis quidem exercitationem ex quas reiciendis. Est eos est optio rerum delectus dignissimos ut consequuntur. Qui consequatur vel ea maiores assumenda.','2004-06-18 20:25:56','2000-03-23 13:38:59'),(4,4,'Omnis placeat omnis praesentium facere iusto rerum et. Eos ipsam est tenetur numquam commodi incidunt. Excepturi est molestiae beatae sunt. Sed est maiores quidem sit recusandae veritatis.','1978-02-11 07:00:13','2007-03-12 12:05:11'),(5,5,'Similique ad aut possimus rerum. Explicabo consequatur soluta molestias ex. Consequatur laboriosam libero est maxime similique.','2007-10-12 19:37:12','2001-05-21 13:24:40'),(6,6,'Ab sit sit ullam porro in. Illo vitae quos magnam eius vel eligendi eum ipsum. Possimus quod quia maiores libero architecto.','1987-03-02 11:50:34','2014-07-27 19:07:55'),(7,7,'Consectetur molestiae occaecati quo at laborum odit. Nisi qui ratione vel illo molestias hic sit. Nihil repudiandae similique nihil deleniti aut a quia. Aperiam laudantium nisi aspernatur.','1999-12-18 11:25:01','2008-07-03 00:14:04'),(8,8,'Laborum voluptates rerum asperiores ipsam aut. Nostrum dolores laboriosam incidunt tempora suscipit.','2005-04-03 01:20:32','2002-03-13 20:09:59'),(9,9,'In nesciunt aut ea nostrum cumque quisquam. In quia quibusdam placeat excepturi debitis aut. Recusandae amet eveniet voluptatem.','1981-05-20 09:20:59','1979-07-02 19:55:15'),(10,10,'Natus ipsum aut itaque explicabo et sunt. Placeat id dolore aut architecto excepturi optio. Excepturi doloremque recusandae doloribus.','2000-01-03 13:04:02','1977-03-05 16:25:28');
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
INSERT INTO `place_x_utility` VALUES (1,1,'1981-10-19 06:28:17','2015-04-25 22:43:58'),(2,2,'1976-08-08 15:28:40','2006-11-20 07:48:56'),(3,3,'1973-07-11 01:16:00','1972-06-17 17:47:23'),(4,4,'2010-05-07 02:25:49','2003-02-15 06:58:36'),(5,5,'1984-04-15 12:41:33','1987-09-02 21:25:08'),(6,6,'1984-11-06 19:15:25','2021-10-07 09:58:27'),(7,7,'1989-05-03 14:37:50','1983-02-07 04:22:51'),(8,8,'2017-12-25 05:46:56','2004-01-25 02:05:00'),(9,9,'1971-10-30 00:03:34','1988-11-28 22:54:46'),(10,10,'1970-05-19 06:06:18','1982-06-28 22:44:38');
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
INSERT INTO `places` VALUES (1,'doloribus','Ex eos tenetur ullam modi commodi eligendi. Qui quaerat quasi vero in sed consequatur. Aut ut qui molestiae. Dolorem deleniti id vero sapiente.',1,0,'2001-12-02 20:42:38','1994-06-15 14:43:25'),(2,'dicta','Quidem tempore quidem suscipit. Aut quia rerum cupiditate sed necessitatibus. Tempora alias hic labore quam enim officia.',2,0,'1998-01-11 01:28:45','1980-06-30 20:28:30'),(3,'et','Qui atque error nihil sit molestias. Suscipit ipsum sint magnam ut et et. Est autem sequi facilis.',3,0,'2018-02-21 01:01:49','1992-03-31 13:29:13'),(4,'laboriosam','Molestiae vel quas non dolores. Ad expedita facere unde quo aut. Illum sed iure repellendus praesentium. Eum dolorem in nihil ut. Aspernatur qui assumenda ut tenetur occaecati et facilis.',4,0,'1980-04-01 03:33:38','1988-06-04 10:33:48'),(5,'molestias','Quia perspiciatis placeat labore aliquam nisi nobis. At enim officia quia eum alias.',5,0,'1985-10-21 18:47:28','1972-11-04 07:27:51'),(6,'cupiditate','Modi aliquam quae aliquam. Accusantium quam magnam minima consectetur. Natus quia consequatur voluptate dolorem aut est quia.',6,0,'2008-04-20 12:50:32','1971-05-09 02:00:31'),(7,'ut','Sunt illo vitae accusamus ad dolores earum omnis. Aut labore optio omnis dignissimos. In delectus sequi et culpa molestiae. Ratione ipsam fugit consequatur et quo animi. Iusto rerum dolore tempore quaerat voluptatem dolorum voluptate et.',7,0,'2019-03-19 22:08:55','1995-03-10 23:44:20'),(8,'harum','Iste eius aut repudiandae est ut. Eaque laborum repellendus doloribus veniam voluptas qui sed. Doloremque eligendi pariatur natus magni omnis. Ut incidunt exercitationem sit vel quibusdam non.',8,0,'2011-08-03 10:48:05','2004-05-07 04:26:21'),(9,'laudantium','Voluptas consectetur quia quas qui nostrum qui aut. Et quo alias occaecati voluptatem quia velit ut. Et reiciendis ipsam quaerat quas et.',9,0,'2003-09-18 18:19:16','1988-10-29 22:33:35'),(10,'asperiores','Error aliquid porro sint adipisci inventore ipsum. Repudiandae dicta alias doloremque. Cupiditate incidunt possimus aperiam dolorem eum totam similique.',10,0,'1988-09-21 11:29:01','1991-03-09 23:55:02');
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица типов цен';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price_type`
--

LOCK TABLES `price_type` WRITE;
/*!40000 ALTER TABLE `price_type` DISABLE KEYS */;
INSERT INTO `price_type` VALUES (1,'23.46549','1970-05-31 21:59:03','2015-05-31 02:24:52'),(2,'221040453.85454','1981-12-02 20:12:32','1989-12-12 16:29:08'),(3,'446655.829','2004-10-12 16:11:16','1998-06-15 15:30:18'),(4,'15.03901','1983-05-03 13:59:45','1977-02-20 11:02:55'),(5,'274342042.71791','2010-04-18 17:40:41','2017-09-20 10:47:03'),(6,'1420.489','1971-11-03 02:14:34','1973-02-23 10:05:42'),(7,'7.34853','1980-11-27 14:55:29','2020-12-16 17:34:36'),(8,'213112227.1078','2019-07-18 12:52:47','1989-12-26 08:44:45'),(9,'22807080.946928','2006-07-27 15:44:07','1984-12-25 05:27:18'),(10,'1.167','2001-04-13 14:58:32','1996-10-30 04:33:13'),(11,'За гостя','2021-10-11 19:34:56','2021-10-11 19:34:56'),(12,'За место размещения','2021-10-11 19:34:56','2021-10-11 19:34:56');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица цен за место размещения внутри объекта';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices`
--

LOCK TABLES `prices` WRITE;
/*!40000 ALTER TABLE `prices` DISABLE KEYS */;
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
INSERT INTO `rates` VALUES (1,'','1982-11-22 14:51:06','2010-12-23 10:45:53'),(2,'104980','2012-06-26 14:55:02','1995-11-02 22:30:11'),(3,'4','2004-03-21 20:38:20','1996-09-13 14:35:58'),(4,'','1976-09-21 16:35:51','1985-08-15 12:12:09'),(5,'746','1996-07-03 05:11:35','1992-09-08 08:36:57'),(6,'','2000-11-17 22:31:08','2005-03-29 07:42:00'),(7,'422199390','2010-05-25 12:32:10','2001-10-21 12:50:53'),(8,'32','2009-07-08 05:05:08','2013-04-27 15:51:39'),(9,'670207443','1979-12-18 12:05:43','1980-10-18 03:43:04'),(10,'936','1998-09-17 08:37:50','1976-12-24 14:20:55');
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица видов объектов для привязки фото (сам обект размещения или место размещения внутри объекта)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `target_types`
--

LOCK TABLES `target_types` WRITE;
/*!40000 ALTER TABLE `target_types` DISABLE KEYS */;
INSERT INTO `target_types` VALUES (1,'sed','2013-01-12 00:24:03','2011-05-01 12:28:05'),(2,'et','1997-12-22 14:17:54','1986-04-13 03:07:41'),(3,'ad','1982-07-20 12:27:58','1991-10-02 13:18:15'),(4,'qui','2005-03-29 18:44:33','2011-01-01 04:20:56'),(5,'et','1999-06-20 18:48:33','1983-09-30 20:48:51'),(6,'et','2015-08-25 20:59:01','2019-08-28 09:33:03'),(7,'amet','1992-05-20 14:11:54','2020-06-15 14:15:57'),(8,'ea','1991-03-15 12:30:23','2007-11-07 03:06:02'),(9,'labore','2012-03-20 16:16:17','1993-08-11 19:59:53'),(10,'cumque','1993-06-09 12:04:25','1975-07-10 10:14:08'),(11,'Объект размещения','2021-10-11 19:38:38','2021-10-11 19:38:38'),(12,'Место размещения','2021-10-11 19:38:38','2021-10-11 19:38:38');
/*!40000 ALTER TABLE `target_types` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица статусов арендатора в программе лояльности';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_status`
--

LOCK TABLES `user_status` WRITE;
/*!40000 ALTER TABLE `user_status` DISABLE KEYS */;
INSERT INTO `user_status` VALUES (1,'Quia iure eum rerum dolor','1978-05-15 18:19:19','2017-07-24 03:52:03'),(2,'Eveniet qui illo harum. F','1986-01-13 18:16:09','2010-11-01 06:13:37'),(3,'Ipsum enim eligendi possi','1989-09-29 16:57:09','1975-04-27 09:55:54'),(4,'Beatae esse qui sed labor','1970-03-16 03:08:35','1987-09-05 22:20:38'),(5,'Voluptatibus necessitatib','2020-07-20 03:46:13','2014-12-11 13:08:22'),(6,'Eos sit a ad. Consequatur','2010-03-18 02:11:58','1973-09-26 10:46:11'),(7,'Nulla id ipsum tempore se','2004-01-27 03:17:31','2002-10-19 18:31:04'),(8,'Sed omnis deserunt hic. V','1998-10-04 10:14:00','2005-02-02 11:36:05'),(9,'Veniam vel harum rerum au','2006-04-01 04:40:16','2016-01-12 04:07:48'),(10,'Voluptatem soluta eum vol','1990-06-11 05:36:48','2014-12-09 13:01:54'),(11,'Genius10','2021-10-11 19:39:49','2021-10-11 19:39:49'),(12,'Genius15','2021-10-11 19:39:49','2021-10-11 19:39:49'),(13,'Обычный','2021-10-11 19:39:49','2021-10-11 19:39:49');
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
  CONSTRAINT `user_status` FOREIGN KEY (`status_id`) REFERENCES `user_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица арендаторов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Jeremy','ea','Conroy','emclaughlin@example.com','336-566-5028x12537','','1972-04-23','13140',1,'1973-08-21 08:40:41','2020-02-18 03:58:55'),(2,'Luella','non','Nicolas','lschulist@example.net','1-593-365-0832x0536','','2017-03-26','9878014',2,'1979-08-11 01:36:23','2020-10-10 22:56:50'),(3,'Karli','veritatis','Hudson','hswift@example.net','904-059-8566x1059','','2009-05-20','63289',3,'1980-05-14 12:12:12','1980-09-16 08:17:08'),(4,'Shaylee','perspiciatis','Bartell','baby84@example.net','726.313.2923x3255','','1986-10-01','71998808',4,'2015-11-28 12:03:49','1989-02-11 06:13:20'),(5,'Lauryn','ut','Marvin','graciela.stark@example.com','(260)063-2812x23983','','1998-11-29','8561',5,'1990-12-13 08:34:30','1970-09-28 06:43:53'),(6,'Ruben','in','Lynch','ncollins@example.org','038.394.6746','','1986-02-09','9589482',6,'2020-02-15 19:28:12','1999-10-01 02:29:54'),(7,'Lionel','deleniti','Bode','dhilll@example.net','(282)699-7428','','2007-01-20','',7,'1981-08-11 21:34:07','2008-03-27 00:28:11'),(8,'Katherine','quis','Jacobi','hermiston.ellis@example.org','+06(7)9684203523','','1987-09-18','2579',8,'1999-12-06 17:54:30','1982-07-05 12:13:08'),(9,'Amelia','quaerat','Kshlerin','viviane02@example.org','02454533231','','2021-03-01','505',9,'2009-09-27 15:08:57','2014-10-17 17:16:04'),(10,'Zita','sed','Torp','cortney06@example.com','865-210-0272','','1986-01-30','326',10,'1977-08-22 10:13:04','2020-02-07 23:02:54');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица типов удобств в местах размещения';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilities`
--

LOCK TABLES `utilities` WRITE;
/*!40000 ALTER TABLE `utilities` DISABLE KEYS */;
INSERT INTO `utilities` VALUES (1,'at','2013-01-27 04:46:42','2006-03-11 18:37:17'),(2,'omnis','1990-09-10 16:40:48','1985-10-04 02:25:32'),(3,'doloremque','1991-05-24 02:37:29','2016-02-22 00:09:46'),(4,'est','1988-02-15 12:14:32','1993-03-09 22:38:54'),(5,'laboriosam','1972-02-21 02:38:14','1974-12-30 18:14:41'),(6,'deleniti','1971-11-15 09:33:07','1998-06-11 07:07:31'),(7,'ratione','1980-02-21 07:50:00','1989-02-01 13:41:01'),(8,'eos','2017-01-08 18:25:36','1978-02-23 21:53:54'),(9,'velit','1982-01-21 04:27:57','1991-09-07 08:43:29'),(10,'est','2015-08-28 06:19:35','1978-11-09 18:52:16'),(11,'Ванна','2021-10-11 19:36:54','2021-10-11 19:36:54'),(12,'Кондиционер','2021-10-11 19:36:54','2021-10-11 19:36:54'),(13,'Фен','2021-10-11 19:36:54','2021-10-11 19:36:54'),(14,'Холодильник','2021-10-11 19:36:54','2021-10-11 19:36:54'),(15,'Москитные сетки','2021-10-11 19:36:54','2021-10-11 19:36:54'),(16,'Wi-Fi','2021-10-11 19:36:54','2021-10-11 19:36:54');
/*!40000 ALTER TABLE `utilities` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-11 19:49:44
