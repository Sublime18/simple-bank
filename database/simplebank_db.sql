/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 10.5.5-MariaDB : Database - simplebank_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`simplebank_db` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `simplebank_db`;

/*Table structure for table `account` */

DROP TABLE IF EXISTS `account`;

CREATE TABLE `account` (
  `username` char(16) NOT NULL,
  `token` char(40) NOT NULL,
  `full_name` varchar(40) NOT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`username`),
  UNIQUE KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `account` */

insert  into `account`(`username`,`token`,`full_name`,`balance`) values 
('jaksem','aflBEUbZ3CBVhPNJmb3Gkbg3QUU7Fu2j8jFGlg2p','Jaka Sembung',206.70),
('milkyman','G9Cd7g1xw4P58EO9CRUZZareRwO5kLEt24Pq5N0Q','Milkyman',100.00),
('wirosableng','Q7YHVDU5BQUkAfax1fcTEEGtu1O4L4hM1idBKKtF','Wiro Sableng',-6.70);

/*Table structure for table `transaction` */

DROP TABLE IF EXISTS `transaction`;

CREATE TABLE `transaction` (
  `id` char(40) NOT NULL,
  `sender` char(16) NOT NULL,
  `recipient` char(16) NOT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `notes` varchar(128) DEFAULT NULL,
  `status` char(20) NOT NULL DEFAULT 'success',
  `issued_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `from` (`sender`),
  KEY `recipient` (`recipient`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`sender`) REFERENCES `account` (`username`),
  CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`recipient`) REFERENCES `account` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `transaction` */

insert  into `transaction`(`id`,`sender`,`recipient`,`amount`,`notes`,`status`,`issued_at`) values 
('ab7A35V1pRfjtJUP4A0sSs5hdfHYYoT38xReSSv1','wirosableng','jaksem',10.00,'Ganti belanja di kantin','success','2019-12-13 12:08:01'),
('EH77SWQNktBbRDa71qvCk11KBx3BeXlOQ48UWYji','jaksem','wirosableng',5.00,'Beli kacang asin','success','2019-12-13 13:35:20'),
('h3rsImhTdTLE743peBBaZNM5s8b8BiKwFY0vw49o','wirosableng','jaksem',7.50,'Voucher pulsa','failed','2019-12-13 16:07:02'),
('HrxO0LEcZpGLbl6k5gbi1maCI5u1If4zQbnsM9kI','wirosableng','jaksem',2.00,NULL,'success','2019-12-13 12:45:07'),
('WIJhVYTmh8tq4miTG6n6RNO1atcNB3gjxwagxVEX','wirosableng','milkyman',3.50,'Ganti uang beli kertas A4','success','2019-12-13 13:35:46'),
('XFh80V6Ww1PvqKxB0spH2LA5Rxlp7AgPu8G0OzJ6','milkyman','jaksem',4.20,NULL,'success','2019-12-13 13:33:59');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
