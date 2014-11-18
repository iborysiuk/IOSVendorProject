-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Oct 22, 2014 at 07:51 PM
-- Server version: 5.6.14
-- PHP Version: 5.5.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `u733452522_vndr`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` varchar(23) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `encrypted_password` varchar(80) NOT NULL,
  `salt` varchar(10) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `unique_id` (`unique_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`uid`, `unique_id`, `name`, `email`, `encrypted_password`, `salt`, `created_at`, `updated_at`) VALUES
(1, '543ee476d32f39.54183910', '', 'sd@sd', 'ulTyRZHfbNpYqiarX3sLORSpngJiNGU5Y2VlMzk3', 'b4e9cee397', '2014-10-15 17:17:42', NULL),
(2, '543ee50e264599.58546290', '', 'borisjuk@mail.ru', 'qAZufil33Q7XbEh3aXZGzWHOhnk4ZDNhZDU5MThh', '8d3ad5918a', '2014-10-15 17:20:14', NULL),
(3, '543ee575536f20.82702864', 'yura', 'borisjuk.yuriy@gmail.com', 'in4gnyyJVxy7QNSIFjW7PwFuLB41NTBiYTZmODA4', '550ba6f808', '2014-10-15 17:21:57', NULL),
(4, '543ee5afa36208.06446034', 'serg', 'serg@gmail.com', 'p5EOi0HNCrbwVOtxsLasSbFj+IczMGRjMzczM2Nm', '30dc3733cf', '2014-10-15 17:22:55', NULL),
(5, '543ee5f57bd630.03706574', 'yura', 'example@gmail.com', 'JCF2Kn9i2iJk7i0NwVt6r1rrufYyMDg5NzFkMjll', '208971d29e', '2014-10-15 17:24:05', NULL),
(6, '543eea56c2f2e1.81651966', 'yura', 'ex@mail.ru', 'dM8VcbHOkwPERvyJHXtrGgjIWhoxMmI4Y2YwNTg3', '12b8cf0587', '2014-10-15 17:42:47', NULL),
(7, '54407598b28b49.71341441', 'yura', 'exc@exc.ca', 'hEG7yeTVE+IxUoawb1jPY2U70zZjZWUwNGI4YTg4', 'cee04b8a88', '2014-10-16 21:49:13', NULL),
(8, '5441c1762645f8.25161049', 'yura', 'exc1@exc.ca', 'mm+FRALG2oH2TKmuPu6iCDmgKLU5MzlmNjM2YTZj', '939f636a6c', '2014-10-17 21:25:11', NULL),
(9, '5441c68bd7dd25.22905394', 'yura', 'exc2@exc.ca', 'JQKIqcrj8Aoh3zegZcsQuiV/kAE3MTM1Yzg4MDJh', '7135c8802a', '2014-10-17 21:46:53', NULL),
(10, '544598378e0fd5.91737869', 'lam', 'lambtonn@gmail.com', '8Ka+NqJnU5BfQohttjfIwikK+qNmMTBlZDE3ZjU4', 'f10ed17f58', '2014-10-20 19:18:16', NULL),
(11, '5445989a1ed898.72387940', 'lam', 'labton@gmail.com', 'xzlZxGtKv9yj023/OQxz28/yvRNhYTdkMzA2YTlk', 'aa7d306a9d', '2014-10-20 19:19:54', NULL),
(12, '5447db998db3c6.63035301', '', '', '8nJ897GHsVZN2dugk/zJjqHFOMY0ZjExMGZkMWVh', '4f110fd1ea', '2014-10-22 12:30:17', NULL),
(13, '5447dbc457d4a9.87150191', 'yura', 'exc3@exc.ca', 'HmtwoY6F1krxGJxJOwSYcroFwr8wNjUyMWI0OTEw', '06521b4910', '2014-10-22 12:31:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE IF NOT EXISTS `vendors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8_unicode_ci NOT NULL,
  `email` text COLLATE utf8_unicode_ci NOT NULL,
  `phonenumber` text COLLATE utf8_unicode_ci NOT NULL,
  `country` text COLLATE utf8_unicode_ci NOT NULL,
  `city` text COLLATE utf8_unicode_ci NOT NULL,
  `address` text COLLATE utf8_unicode_ci NOT NULL,
  `postalcode` text COLLATE utf8_unicode_ci NOT NULL,
  `imgLink` text COLLATE utf8_unicode_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`id`, `name`, `email`, `phonenumber`, `country`, `city`, `address`, `postalcode`, `imgLink`, `createdAt`) VALUES
(1, 'Apple Canada', 'applesupport@apple.com', '905-513-800', 'Canada', 'Markham', '7495 Birchmount Road', 'L3R 5G2', 'http://vendors.t15.org/img/apple_logo.png', '2014-10-16 00:00:00'),
(2, 'Google Kitchener-Waterloo', 'googlecanada@gmail.ca', '519-880-2300', 'Canada', 'Kitchener', '151 Charles Street West', 'N2G 1H6', '', '2014-10-16 20:20:21'),
(3, 'Lambton', 'ibm@ibm.com', '1416708', 'Canada', 'Toronto', '256 Yorkland Rd', 'M2J 1S3', 'http://t1.gstatic.com/images?q=tbn:ANd9GcQkCKZ892m0Uu34e_OJc6d1hO2YC1-8GllWDod2E8oGYnDif73Avg', '2014-10-20 19:26:43'),
(4, 'Georgian college', 'georgiancollege@georgian.ca', '14167078571', 'Canada', 'Barrie', '1 Georgina Dr', 'L4M 1E9', 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSpBfBSFdHlKco_YqAwZtHx3ej6bKZ8XY9-nyC54esjvr-s9p4t3Qu-ur4', '2014-10-20 19:40:18'),
(5, 'Centennial College', 'centennial@college.ca', '+1 (416) 289-50-00', 'Canada', 'Toronto', '941 Progress Avenue', 'M1G 3V4', 'http://apprenticeshipcareerconnections.ca/wp-content/uploads/2012/01/Centennial_College_logo.png', '2014-10-22 12:53:25'),
(6, 'George Brown College', 'georgebrown@college.ca', '+1 (416) 125-45-78', 'Canada', 'Toronto', '341 King St E', 'M5T 2T9', 'http://upload.wikimedia.org/wikipedia/commons/thumb/6/69/George_Brown_College_logo.svg/220px-George_Brown_College_logo.svg.png', '2014-10-22 13:00:06');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
