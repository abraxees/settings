-- MySQL dump 10.13  Distrib 5.6.19, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: hornet
-- ------------------------------------------------------
-- Server version	5.6.19-0ubuntu0.14.04.1

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
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) CHARACTER SET utf8 NOT NULL,
  `lat` decimal(8,4) NOT NULL,
  `lon` decimal(8,4) NOT NULL,
  `confidence` int(11) DEFAULT '0',
  `maxDistanceCovered` double DEFAULT NULL,
  `lastSolved` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4696 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `device`
--

DROP TABLE IF EXISTS `device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device` (
  `UUID` varchar(16) CHARACTER SET utf8 NOT NULL,
  `lat` double DEFAULT NULL,
  `long` double DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `lastLogin` datetime(3) DEFAULT NULL,
  `cityid` int(11) DEFAULT NULL,
  `auth` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cookie` varchar(350) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`UUID`),
  KEY `userid_idx` (`userid`),
  KEY `id_idx` (`cityid`),
  CONSTRAINT `fk_device_1` FOREIGN KEY (`cityid`) REFERENCES `city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `favourite`
--

DROP TABLE IF EXISTS `favourite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favourite` (
  `userOf` int(11) NOT NULL,
  `userTo` int(11) NOT NULL,
  PRIMARY KEY (`userOf`,`userTo`),
  KEY `user2_idx` (`userTo`),
  CONSTRAINT `user1` FOREIGN KEY (`userOf`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user2` FOREIGN KEY (`userTo`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `geocode`
--

DROP TABLE IF EXISTS `geocode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geocode` (
  `latitude` decimal(4,4) NOT NULL,
  `longitude` decimal(4,4) NOT NULL,
  `Address` varchar(150) CHARACTER SET utf8 DEFAULT NULL,
  `city` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `country` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`latitude`,`longitude`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `id` bigint(16) NOT NULL,
  `sender` int(11) NOT NULL,
  `recipient` int(11) NOT NULL,
  `data` varchar(1000) CHARACTER SET utf8mb4 DEFAULT NULL,
  `time` datetime NOT NULL,
  `message_id` varchar(25) CHARACTER SET utf8 DEFAULT NULL,
  `type` varchar(25) CHARACTER SET utf8 DEFAULT NULL,
  `client_ref` varchar(25) CHARACTER SET utf8 DEFAULT NULL,
  `client-ref` varchar(25) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id1_idx` (`sender`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nickname`
--

DROP TABLE IF EXISTS `nickname`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nickname` (
  `idnickname` varchar(30) CHARACTER SET utf8 NOT NULL,
  `userId` int(13) DEFAULT NULL,
  PRIMARY KEY (`idnickname`),
  KEY `user_idx` (`userId`),
  CONSTRAINT `dd33` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `photo`
--

DROP TABLE IF EXISTS `photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photo` (
  `idpicture` int(11) NOT NULL,
  `guid` varchar(40) CHARACTER SET utf8 NOT NULL,
  `prefix` varchar(5) CHARACTER SET utf8 NOT NULL,
  `userid` int(11) NOT NULL,
  `isMain` tinyint(1) NOT NULL,
  `created` datetime DEFAULT NULL,
  `isDownloaded` tinyint(1) DEFAULT '0',
  `isHidden` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idpicture`),
  KEY `user_idx` (`userid`),
  KEY `uid` (`guid`),
  CONSTRAINT `userq` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profile`
--

DROP TABLE IF EXISTS `profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile` (
  `userid` int(11) NOT NULL,
  `about_you` varchar(600) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display_name` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `headline` varchar(600) CHARACTER SET utf8mb4 DEFAULT NULL,
  PRIMARY KEY (`userid`),
  CONSTRAINT `use2r` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `siteuser`
--

DROP TABLE IF EXISTS `siteuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `siteuser` (
  `user_id` int(11) NOT NULL,
  `email` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `user_nickname` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_deviceid` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_accesstoken` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `thumb` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `display_name` varchar(45) CHARACTER SET utf8mb4 DEFAULT NULL,
  `status_icon` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `created` datetime(3) DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userlocation`
--

DROP TABLE IF EXISTS `userlocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userlocation` (
  `idlocations` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(10) NOT NULL,
  `lat` decimal(8,5) NOT NULL,
  `lon` decimal(8,5) NOT NULL,
  `error_km` decimal(5,4) DEFAULT NULL,
  `status` varchar(15) CHARACTER SET utf8mb4 DEFAULT NULL,
  `when` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlocations`),
  KEY `userId` (`userId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=74304156 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-09-12  4:41:01
