-- MySQL dump 10.13  Distrib 5.6.26, for Linux (x86_64)
--
-- Host: localhost    Database: bibliotheque
-- ------------------------------------------------------
-- Server version	5.6.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `element`
--

DROP TABLE IF EXISTS `element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `element` (
  `id_element` int(11) NOT NULL AUTO_INCREMENT,
  `id_narrative` int(11) NOT NULL,
  `type` enum('narrative','situation','transition','') COLLATE utf8_bin NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_element`),
  KEY `id_narrative` (`id_narrative`),
  CONSTRAINT `const_element_narrative` FOREIGN KEY (`id_narrative`) REFERENCES `narrative` (`id_narrative`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `element`
--

LOCK TABLES `element` WRITE;
/*!40000 ALTER TABLE `element` DISABLE KEYS */;
INSERT INTO `element` VALUES (1,1,'narrative','histoire_regis','2016-05-21 21:03:23'),(2,2,'narrative','histoire_robin','2016-05-21 21:03:23'),(3,3,'narrative','histoire_regis_robin','2016-05-21 21:03:51'),(4,4,'narrative','histoire_commune','2016-05-21 21:03:51'),(5,1,'situation','start','2016-05-21 21:08:42'),(6,2,'situation','start','2016-05-21 21:08:42'),(7,3,'situation','start','2016-05-21 21:08:42'),(8,4,'situation','start','2016-05-21 21:08:42'),(9,4,'situation','end_robin','2016-05-21 21:15:58'),(10,4,'situation','end_regis','2016-05-21 21:15:58'),(11,4,'transition','trans_robin','2016-05-21 21:15:58'),(12,4,'transition','trans_regis','2016-05-21 21:15:58');
/*!40000 ALTER TABLE `element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member` (
  `id_member` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `password` varchar(64) COLLATE utf8_bin NOT NULL,
  `email` varchar(64) COLLATE utf8_bin NOT NULL,
  `last_visit` datetime DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_member`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'Régis','Régispass','Regis.Catinaud@gmail.com',NULL,'2016-05-21 20:55:35'),(2,'Robin','Robinpass','Robin.Lamarche.Perrin@gmail.com',NULL,'2016-05-21 20:55:35');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `narrative`
--

DROP TABLE IF EXISTS `narrative`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `narrative` (
  `id_narrative` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) COLLATE utf8_bin NOT NULL,
  `abstract` text COLLATE utf8_bin NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_narrative`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `narrative`
--

LOCK TABLES `narrative` WRITE;
/*!40000 ALTER TABLE `narrative` DISABLE KEYS */;
INSERT INTO `narrative` VALUES (1,'Histoire Régis','Cette narration est modifiable par Régis uniquement.','2016-05-21 21:00:11'),(2,'Histoire Robin','Cette narration est modifiable par Robin uniquement. ','2016-05-21 21:00:11'),(3,'Histoire Régis et Robin','Cette narration est modifiable par Régis et Robin.','2016-05-21 21:01:41'),(4,'Histoire ouverte','Cette narration est modifiable par tout le monde.','2016-05-21 21:01:41');
/*!40000 ALTER TABLE `narrative` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reading`
--

DROP TABLE IF EXISTS `reading`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reading` (
  `id_member` int(11) NOT NULL,
  `id_element` int(11) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `id_member_element` (`id_member`,`id_element`,`date`),
  KEY `id_member` (`id_member`),
  KEY `id_element` (`id_element`),
  CONSTRAINT `const_reading_element` FOREIGN KEY (`id_element`) REFERENCES `element` (`id_element`),
  CONSTRAINT `const_reading_member` FOREIGN KEY (`id_member`) REFERENCES `member` (`id_member`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reading`
--

LOCK TABLES `reading` WRITE;
/*!40000 ALTER TABLE `reading` DISABLE KEYS */;
/*!40000 ALTER TABLE `reading` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rights`
--

DROP TABLE IF EXISTS `rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rights` (
  `id_member` int(11) NOT NULL,
  `id_element` int(11) NOT NULL,
  `type` enum('none','read','add','mod','full') COLLATE utf8_bin NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_member`,`id_element`) USING BTREE,
  KEY `const_rights_element` (`id_element`),
  CONSTRAINT `const_rights_element` FOREIGN KEY (`id_element`) REFERENCES `element` (`id_element`),
  CONSTRAINT `const_rights_member` FOREIGN KEY (`id_member`) REFERENCES `member` (`id_member`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rights`
--

LOCK TABLES `rights` WRITE;
/*!40000 ALTER TABLE `rights` DISABLE KEYS */;
INSERT INTO `rights` VALUES (1,1,'full','2016-05-21 21:06:09'),(1,3,'full','2016-05-21 21:06:09'),(1,4,'add','2016-05-21 21:06:09'),(2,2,'full','2016-05-21 21:06:09'),(2,3,'mod','2016-05-21 21:06:09'),(2,4,'add','2016-05-21 21:06:09');
/*!40000 ALTER TABLE `rights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `writing`
--

DROP TABLE IF EXISTS `writing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `writing` (
  `id_member` int(11) NOT NULL,
  `id_element` int(11) NOT NULL,
  `type` enum('create','modify','suppress','') COLLATE utf8_bin NOT NULL,
  `xml` text COLLATE utf8_bin NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `id_member_2` (`id_member`,`id_element`,`date`),
  KEY `id_member` (`id_member`),
  KEY `id_element` (`id_element`),
  CONSTRAINT `const_writing_element` FOREIGN KEY (`id_element`) REFERENCES `element` (`id_element`),
  CONSTRAINT `const_writing_member` FOREIGN KEY (`id_member`) REFERENCES `member` (`id_member`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `writing`
--

LOCK TABLES `writing` WRITE;
/*!40000 ALTER TABLE `writing` DISABLE KEYS */;
INSERT INTO `writing` VALUES (1,5,'create','<SITUATION NAME=\"start\">\r\n  <CONTENT>\r\n    <PRINT>Hello Régis!</PRINT>\r\n    <END/>\r\n  </CONTENT>\r\n</SITUATION>','2016-05-21 21:10:57'),(1,7,'modify','<SITUATION NAME=\"start\">\r\n  <CONTENT>\r\n    <PRINT>Hello Robin et Régis!</PRINT>\r\n    <END/>\r\n  </CONTENT>\r\n</SITUATION>','2016-05-21 21:14:21'),(1,8,'create','<SITUATION NAME=\"start\">\r\n  <CONTENT>\r\n    <PRINT>Hello...</PRINT>\r\n  </CONTENT>\r\n</SITUATION>','2016-05-21 21:20:48'),(1,10,'create','<SITUATION NAME=\"end_robin\">\r\n  <CONTENT>\r\n    <PRINT>... Régis!</PRINT>\r\n    <END/>\r\n  </CONTENT>\r\n</SITUATION>','2016-05-21 21:19:18'),(1,12,'create','<TRANSITION FROM=\"start\" TO=\"end_regis\">\r\n  <CHOICE>Régis</CHOICE>\r\n</TRANSITION>','2016-05-21 21:19:18'),(2,6,'create','<SITUATION NAME=\"start\">\r\n  <CONTENT>\r\n    <PRINT>Hello Robin!</PRINT>\r\n    <END/>\r\n  </CONTENT>\r\n</SITUATION>','2016-05-21 21:10:57'),(2,7,'create','<SITUATION NAME=\"start\">\r\n  <CONTENT>\r\n    <PRINT>Hello Robin!</PRINT>\r\n    <END/>\r\n  </CONTENT>\r\n</SITUATION>','2016-05-21 21:14:03'),(2,9,'create','<SITUATION NAME=\"end_robin\">\n  <CONTENT>\n    <PRINT>... Robin!</PRINT>\n    <END/>\n  </CONTENT>\n</SITUATION>','2016-05-21 21:19:18'),(2,11,'create','<TRANSITION FROM=\"start\" TO=\"end_robin\">\r\n  <CHOICE>Robin</CHOICE>\r\n</TRANSITION>','2016-05-21 21:19:18');
/*!40000 ALTER TABLE `writing` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-05-22 14:25:07
