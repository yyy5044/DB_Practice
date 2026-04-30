CREATE TABLE IF NOT EXISTS `country` (
  `Code` char(3) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `Name` char(52) CHARACTER SET utf8mb4 NOT NULL,
  `Continent` enum('Asia','Europe','North America','Africa','Oceania','Antarctica','South America') CHARACTER SET utf8mb4 NOT NULL DEFAULT 'Asia',
  `Region` char(26) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `SurfaceArea` float(10,2) NOT NULL DEFAULT '0.00',
  `IndepYear` smallint(6) DEFAULT NULL,
  `Population` int(11) NOT NULL DEFAULT '0',
  `LifeExpectancy` float(3,1) DEFAULT NULL,
  `GNP` float(10,2) DEFAULT NULL,
  `GNPOld` float(10,2) DEFAULT NULL,
  `LocalName` char(45) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `GovernmentForm` char(45) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `HeadOfState` char(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `Capital` int(11) DEFAULT NULL,
  `Code2` char(2) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  PRIMARY KEY (`Code`)
);


CREATE TABLE IF NOT EXISTS `countrylanguage` (
  `CountryCode` char(3) NOT NULL DEFAULT '',
  `Language` char(30) NOT NULL DEFAULT '',
  `IsOfficial` enum('T','F') NOT NULL DEFAULT 'F',
  `Percentage` float(4,1) NOT NULL DEFAULT '0.0',
  PRIMARY KEY (`CountryCode`,`Language`),
  KEY `CountryCode` (`CountryCode`)
) ;

CREATE TABLE IF NOT EXISTS `city` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` char(35) NOT NULL DEFAULT '',
  `CountryCode` char(3) NOT NULL DEFAULT '',
  `District` char(20) NOT NULL DEFAULT '',
  `Population` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `CountryCode` (`CountryCode`)
) ;
