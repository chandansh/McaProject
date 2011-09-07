/*
SQLyog - Free MySQL GUI v5.02
Host - 5.0.22-community-nt : Database - magicon
*********************************************************************
Server version : 5.0.22-community-nt
*/


create database if not exists `magicon`;

USE `magicon`;

/*Table structure for table `administrator_info` */

DROP TABLE IF EXISTS `administrator_info`;

CREATE TABLE `administrator_info` (
  `ad_id` varchar(20) default NULL,
  `ad_firstname` varchar(20) default NULL,
  `ad_lastname` varchar(20) default NULL,
  `ad_email` varchar(40) default NULL,
  `ad_phone` varchar(12) default NULL,
  `ad_address` varchar(40) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `administrator_info` */

/*Table structure for table `cart` */

DROP TABLE IF EXISTS `cart`;

CREATE TABLE `cart` (
  `cart_id` int(4) NOT NULL,
  `cust_id` char(20) default NULL,
  `pd_id` char(15) default NULL,
  `cart_qty` int(4) default NULL,
  `cart_date` date default NULL,
  PRIMARY KEY  (`cart_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cart` */

/*Table structure for table `category_info` */

DROP TABLE IF EXISTS `category_info`;

CREATE TABLE `category_info` (
  `cat_id` varchar(5) NOT NULL,
  `cat_name` varchar(15) default NULL,
  `cat_des` varchar(30) default NULL,
  PRIMARY KEY  (`cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `category_info` */

insert into `category_info` values 
('a','assoceries','assoceries of mobile'),
('b','battery','battery abc'),
('mo','mobile ','mobile phones');

/*Table structure for table `cust_info` */

DROP TABLE IF EXISTS `cust_info`;

CREATE TABLE `cust_info` (
  `cust_id` varchar(20) NOT NULL,
  `cust_firstname` varchar(20) default NULL,
  `cust_lastname` varchar(20) default NULL,
  `cust_dob` date default NULL,
  `cust_gender` varchar(10) default NULL,
  `cust_occupation` varchar(15) default NULL,
  `cust_email` varchar(40) default NULL,
  `cust_address` varchar(40) default NULL,
  `cust_nationality` varchar(15) default NULL,
  `cust_phone` varchar(12) default NULL,
  `cust_mobile` varchar(12) default NULL,
  `cust_setdate` date default NULL,
  `cust_mailupdate` date default NULL,
  `cust_password` varchar(10) default NULL,
  PRIMARY KEY  (`cust_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cust_info` */

insert into `cust_info` values 
('a','a','a','1990-12-10','male','student','a','a','indian','a','a','2011-07-30','2011-07-30','a'),
('Administrator','','','1990-12-30','','','','','','','','0000-00-00','0000-00-00','admin'),
('b','b','b','1990-12-10','male','business','b','b','indian','b','b','2010-08-30','2010-08-30','b'),
('cks','chandan','sharma','1988-03-01','male','student','chandansharmamca@gmail.com','nangloi','indian','9971175765','9716846082','2010-08-30','2010-08-30','aditya');

/*Table structure for table `order_detail` */

DROP TABLE IF EXISTS `order_detail`;

CREATE TABLE `order_detail` (
  `order_id` int(4) default NULL,
  `pd_id` varchar(10) default NULL,
  `qty` int(4) default NULL,
  KEY `FK_order_detail` (`order_id`),
  CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order_table` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `order_detail` */

insert into `order_detail` values 
(9563,'b',2),
(9563,'c',2),
(6360,'n1100hf',2),
(6360,'n97',5),
(6360,'sw760',2),
(729,'n2525',2),
(2061,'sw760',1),
(2061,'1',1),
(6538,'b',1),
(4987,'sw760',2);

/*Table structure for table `order_table` */

DROP TABLE IF EXISTS `order_table`;

CREATE TABLE `order_table` (
  `order_id` int(4) NOT NULL,
  `cust_id` varchar(20) default NULL,
  `total_amount` double(8,2) default NULL,
  `order_date` date default NULL,
  `credit_card_no` varchar(22) default NULL,
  `holder_name` varchar(20) default NULL,
  `exp_date` date default NULL,
  `ship_name` varchar(30) default NULL,
  `ship_address` varchar(50) default NULL,
  `ship_phone` varchar(12) default NULL,
  `ship_mobile` varchar(12) default NULL,
  `ship_email` varchar(50) default NULL,
  `status` varchar(50) default NULL,
  PRIMARY KEY  (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `order_table` */

insert into `order_table` values 
(729,'cks',7000.00,'2010-09-10','12345678901234567890','chadnan','2010-02-28','chandan sharma','nangloi','9971175765','9716846082','chandansharmamca@gmail.com','completed'),
(2061,'cks',21000.00,'2010-09-10','12345678901234567890','chandan','2010-01-19','chandan sharma','nangloi','9971175765','9716846082','chandansharmamca@gmail.com','posted'),
(4987,'a',27000.00,'2010-09-11','12345678901234567890','chadnan','2011-02-28','a a','a','a','a','a','posted'),
(6360,'cks',87700.00,'2010-09-10','12345678901234567890','chadnan','2010-11-29','chandan sharma','nangloi','9971175765','9716846082','chandansharmamca@gmail.com','posted'),
(6538,'a',8500.00,'2010-09-10','12345678901234567890','ada','2010-01-28','a a','a','a','a','a','posted'),
(9563,'a',22400.00,'2010-09-08','12345678901234567890','chandan','2012-03-19','a a','a','a','a','a','completed');

/*Table structure for table `product_info` */

DROP TABLE IF EXISTS `product_info`;

CREATE TABLE `product_info` (
  `pd_id` varchar(10) NOT NULL,
  `pd_name` varchar(20) default NULL,
  `cat_id` varchar(5) default NULL,
  `pd_brand` varchar(15) default NULL COMMENT 'product description',
  `pd_price` double(8,2) default NULL,
  `pd_qty` int(4) default NULL,
  `pd_date` date default NULL,
  `pd_photo_path` varchar(80) default NULL,
  `pd_des` varchar(50) default NULL,
  PRIMARY KEY  (`pd_id`),
  KEY `FK_product_info` (`cat_id`),
  CONSTRAINT `product_info_ibfk_1` FOREIGN KEY (`cat_id`) REFERENCES `category_info` (`cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `product_info` */

insert into `product_info` values 
('1','nokia6600','mo','Nokia',7500.00,10,'2010-09-04','product_images/1_Nokia1616_pbilogo.jpg','nokia new image'),
('b','sw550i','a','Sony Ericsson',8500.00,6,'2010-09-04','product_images/1_SamsungS3370Nano_pbilogo.jpg','sony new model'),
('c','c168','mo','Motorola',2700.00,10,'2010-09-04','product_images/1_Nokia2690_pbilogo.jpg','motorola best phone'),
('lgd580','LGGD580_pbi','mo','LG',9300.00,3,'2010-09-07','product_images/1_LGGD580_pbilogo.gif','lg most effective'),
('n1100hf','nokia 1100 handfree','a','Nokia',350.00,25,'2010-09-05','product_images/1_Headset_H4718_pbilogo.5x8.5cm.JPG','this hands free is good'),
('n2525','nokia 2525b','mo','Nokia',3500.51,15,'2010-09-05','product_images/1_Nokia7230_pbilogo.jpg','new arrive'),
('n97','nokia n97','mo','Nokia',12000.40,15,'2010-09-05','product_images/1_GS290Cookiefresh_pbilogo.jpg','best of nokia'),
('n97mini','nokia N97 mini','mo','Nokia',12590.00,10,'2010-09-05','product_images/1_Nokia_N97_mini_pbilogo.jpg','nokia n series mobile'),
('sw760','sony er w760i','mo','Sony Ericsson',13500.00,5,'2010-09-05','product_images/1_GS500vCookiePlus_pbilogo.jpg','our mobile');

/*Table structure for table `query_table` */

DROP TABLE IF EXISTS `query_table`;

CREATE TABLE `query_table` (
  `query_id` int(4) NOT NULL,
  `query_userid` varchar(20) default NULL,
  `query_des` varchar(50) default NULL,
  `query_ans` varchar(50) default NULL,
  PRIMARY KEY  (`query_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `query_table` */

/*Table structure for table `ringtones` */

DROP TABLE IF EXISTS `ringtones`;

CREATE TABLE `ringtones` (
  `r_id` int(4) NOT NULL,
  `r_title` varchar(50) default NULL,
  `r_album` varchar(50) default NULL,
  `r_file_Name` varchar(50) default NULL,
  `r_path` varchar(80) default NULL,
  `add_date` date default NULL,
  PRIMARY KEY  (`r_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `ringtones` */

insert into `ringtones` values 
(92,'ragupati ragav','kuch kuch hota hai','RACHUPATI RAGHAV .mp3','ring_tones/RACHUPATI RAGHAV .mp3','2010-09-07'),
(898,'police message','police','Police_Message.mp3','ring_tones/Police_Message.mp3','2010-09-05'),
(2576,'airtel blackberry','airtel','Airtel Blackberry Pearl Bass Boost.mp3','ring_tones/Airtel Blackberry Pearl Bass Boost.mp3','2010-09-05'),
(3477,'blue666','blue','666.mp3','ring_tones/666.mp3','2010-09-07'),
(3803,'yun hi chala chal rahi','swadesh','Yun hi chala chal rahi.mp3','ring_tones/Yun hi chala chal rahi.mp3','2010-09-05'),
(4563,'radha kaise na jale','lagaan','Radha kaise na jale.mp3','ring_tones/Radha kaise na jale.mp3','2010-09-05'),
(5114,'o rey chhori','lagaan','O Rey Chohri.mp3','ring_tones/O Rey Chohri.mp3','2010-09-05'),
(7493,'kyon kisi ko','tere nam','kyon kisi ko (tri.mp3','ring_tones/kyon kisi ko (tri.mp3','2010-09-07');

/*Table structure for table `wallpaper` */

DROP TABLE IF EXISTS `wallpaper`;

CREATE TABLE `wallpaper` (
  `w_id` int(4) NOT NULL,
  `w_title` varchar(50) default NULL,
  `w_file_name` varchar(50) default NULL,
  `w_path` varchar(80) default NULL,
  `add_date` date default NULL,
  PRIMARY KEY  (`w_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wallpaper` */

insert into `wallpaper` values 
(2447,'flower','F.JPG','wallpaper/F.JPG','2010-09-10'),
(5372,'om2','CO9022850.jpg','wallpaper/CO9022850.jpg','2010-09-10'),
(7902,'krishna','Krishna.jpg','wallpaper/Krishna.jpg','2010-09-10'),
(8263,'om','OM.JPG','wallpaper/OM.JPG','2010-09-10'),
(8366,'mars','030827_hubble_mars_1_02,0.jpg','wallpaper/030827_hubble_mars_1_02,0.jpg','2010-09-10'),
(9598,'sea','At Sea.jpg','wallpaper/At Sea.jpg','2010-09-10'),
(9647,'skyline','Skyline.jpg','wallpaper/Skyline.jpg','2010-09-10'),
(9687,'india','ind5s.jpg','wallpaper/ind5s.jpg','2010-09-10'),
(9881,'heart','aflame1cp[1].gif','wallpaper/aflame1cp[1].gif','2010-09-10'),
(9938,'holi','holi9.jpg','wallpaper/holi9.jpg','2010-09-10');

/*Table structure for table `wish_list` */

DROP TABLE IF EXISTS `wish_list`;

CREATE TABLE `wish_list` (
  `w_id` int(4) NOT NULL,
  `cust_id` varchar(20) default NULL,
  `pd_id` varchar(15) default NULL,
  PRIMARY KEY  (`w_id`),
  KEY `FK_wish_list` (`cust_id`),
  KEY `FK_wish_list_product` (`pd_id`),
  CONSTRAINT `wish_list_ibfk_1` FOREIGN KEY (`cust_id`) REFERENCES `cust_info` (`cust_id`),
  CONSTRAINT `wish_list_ibfk_2` FOREIGN KEY (`pd_id`) REFERENCES `product_info` (`pd_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wish_list` */

insert into `wish_list` values 
(1262,'a','n97'),
(6161,'cks','sw760'),
(6647,'a','n97mini'),
(7365,'a','c'),
(8598,'cks','n97mini'),
(9167,'cks','n97'),
(9259,'a','n2525');
