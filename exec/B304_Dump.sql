-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: j11b304.p.ssafy.io    Database: runnerway
-- ------------------------------------------------------
-- Server version	9.0.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `course_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `content` varchar(500) DEFAULT NULL,
  `count` bigint DEFAULT '0',
  `level` int DEFAULT NULL,
  `average_slope` int DEFAULT NULL,
  `average_downhill` int DEFAULT NULL,
  `average_time` time DEFAULT NULL,
  `course_length` double DEFAULT NULL,
  `member_id` bigint NOT NULL,
  `course_type` enum('official','user') NOT NULL,
  `regist_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `average_calorie` double NOT NULL,
  `lat` double NOT NULL,
  `lng` double NOT NULL,
  `area` varchar(45) NOT NULL,
  PRIMARY KEY (`course_id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (0,'자유 러닝','주소',NULL,0,0,0,0,NULL,0,1,'official','2024-09-11 11:23:48',0,0,0,''),(1,'복용 승마장','대전광역시 유성구 덕명동 574','한밭대 앞, 복용 승마장으로 산책해보세요!',1,1,3,9,'00:08:00',1,1,'official','2024-10-02 16:56:42',70,36.356944818293904,127.30477344439119,'8730e3782ffffff'),(2,'도안뜰 어린이 공원','대전광역시 서구 도안동 48-1','도안뜰 어린이 공원부터 유림공원까지 하천을 보며 달려보세요!',2,2,0,3,'00:40:00',5.19,1,'official','2024-10-02 16:57:40',385,36.31760437047439,127.35137960484109,'8730e379bffffff'),(3,'갑천 러닝코스','대전광역시 서구 도안동 48-1','갑천의 도안코스로 러닝해보세요!',1,1,0,3,'00:25:00',3.41,1,'official','2024-10-02 16:57:55',266,36.31760437047439,127.35137960484109,'8730e379bffffff'),(4,'충남대 종합운동장 트랙','대전광역시 유성구 대학로 99','충남대학교 종합운동장에서 트랙 러닝을 해보세요!',0,1,1,10,'00:03:00',0.43,1,'official','2024-10-02 16:58:06',30.1,36.37266464698365,127.34292909537031,'8730e378effffff'),(5,'봉명교부터 죽동까지','대전광역시 유성구 장대동 9-3','갑천 봉명교부터 죽동 근린공원까지 이어진 산책로 코스를 이용하세요!',1,1,0,4,'00:15:00',2.2,1,'official','2024-10-02 16:58:16',154,36.35708664963028,127.33948412394929,'8730e379dffffff'),(6,'현충원역 -> 유림공원','대전광역시 유성구 장대동 233-32','현충원역부터 유림공원까지 이용하세요!',0,1,0,2,'00:23:40',3.12,1,'official','2024-10-02 16:58:25',218.4,36.35838114412489,127.32225989652967,'8730e3783ffffff'),(7,'유림정','대전광역시 유성구 봉명동 15-4','유성천을 보며, 갑천근린공원까지 가보세요! 왕복도 좋아요~!',0,1,0,12,'00:12:30',1.67,1,'official','2024-10-02 16:58:33',154,36.35978046970383,127.35442982096009,'8730e378effffff'),(8,'한밭대학교 대운동장','대전광역시 유성구 동서대로 125','한밭대학교 대운동장 트랙을 4바퀴 뛰어보세요!',0,1,0,0,'00:09:31',1.27,1,'official','2024-10-02 16:58:39',88.9,36.353870273658885,127.3008971772697,'8730e3782ffffff'),(9,'온천교와 카이스트교','대전광역시 유성구 궁동 473','온천교와 카이스트를 달리면 바라보는 캠퍼스 풍경!',1,1,0,6,'00:15:26',2.29,1,'official','2024-10-02 16:58:45',160.3,36.36002295163785,127.34499723569246,'8730e378effffff'),(10,'SSAFY 출퇴근로 산책길','대전광역시 유성구 동서대로 98-39','매일매일 SSAFY 대전캠퍼스의 둘레길로 출퇴근하세요!',0,1,0,4,'00:02:37',0.32,1,'official','2024-10-02 16:58:53',22.4,36.35507970464854,127.29849974270184,'8730e3782ffffff'),(11,'화산천 한바퀴','대전광역시 유성구 덕명동 616-1','화산천부터 수통골 입구까지 한바퀴 돌아보세요!',0,1,1,2,'00:15:00',2.1,1,'official','2024-10-02 16:58:59',147,36.34885444996022,127.29651499616904,'8730e3782ffffff'),(12,'은구비 공원 한바퀴','대전광역시 유성구 노은동로 126','대전 선사박물관이 있는 은구비 공원에서 산책하세요!',2,1,0,31,'00:07:42',1,1,'official','2024-10-04 12:43:33',70,36.37046246397621,127.32371080178342,'8730e3781ffffff'),(13,'충남대학교 앞 갑천 한바퀴','대전광역시 유성구 궁동 467',' 유성문화원부터 충대 앞까지 천을 보며 돌 수 있어요!',0,1,0,2,'00:11:40',1.57,1,'official','2024-10-04 12:44:00',109.9,36.359076224274254,127.34161419427183,'8730e378effffff'),(14,'만년교 → 도안대교','대전광역시 유성구 봉명동 496-25','만년교에서 도안대교까지, 시티뷰와 마운틴뷰를 느끼봐요',2,1,0,2,'00:18:00',2.4,1,'official','2024-10-04 12:44:08',168,36.3513959527376,127.3489773442841,'8730e379dffffff'),(15,'수통폭포 200배 즐기기','대전광역시 유성구 덕명동 142-12','수통골 폭포까지 가는 학교 앞 코스',0,1,7,33,'00:14:14',1.89,1,'official','2024-10-04 12:44:17',132.3,36.350565880901435,127.29717624952306,'8730e3782ffffff'),(16,'덕명 복용하기','대전광역시 유성구 덕명동 618','수통골 삼거리인 덕명동부터 복용동까지 천을 따라 뛰어보세요!',0,1,0,3,'00:14:05',1.88,1,'official','2024-10-04 12:44:28',131.6,36.34829728216399,127.29661288425515,'8730e3782ffffff'),(17,'한밭대학교 탐방','대전광역시 유성구 동서대로 125','주민과 함께하는 스마트 캠퍼스를 탐방하세요!',0,1,0,6,'00:13:34',1.8,1,'official','2024-10-04 12:44:36',16,36.35100111871264,127.29846524980601,'8730e3782ffffff'),(18,'달려라 구암역','대전광역시 유성구 덕명동 574','네오미아 아파트에서 구암역까지! 쭉 달릴 수 있어요',0,1,0,2,'00:16:30',2.2,1,'official','2024-10-04 12:44:43',154,36.358153718037144,127.30776791385347,'8730e3782ffffff'),(19,'계룡대교 복용하기','대전광역시 유성구 봉명동 998','도안동부터 복용동까지 진잠천 산책로에서 러닝하세요!',0,1,0,4,'00:20:15',2.7,1,'official','2024-10-04 12:44:52',154,36.346945586159315,127.34923172476465,'8730e379dffffff'),(20,'백화점까지 러닝하기','대전광역시 유성구 덕명동 574','아파트 단지에서 신세계 백화점까지 러닝해 보세요!',0,2,0,4,'00:56:15',7.5,1,'official','2024-10-04 12:45:00',525,36.358153718037144,127.30776791385347,'8730e3782ffffff'),(21,'덕명네거리→한밭대(오르막길)','대전광역시 유성구 구암동 692','출근 시 이용해보세요 운동됩니다!',0,2,14,8,'00:07:16',2.7,2,'user','2024-10-07 09:33:15',67.9,36.360221335875465,127.30559798389538,'8730e3782ffffff'),(22,'현충원에서 현충탑으로','대전광역시 유성구 덕명동 102-7','현충원 가보셨나요?? 진짜 멋있어요',0,3,17,3,'00:09:41',4.78,3,'user','2024-10-07 09:33:35',82,36.36064050471384,127.29931136122546,'8730e3782ffffff'),(23,'식물원 코스','대전광역시 유성구 구암동 695-1','가는 길에 경치가 너무 좋고, 식물원도 너무 쾌적해요!',0,1,0,5,'00:08:56',1.18,4,'user','2024-10-07 09:33:46',77,36.35979947833466,127.30539534563692,'8730e3782ffffff'),(24,'왕가봉 불암사 코스','대전광역시 유성구 노은동 603','산 속을 걸을 수 있어요! 꼭 걸어보세요',0,2,13,15,'00:04:34',0.61,2,'user','2024-10-07 09:33:56',40,36.365295258696825,127.31290884428537,'8730e3780ffffff'),(25,'회먹자 코스','대전광역시 유성구 구암동 705','운동 끝나고 신선한 회를 살 수 있어요! 끝나고 회쏘 고고??',0,2,11,11,'00:11:48',2.99,3,'user','2024-10-07 09:34:07',102,36.3606020725046,127.30592480050088,'8730e3782ffffff'),(26,'해장이 필요할 때 가는 코스','대전광역시 유성구 덕명동 563','술먹은 다음 날 이 코스를 뛰면 진짜 속이 다 풀립니다~~ㅎ',0,1,0,4,'00:04:37',0.62,4,'user','2024-10-07 09:34:20',41,36.3579837018378,127.30305519367587,'8730e3782ffffff'),(27,'다이소 코스','대전광역시 유성구 덕명동 150-6','퇴근 후, 다이소를 들려야한다면 이 코스 추천합니다~!',0,1,1,4,'00:06:29',0.88,2,'user','2024-10-07 09:34:39',58,36.35300792525383,127.2997325803701,'8730e3782ffffff'),(28,'산채비빔밥 코스','대전광역시 유성구 덕명동 154-15','이 코스를 따라가보십시요. 종점엔 맛있는 BㅣBㅣㅁ밥집이 기다리고 있어요!',0,1,2,3,'00:03:11',0.41,3,'user','2024-10-07 09:34:49',27,36.34853971650872,127.29611592775376,'8730e3782ffffff'),(29,'미로공원 코스','대전광역시 유성구 덕명동 574','꼬불꼬불한 미로공원이 있어요!',0,3,21,17,'00:04:36',2.78,4,'user','2024-10-07 09:34:57',38,36.357698446504955,127.30361283290858,'8730e3782ffffff'),(30,'한밭대 풋살장 코스','대전광역시 유성구 구암동 692','덕명네거리에서 한밭풋살장까지 가는 코스입니다~~',0,1,0,7,'00:04:08',0.54,2,'user','2024-10-07 09:35:09',35,36.36025614585283,127.30559834713279,'8730e3782ffffff'),(62,'SSAFY 조깅','대전광역시 유성구 덕명동 124','몸이 뻐근할 때, 캠퍼스에서 가볍게 뛰어보세요',15,1,0,0,'00:01:44',0.23,6,'user','2024-10-08 12:19:52',16.1,36.35507,127.29963,'8730e3782ffffff'),(90,'쩬 싸피 코스','대한민국 대전광역시 유성구 덕명동 135-1','한번만 뛰어보세요',1,1,0,3,'00:01:07',0.21962238596547654,15,'user','2024-10-10 11:22:20',2,36.3550763,127.2996504,'8730e3782ffffff'),(91,'싸피 100m 달리기','대한민국 대전광역시 덕명동 124번지 유성구 대전광역시 KR','1등에 도전해보세요\n코스는 정문의 가로등부터 시작해서 호텔동 입구까지입니다',5,1,0,3,'00:01:08',0.10001465181546382,6,'user','2024-10-10 13:05:10',2,36.3550322,127.2978987,'8730e3782ffffff'),(93,'하이테이블에서 하아파이브','대한민국 대전광역시 유성구 봉명동 551-17','하테에서 100m 달리기!',3,1,0,3,'00:01:19',0.11,6,'user','2024-10-10 20:05:14',2,36.3547355,127.3428364,'8730e379dffffff'),(99,'굿','대한민국 대전광역시 유성구 계룡로105번길 28','너무 좋어요',1,1,0,3,'00:00:22',0.11,6,'user','2024-10-10 22:24:04',0,36.354668,127.3431203,'8730e379dffffff'),(100,'한 번 뛰어보실래요? 기분 좋은 풍경 코스','대한민국 대전광역시 유성구 덕명동 135-1','기분 좋은 풍경과 함께하세요',1,1,0,3,'00:06:10',1.2325091251061577,6,'user','2024-10-11 00:26:33',12,36.355045,127.2996033,'8730e3782ffffff');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_image`
--

DROP TABLE IF EXISTS `course_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_image` (
  `course_id` bigint NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  CONSTRAINT `course_image_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_image`
--

LOCK TABLES `course_image` WRITE;
/*!40000 ALTER TABLE `course_image` DISABLE KEYS */;
INSERT INTO `course_image` VALUES (1,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/1.jpg'),(2,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/2.jpg'),(3,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/3.jpg'),(4,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/4.png'),(5,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/5.jpg'),(6,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/6.jpg'),(7,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/7.jpg'),(8,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/8.jpg'),(9,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/9.jpg'),(10,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/10.jpg'),(11,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/11.jpg'),(12,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/12.jpg'),(13,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/13.jpg'),(14,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/14.jpg'),(15,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/15.jpg'),(16,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/16.png'),(17,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/17.png'),(18,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/18.jpg'),(19,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/19.jpg'),(20,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/20.jpg'),(21,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/21.png'),(22,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/22.jpg'),(23,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/23.jpg'),(24,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/24.jpg'),(25,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/25.jpg'),(26,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/26.jpg'),(27,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/27.jpg'),(28,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/28.jpg'),(29,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/29.jpg'),(30,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/30.jpg'),(62,'https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/course_image/62.jpg'),(90,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728526840607.png'),(91,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728532980772.png'),(93,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/course_images/uploaded_image_1728558311474.png'),(99,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/course_images/uploaded_image_1728566641552.png'),(100,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/course_images/uploaded_image_1728573987534.png');
/*!40000 ALTER TABLE `course_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_tags`
--

DROP TABLE IF EXISTS `course_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_tags` (
  `tag_id` bigint NOT NULL AUTO_INCREMENT,
  `course_id` bigint NOT NULL,
  `tag_name` varchar(255) NOT NULL,
  PRIMARY KEY (`tag_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `course_tags_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_tags`
--

LOCK TABLES `course_tags` WRITE;
/*!40000 ALTER TABLE `course_tags` DISABLE KEYS */;
INSERT INTO `course_tags` VALUES (1,1,'사람 적은'),(2,2,'사람 많은'),(3,2,'평지 중심 코스'),(4,3,'강가 근처 코스'),(5,3,'자전거 도로와 함께하는'),(6,4,'평지 중심 코스'),(7,4,'사람 많은'),(8,5,'사람 많은'),(9,5,'평지 중심 코스'),(10,5,'강가 근처 코스'),(11,6,'오르막길이 많은'),(12,6,'접근성이 좋은'),(13,7,'강가 근처 코스'),(14,8,'사람 많은'),(15,8,'평지 중심 코스'),(16,9,'사람 많은'),(17,9,'강가 근처 코스'),(18,10,'오르막길이 많은'),(19,10,'사람 적은'),(20,11,'사람 많은'),(21,12,'평지 중심 코스'),(22,12,'접근성이 좋은'),(23,13,'자전거 도로와 함께하는'),(24,14,'강가 근처 코스'),(25,14,'자전거 도로와 함께하는'),(26,14,'사람 적은'),(27,15,'오르막길이 많은'),(28,15,'사람 많은'),(29,16,'강가 근처 코스'),(30,16,'평지 중심 코스'),(31,17,'오르막길이 많은'),(32,17,'사람 많은'),(33,18,'내리막길이 많은'),(34,18,'사람 적은'),(35,19,'접근성이 좋은'),(36,19,'강가 근처 코스'),(37,20,'강가 근처 코스'),(38,20,'사람 많은'),(40,20,'평지 중심 코스'),(41,62,'오르막길이 많은'),(42,62,'사람 적은');
/*!40000 ALTER TABLE `course_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite_course`
--

DROP TABLE IF EXISTS `favorite_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorite_course` (
  `favorite_course_id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` bigint NOT NULL,
  `tag_name` varchar(255) NOT NULL,
  PRIMARY KEY (`favorite_course_id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `favorite_course_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite_course`
--

LOCK TABLES `favorite_course` WRITE;
/*!40000 ALTER TABLE `favorite_course` DISABLE KEYS */;
INSERT INTO `favorite_course` VALUES (1,5,'오르막길이 많은'),(2,5,'내리막길이 많은'),(3,5,'평지 중심 코스'),(4,5,'강가 근처 코스'),(5,5,'접근성이 좋은'),(6,5,'해안가 근처 코스'),(7,5,'자전거 도로와 함께하는'),(8,5,'사람 적은'),(9,6,'사람 적은'),(10,6,'접근성이 좋은'),(11,6,'평지 중심 코스'),(12,1,'오르막길이 많은'),(13,7,'평지 중심 코스'),(14,7,'강가 근처 코스'),(18,9,'사람 적은'),(19,9,'자전거 도로와 함께하는'),(20,10,'오르막길이 많은'),(21,10,'사람 적은'),(22,10,'평지 중심 코스'),(25,15,'평지 중심 코스'),(26,15,'사람 적은'),(27,16,'오르막길이 많은'),(28,16,'평지 중심 코스'),(29,16,'해안가 근처 코스'),(30,17,'평지 중심 코스'),(31,17,'접근성이 좋은'),(32,17,'자전거 도로와 함께하는'),(33,17,'사람 적은'),(34,18,'평지 중심 코스'),(35,18,'해안가 근처 코스'),(36,18,'자전거 도로와 함께하는'),(37,18,'접근성이 좋은'),(38,19,'강가 근처 코스'),(39,20,'강가 근처 코스'),(40,20,'강가 근처 코스'),(41,21,'강가 근처 코스'),(42,21,'사람 적은'),(43,21,'접근성이 좋은'),(44,21,'평지 중심 코스'),(45,22,'사람 적은'),(46,23,'접근성이 좋은'),(47,23,'사람 적은'),(48,24,'사람 적은'),(49,25,'평지 중심 코스'),(50,25,'사람 적은'),(51,26,'평지 중심 코스'),(52,27,'접근성이 좋은'),(53,27,'사람 적은'),(54,27,'평지 중심 코스'),(55,28,'오르막길이 많은');
/*!40000 ALTER TABLE `favorite_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `member_id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `join_type` enum('kakao','google') NOT NULL,
  `nickname` varchar(30) NOT NULL,
  `birth` date DEFAULT NULL,
  `height` int DEFAULT NULL,
  `weight` int DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `resign_time` timestamp NULL DEFAULT NULL,
  `is_resign` tinyint(1) DEFAULT '0',
  `gender` tinyint NOT NULL,
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `nickname` (`nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'admin@gmail.com','kakao','관리자','9999-09-09',NULL,NULL,'2024-09-10 06:05:58',NULL,0,0),(2,'user1@kakao.com','kakao','러닝의 고수','1999-04-29',175,64,'2024-10-07 05:22:12',NULL,0,1),(3,'user2@kakao.com','kakao','예쁜 러너','2001-10-01',158,42,'2024-09-14 09:32:43',NULL,0,0),(4,'user3@kakao.com','kakao','갑천 멋쟁이','1997-05-12',180,74,'2024-12-12 03:12:12',NULL,0,1),(5,'onestore192@kakao.com','kakao','원토','1995-10-07',175,70,'2024-10-07 00:54:04',NULL,0,1),(6,'tmdxkr5@hanmail.net','kakao','고수준석','2024-10-10',180,80,'2024-10-07 01:00:27',NULL,0,1),(7,'csb8662sb@naver.com','kakao','강원도감자','2019-10-07',180,12,'2024-10-07 11:38:11',NULL,0,1),(9,'wonnyboi@naver.com','kakao','악성유저1입니다','1930-09-19',NULL,NULL,'2024-10-08 01:56:48',NULL,0,1),(10,'goodyebon123@naver.com','kakao','초보 소연','1997-04-01',160,40,'2024-10-08 03:38:13',NULL,0,0),(12,'','kakao','아뇨하세요','2024-03-07',0,0,'2024-10-08 06:41:59',NULL,0,1),(15,'bumdoly2000@naver.com','kakao','범규','2024-01-08',200,50,'2024-10-08 07:12:52',NULL,0,1),(16,'hyeee19@daum.net','kakao','지혜는 러닝을 ','2001-02-25',160,40,'2024-10-09 05:33:04',NULL,0,0),(17,'april_401@daum.net','kakao','이소는피고내','1997-04-01',160,50,'2024-10-09 07:57:58',NULL,0,0),(18,'munbeumsu@hanmail.net','kakao','문범수수수','1998-04-29',190,50,'2024-10-10 02:05:12',NULL,0,1),(19,'zlzl9432@gmail.com','kakao','ㅊㅊ','1997-02-20',172,60,'2024-10-10 03:04:14',NULL,0,1),(20,'poow810@naver.com','kakao','우니','1998-08-13',181,73,'2024-10-10 05:35:13',NULL,0,1),(21,'jsmtoltwd@daum.net','kakao','admin',NULL,NULL,NULL,'2024-10-10 05:35:57',NULL,0,0),(22,'shtony123@naver.com','kakao','푸바오','1997-08-25',175,60,'2024-10-10 05:49:42',NULL,0,1),(23,'bubbleutopia@hanmail.net','kakao','01','1996-09-23',178,100,'2024-10-10 05:51:06',NULL,0,1),(24,'hyjang2955@daum.net','kakao','러너','2024-10-10',200,100,'2024-10-10 05:56:49',NULL,0,0),(25,'choikkbonv@naver.com','kakao','미또또의나','2000-02-08',230,300,'2024-10-10 06:10:01',NULL,0,0),(26,'kim990728@naver.com','kakao','김종원','1999-07-28',NULL,NULL,'2024-10-10 06:48:07',NULL,0,1),(27,'1514kth@naver.com','kakao','승탁','1930-08-26',185,75,'2024-10-10 06:48:33',NULL,0,1),(28,'sktks11@naver.com','kakao','dk','2024-10-10',123,12,'2024-10-10 07:33:46',NULL,0,1);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_image`
--

DROP TABLE IF EXISTS `member_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_image` (
  `member_id` bigint NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`member_id`),
  CONSTRAINT `member_image_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_image`
--

LOCK TABLES `member_image` WRITE;
/*!40000 ALTER TABLE `member_image` DISABLE KEYS */;
INSERT INTO `member_image` VALUES (4,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/profile_images/uploaded_image_1728288168793.png'),(5,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/profile_images/uploaded_image_1728288168797.png'),(6,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/profile_images/uploaded_image_1728288168791.png'),(7,NULL),(9,NULL),(10,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/profile_images/uploaded_image_1728288168792.png'),(12,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/profile_images/uploaded_image_1728288168791.png'),(15,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/profile_images/uploaded_image_1728371559305.png'),(16,NULL),(18,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/profile_images/uploaded_image_1728525880940.png'),(19,NULL),(20,NULL),(21,NULL),(22,NULL),(23,NULL),(24,NULL),(25,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/profile_images/uploaded_image_1728540569004.png'),(26,NULL),(27,NULL),(28,NULL);
/*!40000 ALTER TABLE `member_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_image`
--

DROP TABLE IF EXISTS `personal_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_image` (
  `record_id` bigint NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  CONSTRAINT `personal_image_ibfk_1` FOREIGN KEY (`record_id`) REFERENCES `running_record` (`record_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_image`
--

LOCK TABLES `personal_image` WRITE;
/*!40000 ALTER TABLE `personal_image` DISABLE KEYS */;
INSERT INTO `personal_image` VALUES (24,NULL),(25,NULL),(26,NULL),(27,NULL),(28,NULL),(29,NULL),(30,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728371728526.png'),(31,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728371970328.png'),(32,''),(33,''),(34,''),(35,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728455559882.png'),(36,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728455559882.png'),(37,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728459985193.png'),(38,''),(40,''),(41,''),(42,''),(43,''),(44,''),(45,''),(46,''),(47,''),(48,''),(49,''),(50,''),(51,''),(52,''),(53,''),(54,''),(55,''),(56,''),(57,''),(58,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728468379476.png'),(59,''),(60,''),(61,''),(62,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728506205614.png'),(63,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728510393786.png'),(64,''),(65,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728519589231.png'),(66,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728519654389.png'),(67,''),(68,''),(69,''),(70,''),(71,''),(72,''),(73,''),(74,''),(75,''),(76,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728520058929.png'),(77,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728520353551.png'),(78,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728520439206.png'),(79,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728520498779.png'),(80,''),(81,''),(82,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728520693287.png'),(83,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728520849940.png'),(84,''),(85,''),(86,''),(87,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728521089327.png'),(88,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728521152238.png'),(89,''),(90,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728521805849.png'),(91,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728522591373.png'),(92,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728522846580.png'),(93,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728525994263.png'),(94,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728526840607.png'),(95,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728531743510.png'),(96,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728531743510.png'),(97,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728532699839.png'),(98,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728532980772.png'),(99,''),(100,''),(101,''),(103,''),(104,''),(106,''),(107,''),(108,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728540063012.png'),(109,''),(110,''),(111,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728543028204.png'),(112,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728545763344.png'),(113,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728546625495.png'),(114,''),(115,''),(116,''),(121,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728561080448.png'),(122,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728562700719.png'),(123,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728562700719.png'),(124,''),(125,''),(126,''),(127,''),(128,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728564196141.png'),(129,''),(130,''),(131,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728564555816.png'),(132,''),(133,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728564834730.png'),(134,''),(135,''),(136,''),(137,''),(138,'https://runnerway.s3.ap-northeast-2.amazonaws.com/uploads/running_images/uploaded_image_1728566414224.png'),(139,''),(140,'');
/*!40000 ALTER TABLE `personal_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ranking`
--

DROP TABLE IF EXISTS `ranking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ranking` (
  `rank_id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` bigint NOT NULL,
  `course_id` bigint NOT NULL,
  `score` time NOT NULL,
  `path` varchar(255) NOT NULL,
  `is_delete` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`rank_id`),
  KEY `member_id` (`member_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `ranking_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `ranking_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ranking`
--

LOCK TABLES `ranking` WRITE;
/*!40000 ALTER TABLE `ranking` DISABLE KEYS */;
INSERT INTO `ranking` VALUES (2,5,62,'00:01:03','',0),(3,4,62,'00:01:05','',0),(7,10,62,'00:00:54','https://runnerway.s3.ap-northeast-2.amazonaws.com/ranking/1728376853416246.json',0),(8,10,0,'00:00:54','https://runnerway.s3.ap-northeast-2.amazonaws.com/ranking/1728376872922354.json',0),(15,6,62,'00:01:00','https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/ranking/1.json',0),(19,5,0,'00:01:24','https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/ranking/1728506186333392.json',0),(20,6,0,'00:02:10','https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/ranking/1728472170466362.json',0),(21,6,0,'00:01:24','https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/ranking/1728506186333392.json',0),(22,17,0,'00:00:19','https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/ranking/1728518501703460.json',0),(24,15,62,'00:01:07','https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/ranking/1728526684925992.json',0),(25,6,91,'00:00:13','https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/ranking/1728533225571074.json',0),(26,22,91,'00:00:13','https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/ranking/1728540084108571.json',0),(27,19,91,'00:00:16','https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/ranking/1728540272723837.json',0),(28,27,91,'00:00:52','https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/ranking/1728542999230168.json',0),(29,28,91,'00:00:12','https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/ranking/1728545712914515.json',0),(30,6,93,'00:00:40','https://runnerway.s3.ap-northeast-2.amazonaws.com/upload/ranking/1728561023513086.json',0);
/*!40000 ALTER TABLE `ranking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recommendation_log`
--

DROP TABLE IF EXISTS `recommendation_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recommendation_log` (
  `log_id` bigint NOT NULL AUTO_INCREMENT,
  `course_id` bigint NOT NULL,
  `member_id` bigint NOT NULL,
  `course_level` int NOT NULL,
  `average_slope` int NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `fk_recomm_to_course_idx` (`course_id`),
  KEY `fk_recomm_to_member_idx` (`member_id`),
  CONSTRAINT `fk_recomm_to_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`),
  CONSTRAINT `fk_recomm_to_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommendation_log`
--

LOCK TABLES `recommendation_log` WRITE;
/*!40000 ALTER TABLE `recommendation_log` DISABLE KEYS */;
INSERT INTO `recommendation_log` VALUES (1,0,6,0,0),(2,0,6,0,0),(3,0,6,0,0),(4,0,7,0,0),(5,0,6,0,0),(6,0,6,0,0),(7,0,6,0,0),(8,0,6,0,0),(9,0,6,0,0),(10,0,6,0,0),(11,0,6,0,0),(12,0,6,0,0),(13,0,6,0,0),(14,0,6,0,0),(16,0,9,0,0),(17,0,6,0,0),(18,0,6,0,0),(19,3,10,1,0),(20,5,10,1,0),(21,9,10,1,0),(22,12,10,1,0),(23,12,6,1,0),(24,14,6,1,0),(25,0,15,0,0),(26,0,6,0,0),(27,14,6,1,0),(28,0,6,0,0),(29,0,6,0,0),(30,0,6,0,0),(31,0,6,0,0),(32,0,6,0,0),(33,0,6,0,0),(34,0,17,0,0),(35,0,6,0,0),(36,0,17,1,0),(37,0,17,1,0),(38,0,6,2,0),(39,0,6,2,0),(40,0,6,2,0),(41,0,6,2,0),(42,2,17,2,0),(43,2,17,2,0),(44,0,17,0,0),(45,0,6,0,0),(46,0,6,0,0),(47,0,17,1,0),(48,0,17,0,0),(49,0,17,0,0),(50,0,6,0,0),(51,0,6,0,0),(52,0,6,0,0),(53,0,6,0,0),(54,0,6,1,0),(55,0,6,0,0),(56,0,6,0,0),(57,0,6,1,0),(58,0,6,1,0),(59,0,6,0,0),(60,0,17,1,0),(61,0,17,1,0),(62,0,6,0,0),(63,0,6,0,0),(64,0,6,0,0),(65,0,6,0,0),(66,0,6,0,0),(67,0,6,0,0),(68,0,17,1,0),(69,0,6,0,0),(70,0,6,0,0),(71,0,17,1,0),(72,0,6,0,0),(73,0,6,0,0),(74,0,6,0,0),(75,0,6,0,0),(76,0,6,0,0),(77,0,17,1,0),(78,0,6,0,0),(79,0,6,0,0),(80,0,6,0,0),(81,0,6,0,0),(82,0,6,0,0),(83,0,6,0,0),(84,0,6,0,0),(85,0,6,0,0),(86,0,6,0,0),(87,0,6,0,0),(88,0,18,0,0),(89,0,15,0,0),(90,62,6,1,0),(91,62,6,1,0),(92,62,6,1,0),(93,0,6,0,0),(94,91,6,1,0),(95,0,6,0,0),(96,0,6,0,0),(97,2,1,2,0),(98,0,6,0,0),(99,0,6,0,0),(100,0,6,0,0),(101,0,21,0,0),(102,0,23,0,0),(103,0,19,0,0),(104,0,22,0,0),(105,0,6,0,0),(106,91,27,1,0),(107,0,28,0,0),(108,91,6,1,0),(109,91,6,1,0),(110,0,6,0,0),(111,0,6,0,0),(112,0,6,0,0),(113,0,6,0,0),(114,0,6,0,0),(115,0,6,0,0),(116,93,6,1,0),(117,0,6,0,0),(118,0,6,0,0),(119,0,6,0,0),(120,0,6,0,0),(121,0,6,0,0),(122,0,6,0,0),(123,0,6,0,0),(124,0,6,0,0),(125,0,6,0,0),(126,0,6,0,0),(127,0,6,0,0),(128,0,6,0,0),(129,0,6,0,0),(130,0,6,0,0),(131,0,6,0,0),(132,0,6,0,0),(133,93,6,1,0),(134,0,6,0,0),(135,0,6,0,0);
/*!40000 ALTER TABLE `recommendation_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `running_record`
--

DROP TABLE IF EXISTS `running_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `running_record` (
  `record_id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` bigint NOT NULL,
  `course_id` bigint NOT NULL,
  `score` time NOT NULL,
  `address` varchar(255) NOT NULL,
  `running_distance` double NOT NULL,
  `calorie` double NOT NULL,
  `average_face` double NOT NULL,
  `comment` varchar(500) DEFAULT NULL,
  `start_date` timestamp NOT NULL,
  `finish_date` timestamp NOT NULL,
  `lat` double NOT NULL,
  `lng` double NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `member_id` (`member_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `running_record_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `running_record_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `running_record`
--

LOCK TABLES `running_record` WRITE;
/*!40000 ALTER TABLE `running_record` DISABLE KEYS */;
INSERT INTO `running_record` VALUES (21,6,62,'00:01:00','대전광역시 유성구 덕명동 124',0.23,16.1,4.21,'쉽네요','2024-10-08 03:00:00','2024-10-08 03:01:00',36.35507,127.29963),(23,10,1,'00:10:24','대전광역시 유성구 덕명동 574',1,70,10.24,'사람 적고 좋아요','2024-10-07 02:00:00','2024-10-07 02:10:24',36.356944818293904,127.30477344439119),(24,10,3,'00:33:44','대전광역시 서구 도안동 48-1',3.41,266,9.53,'도안쪽 풍경이 너무 좋아요','2024-10-06 06:00:00','2024-10-06 06:33:44',36.31760437047439,127.35137960484109),(25,10,5,'00:18:44','대전광역시 유성구 장대동 9-3',2.2,154,8.3,'바람이 시원해','2024-10-04 08:21:00','2024-10-04 08:39:44',36.35708664963028,127.33948412394929),(26,10,9,'00:20:11','대전광역시 유성구 궁동 473',2.29,160.3,8.48,'갑천이 뛰기가 제일 좋다','2024-10-02 10:00:00','2024-10-02 10:20:11',36.36002295163785,127.34499723569246),(27,10,12,'00:09:11','대전광역시 유성구 노은동로 126',1,70,9.11,'은구비 공원 자주 와야겠다!','2024-10-01 10:00:00','2024-10-01 10:09:11',36.37046246397621,127.32371080178342),(28,6,12,'00:07:11','대전광역시 유성구 노은동로 126',1,70,7.11,'아 러닝 쉽다!','2024-10-01 10:00:00','2024-10-01 10:07:11',36.37046246397621,127.32371080178342),(29,6,14,'00:17:05','대전광역시 유성구 봉명동 496-25',2.4,168,7.7,'페이스를 끌어 올리자!','2024-10-01 10:00:00','2024-10-01 10:17:05',36.3513959527376,127.3489773442841),(30,15,0,'00:00:06','대한민국 대전광역시 유성구 덕명동 122-1',0.0016928976104385331,0,0,'좋아요!','2024-10-08 07:15:15','2024-10-08 07:15:21',36.3553619,127.2981147),(31,6,0,'00:00:05','대한민국 대전광역시 유성구 계룡로141번길 30-1',0,0,0,'hhhhh','2024-10-07 22:19:16','2024-10-07 22:19:21',36.35406166666667,127.34688833333334),(32,6,14,'00:00:06','대한민국 대전광역시 유성구 계룡로141번길 30-1',0,0,0,'ggggg','2024-10-08 20:07:26','2024-10-08 20:07:32',36.3540617,127.3468883),(33,6,0,'00:00:05','대한민국 대전광역시 유성구 계룡로141번길 30-1',0,0,0,'ㅎㅎㅎㅎㅎㅎㅎ\n','2024-10-08 21:08:39','2024-10-08 21:08:44',36.3540617,127.3468883),(34,6,0,'00:00:05','대한민국 대전광역시 유성구 계룡로141번길 30-1',0,0,0,'ㅎㅎㅎㅎㅎㅎㅎ\n','2024-10-08 21:08:39','2024-10-08 21:08:44',36.3540617,127.3468883),(35,6,0,'00:00:25','대한민국 대전광역시 유성구 계룡로141번길 30-1',0,0,0,'날다날다날다','2024-10-08 21:19:23','2024-10-08 21:19:48',36.3540617,127.3468883),(36,6,0,'00:00:25','대한민국 대전광역시 유성구 계룡로141번길 30-1',0,0,0,'날다날다날다','2024-10-08 21:19:23','2024-10-08 21:19:48',36.3540617,127.3468883),(37,6,0,'00:00:43','대한민국 대전광역시 유성구 덕명동 135-1',5.1347035653279445,0,0,'아고','2024-10-08 22:45:20','2024-10-08 22:46:03',36.3550448,127.2996012),(38,6,0,'00:00:01','대한민국 대전광역시 유성구 봉명동 536-11',0,0,0,'','2024-10-08 23:03:08','2024-10-08 23:03:09',36.3567217,127.3426817),(40,6,0,'00:00:18','대한민국 대전광역시 유성구 봉명동 536-11',14.580779601730978,0,0,'','2024-10-09 00:01:49','2024-10-09 00:02:07',36.3567217,127.3426817),(41,17,0,'00:00:04','대한민국 대전광역시 유성구 계룡로141번길 30-1',0,0,0,'','2024-10-09 00:05:58','2024-10-09 00:06:02',36.3540617,127.3468883),(42,17,0,'00:00:09','대한민국 대전광역시 유성구 계룡로141번길 30-1',0,0,0,'ㅏㅏㅏㅏ','2024-10-09 00:15:23','2024-10-09 00:15:32',36.3540617,127.3468883),(43,6,0,'00:00:10','대한민국 대전광역시 유성구 덕명동 135-1',11.982219247925533,0,0,'','2024-10-09 00:17:26','2024-10-09 00:17:36',36.354985,127.298325),(44,6,0,'00:00:10','대한민국 대전광역시 유성구 덕명동 135-1',3.6307219310725536,0,0,'','2024-10-09 00:18:24','2024-10-09 00:18:34',36.3539233,127.34159),(45,6,0,'00:00:05','대한민국 대전광역시 유성구 덕명동 135-1',1.2775727137471826,0,0,'','2024-10-09 00:21:00','2024-10-09 00:21:05',36.3495567,127.34824),(46,6,0,'00:00:05','대한민국 대전광역시 유성구 덕명동 135-1',1.2775727137471826,0,0,'','2024-10-09 00:21:00','2024-10-09 00:21:05',36.3495567,127.34824),(47,17,2,'00:39:00','대전',5.5,333,3.3,'abc','2024-09-12 03:00:00','2024-09-12 03:45:00',0,0),(48,17,2,'00:39:00','대전',5.5,333,3.3,'abc','2024-10-31 03:00:00','2024-10-31 03:45:00',0,0),(49,17,0,'00:39:00','대전',5.5,333,3.3,'abc','2024-10-31 03:00:00','2024-10-31 03:45:00',0,0),(50,6,0,'00:00:05','대한민국 대전광역시 유성구 봉명동 967',1.2775727137471826,0,0,'','2024-10-09 00:26:45','2024-10-09 00:26:50',36.3495567,127.34824),(51,6,0,'00:00:06','대한민국 대전광역시 유성구 구암동 614-17',4.236245486263542,0,0,'','2024-10-09 00:28:21','2024-10-09 00:28:27',36.349695,127.3339917),(52,17,0,'00:00:05','대한민국 대전광역시 유성구 계룡로141번길 30-1',0,0,0,'','2024-10-09 00:30:28','2024-10-09 00:30:33',36.3540617,127.3468883),(53,17,0,'00:00:09','대한민국 대전광역시 유성구 계룡로141번길 30-1',0,0,0,'','2024-10-09 00:31:17','2024-10-09 00:31:26',36.3540617,127.3468883),(54,17,0,'00:00:10','대한민국 대전광역시 유성구 계룡로141번길 30-1',0.6299060217528082,0,0,'11111','2024-10-09 00:32:25','2024-10-09 00:32:35',36.3540617,127.3468883),(55,6,0,'00:00:22','대한민국 대전광역시 서구 월평동 1503-1',10.039517288104797,0,0,'','2024-10-09 00:33:30','2024-10-09 00:33:52',36.358405,127.3702133),(56,6,0,'00:00:47','대한민국 대전광역시 유성구 계룡로 127',0.06395851395446665,0,0,'아야','2024-10-09 09:42:05','2024-10-09 09:42:52',36.3528373,127.3446998),(57,6,0,'00:02:05','대한민국 대전광역시 유성구 봉명동 548-12',0.2508080569248708,4,0,'아가가','2024-10-09 09:48:54','2024-10-09 09:50:59',36.3529517,127.3449778),(58,6,0,'00:02:02','대한민국 대전광역시 유성구 봉명동 548-12',0.1646405733893096,4,0,'우왕','2024-10-09 10:04:03','2024-10-09 10:06:05',36.3529362,127.3449868),(59,6,0,'00:02:10','대한민국 대전광역시 유성구 봉명동 548-12',0.1738591017143618,4,0,'안녕하세요','2024-10-09 11:07:41','2024-10-09 11:09:51',36.3529186,127.3449933),(60,6,0,'00:01:06','대한민국 대전광역시 유성구 봉명동 465-12',0.09982598901924065,2,0,'될까?','2024-10-09 20:16:38','2024-10-09 20:17:44',36.3530637,127.3359063),(61,6,0,'00:01:45','대한민국 대전광역시 유성구 봉명동 568-20',0.16489045037434424,2,0,'제발요','2024-10-09 20:29:39','2024-10-09 20:31:24',36.3533346,127.3356107),(62,6,0,'00:01:24','대한민국 대전광역시 유성구 봉명동 568-20',0.1383890324612011,2,0,'왜 사진 안 들어가?','2024-10-09 20:35:07','2024-10-09 20:36:31',36.3534552,127.3354116),(63,6,0,'00:01:33','대한민국 대전광역시 유성구 봉명동 568-20',0.14272000187051959,2,0,'아야','2024-10-09 12:44:51','2024-10-09 12:46:24',36.3534567,127.33529),(64,6,0,'00:01:37','대한민국 대전광역시 유성구 덕명동 122-1',0.10531066009018318,2,0,'휴 힘들다','2024-10-10 00:15:45','2024-10-10 00:17:22',36.3553315,127.2981156),(65,17,0,'00:00:21','대한민국 대전광역시 유성구 봉명동 568-20',0.07201989967178693,0,0,'ㅎㅎㅎㅎㅎ','2024-10-09 15:19:04','2024-10-09 15:19:25',36.3549917,127.2994617),(66,17,0,'00:00:14','대한민국 대전광역시 유성구 봉명동 568-20',0.13580917932957187,0,0,'ㅎㅎㅎㅎㅎ','2024-10-09 15:20:35','2024-10-09 15:20:49',36.3547517,127.2987683),(67,6,0,'00:00:15','대한민국 대전광역시 유성구 덕명동 122-1',0.009869804945339546,0,0,'에베베베','2024-10-10 00:24:47','2024-10-10 00:25:02',36.3553373,127.2981214),(68,6,0,'00:00:15','대한민국 대전광역시 유성구 덕명동 122-1',0.009869804945339546,0,0,'에베베베','2024-10-10 00:24:47','2024-10-10 00:25:02',36.3553373,127.2981214),(69,6,0,'00:00:15','대한민국 대전광역시 유성구 덕명동 122-1',0.009869804945339546,0,0,'에베베베','2024-10-10 00:24:47','2024-10-10 00:25:02',36.3553373,127.2981214),(70,6,0,'00:00:15','대한민국 대전광역시 유성구 덕명동 122-1',0.009869804945339546,0,0,'에베베베','2024-10-10 00:24:47','2024-10-10 00:25:02',36.3553373,127.2981214),(71,6,0,'00:00:15','대한민국 대전광역시 유성구 덕명동 122-1',0.009869804945339546,0,0,'에베베베','2024-10-10 00:24:47','2024-10-10 00:25:02',36.3553373,127.2981214),(72,6,0,'00:00:15','대한민국 대전광역시 유성구 덕명동 122-1',0.009869804945339546,0,0,'에베베베','2024-10-10 00:24:47','2024-10-10 00:25:02',36.3553373,127.2981214),(73,17,0,'00:00:22','대한민국 대전광역시 유성구 봉명동 548-12',0.020649228815482992,0,0,'후 어렵넴','2024-10-09 15:25:07','2024-10-09 15:25:29',36.3529267,127.3450117),(74,6,0,'00:00:11','',0.025515716073810542,0,0,'아아','2024-10-10 00:26:01','2024-10-10 00:26:12',36.3553411,127.2981203),(75,6,0,'00:00:22','',0.03180175683917564,0,0,'마지막','2024-10-10 00:27:07','2024-10-10 00:27:29',36.3553099,127.2980851),(76,17,0,'00:00:51','대한민국 대전광역시 유성구 봉명동 548-12',0.1180333046428345,0,0,'히히히히','2024-10-09 15:26:37','2024-10-09 15:27:28',36.3529183,127.3450129),(77,6,0,'00:00:09','대한민국 대전광역시 유성구 덕명동 122-1',0.006609209658576925,0,0,'가나다라','2024-10-10 00:32:19','2024-10-10 00:32:28',36.3552386,127.2981255),(78,6,0,'00:00:03','대한민국 대전광역시 유성구 덕명동 122-1',0.002778326988574047,0,0,'카페 러닝','2024-10-10 00:33:52','2024-10-10 00:33:55',36.3552676,127.2981762),(79,6,0,'00:00:03','대한민국 대전광역시 유성구 덕명동 122-1',0.002936854183692669,0,0,'ㅎㅇ','2024-10-10 00:34:47','2024-10-10 00:34:50',36.3552981,127.2980896),(80,6,0,'00:00:04','대한민국 대전광역시 유성구 덕명동 122-1',0.00005493092827008959,0,0,'ㅇㅅㅌ\n','2024-10-10 00:35:21','2024-10-10 00:35:25',36.3552795,127.2980641),(81,6,0,'00:00:04','대한민국 대전광역시 유성구 덕명동 122-1',0.00005493092827008959,0,0,'ㅇㅅㅌ\n','2024-10-10 00:35:21','2024-10-10 00:35:25',36.3552795,127.2980641),(82,17,0,'00:00:24','대한민국 대전광역시 유성구 봉명동 548-12',0.12416253669118356,0,0,'gㅎㅎㅎㅎㅎㅎㅎ','2024-10-09 15:37:46','2024-10-09 15:38:10',36.35317,127.3439183),(83,6,0,'00:00:07','대한민국 대전광역시 유성구 덕명동 122-1',0.007208100733355051,0,0,'가가','2024-10-10 00:40:39','2024-10-10 00:40:46',36.3553375,127.2981223),(84,6,0,'00:00:07','대한민국 대전광역시 유성구 덕명동 122-1',0.00026166597851422376,0,0,'ㅎㅇ','2024-10-10 00:41:14','2024-10-10 00:41:21',36.3553119,127.2981268),(85,6,0,'00:00:03','대한민국 대전광역시 유성구 덕명동 122-1',0,0,0,'가나다라','2024-10-10 00:43:19','2024-10-10 00:43:22',36.3553366,127.2981264),(86,6,0,'00:00:01','대한민국 대전광역시 유성구 덕명동 122-1',0,0,0,'에베','2024-10-10 00:44:06','2024-10-10 00:44:07',36.3552659,127.2981495),(87,6,0,'00:00:01','대한민국 대전광역시 유성구 덕명동 122-1',0,0,0,'에베','2024-10-10 00:44:06','2024-10-10 00:44:07',36.3552659,127.2981495),(88,6,0,'00:00:05','대한민국 대전광역시 유성구 덕명동 122-1',0.0028631558729391854,0,0,'가나','2024-10-10 00:45:44','2024-10-10 00:45:49',36.3553411,127.298123),(89,6,0,'00:00:02','대한민국 대전광역시 유성구 덕명동 122-1',0,0,0,'가나','2024-10-10 00:47:10','2024-10-10 00:47:12',36.3553386,127.2981256),(90,6,0,'00:00:01','대한민국 대전광역시 유성구 덕명동 122-1',0,0,0,'','2024-10-10 00:56:36','2024-10-10 00:56:37',36.3552568,127.2979535),(91,6,0,'00:00:03','대한민국 대전광역시 유성구 덕명동 122-1',0.00420898004740563,0,0,'가가','2024-10-10 01:05:31','2024-10-10 01:05:34',36.355333,127.2981192),(92,6,0,'00:00:01','대한민국 대전광역시 유성구 덕명동 122-1',0,0,0,'하나둘','2024-10-10 01:13:35','2024-10-10 01:13:36',36.3553371,127.2981252),(93,18,0,'00:00:04','대한민국 대전광역시 유성구 덕명동 122-1',0.0002333678224957967,0,0,'kdnrbrndkfkfkfkfkfkfkfjfjdjdkdjfkfkddkdjdndndjfjfjfjfjkdnrbrndkfkfkfkfkfkfkfjfjdjdkdjfkfkddkdjdndndjfjfjfjfjkdnrbrndkfkfkfkfkfkfkfjfjdjdkdjfkfkddkdjdndndjfjfjfjfjkdnrbrndkfkfkfkfkfkfkfjfjdjdkdjfkfkddkdjdndndjfjfjfjfjkdnrbrndkfkfkfkfkfkfkfjfjdjdkdjfkfkddkdjdndndjfjfjfjfjkdnrbrndkfkfkfkfkfkfkfjfjdjd','2024-10-10 02:06:24','2024-10-10 02:06:28',36.3553377,127.2981326),(94,15,90,'00:01:07','대한민국 대전광역시 유성구 덕명동 135-1',0.21962238596547654,2,0,'진짜 힘들다 ㅠㅠ','2024-10-10 02:18:41','2024-10-10 02:19:48',36.3550763,127.2996504),(95,6,62,'00:01:16','대전광역시 유성구 덕명동 124',0.22156362301734145,2,0,'가냐','2024-10-09 18:41:03','2024-10-09 18:42:19',36.355045,127.2996033),(96,6,62,'00:01:16','대전광역시 유성구 덕명동 124',0.22156362301734145,2,0,'가냐','2024-10-09 18:41:03','2024-10-09 18:42:19',36.355045,127.2996033),(97,6,62,'00:01:47','대전광역시 유성구 덕명동 124',0.2162063168867245,2,0,'하하','2024-10-10 03:55:15','2024-10-10 03:57:02',36.3551285,127.2996589),(98,6,91,'00:01:08','대한민국 대전광역시 덕명동 124번지 유성구 대전광역시 KR',0.10001465181546382,2,0,'하하','2024-10-10 04:00:17','2024-10-10 04:01:25',36.3550322,127.2978987),(99,6,91,'00:00:13','대한민국 대전광역시 덕명동 124번지 유성구 대전광역시 KR',0.07585672553811361,0,0,'','2024-10-10 04:06:59','2024-10-10 04:07:12',36.3549431,127.2983493),(100,6,0,'00:00:06','대한민국 대전광역시 유성구 덕명동 122-1',0.009273827695434956,0,0,'','2024-10-10 04:11:26','2024-10-10 04:11:32',36.3553461,127.2980504),(101,6,0,'00:00:05','대한민국 대전광역시 유성구 덕명동 136-2',0.0966920504217273,0,0.8618426537638902,'','2024-10-09 20:08:25','2024-10-09 20:08:30',36.354515,127.2983283),(103,6,0,'00:00:08','대한민국 대전광역시 유성구 덕명동 495-2',0.21202669476108527,0,0,'ㅁㄴㅇㄹ','2024-10-09 20:21:07','2024-10-09 20:21:15',36.3547817,127.2973617),(104,6,0,'00:00:22','대한민국 대전광역시 유성구 덕명동 135-1',0.13087892627541073,0,0,'아아','2024-10-09 20:22:31','2024-10-09 20:22:53',36.3550443,127.299597),(106,21,0,'00:00:06','대한민국 대전광역시 유성구 덕명동 122-1',0.0006354972587181601,0,157.21,'','2024-10-10 05:37:35','2024-10-10 05:37:41',36.3553492,127.2981718),(107,23,0,'00:00:53','대한민국 대전광역시 유성구 덕명동 122-1',0.010480340924743628,0,84.17,'123','2024-10-10 05:53:08','2024-10-10 05:54:01',36.3553385,127.2981414),(108,19,0,'00:00:23','대한민국 대전광역시 유성구 덕명동 495-2',0.08301567388551681,0,4.37,'러너웨이화이팅!!','2024-10-10 05:58:33','2024-10-10 05:58:56',36.3549953,127.2976579),(109,22,0,'00:00:13','',0.07926494169915149,0,2.44,'힘들어요','2024-10-10 06:01:24','2024-10-10 06:01:37',36.3549064,127.2983214),(110,6,0,'00:00:07','대한민국 대전광역시 유성구 덕명동 122-1',0.0062461630556187395,0,18.41,'첫 러닝','2024-10-10 06:24:11','2024-10-10 06:24:18',36.3553355,127.2981261),(111,27,91,'00:00:52','대한민국 대전광역시 덕명동 124번지 유성구 대전광역시 KR',0.07476820229655988,0,11.35,'승탁이가 시켰어요','2024-10-10 06:49:17','2024-10-10 06:50:09',36.3550095,127.298452),(112,28,0,'00:00:12','대한민국 대전광역시 덕명동 124번지 유성구 대전광역시 KR',0.06554995459891386,0,3.03,'1등!','2024-10-10 07:35:45','2024-10-10 07:35:57',36.3549583,127.298358),(113,6,91,'00:00:44','대한민국 대전광역시 덕명동 124번지 유성구 대전광역시 KR',0.07330014090228529,0,10,'진짜로??? ㄷㄷ','2024-10-10 07:49:16','2024-10-10 07:50:00',36.355032,127.2984199),(114,6,91,'00:00:14','대한민국 대전광역시 덕명동 124번지 유성구 대전광역시 KR',0.07934750227492714,0,2.56,'잘 보셨나요???','2024-10-10 08:27:16','2024-10-10 08:27:30',36.355017,127.2984421),(115,6,0,'00:01:19','대한민국 대전광역시 유성구 봉명동 551-17',0.09927381690514078,2,13.16,'응애','2024-10-10 10:50:05','2024-10-10 10:51:24',36.3547355,127.3428364),(116,6,93,'00:01:19','대한민국 대전광역시 유성구 봉명동 551-17',0.11,2,13.16,'응애','2024-10-10 10:50:05','2024-10-10 10:51:24',36.3547355,127.3428364),(121,6,93,'00:00:40','대한민국 대전광역시 유성구 봉명동 551-17',0.10203203822223703,0,6.32,'아주 굳이요!','2024-10-10 11:49:56','2024-10-10 11:50:36',36.3545603,127.3429214),(122,6,0,'00:00:12','대한민국 대전광역시 유성구 계룡로105번길 28',0.007418583893463056,0,26.58,'진짜야','2024-10-10 12:18:03','2024-10-10 12:18:15',36.3545446,127.3430991),(123,6,0,'00:00:12','대한민국 대전광역시 유성구 계룡로105번길 28',0.007418583893463056,0,26.58,'진짜야','2024-10-10 12:18:03','2024-10-10 12:18:15',36.3545446,127.3430991),(124,6,0,'00:00:06','대한민국 대전광역시 유성구 계룡로105번길 28',0.010506003922219764,0,9.31,'쮜얶','2024-10-10 12:30:58','2024-10-10 12:31:04',36.3546694,127.343122),(125,6,0,'00:00:10','대한민국 대전광역시 유성구 계룡로105번길 28',0,0,0,'메롱','2024-10-10 12:32:14','2024-10-10 12:32:24',36.3545795,127.3430132),(126,6,0,'00:00:10','대한민국 대전광역시 유성구 계룡로105번길 28',0,0,0,'메롱2','2024-10-10 12:32:14','2024-10-10 12:32:24',36.3545795,127.3430132),(127,6,0,'00:00:06','대한민국 대전광역시 유성구 계룡로105번길 28',0.00041375193772030236,0,241.41,'메롱3','2024-10-10 12:37:10','2024-10-10 12:37:16',36.3546712,127.3431165),(128,6,0,'00:00:04','대한민국 대전광역시 유성구 계룡로105번길 28',0.00013626409981502247,0,489.15,'메롱포','2024-10-10 12:43:01','2024-10-10 12:43:05',36.3546694,127.3431208),(129,6,0,'00:00:03','대한민국 대전광역시 유성구 계룡로105번길 28',0,0,0,'메ㅖㅖ','2024-10-10 12:46:03','2024-10-10 12:46:06',36.354669,127.3431223),(130,6,0,'00:00:02','대한민국 대전광역시 유성구 계룡로105번길 28',0,0,0,'ㄴㄴㄴ','2024-10-10 12:48:04','2024-10-10 12:48:06',36.3546707,127.3431175),(131,6,0,'00:00:07','대한민국 대전광역시 유성구 봉명동 550-10',0.00592890314907821,0,19.41,'힘내','2024-10-10 12:48:59','2024-10-10 12:49:06',36.3545198,127.3430149),(132,6,0,'00:00:02','대한민국 대전광역시 유성구 봉명동 551-5',0,0,0,'ㅎㅇ','2024-10-10 12:50:22','2024-10-10 12:50:24',36.3546236,127.3429671),(133,6,0,'00:00:06','대한민국 대전광역시 유성구 계룡로105번길 28',0.00027127738813977905,0,368.38,'하염','2024-10-10 12:53:39','2024-10-10 12:53:45',36.3546752,127.3431238),(134,6,0,'00:00:00','대한민국 대전광역시 유성구 계룡로105번길 28',0,0,0,'굳','2024-10-10 12:54:39','2024-10-10 12:54:39',36.3546218,127.3430285),(135,6,0,'00:00:00','대한민국 대전광역시 유성구 봉명동 550-10',0,0,0,'','2024-10-10 12:56:08','2024-10-10 12:56:08',36.354497,127.3430464),(136,6,0,'00:00:02','대한민국 대전광역시 유성구 봉명동 550-10',0,0,0,'','2024-10-10 12:56:30','2024-10-10 12:56:32',36.354479,127.3431376),(137,6,99,'00:00:22','대한민국 대전광역시 유성구 계룡로105번길 28',0.11,0,30.04,'응응','2024-10-10 13:06:18','2024-10-10 13:06:40',36.354668,127.3431203),(138,6,93,'00:00:53','대한민국 대전광역시 유성구 봉명동 551-17',0.11152004324394302,0,7.55,'어우 힘들어요','2024-10-10 13:19:07','2024-10-10 13:20:00',36.3546015,127.3429255),(139,6,100,'00:06:10','대한민국 대전광역시 유성구 덕명동 135-1',1.2325091251061577,12,5,'기분 좋은 러닝이였어요','2024-10-10 06:19:06','2024-10-10 06:25:16',36.355045,127.2996033),(140,6,0,'00:01:11','대한민국 대전광역시 유성구 덕명동 135-1',0.23426958992686495,2,5.03,'','2024-10-10 06:49:53','2024-10-10 06:51:04',36.355045,127.2996033);
/*!40000 ALTER TABLE `running_record` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-11  8:50:50
