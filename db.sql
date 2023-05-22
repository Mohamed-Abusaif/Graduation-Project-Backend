-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: courseschemagp
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `content_type`
--

DROP TABLE IF EXISTS `content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content_type` (
  `idcontent_type` int NOT NULL AUTO_INCREMENT,
  `content_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idcontent_type`),
  UNIQUE KEY `idcontent_type_UNIQUE` (`idcontent_type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_type`
--

LOCK TABLES `content_type` WRITE;
/*!40000 ALTER TABLE `content_type` DISABLE KEYS */;
INSERT INTO `content_type` VALUES (1,'pdf'),(2,'image'),(3,'arlink'),(4,'video');
/*!40000 ALTER TABLE `content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `idcourse` int NOT NULL AUTO_INCREMENT,
  `course_title` varchar(200) NOT NULL,
  `course_brief` varchar(4000) NOT NULL,
  `num_of_chapters` int DEFAULT NULL,
  `course_fee` int NOT NULL,
  `instructor_id` int NOT NULL,
  PRIMARY KEY (`idcourse`),
  UNIQUE KEY `idcourse_UNIQUE` (`idcourse`),
  KEY `instructor_id_idx` (`instructor_id`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`idinstructor`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'Updated Course Title','Updated course brief description',10,100,7),(2,'2','2',2,2,8),(3,'3','3',3,3,7),(16,'Introduction to Programming','Learn the basics of programming',10,99,7);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_chapter`
--

DROP TABLE IF EXISTS `course_chapter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_chapter` (
  `idcourse_chapter` int NOT NULL AUTO_INCREMENT,
  `chapter_title` varchar(100) NOT NULL,
  `num_of_reading` int DEFAULT NULL,
  `num_of_video` int DEFAULT NULL,
  `num_of_assignment` int DEFAULT NULL,
  `num_of_ar_content` int DEFAULT NULL,
  `course_idcourse` int NOT NULL,
  PRIMARY KEY (`idcourse_chapter`),
  UNIQUE KEY `idcourse_chapter_UNIQUE` (`idcourse_chapter`),
  KEY `fk_course_chapter_course1_idx` (`course_idcourse`),
  CONSTRAINT `fk_course_chapter_course1` FOREIGN KEY (`course_idcourse`) REFERENCES `course` (`idcourse`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_chapter`
--

LOCK TABLES `course_chapter` WRITE;
/*!40000 ALTER TABLE `course_chapter` DISABLE KEYS */;
INSERT INTO `course_chapter` VALUES (1,'New Section',NULL,NULL,NULL,NULL,16);
/*!40000 ALTER TABLE `course_chapter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_chpater_content`
--

DROP TABLE IF EXISTS `course_chpater_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_chpater_content` (
  `idcourse_chpater_content` int NOT NULL AUTO_INCREMENT,
  `is_mandatory` varchar(1) NOT NULL,
  `time_required_in_sec` int NOT NULL,
  `is_open_for_free` varchar(1) NOT NULL,
  `course_chapter_idcourse_chapter` int NOT NULL,
  `content_type_idcontent_type` int NOT NULL,
  `pathToContent` varchar(45) DEFAULT NULL,
  `contentItself` blob,
  PRIMARY KEY (`idcourse_chpater_content`),
  UNIQUE KEY `idcourse_chpater_content_UNIQUE` (`idcourse_chpater_content`),
  KEY `fk_course_chpater_content_course_chapter1_idx` (`course_chapter_idcourse_chapter`),
  KEY `fk_course_chpater_content_content_type1_idx` (`content_type_idcontent_type`),
  CONSTRAINT `fk_course_chpater_content_content_type1` FOREIGN KEY (`content_type_idcontent_type`) REFERENCES `content_type` (`idcontent_type`),
  CONSTRAINT `fk_course_chpater_content_course_chapter1` FOREIGN KEY (`course_chapter_idcourse_chapter`) REFERENCES `course_chapter` (`idcourse_chapter`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_chpater_content`
--

LOCK TABLES `course_chpater_content` WRITE;
/*!40000 ALTER TABLE `course_chpater_content` DISABLE KEYS */;
INSERT INTO `course_chpater_content` VALUES (1,'1',20,'1',1,1,'uploads\\security roadmap.txt',''),(2,'1',20,'1',1,1,'uploads\\security roadmap.txt',_binary 'recommend best cybersecurity courses and roadmap\r\nChatGPT\r\nSure! Cybersecurity is a rapidly evolving field, and there are numerous courses and certifications available to help you develop your skills. Here\'s a recommended roadmap for learning cybersecurity:\r\n\r\nStart with the Basics:\r\n\r\nCompTIA Security+ (Certification): This entry-level certification covers fundamental concepts of cybersecurity, including network security, cryptography, and risk management.\r\nIntroduction to Cybersecurity (Course): Many online platforms offer introductory courses that cover the basics of cybersecurity, providing a solid foundation for further learning.\r\nExpand Your Knowledge:\r\n\r\nCertified Ethical Hacker (CEH) (Certification): This certification focuses on understanding the mindset of a hacker and helps you identify vulnerabilities in systems, networks, and applications.\r\nCISSP (Certified Information Systems Security Professional) (Certification): CISSP is a globally recognized certification that covers various domains of information security, including access control, cryptography, and security operations.\r\nNetwork+ (Certification): This certification provides a comprehensive understanding of networking concepts, which is essential for securing networks and infrastructure.\r\nSpecialize in Specific Areas:\r\n\r\nCertified Information Security Manager (CISM) (Certification): CISM focuses on information security management and governance, covering topics like risk management, incident response, and security strategy.\r\nCertified Information Systems Auditor (CISA) (Certification): CISA focuses on auditing, control, and assurance of information systems, providing valuable skills for assessing an organization\'s security posture.\r\nOffensive Security Certified Professional (OSCP) (Certification): OSCP is a hands-on certification that focuses on penetration testing and ethical hacking, providing practical experience in identifying and exploiting vulnerabilities.\r\nExplore Advanced Topics:\r\n\r\nAdvanced Persistent Threat (APT) Analysis (Course): This course delves into advanced techniques used by threat actors, helping you understand and analyze complex cyber attacks.\r\nDigital Forensics (Course): Learn how to investigate and analyze digital evidence to identify the cause and extent of a security breach or cybercrime.\r\nCloud Security (Course): With the increasing adoption of cloud technologies, understanding how to secure cloud environments is crucial. Look for courses that focus on the major cloud platforms like AWS, Azure, or GCP.\r\nStay Updated and Engage in Continuous Learning:\r\n\r\nKeep up with the latest cybersecurity news, trends, and best practices through industry blogs, podcasts, and newsletters.\r\nJoin cybersecurity communities and forums to network with professionals, share knowledge, and participate in discussions.\r\nParticipate in Capture the Flag (CTF) competitions and hands-on cybersecurity challenges to sharpen your practical skills.\r\nRemember that hands-on experience and practical application of knowledge are essential in cybersecurity. Consider setting up a lab environment to practice different techniques and tools.\r\n\r\nLastly, always evaluate and choose courses and certifications based on your specific interests, career goals, and the demands of the industry. The roadmap provided is a general guideline, and you can adapt it to your needs.'),(3,'1',20,'1',1,1,'uploads\\security roadmap.txt',_binary 'recommend best cybersecurity courses and roadmap\r\nChatGPT\r\nSure! Cybersecurity is a rapidly evolving field, and there are numerous courses and certifications available to help you develop your skills. Here\'s a recommended roadmap for learning cybersecurity:\r\n\r\nStart with the Basics:\r\n\r\nCompTIA Security+ (Certification): This entry-level certification covers fundamental concepts of cybersecurity, including network security, cryptography, and risk management.\r\nIntroduction to Cybersecurity (Course): Many online platforms offer introductory courses that cover the basics of cybersecurity, providing a solid foundation for further learning.\r\nExpand Your Knowledge:\r\n\r\nCertified Ethical Hacker (CEH) (Certification): This certification focuses on understanding the mindset of a hacker and helps you identify vulnerabilities in systems, networks, and applications.\r\nCISSP (Certified Information Systems Security Professional) (Certification): CISSP is a globally recognized certification that covers various domains of information security, including access control, cryptography, and security operations.\r\nNetwork+ (Certification): This certification provides a comprehensive understanding of networking concepts, which is essential for securing networks and infrastructure.\r\nSpecialize in Specific Areas:\r\n\r\nCertified Information Security Manager (CISM) (Certification): CISM focuses on information security management and governance, covering topics like risk management, incident response, and security strategy.\r\nCertified Information Systems Auditor (CISA) (Certification): CISA focuses on auditing, control, and assurance of information systems, providing valuable skills for assessing an organization\'s security posture.\r\nOffensive Security Certified Professional (OSCP) (Certification): OSCP is a hands-on certification that focuses on penetration testing and ethical hacking, providing practical experience in identifying and exploiting vulnerabilities.\r\nExplore Advanced Topics:\r\n\r\nAdvanced Persistent Threat (APT) Analysis (Course): This course delves into advanced techniques used by threat actors, helping you understand and analyze complex cyber attacks.\r\nDigital Forensics (Course): Learn how to investigate and analyze digital evidence to identify the cause and extent of a security breach or cybercrime.\r\nCloud Security (Course): With the increasing adoption of cloud technologies, understanding how to secure cloud environments is crucial. Look for courses that focus on the major cloud platforms like AWS, Azure, or GCP.\r\nStay Updated and Engage in Continuous Learning:\r\n\r\nKeep up with the latest cybersecurity news, trends, and best practices through industry blogs, podcasts, and newsletters.\r\nJoin cybersecurity communities and forums to network with professionals, share knowledge, and participate in discussions.\r\nParticipate in Capture the Flag (CTF) competitions and hands-on cybersecurity challenges to sharpen your practical skills.\r\nRemember that hands-on experience and practical application of knowledge are essential in cybersecurity. Consider setting up a lab environment to practice different techniques and tools.\r\n\r\nLastly, always evaluate and choose courses and certifications based on your specific interests, career goals, and the demands of the industry. The roadmap provided is a general guideline, and you can adapt it to your needs.'),(4,'1',20,'1',1,1,'uploads\\Express.js Template Code.txt',_binary 'const express = require(\"express\");\r\nconst bodyParser = require(\"body-parser\");\r\n\r\nconst app = express();\r\napp.use(bodyParser.urlencoded({extended: false}));\r\n\r\n\r\n\r\napp.use(\"/\", (req, res, nxt) => {\r\n  res.send(\"<h1>This Is The Home Page!</h1>\");\r\n});\r\n\r\n\r\n\r\n\r\nconst port = 3000;\r\napp.listen(port, () => {\r\n  console.log(`Server Is Running On Port ${port}!`);\r\n});\r\n'),(5,'1',20,'1',1,1,'Draft.pdf',NULL),(6,'1',20,'1',1,1,'Draft.pdf',NULL),(7,'1',20,'1',1,1,'Draft.pdf',NULL),(8,'1',20,'1',1,1,'Final.pdf',NULL);
/*!40000 ALTER TABLE `course_chpater_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollment`
--

DROP TABLE IF EXISTS `enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollment` (
  `idenrollment` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `course_id` int NOT NULL,
  `enrollment_date` date NOT NULL,
  `is_paid_subscription` varchar(1) NOT NULL,
  PRIMARY KEY (`idenrollment`),
  UNIQUE KEY `idenrollment_UNIQUE` (`idenrollment`),
  KEY `student_id_idx` (`student_id`),
  KEY `course_id_idx` (`course_id`),
  CONSTRAINT `course_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`idcourse`),
  CONSTRAINT `student_id` FOREIGN KEY (`student_id`) REFERENCES `student` (`idstudent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollment`
--

LOCK TABLES `enrollment` WRITE;
/*!40000 ALTER TABLE `enrollment` DISABLE KEYS */;
/*!40000 ALTER TABLE `enrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `idfeedback` int NOT NULL AUTO_INCREMENT,
  `enrollment_id` int NOT NULL,
  `rating_score` int NOT NULL,
  `feedback_text` varchar(4000) NOT NULL,
  `submission_date` date NOT NULL,
  PRIMARY KEY (`idfeedback`),
  UNIQUE KEY `idfeedback_UNIQUE` (`idfeedback`),
  KEY `enrollment_id_idx` (`enrollment_id`),
  CONSTRAINT `enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `enrollment` (`idenrollment`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor`
--

DROP TABLE IF EXISTS `instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructor` (
  `idinstructor` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  `registration_date` date DEFAULT NULL,
  `qualification` varchar(200) DEFAULT NULL,
  `introduction_brief` varchar(1000) DEFAULT NULL,
  `image` blob,
  `num_of_published_courses` int DEFAULT NULL,
  `num_of_enrolled_students` int DEFAULT NULL,
  `average_review_rating` int DEFAULT NULL,
  `num_of_reviews` int DEFAULT NULL,
  PRIMARY KEY (`idinstructor`),
  UNIQUE KEY `idinstructor_UNIQUE` (`idinstructor`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor`
--

LOCK TABLES `instructor` WRITE;
/*!40000 ALTER TABLE `instructor` DISABLE KEYS */;
INSERT INTO `instructor` VALUES (7,'','','ahmed@test.com','1234',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,'moha','abus','mohaabus@test.com','1234',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,'John','Doe','instructor@email.com','$2b$10$nrWSaOSifsjoVKNXI.MGhOTl7IKOCCT52tSsc5cZqWmXhYDNJd5z2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11,'first','last','newinstructor@email.com','$2b$10$aID2voQz5B6Kwzqg6M11heZXexHaLPCUb1hIKd3h6r4Q88zxjjBeO',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(13,'first','last','newwwww@email.com','$2b$10$qUHmiKPlSqRuw.RdKYw3OucfRh/Brop5e8e2yikQ.yhK.iBkftQuC',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(14,'first','last','newwwwwwww@email.com','$2b$10$GJxSBSD/Ajm8YNAsn116LeHrOndrKdpzmhIN.UUe6kRsaqSMR84aq',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(15,'Bella','david','bella66@gmail.com','$2b$10$D2CuawYliUopA4KOcyvTU.jK860jYkRBluC7u.IzDTobW9ZV2HGGS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(17,'first','last','hehe@email.com','$2b$10$mWuKsb9uX/8/cyHvd0USke8g.mhCsKV3tcOiZOXa2kIyY8lM0OZ/W',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(18,'merna','fared','merna127@gmail.com','$2b$10$7MTl1X/6yiDSCCCwhqvtZeeJOTHsQ1f/VtRwGMllinFpdtJFsCQgG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(20,'merna','fared','merna17@gmail.com','$2b$10$sV/Be4dMDRQyVRyaA4x//OjBrUp6ImCxZuuZt7Y5UEPaIpOJQiEPK',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interests`
--

DROP TABLE IF EXISTS `interests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interests` (
  `idintrests` int NOT NULL AUTO_INCREMENT,
  `intrests` varchar(1000) DEFAULT NULL,
  `student_id` int NOT NULL,
  PRIMARY KEY (`idintrests`),
  UNIQUE KEY `idintrests_UNIQUE` (`idintrests`),
  KEY `student_id_idx` (`student_id`),
  CONSTRAINT `studentID` FOREIGN KEY (`student_id`) REFERENCES `student` (`idstudent`)
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interests`
--

LOCK TABLES `interests` WRITE;
/*!40000 ALTER TABLE `interests` DISABLE KEYS */;
INSERT INTO `interests` VALUES (1,'moIn',1),(2,'moIn',1),(11,'c  ',1),(12,'anatomy',1),(13,'robotics',1),(14,'c  ',1),(15,'anatomy',1),(16,'robotics',1),(17,'c  ',1),(18,'anatomy',1),(19,'robotics',1),(20,'c  ',1),(21,'anatomy',1),(22,'robotics',1),(23,'c  ',1),(24,'anatomy',1),(25,'robotics',1),(26,'c  ',2),(27,'anatomy',2),(28,'robotics',2),(29,'c  ',2),(30,'anatomy',2),(31,'robotics',2),(32,'c  ',2),(33,'robotics',2),(34,'anatomy',2),(35,'c  ',2),(36,'anatomy',2),(37,'robotics',2),(38,'c  ',2),(39,'anatomy',2),(40,'robotics',2),(41,'c  ',2),(42,'anatomy',2),(43,'robotics',2),(44,'c  ',2),(45,'anatomy',2),(46,'robotics',2),(47,'c  ',2),(48,'robotics',2),(49,'anatomy',2),(50,'c  ',2),(51,'anatomy',2),(52,'robotics',2),(53,'c  ',2),(54,'anatomy',2),(55,'robotics',2),(56,'robotics',2),(57,'c  ',2),(58,'anatomy',2),(59,'anatomy',2),(60,'c  ',2),(61,'robotics',2),(62,'c  ',2),(63,'anatomy',2),(64,'robotics',2),(65,'c  ',2),(66,'anatomy',2),(67,'robotics',2),(68,'C  ',1),(69,'C  ',1),(70,'C  ',1),(71,'C++',1),(72,'anatomy',1),(73,'machine learning',1),(74,'C++',1),(75,'anatomy',1),(76,'machine learning',1),(77,'anatomy',1),(78,'machine learning',1),(79,'C++',1),(80,'C++',1),(81,'anatomy',1),(82,'machine learning',1),(83,'C++',1),(84,'anatomy',1),(85,'machine learning',1),(86,'machine learning',1),(87,'anatomy',1),(88,'C++',1),(89,'C++',1),(90,'anatomy',1),(91,'machine learning',1),(92,'C++',1),(93,'anatomy',1),(94,'machine learning',1),(95,'anatomy',1),(96,'machine learning',1),(97,'C++',1),(98,'C++',1),(99,'anatomy',1),(100,'machine learning',1),(101,'C++',1),(102,'anatomy',1),(103,'machine learning',1),(104,'C++',1),(105,'anatomy',1),(106,'machine learning',1),(107,'C++',1),(108,'anatomy',1),(109,'machine learning',1),(110,'C++',1),(111,'anatomy',1),(112,'machine learning',1),(113,'C++',1),(114,'anatomy',1),(115,'machine learning',1),(116,'C++',1),(117,'anatomy',1),(118,'machine learning',1),(119,'machine learning',1),(120,'C++',1),(121,'anatomy',1),(122,'machine learning',1),(123,'anatomy',1),(124,'C++',1),(125,'C++',1),(126,'anatomy',1),(127,'machine learning',1),(128,'C++',1),(129,'anatomy',1),(130,'machine learning',1),(131,'C++',1),(132,'anatomy',1),(133,'machine learning',1),(134,'C++',1),(135,'anatomy',1),(136,'machine learning',1),(137,'C++',1),(138,'anatomy',1),(139,'machine learning',1),(140,'C++',1),(141,'anatomy',1),(142,'machine learning',1),(143,'C++',1),(144,'anatomy',1),(145,'machine learning',1),(146,'machine learning',1),(147,'C++',1),(148,'anatomy',1),(149,'machine learning',1),(150,'anatomy',1),(151,'C++',1),(152,'machine learning',1),(153,'anatomy',1),(154,'C++',1),(155,'C++',1),(156,'anatomy',1),(157,'machine learning',1),(158,'anatomy',1),(159,'C++',1),(160,'machine learning',1),(161,'C++',1),(162,'machine learning',1),(163,'anatomy',1),(164,'C++',1),(165,'machine learning',1),(166,'anatomy',1),(167,'C++',1),(168,'anatomy',1),(169,'machine learning',1),(170,'anatomy',1),(171,'machine learning',1),(172,'C++',1),(173,'anatomy',1),(174,'machine learning',1),(175,'C++',1),(176,'anatomy',1),(177,'machine learning',1),(178,'C++',1),(179,'C++',1),(180,'machine learning',1),(181,'anatomy',1),(182,'C++',1),(183,'anatomy',1),(184,'machine learning',1),(185,'C++',1),(186,'anatomy',1),(187,'machine learning',1),(188,'machine learning',1),(189,'C++',1),(190,'anatomy',1),(191,'machine learning',1),(192,'anatomy',1),(193,'C++',1);
/*!40000 ALTER TABLE `interests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning_progress`
--

DROP TABLE IF EXISTS `learning_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `learning_progress` (
  `idlearning_progress` int NOT NULL AUTO_INCREMENT,
  `course_chapter_content_id` int NOT NULL,
  `begin_timestamp` timestamp NOT NULL,
  `completion_timestamp` timestamp NULL DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  `enrollment_idenrollment` int NOT NULL,
  PRIMARY KEY (`idlearning_progress`),
  UNIQUE KEY `idlearning_progress_UNIQUE` (`idlearning_progress`),
  KEY `fk_learning_progress_enrollment1_idx` (`enrollment_idenrollment`),
  CONSTRAINT `fk_learning_progress_enrollment1` FOREIGN KEY (`enrollment_idenrollment`) REFERENCES `enrollment` (`idenrollment`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning_progress`
--

LOCK TABLES `learning_progress` WRITE;
/*!40000 ALTER TABLE `learning_progress` DISABLE KEYS */;
/*!40000 ALTER TABLE `learning_progress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `idstudent` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  `registration_date` date DEFAULT NULL,
  `num_of_courses_enrolled` int DEFAULT NULL,
  `num_of_courses_completed` int DEFAULT NULL,
  `image` blob,
  PRIMARY KEY (`idstudent`),
  UNIQUE KEY `idstudent_UNIQUE` (`idstudent`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,'mohamed','abusaif','mohamed@gmail.com','1234','2023-02-26',NULL,NULL,NULL),(2,'Ahmed','Atef','Ahmed@gmail.com','1234','2023-02-26',NULL,NULL,NULL),(5,'ahmed','essam','essam@gmail.com','1234','2023-03-03',NULL,NULL,NULL),(6,'masoud','ozail','masoud@gmial.com','1234','2012-07-25',NULL,NULL,NULL),(7,'Ali','Ashraf','Ali@gmial.com','1234','2012-07-25',NULL,NULL,NULL),(9,'ahmed','eissa','ahmedeissa@gmail.com','1122','2023-04-04',NULL,NULL,NULL),(10,'ahmed','test','ahmed@test.com','123',NULL,NULL,NULL,NULL),(18,'','','hatem@test.com','1234',NULL,NULL,NULL,NULL),(19,'Mohamed','Abusaif','mohaausaif@test.com','1234',NULL,NULL,NULL,NULL),(20,'ahmed','Smsm','smsm@test.com','1234',NULL,NULL,NULL,NULL),(21,'llll','hhhh','hhh@g.com','1234',NULL,NULL,NULL,NULL),(22,'helloUser','this is last name','hello@gmail.com','$2b$10$h.BmC22Om6JQPYc3D7GyKeDmfotkH26HRFpiynO2CvwCdkl07.d.y',NULL,NULL,NULL,NULL),(23,'mohamed','fayed','fayed@gmail.com','$2b$10$cIOgaHxEXa3byrHyb.XBVOcCwfFmUGEMtjYscAsDrcHtalfOBmglG',NULL,NULL,NULL,NULL),(25,'merna','nasser','merna@gmail.com','$2b$10$Bfz/gd5BwC0PULH/pfOz7ursM5ffQPTULBhatAIrak9ldQX1xuvIm',NULL,NULL,NULL,NULL),(26,'merna','nasser','merna22@gmail.com','$2b$10$6LXA8df0tJjvQIQqmi20z.5Sn9ZJ6mbmy2HPz0OdrAK0CCcUxgcA.',NULL,NULL,NULL,NULL),(27,'merna','nasser','merna33@gmail.com','$2b$10$GeCW0IzWaZz88s/xCbCakOjhYEImPJLs2Hiewa33XG6K6Ky/.7GLe',NULL,NULL,NULL,NULL),(29,'merna','nasser','merna44@gmail.com','$2b$10$/.tiSrfqTVkL2QZlB9QJkOjBijF0fLa0OOWhDlxFpuE.MQvty2qHq',NULL,NULL,NULL,NULL),(32,'merna','nasser','merna55@gmail.com','$2b$10$6sbyVWam1WCmcvIy46G3/OEhOvqs4aY79.2UanAwcwJnWBeWWV90q',NULL,NULL,NULL,NULL),(34,'mohamd','fayed','mohamed99@gmail.com','$2b$10$Ia9iKGgbWeoKU6cnewMHJOtJZHWslhnS7bKZJc5WBYVbdjuvYUKwW',NULL,NULL,NULL,NULL),(35,'bella','beto','bella33@gmail.com','$2b$10$0T1Ywnd1h5JBNzPfFe2ppe.AorjreLimPFiLavUw1jOx1P465jGSe',NULL,NULL,NULL,NULL),(36,'bela','bebo','bela@gmail.com','$2b$10$3yGvmljPPfx0h4jsTikeU.FxtN8jsRnb1Q6M3r8gBTdPg8Oe7czI.',NULL,NULL,NULL,NULL),(37,'yasmin','salah','yasmin22@gmail.com','$2b$10$2zkZHns8od2x0hTAF2S2WeDgF4T9j0Sy8FtonxUbbHWbkbeAG2DQG',NULL,NULL,NULL,NULL),(38,'merna','nasser','merna12@gmail.com','$2b$10$HCcWa6pDNrM8jGnpLlkQRuNA.qVdeweDbTUWkwJinDBzIHbaiWNIy',NULL,NULL,NULL,NULL),(39,'merna','nasser','merna123@gmail.com','$2b$10$Scbhiy8LnzBlTHwGHjlLiO7e.5PComhpPkn4J3Mo5SxOzxQRJTgFe',NULL,NULL,NULL,NULL),(40,'merna','nasser','merna13@gmail.com','$2b$10$XtsEZm5ag05n7WkmGQsL.egX/EvFcocqJun/j9FfCLxuuneWveOe2',NULL,NULL,NULL,NULL),(41,'first','last','newwwwwwww@email.com','$2b$10$rk6jD4qBa5mvcheoclaum.yAKL2UTiKd9A0bjxAJHn/TArXJP4hOy',NULL,NULL,NULL,NULL),(42,'merna','nasser','merna7@gmail.com','$2b$10$QuRku6V5glFtKK3E2KvoO.hhkJ9cnFBnw2c8DJI4Clv1YyU6u8D9.',NULL,NULL,NULL,NULL),(43,'mm','nn','merna77@gmail.com','$2b$10$wamhfwhcUXQo01gc.8LY3O7Tuj/7GPq.zl35s96UP0cxW1YSwvuLS',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-23  0:54:35
