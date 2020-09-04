-- MySQL dump 10.16  Distrib 10.1.26-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: db
-- ------------------------------------------------------
-- Server version	10.1.26-MariaDB-0+deb9u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Blogs`
--

DROP TABLE IF EXISTS `Blogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Blogs` (
  `id` tinyint(4) DEFAULT NULL,
  `title` varchar(3) DEFAULT NULL,
  `thumbnail` varchar(11) DEFAULT NULL,
  `pictures` varchar(31) DEFAULT NULL,
  `content` text,
  `category` varchar(4) DEFAULT NULL,
  `status` varchar(9) DEFAULT NULL,
  `createdAt` varchar(10) DEFAULT NULL,
  `updatedAt` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Blogs`
--

LOCK TABLES `Blogs` WRITE;
/*!40000 ALTER TABLE `Blogs` DISABLE KEYS */;
INSERT INTO `Blogs` VALUES (18,'asd','3150182.jpg','[{\"id\":1,\"name\":\"3150182.jpg\"}]','','fdfg','published','2020-07-31','2020-08-24'),(21,'a','3150182.jpg','[{\"id\":1,\"name\":\"3150182.jpg\"}]','','a','saved','2020-07-31','2020-08-24'),(22,'b','3897650.jpg','[{\"id\":1,\"name\":\"3897650.jpg\"}]','<p>b</p>\r\n','b','published','2020-07-31','2020-08-24'),(24,'d','3921396.jpg','[{\"id\":1,\"name\":\"3921396.jpg\"}]','<p>dbsdbfsjahsdklfjads;jfkladsjlf;asjfliewajioaewjeoiwprjafoi;ja;ieowhjoaeolaefw;afwk</p>\r\n\r\n<p>ASDAKJSDFHKALWEJKJAWERLKFJAWOIJAELKF;ML;AKEWJFL;AEKWFL;AEKWLF;FK</p>\r\n\r\n<p>BKJBKJEWnfkjnalkfwnkalwenlkf;anlkrnaflkaejrnflkjaerwnljfawheewjrlkewRWeewER</p>\r\n\r\n<p>nbvaewbkjaewnfjawenflklkwaerjlkewjrklejwklnflkaenflkaenlkanalk;rnfalkr;nakrnfklrf</p>\r\n\r\n<p>kjewfLKefwjkljEWK;Jew;lf</p>\r\n\r\n<p><br />\r\n<img alt=\"picture image\" src=\"http://localhost:8081/assets/uploads/3921396.jpg\" style=\"float:left; height:250px; width:250px\" /></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>EWFMKwefhW E[KLIAFLJKENRWKJTOIAERJKGHAEKJRTLQHKRHTUINJRAKIUEHGROIT4HNIKJNIOLR</p>\r\n','d','saved','2020-07-31','2020-08-24'),(26,'g','3921396.jpg','[{\"id\":1,\"name\":\"3921396.jpg\"}]','<p>g</p>\r\n','g','published','2020-07-31','2020-08-24'),(27,'x','3066071.jpg','[{\"id\":1,\"name\":\"3066071.jpg\"}]','<p>x</p>\r\n','x','published','2020-07-31','2020-08-24');
/*!40000 ALTER TABLE `Blogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Comments`
--

DROP TABLE IF EXISTS `Comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Comments` (
  `id` tinyint(4) DEFAULT NULL,
  `blogId` tinyint(4) DEFAULT NULL,
  `comment` varchar(30) DEFAULT NULL,
  `userId` tinyint(4) DEFAULT NULL,
  `createdAt` varchar(10) DEFAULT NULL,
  `updatedAt` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Comments`
--

LOCK TABLES `Comments` WRITE;
/*!40000 ALTER TABLE `Comments` DISABLE KEYS */;
INSERT INTO `Comments` VALUES (22,24,'สนุกมากๆเลยครับฟหกฟหก',32,'2020-08-10','2020-08-10'),(23,24,'หฟกฟหกฟกหฟหกdasasdadsฟหกฟหกฟหก',32,'2020-08-10','2020-09-04'),(25,24,'โครตดีอะเนื้อหากินใจๆๆๆๆๆๆๆ',32,'2020-09-04','2020-09-04');
/*!40000 ALTER TABLE `Comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `id` tinyint(4) DEFAULT NULL,
  `email` varchar(24) DEFAULT NULL,
  `password` varchar(60) DEFAULT NULL,
  `name` varchar(8) DEFAULT NULL,
  `lastname` varchar(13) DEFAULT NULL,
  `status` varchar(6) DEFAULT NULL,
  `type` varchar(5) DEFAULT NULL,
  `createdAt` varchar(10) DEFAULT NULL,
  `updatedAt` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (32,'test','$2a$08$ngQm8xj5nD4NMR/PdwXkoO8sgzOsmqQto.U6k4AhbGUdrt.YOoQ3u','test','test','active','admin','2020-07-30','2020-09-04'),(46,'t','$2a$08$ISs/UT8rM8nptVgkU/5xS.JDEenJpb.g2flfMshgLJwzA9tXRJ8Km','t','t','active','admin','2020-08-06','2020-09-04'),(47,'Aom@gmail.com','$2a$08$x.oPH4RWO7erfAGnx/k8Iew94QO8wXvPN50BCIOTjMCV1bOZpppCS','Aom','Aom','active','admin','2020-08-06','2020-08-24'),(48,'a','$2a$08$LmJ8VjtLp5AIp.Svm8MZX.w9M9lbAorWSqlNflrTsfiJKmJ/4yfOu','a','a','active','admin','2020-08-06','2020-09-04'),(49,'t@t','$2a$08$Ml9WL.ju.Jne2JbGswIGy.krXtIgw0VmsAPZYK9qJTV34goUrOagi','t@t','t@t','active','user','2020-08-06','2020-09-04'),(51,'tt@t','$2a$08$DmhKnneGBH7D2jZPeePABeyYMLyr7.5PBHdE5xyNxHl88xA1B.PBi','Kornl','korn1lastname','active','user','2020-08-07','2020-08-24'),(52,'ttt@t','$2a$08$/y3BARFylCjOUAdRS2mVPOE3oakswaL6zCGOZIQiSIRTZV3.O0qMi','Kornl','korn1lastname','active','user','2020-08-07','2020-08-24'),(53,'tttt@t','$2a$08$rhLFyAAzL9ZVdwVtL108FOrW97r5adSd8eupF4DhTJ4jNrX3CPE66','Kornl','korn1lastname','active','user','2020-08-07','2020-08-24'),(54,'asd','$2a$08$WlusnHbUZ8tOmMD3QGwzY.c5kgHRgnE60x0Xqs0196au0Yrojztyu','asd','asd','active','','2020-08-07','2020-08-24'),(55,'a@a','$2a$08$tW2tphuNMRa33OGfKR5LZercfeMAyoaqoLP0RfAlI8QDiQPMlko0C','a@a','a@a','active','','2020-08-10','2020-08-24'),(57,'zxc852741963@hotmail.com','$2a$08$wKdWtyEKyuNXXHto/cctwuf0CEqwnAiE/u1l1PJoiadvJevhRSRK6','Chirayut','Deepard','active','admin','2020-09-04','2020-09-04');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sqlite_sequence`
--

DROP TABLE IF EXISTS `sqlite_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sqlite_sequence` (
  `name` varchar(8) DEFAULT NULL,
  `seq` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sqlite_sequence`
--

LOCK TABLES `sqlite_sequence` WRITE;
/*!40000 ALTER TABLE `sqlite_sequence` DISABLE KEYS */;
INSERT INTO `sqlite_sequence` VALUES ('Blogs',30),('Comments',25),('Users',57);
/*!40000 ALTER TABLE `sqlite_sequence` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-22 15:20:25
