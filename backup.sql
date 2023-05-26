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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'Updated Course Title','Updated course brief description',10,100,7),(2,'2','2',2,2,8),(3,'3','3',3,3,7),(16,'Introduction to Programming','Learn the basics of programming',10,99,7),(17,'Introduction to Programming','Learn the basics of programming',10,99,8),(18,'Introduction to Programming','Learn the basics of programming',10,99,8),(19,'Introduction to Programming','Learn the basics of programming',10,99,8),(20,'Introduction to Programming','Learn the basics of programming',10,99,8),(21,'Introduction to Programming','Learn the basics of programming',10,99,8),(22,'Introduction to Programming','Learn the basics of programming',10,99,8);
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
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interests`
--

LOCK TABLES `interests` WRITE;
/*!40000 ALTER TABLE `interests` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (49,'firasdfst','last','hegghe@email.com','$2b$10$d130V6YXgd.qfMHJcZ7qke1JT6g3k9PXYUh2RT6Ioogup1jWj7KMe',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_recommended_courses`
--

DROP TABLE IF EXISTS `student_recommended_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_recommended_courses` (
  `RecommendedCourseId` int NOT NULL AUTO_INCREMENT,
  `studentId` int NOT NULL,
  `CourseData` varchar(15000) NOT NULL,
  PRIMARY KEY (`RecommendedCourseId`),
  UNIQUE KEY `RecommendedCourseId_UNIQUE` (`RecommendedCourseId`),
  KEY `studentId_idx` (`studentId`),
  CONSTRAINT `studentIdRS` FOREIGN KEY (`studentId`) REFERENCES `student` (`idstudent`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_recommended_courses`
--

LOCK TABLES `student_recommended_courses` WRITE;
/*!40000 ALTER TABLE `student_recommended_courses` DISABLE KEYS */;
INSERT INTO `student_recommended_courses` VALUES (7,49,'{\"287\":\"Developing AI Applications on Azure\",\"335\":\"Anatomy of the Chest, Abdomen, and Pelvis\",\"2538\":\"Introduction to Applied Machine Learning\",\"3230\":\"Machine Learning for All\",\"3321\":\"Machine Learning Foundations: A Case Study Approach\"}'),(13,49,'{\"287\":\"LearnQuest\",\"335\":\"Yale University\",\"2538\":\"Alberta Machine Intelligence Institute\",\"3230\":\"University of London\",\"3321\":\"University of Washington\"}'),(16,49,'{\"287\":\"Machine Learning  web service  workspace  Training  Computer Programming  Microsoft Azure  Python Programming  Computer Vision  Human Learning  application programming interfaces data-science machine-learning\",\"335\":\"medicine  urethra  auscultation  dissection  anatomical terminology  radiology  Surgery  anatomy  abdomen  physical examination life-sciences basic-science\",\"2538\":\"Algorithms  Machine Learning Algorithms  Applied Machine Learning  Test Set  Machine Learning  ordered pair  Training  Human Learning  Deep Learning  business requirements data-science machine-learning\",\"3230\":\"robotics  Machine Learning  Artificial Neural Networks  Training  Algorithms  Tensorflow  statistical classification  modeling  Human Learning  Deep Learning computer-science software-development\",\"3321\":\"Human Learning  Regression  Machine Learning  Graphlab  statistical classification  linearity  Algorithms  Computer Programming  Python Programming  analysis data-science machine-learning\"}'),(18,49,'{\"287\":\"Beginner\",\"335\":\"Beginner\",\"2538\":\"Intermediate\",\"3230\":\"Conversant\",\"3321\":\"Conversant\"}'),(20,49,'{\"287\":\"https://www.coursera.org/learn/developing-ai-applications-azure\",\"335\":\"https://www.coursera.org/learn/trunk-anatomy\",\"2538\":\"https://www.coursera.org/learn/machine-learning-applied\",\"3230\":\"https://www.coursera.org/learn/uol-machine-learning-for-all\",\"3321\":\"https://www.coursera.org/learn/ml-foundations\"}'),(23,49,'{\"287\":\"4.3\",\"335\":\"4.8\",\"2538\":\"4.7\",\"3230\":\"4.7\",\"3321\":\"4.5\"}'),(24,49,'{\"287\":\"Developing AI Applications on Azure LearnQuest Machine Learning  web service  workspace  Training  Computer Programming  Microsoft Azure  Python Programming  Computer Vision  Human Learning  application programming interfaces data-science machine-learning cours introduc concept artifici intellig machin learn . \'ll discuss machin learn type task , machin learn algorithm . \'ll explor python popular program languag machin learn solut , includ use scientif ecosystem packag help implement machin learn . next , cours introduc machin learn tool avail microsoft azur . \'ll review standard approach data analyt \'ll receiv specif guidanc microsoft \'s team data scienc approach . go cours , \'ll introduc microsoft \'s pre-train manag machin learn offer rest api \'s suit cognit servic . \'ll implement solut use comput vision api facial recognit api , \'ll sentiment analysi call natur languag servic . use azur machin learn servic \'ll creat use azur machin learn worksace.then \'ll train model , \'ll deploy test model cloud . throughout cours perform hands-on exercis practic new ai skill . end cours , abl creat , implement deploy machin learn model .\",\"335\":\"Anatomy of the Chest, Abdomen, and Pelvis Yale University medicine  urethra  auscultation  dissection  anatomical terminology  radiology  Surgery  anatomy  abdomen  physical examination life-sciences basic-science warn : video contain imag human dissect . may disturb . human structur import us millennia . artist , teacher , health care provid , scientist children tri understand human form stick figur draw electron microscopi . learn form peopl great interest us ∩┐╜ physician , nurs , physician assist , emerg medic servic personnel mani , mani other . learn anatomi classic involv dissect deceas whether directli laboratori text , draw , photograph video . mani wonder resourc studi anatomi . develop understand human form requir signific work wide rang resourc . cours , attempt present succinct video human anatomi . find imag disturb imag carri need respect individu decid donat remain benefit teach learn . dissect depict follow video individu gave remain use advanc medic educ research death yale school medicin . sequenc video divid classic anatom section . video set learn object brief quiz end . follow section anoth quiz cover entir section order test knowledg . hope video help better understand human form , make time may laboratori worthwhil opportun help develop appreci wonder intricaci peopl . anatomi chest , abdomen , pelvi produc part due gener fund david f. swensen fund innov teach . work support part kaplow famili fund , yale school medicine._x000c_ cours curriculum : anatomi thorax , heart , abdomen pelvi recommend text\\\\t gray∩┐╜ anatomi student , richard l drake , elsevi . onlin print edit addit resourc atla human anatomi , frank h netter , elsevi . onlin print edit . would like thank contribut creation cours : charl c duncan , md , produc & director , professor neurosurgeri , pediatr surgeri ( anatomi ) , yale school medicin william b stewart , phd , associ produc , narrat , anatomist , chief section human anatomi , depart surgeri , yale school medicin shanta e kapadia , mbb , anatomist , lectur anatomi , section human anatomi , depart surgeri , yale school medicin linda honan , phd , professor , yale school nurs harri r aslanian , md , associ professor , depart medicin ( gastroenterolog ) yale school medicin jonathan puchalski , md , associ professor intern medicin ( pulmonari ) , yale school medicin michael k. o∩┐╜brien , md , phd , assist clinic professor surgeri , yale school medicin mahan mathur , md , assist professor radiolog bio-med imag , yale school medicin lei wang , ml & kelli perri , technic , yale medic librari anna nasonova , artist , yale school architectur rachel hill , artist technic , yale colleg philip lapr , technic , section anatomi , depart surgeri , yale school medicin\",\"2538\":\"Introduction to Applied Machine Learning Alberta Machine Intelligence Institute Algorithms  Machine Learning Algorithms  Applied Machine Learning  Test Set  Machine Learning  ordered pair  Training  Human Learning  Deep Learning  business requirements data-science machine-learning cours profession heard buzz around machin learn want appli machin learn data analysi autom . whether financ , medicin , engin , busi domain , cours introduc problem definit data prepar machin learn project . end cours , abl clearli defin machin learn problem use two approach . learn survey avail data resourc identifi potenti ml applic . learn take busi need turn machin learn applic . prepar data effect machin learn applic . first cours appli machin learn special brought coursera alberta machin intellig institut .\",\"3230\":\"Machine Learning for All University of London robotics  Machine Learning  Artificial Neural Networks  Training  Algorithms  Tensorflow  statistical classification  modeling  Human Learning  Deep Learning computer-science software-development machin learn , often call artifici intellig ai , one excit area technolog moment . see daili news stori herald new breakthrough facial recognit technolog , self drive car comput convers like real person . machin learn technolog set revolutionis almost area human life work , affect live , like want find . machin learn reput one complex area comput scienc , requir advanc mathemat engin skill understand . true work machin learn engin involv lot mathemat program , believ anyon understand basic concept machin learn , given import technolog , everyon . big ai breakthrough sound like scienc fiction , come simpl idea : use data train statist algorithm . cours learn understand basic idea machin learn , even n\'t background math program . , get hand use user friendli tool develop goldsmith , univers london actual machin learn project : train comput recognis imag . cours lot differ peopl . could good first step technic career machin learn , alway better start high level concept technic detail , also great role non-techn . might manag non-techn role compani consid use machin learn . realli need understand technolog , cours great place get understand . might follow news report ai interest find hottest new technolog moment . whoever , look forward guid first machin learn project . nb cours design introduc machin learn without need program . mean n\'t cover program base machin learn tool like python tensorflow .\",\"3321\":\"Machine Learning Foundations: A Case Study Approach University of Washington Human Learning  Regression  Machine Learning  Graphlab  statistical classification  linearity  Algorithms  Computer Programming  Python Programming  analysis data-science machine-learning data wonder tell ? need deeper understand core way machin learn improv busi ? want abl convers specialist anyth regress classif deep learn recommend system ? cours , get hands-on experi machin learn seri practic case-studi . end first cours studi predict hous price base house-level featur , analyz sentiment user review , retriev document interest , recommend product , search imag . hands-on practic use case , abl appli machin learn method wide rang domain . first cours treat machin learn method black box . use abstract , focu understand task interest , match task machin learn tool , assess qualiti output . subsequ cours , delv compon black box examin model algorithm . togeth , piec form machin learn pipelin , use develop intellig applic . learn outcom : end cours , abl : -identifi potenti applic machin learn practic . -describ core differ analys enabl regress , classif , cluster . -select appropri machin learn task potenti applic . -appli regress , classif , cluster , retriev , recommend system , deep learn . -repres data featur serv input machin learn model . -assess model qualiti term relev error metric task . -util dataset fit model analyz new data . -build end-to-end applic use machin learn core . -implement techniqu python .\"}'),(25,49,'{\"287\":\"This course introduces the concepts of Artificial Intelligence and Machine learning. We\'ll discuss machine learning types and tasks, and machine learning algorithms. You\'ll  explore Python as a popular programming language for machine learning solutions, including using some scientific ecosystem packages which will help you implement machine learning.   Next, this course introduces the machine learning tools available in Microsoft Azure. We\'ll review standardized approaches to data analytics and you\'ll receive specific guidance on Microsoft\'s Team Data Science Approach. As you go through the course, we\'ll introduce you to Microsoft\'s pre-trained and managed machine learning offered as REST API\'s in their suite of cognitive services. We\'ll implement solutions using the computer vision API and the facial recognition API, and we\'ll do sentiment analysis by calling the natural language service.     Using the Azure Machine Learning Service you\'ll create and use an Azure Machine Learning Worksace.Then you\'ll train your own model, and you\'ll deploy and test your model in the cloud. Throughout the course you will perform hands-on exercises to practice your new AI skills. By the end of this course, you will be able to create, implement and deploy machine learning models.\",\"335\":\"WARNING: THESE VIDEOS CONTAIN IMAGES OF HUMAN DISSECTION. MAY BE DISTURBING TO SOME.  Human structure is important to all of us as it has been for millennia.  Artists, teachers, health care providers, scientists and most children try to understand the human form from stick figure drawings to electron microscopy. Learning the form of people is of great interest to us ∩┐╜ physicians, nurses, physician assistants, emergency medical services personnel and many, many others.  Learning anatomy classically involved dissection of the deceased whether directly in the laboratory or from texts, drawings, photographs or videos.  There are many wonderful resources for the study of anatomy.  Developing an understanding of the human form requires significant work and a wide range of resources.  In this course, we have attempted to present succinct videos of human anatomy.  Some will find these images to be disturbing and these images carry a need to respect the individual who decided to donate their remains to benefit our teaching and learning.  All of the dissections depicted in the following videos are from individuals who gave their remains to be used in the advancement of medical education and research after death to the Yale School of Medicine.  The sequence of videos is divided into classic anatomic sections.  Each video has a set of learning objectives and a brief quiz at the end.  Following each section there is another quiz covering the entire section in order for you to test your knowledge.    We hope these videos will help you better understand the human form, make time that you may have in the laboratory more worthwhile if you have that opportunity and help you develop an appreciation of the wonderful intricacies of people.  ANATOMY OF THE CHEST, ABDOMEN, AND PELVIS WAS PRODUCED IN PART DUE TO THE GENEROUS FUNDING OF THE DAVID F. SWENSEN FUND FOR INNOVATION IN TEACHING.  This work was supported in part by the Kaplow Family Fund, Yale School of Medicine._x000c_ COURSE CURRICULUM:  ANATOMY OF THE THORAX, HEART, ABDOMEN AND PELVIS  RECOMMENDED TEXT\\\\t GRAY∩┐╜S ANATOMY FOR STUDENTS, RICHARD L DRAKE, ELSEVIER.  ONLINE AND PRINT EDITIONS  ADDITIONAL RESOURCE ATLAS OF HUMAN ANATOMY, FRANK H NETTER, ELSEVIER.  ONLINE AND PRINT EDITIONS.  We would like to thank all of those who have contributed to the creation of this course: Charles C Duncan, MD, Producer & Director, Professor of Neurosurgery, Pediatrics and Surgery (Anatomy), Yale School of Medicine  William B Stewart, PhD, Associate Producer, Narration, Anatomist, Chief Section of Human Anatomy, Department of Surgery, Yale School of Medicine  Shanta E Kapadia, MBBS, Anatomist, Lecturer in Anatomy, Section of Human Anatomy, Department of Surgery, Yale School of Medicine  Linda Honan, PhD, Professor, Yale School of Nursing  Harry R Aslanian, MD, Associate Professor, Department of Medicine (Gastroenterology) Yale School of Medicine   Jonathan Puchalski, MD, Associate Professor of Internal Medicine (Pulmonary), Yale School of Medicine  Michael K. O∩┐╜Brien, MD, PhD, Assistant Clinical Professor of Surgery, Yale School of Medicine  Mahan Mathur, MD, Assistant Professor of Radiology and Bio-Medical Imaging, Yale School of Medicine  Lei Wang, MLS & Kelly Perry, Technical, Yale Medical Library  Anna Nasonova, Artist, Yale School of Architecture  Rachel Hill, Artist and Technical, Yale College  Philip Lapre, Technical, Section of Anatomy, Department of Surgery, Yale School of Medicine\",\"2538\":\"This course is for professionals who have heard the buzz around machine learning and want to apply machine learning to data analysis and automation. Whether finance, medicine, engineering, business or other domains, this course will introduce you to problem definition and data preparation in a machine learning project.  By the end of the course, you will be able to clearly define a machine learning problem using two approaches. You will learn to survey available data resources and identify potential ML applications. You will learn to take a business need and turn it into a machine learning application. You will prepare data for effective machine learning applications.  This is the first course of the Applied Machine Learning Specialization brought to you by Coursera and the Alberta Machine Intelligence Institute.\",\"3230\":\"Machine Learning, often called Artificial Intelligence or AI, is one of the most exciting areas of technology at the moment. We see daily news stories that herald new breakthroughs in facial recognition technology, self driving cars or computers that can have a conversation just like a real person. Machine Learning technology is set to revolutionise almost any area of human life and work, and so will affect all our lives, and so you are likely to want to find out more about it. Machine Learning has a reputation for being one of the most complex areas of computer science, requiring Advanced mathematics and engineering skills to understand it. While it is true that working as a Machine Learning engineer does involve a lot of mathematics and programming, we believe that anyone can understand the basic concepts of Machine Learning, and given the importance of this technology, everyone should. The big AI breakthroughs sound like science fiction, but they come down to a simple idea: the use of data to train statistical algorithms. In this course you will learn to understand the basic idea of machine learning, even if you don\'t have any background in math or programming. Not only that, you will get hands on and use user friendly tools developed at Goldsmiths, University of London to actually do a machine learning project: training a computer to recognise images. This course is for a lot of different people. It could be a good first step into a technical career in Machine Learning, after all it is always better to start with the high level concepts before the technical details, but it is also great if your role is non-technical. You might be a manager or other non-technical role in a company that is considering using Machine Learning. You really need to understand this technology, and this course is a great place to get that understanding. Or you might just be following the news reports about AI and interested in finding out more about the hottest new technology of the moment. Whoever you are, we are looking forward to guiding you through you first machine learning project.  NB this course is designed to introduce you to Machine Learning without needing any programming. That means that we don\'t cover the programming based machine learning tools like python and TensorFlow.\",\"3321\":\"Do you have data and wonder what it can tell you?  Do you need a deeper understanding of the core ways in which machine learning can improve your business?  Do you want to be able to converse with specialists about anything from regression and classification to deep learning and recommender systems?  In this course, you will get hands-on experience with machine learning from a series of practical case-studies.  At the end of the first course you will have studied how to predict house prices based on house-level features, analyze sentiment from user reviews, retrieve documents of interest, recommend products, and search for images.  Through hands-on practice with these use cases, you will be able to apply machine learning methods in a wide range of domains.  This first course treats the machine learning method as a black box.  Using this abstraction, you will focus on understanding tasks of interest, matching these tasks to machine learning tools, and assessing the quality of the output. In subsequent courses, you will delve into the components of this black box by examining models and algorithms.  Together, these pieces form the machine learning pipeline, which you will use in developing intelligent applications.  Learning Outcomes:  By the end of this course, you will be able to:    -Identify potential applications of machine learning in practice.      -Describe the core differences in analyses enabled by regression, classification, and clustering.    -Select the appropriate machine learning task for a potential application.      -Apply regression, classification, clustering, retrieval, recommender systems, and deep learning.    -Represent your data as features to serve as input to machine learning models.     -Assess the model quality in terms of relevant error metrics for each task.    -Utilize a dataset to fit a model to analyze new data.    -Build an end-to-end application that uses machine learning at its core.      -Implement these techniques in Python.\"}');
/*!40000 ALTER TABLE `student_recommended_courses` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-27  0:51:55
