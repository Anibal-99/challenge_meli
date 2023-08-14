-- MySQL dump 10.13  Distrib 8.1.0, for Linux (x86_64)
--
-- Host: db_api    Database: meli_database
-- ------------------------------------------------------
-- Server version	8.1.0

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
-- Table structure for table `api_challenge_classification`
--

CREATE DATABASE IF NOT EXISTS meli_database;

USE meli_database;

DROP TABLE IF EXISTS `api_challenge_classification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_challenge_classification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` datetime(6) NOT NULL,
  `scan_history_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `scan_history_id` (`scan_history_id`),
  CONSTRAINT `api_challenge_classi_scan_history_id_ea5d9a66_fk_api_chall` FOREIGN KEY (`scan_history_id`) REFERENCES `api_challenge_scanhistory` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_challenge_classification`
--

LOCK TABLES `api_challenge_classification` WRITE;
/*!40000 ALTER TABLE `api_challenge_classification` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_challenge_classification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_challenge_columndatabase`
--

DROP TABLE IF EXISTS `api_challenge_columndatabase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_challenge_columndatabase` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `information_type_id` bigint DEFAULT NULL,
  `table_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `api_challenge_column_table_id_3eaaaa01_fk_api_chall` (`table_id`),
  KEY `api_challenge_column_information_type_id_bbf3f7d2_fk_api_chall` (`information_type_id`),
  CONSTRAINT `api_challenge_column_information_type_id_bbf3f7d2_fk_api_chall` FOREIGN KEY (`information_type_id`) REFERENCES `api_challenge_informationtype` (`id`),
  CONSTRAINT `api_challenge_column_table_id_3eaaaa01_fk_api_chall` FOREIGN KEY (`table_id`) REFERENCES `api_challenge_tabledatabase` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_challenge_columndatabase`
--

LOCK TABLES `api_challenge_columndatabase` WRITE;
/*!40000 ALTER TABLE `api_challenge_columndatabase` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_challenge_columndatabase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_challenge_database`
--

DROP TABLE IF EXISTS `api_challenge_database`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_challenge_database` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `host` varchar(255) NOT NULL,
  `port` int NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_challenge_database`
--

LOCK TABLES `api_challenge_database` WRITE;
/*!40000 ALTER TABLE `api_challenge_database` DISABLE KEYS */;
INSERT INTO `api_challenge_database` VALUES (6,'db_test',3306,'meli_user_testx','mysql_pass_test','db_challenge_test');
/*!40000 ALTER TABLE `api_challenge_database` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_challenge_informationtype`
--

DROP TABLE IF EXISTS `api_challenge_informationtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_challenge_informationtype` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `regex` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_challenge_informationtype`
--

LOCK TABLES `api_challenge_informationtype` WRITE;
/*!40000 ALTER TABLE `api_challenge_informationtype` DISABLE KEYS */;
INSERT INTO `api_challenge_informationtype` VALUES (1,'N/A','^id$'),(2,'USERNAME','^username$'),(3,'EMAIL_ADDRESS','^(email|useremail)$'),(4,'CREDIT_CARD_NUMBER','^(credit|card_number|credit_card_number)$'),(5,'N/A','timestamp');
/*!40000 ALTER TABLE `api_challenge_informationtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_challenge_scanhistory`
--

DROP TABLE IF EXISTS `api_challenge_scanhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_challenge_scanhistory` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` datetime(6) NOT NULL,
  `database_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `api_challenge_scanhi_database_id_501180dc_fk_api_chall` (`database_id`),
  KEY `api_challenge_scanhistory_user_id_80396ab1_fk_user_user_id` (`user_id`),
  CONSTRAINT `api_challenge_scanhi_database_id_501180dc_fk_api_chall` FOREIGN KEY (`database_id`) REFERENCES `api_challenge_database` (`id`),
  CONSTRAINT `api_challenge_scanhistory_user_id_80396ab1_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_challenge_scanhistory`
--

LOCK TABLES `api_challenge_scanhistory` WRITE;
/*!40000 ALTER TABLE `api_challenge_scanhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_challenge_scanhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_challenge_tabledatabase`
--

DROP TABLE IF EXISTS `api_challenge_tabledatabase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_challenge_tabledatabase` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `clasification_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `api_challenge_tabled_clasification_id_ba44da9b_fk_api_chall` (`clasification_id`),
  CONSTRAINT `api_challenge_tabled_clasification_id_ba44da9b_fk_api_chall` FOREIGN KEY (`clasification_id`) REFERENCES `api_challenge_classification` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_challenge_tabledatabase`
--

LOCK TABLES `api_challenge_tabledatabase` WRITE;
/*!40000 ALTER TABLE `api_challenge_tabledatabase` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_challenge_tabledatabase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add Token',7,'add_token'),(26,'Can change Token',7,'change_token'),(27,'Can delete Token',7,'delete_token'),(28,'Can view Token',7,'view_token'),(29,'Can add token',8,'add_tokenproxy'),(30,'Can change token',8,'change_tokenproxy'),(31,'Can delete token',8,'delete_tokenproxy'),(32,'Can view token',8,'view_tokenproxy'),(33,'Can add Classification',9,'add_classification'),(34,'Can change Classification',9,'change_classification'),(35,'Can delete Classification',9,'delete_classification'),(36,'Can view Classification',9,'view_classification'),(37,'Can add Database Connection',10,'add_databaseconnections'),(38,'Can change Database Connection',10,'change_databaseconnections'),(39,'Can delete Database Connection',10,'delete_databaseconnections'),(40,'Can view Database Connection',10,'view_databaseconnections'),(41,'Can add Information type',11,'add_informationtype'),(42,'Can change Information type',11,'change_informationtype'),(43,'Can delete Information type',11,'delete_informationtype'),(44,'Can view Information type',11,'view_informationtype'),(45,'Can add scan history',12,'add_scanhistory'),(46,'Can change scan history',12,'change_scanhistory'),(47,'Can delete scan history',12,'delete_scanhistory'),(48,'Can view scan history',12,'view_scanhistory'),(49,'Can add Database Connection',10,'add_database'),(50,'Can change Database Connection',10,'change_database'),(51,'Can delete Database Connection',10,'delete_database'),(52,'Can view Database Connection',10,'view_database'),(53,'Can add Table database',13,'add_tabledatabase'),(54,'Can change Table database',13,'change_tabledatabase'),(55,'Can delete Table database',13,'delete_tabledatabase'),(56,'Can view Table database',13,'view_tabledatabase'),(57,'Can add Column Database',14,'add_columndatabase'),(58,'Can change Column Database',14,'change_columndatabase'),(59,'Can delete Column Database',14,'delete_columndatabase'),(60,'Can view Column Database',14,'view_columndatabase');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
INSERT INTO `authtoken_token` VALUES ('8a60c5986ce526cf66d51e8bf0a904b5fdf7b201','2023-08-12 20:49:11.922573',1);
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_user_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(9,'api_challenge','classification'),(14,'api_challenge','columndatabase'),(10,'api_challenge','database'),(11,'api_challenge','informationtype'),(12,'api_challenge','scanhistory'),(13,'api_challenge','tabledatabase'),(3,'auth','group'),(2,'auth','permission'),(7,'authtoken','token'),(8,'authtoken','tokenproxy'),(4,'contenttypes','contenttype'),(5,'sessions','session'),(6,'user','user');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-08-11 14:32:03.603249'),(2,'contenttypes','0002_remove_content_type_name','2023-08-11 14:32:03.709808'),(3,'auth','0001_initial','2023-08-11 14:32:04.247683'),(4,'auth','0002_alter_permission_name_max_length','2023-08-11 14:32:04.337874'),(5,'auth','0003_alter_user_email_max_length','2023-08-11 14:32:04.346208'),(6,'auth','0004_alter_user_username_opts','2023-08-11 14:32:04.363747'),(7,'auth','0005_alter_user_last_login_null','2023-08-11 14:32:04.376280'),(8,'auth','0006_require_contenttypes_0002','2023-08-11 14:32:04.384814'),(9,'auth','0007_alter_validators_add_error_messages','2023-08-11 14:32:04.398642'),(10,'auth','0008_alter_user_username_max_length','2023-08-11 14:32:04.410140'),(11,'auth','0009_alter_user_last_name_max_length','2023-08-11 14:32:04.422860'),(12,'auth','0010_alter_group_name_max_length','2023-08-11 14:32:04.515852'),(13,'auth','0011_update_proxy_permissions','2023-08-11 14:32:04.529965'),(14,'auth','0012_alter_user_first_name_max_length','2023-08-11 14:32:04.544308'),(15,'user','0001_initial','2023-08-11 14:32:05.078179'),(16,'admin','0001_initial','2023-08-11 14:32:05.261148'),(17,'admin','0002_logentry_remove_auto_add','2023-08-11 14:32:05.271078'),(18,'admin','0003_logentry_add_action_flag_choices','2023-08-11 14:32:05.279796'),(19,'sessions','0001_initial','2023-08-11 14:32:05.347962'),(20,'authtoken','0001_initial','2023-08-11 17:02:19.288295'),(21,'authtoken','0002_auto_20160226_1747','2023-08-11 17:02:19.354849'),(22,'authtoken','0003_tokenproxy','2023-08-11 17:02:19.374873'),(23,'api_challenge','0001_initial','2023-08-12 21:33:19.145632'),(24,'api_challenge','0002_rename_databaseconnections_database_and_more','2023-08-13 17:45:23.587858'),(25,'api_challenge','0003_database_name','2023-08-13 21:25:45.379579'),(26,'api_challenge','0004_alter_database_name','2023-08-13 22:19:59.515323'),(27,'api_challenge','0005_alter_columndatabase_table','2023-08-13 23:53:23.453645'),(28,'api_challenge','0006_alter_columndatabase_information_type','2023-08-14 00:02:26.359441'),(29,'api_challenge','0007_alter_classification_scan_history','2023-08-14 13:43:37.036906'),(30,'api_challenge','0008_alter_tabledatabase_clasification','2023-08-14 13:47:04.320856');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_user`
--

DROP TABLE IF EXISTS `user_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `email` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_user`
--

LOCK TABLES `user_user` WRITE;
/*!40000 ALTER TABLE `user_user` DISABLE KEYS */;
INSERT INTO `user_user` VALUES (1,'pbkdf2_sha256$600000$nZ38uLpK4TPi5XLs6GkNBl$rPMMuMnB+v0icotkQQ8JIazdFxKieQ34EocRPF+QQIo=',NULL,0,'meli@gmail.com','challenge_meli',1,0);
/*!40000 ALTER TABLE `user_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_user_groups`
--

DROP TABLE IF EXISTS `user_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_user_groups_user_id_group_id_bb60391f_uniq` (`user_id`,`group_id`),
  KEY `user_user_groups_group_id_c57f13c0_fk_auth_group_id` (`group_id`),
  CONSTRAINT `user_user_groups_group_id_c57f13c0_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_user_groups_user_id_13f9a20d_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_user_groups`
--

LOCK TABLES `user_user_groups` WRITE;
/*!40000 ALTER TABLE `user_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_user_user_permissions`
--

DROP TABLE IF EXISTS `user_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_user_user_permissions_user_id_permission_id_64f4d5b8_uniq` (`user_id`,`permission_id`),
  KEY `user_user_user_permi_permission_id_ce49d4de_fk_auth_perm` (`permission_id`),
  CONSTRAINT `user_user_user_permi_permission_id_ce49d4de_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_user_user_permissions_user_id_31782f58_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_user_user_permissions`
--

LOCK TABLES `user_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `user_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-14 13:57:44
