CREATE DATABASE  IF NOT EXISTS `336ProjectSQL` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `336ProjectSQL`;

-- ------------------------------------------------------
-- Server version	5.6.35-log

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

DROP TABLE IF EXISTS `credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credentials` (
  `user` varchar(50) NOT NULL DEFAULT '',
  `pass` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `credentials` WRITE;
/*!40000 ALTER TABLE `credentials` DISABLE KEYS */;
INSERT INTO `credentials` VALUES ("admin","adminpass");
INSERT INTO `credentials` VALUES ("u","u");
/*!40000 ALTER TABLE `credentials` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `clothing`;
create table `clothing`(
	`itemID` int auto_increment primary key,
    `name` varchar(50),
    `sex` varchar(1)
);
DROP TABLE IF EXISTS `shirt`;
create table `shirt`(
	`itemID` int primary key,
    foreign key (`itemID`) references clothing(`itemID`),
    `size` varchar(5)
);
DROP TABLE IF EXISTS `pants`;
create table `pants`(
	`itemID` int primary key,
    foreign key (`itemID`) references clothing(`itemID`),
    `WaistWidth` int,
    `LegLength` int
);
DROP TABLE IF EXISTS `shoe`;
create table `shoe`(
	`itemID` int primary key,
    foreign key (`itemID`) references clothing(`itemID`),
    `size` int
);
DROP TABLE IF EXISTS `auction`;
create table `auction`(
	`AuctionID`int auto_increment primary key,
    `InitialPrice` float,
    `CloseDate`datetime,
    `LowestSelliingPrice` float,
    `increment`float, 
    `CurrentPrice`float, 
	`itemID` int,
   -- `ObserverID` varchar(50),
    foreign key(`itemID`) references clothing(`itemID`)

);
-- adding tables from here on 

DROP TABLE IF EXISTS `admin`;
create table `admin`(
	`user` varchar(50) primary key,
    foreign key(user) references credentials(user)
);

DROP TABLE IF EXISTS `customerRep`;
create table `customerRep`(
	`user` varchar(50) primary key,
    foreign key(user) references credentials(user)
);

DROP TABLE IF EXISTS `endUser`;

create table `endUser`(
	`user` varchar(50) primary key,
    foreign key(user) references credentials(user)
);
INSERT INTO `endUser` VALUES ("u");

DROP TABLE IF EXISTS `helps`;
create table `helps`(
	`euid` varchar(50),
    `crid` varchar(50),
    primary key (euid, crid),
    foreign key(euid) references endUser(user),
    foreign key(crid) references endUser(user)
);

DROP TABLE IF EXISTS `holds`;
create table `holds`(
	`user` varchar(50),
    `AuctionID` int,
    primary key(user, AuctionID),
    foreign key(user) references endUser(user),
    foreign key(AuctionID) references auction(AuctionID)
);

DROP TABLE IF EXISTS `bid`;
create table `bid`(
	`bidID` int auto_increment primary key,
    `user` varchar(50),
    `AuctionID` int,
    `price` int,
    `time` datetime,
    foreign key(user) references endUser(user),
    foreign key(AuctionID) references auction(AuctionID)
);

DROP TABLE IF EXISTS `autobid`;
create table `autobid`(
	`upperLimit` float,
    `creator` varchar(50),
    `AuctionID` int,
    primary key (creator, AuctionID),
    foreign key(creator) references endUser(user),
    foreign key(AuctionID) references auction(AuctionID)
);

DROP TABLE IF EXISTS `setAlert`;
create table `setAlert`(
	`user` varchar(50),
    `itemID` int,
    primary key (user, itemID),
    foreign key(user) references endUser(user),
    foreign key (itemID) references clothing(itemID)
);

 DROP TABLE IF EXISTS `customerRequests`;
 create table `customerRequests`(
	`user` varchar(50),
    `request` varchar(500),
    `status` boolean,
    primary key(user, request),
    foreign key(user) references credentials(user)
 );