CREATE DATABASE IF NOT EXISTS meli_database;

USE meli_database;




LOCK TABLES `api_challenge_database` WRITE;
/*!40000 ALTER TABLE `api_challenge_database` DISABLE KEYS */;
INSERT INTO `api_challenge_database` VALUES (6,'db_test',3306,'meli_user_testx','mysql_pass_test','db_challenge_test');

LOCK TABLES `api_challenge_informationtype` WRITE;
/*!40000 ALTER TABLE `api_challenge_informationtype` DISABLE KEYS */;
INSERT INTO `api_challenge_informationtype` VALUES (1,'N/A','^id$'),(2,'USERNAME','^username$'),(3,'EMAIL_ADDRESS','^(email|useremail)$'),(4,'CREDIT_CARD_NUMBER','^(credit|card_number|credit_card_number)$'),(5,'N/A','timestamp');
/*!40000 ALTER TABLE `api_challenge_informationtype` ENABLE KEYS */;
UNLOCK TABLES;
