-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 16, 2016 at 01:50 AM
-- Server version: 5.7.13-0ubuntu0.16.04.2
-- PHP Version: 7.0.8-0ubuntu0.16.04.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bibliotheque`
--

-- --------------------------------------------------------

--
-- Table structure for table `element`
--

CREATE TABLE `element` (
  `id_element` int(11) NOT NULL,
  `id_narrative` int(11) NOT NULL,
  `type` enum('narrative','situation','transition','') COLLATE utf8_bin NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `element`
--

INSERT INTO `element` (`id_element`, `id_narrative`, `type`, `date`) VALUES
(1, 1, 'narrative', '2016-05-21 21:03:23'),
(3, 3, 'narrative', '2016-05-21 21:03:51'),
(4, 4, 'narrative', '2016-05-21 21:03:51'),
(5, 1, 'situation', '2016-05-21 21:08:42'),
(7, 3, 'situation', '2016-05-21 21:08:42'),
(8, 4, 'situation', '2016-05-21 21:08:42'),
(9, 4, 'situation', '2016-05-21 21:15:58'),
(10, 4, 'situation', '2016-05-21 21:15:58'),
(11, 4, 'transition', '2016-05-21 21:15:58'),
(12, 4, 'transition', '2016-05-21 21:15:58'),
(23, 5, 'narrative', '2016-06-29 00:59:46'),
(24, 5, 'situation', '2016-06-29 00:59:46'),
(25, 5, 'situation', '2016-06-29 01:01:47'),
(26, 5, 'situation', '2016-06-29 01:01:47'),
(27, 5, 'transition', '2016-06-29 01:01:47'),
(1266, 19, 'narrative', '2016-08-12 15:14:26'),
(1267, 19, 'situation', '2016-08-12 15:14:26'),
(1268, 19, 'situation', '2016-08-12 15:14:26'),
(1269, 19, 'situation', '2016-08-12 15:14:26'),
(1270, 19, 'situation', '2016-08-12 15:14:26'),
(1271, 19, 'situation', '2016-08-12 15:14:26'),
(1272, 19, 'situation', '2016-08-12 15:14:26'),
(1273, 19, 'situation', '2016-08-12 15:14:26'),
(1274, 19, 'situation', '2016-08-12 15:14:26'),
(1275, 19, 'situation', '2016-08-12 15:14:26'),
(1276, 19, 'situation', '2016-08-12 15:14:26'),
(1277, 19, 'situation', '2016-08-12 15:14:26'),
(1278, 19, 'situation', '2016-08-12 15:14:26'),
(1279, 19, 'situation', '2016-08-12 15:14:26'),
(1280, 19, 'situation', '2016-08-12 15:14:26'),
(1281, 19, 'situation', '2016-08-12 15:14:26'),
(1282, 19, 'situation', '2016-08-12 15:14:26'),
(1283, 19, 'situation', '2016-08-12 15:14:26'),
(1284, 19, 'situation', '2016-08-12 15:14:26'),
(1285, 19, 'situation', '2016-08-12 15:14:26'),
(1286, 19, 'situation', '2016-08-12 15:14:26'),
(1287, 19, 'situation', '2016-08-12 15:14:26'),
(1288, 19, 'situation', '2016-08-12 15:14:26'),
(1289, 19, 'situation', '2016-08-12 15:14:26'),
(1290, 19, 'situation', '2016-08-12 15:14:26'),
(1291, 19, 'situation', '2016-08-12 15:14:26'),
(1292, 19, 'situation', '2016-08-12 15:14:26'),
(1293, 19, 'situation', '2016-08-12 15:14:26'),
(1294, 19, 'transition', '2016-08-12 15:14:26'),
(1295, 19, 'transition', '2016-08-12 15:14:26'),
(1296, 19, 'transition', '2016-08-12 15:14:26'),
(1297, 19, 'transition', '2016-08-12 15:14:26'),
(1298, 19, 'transition', '2016-08-12 15:14:26'),
(1299, 19, 'transition', '2016-08-12 15:14:26'),
(1300, 19, 'transition', '2016-08-12 15:14:26'),
(1301, 19, 'transition', '2016-08-12 15:14:26'),
(1302, 19, 'transition', '2016-08-12 15:14:26'),
(1303, 19, 'transition', '2016-08-12 15:14:26'),
(1304, 19, 'transition', '2016-08-12 15:14:26'),
(1305, 19, 'transition', '2016-08-12 15:14:26'),
(1306, 19, 'transition', '2016-08-12 15:14:26'),
(1307, 19, 'transition', '2016-08-12 15:14:26'),
(1308, 19, 'transition', '2016-08-12 15:14:26'),
(1309, 19, 'transition', '2016-08-12 15:14:26'),
(1310, 19, 'transition', '2016-08-12 15:14:26'),
(1311, 19, 'transition', '2016-08-12 15:14:27'),
(1312, 19, 'transition', '2016-08-12 15:14:27'),
(1313, 19, 'transition', '2016-08-12 15:14:27'),
(1314, 19, 'transition', '2016-08-12 15:14:27'),
(1315, 19, 'transition', '2016-08-12 15:14:27'),
(1316, 19, 'transition', '2016-08-12 15:14:27'),
(1317, 19, 'transition', '2016-08-12 15:14:27'),
(1318, 19, 'transition', '2016-08-12 15:14:27'),
(1319, 19, 'transition', '2016-08-12 15:14:27'),
(1320, 19, 'transition', '2016-08-12 15:14:27'),
(1321, 19, 'transition', '2016-08-12 15:14:27'),
(1322, 19, 'transition', '2016-08-12 15:14:27'),
(1323, 19, 'transition', '2016-08-12 15:14:27'),
(1324, 19, 'transition', '2016-08-12 15:14:27'),
(1325, 19, 'transition', '2016-08-12 15:14:27'),
(1326, 19, 'transition', '2016-08-12 15:14:27'),
(1327, 19, 'transition', '2016-08-12 15:14:27'),
(1328, 19, 'transition', '2016-08-12 15:14:27'),
(1329, 19, 'transition', '2016-08-12 15:14:27'),
(1330, 19, 'transition', '2016-08-12 15:14:27'),
(1331, 19, 'transition', '2016-08-12 15:14:27'),
(1332, 19, 'transition', '2016-08-12 15:14:27'),
(1333, 19, 'transition', '2016-08-12 15:14:27'),
(1334, 19, 'transition', '2016-08-12 15:14:27'),
(1335, 19, 'transition', '2016-08-12 15:14:27'),
(1336, 19, 'transition', '2016-08-12 15:14:27'),
(1337, 19, 'transition', '2016-08-12 15:14:27'),
(1338, 19, 'transition', '2016-08-12 15:14:27'),
(1391, 33, 'narrative', '2016-10-02 12:22:40'),
(1392, 33, 'situation', '2016-10-02 12:22:40'),
(1393, 33, 'situation', '2016-10-02 12:22:40'),
(1394, 33, 'situation', '2016-10-02 12:22:40'),
(1395, 33, 'transition', '2016-10-02 12:22:40'),
(1396, 33, 'transition', '2016-10-02 12:22:41'),
(1397, 33, 'situation', '2016-10-13 23:09:56'),
(1398, 33, 'situation', '2016-10-13 23:10:35'),
(1399, 33, 'situation', '2016-10-13 23:27:40'),
(1400, 33, 'situation', '2016-10-13 23:33:37'),
(1401, 33, 'situation', '2016-10-13 23:35:30'),
(1402, 33, 'situation', '2016-10-13 23:36:49'),
(1403, 33, 'situation', '2016-10-13 23:37:15'),
(1404, 33, 'situation', '2016-10-13 23:37:52'),
(1405, 33, 'situation', '2016-10-13 23:37:58'),
(1406, 33, 'situation', '2016-10-13 23:38:04'),
(1407, 33, 'situation', '2016-10-13 23:39:40'),
(1408, 33, 'situation', '2016-10-13 23:39:48'),
(1409, 33, 'transition', '2016-10-15 15:28:56'),
(1410, 33, 'transition', '2016-10-15 15:31:22'),
(1411, 33, 'transition', '2016-10-15 15:31:50'),
(1412, 33, 'situation', '2016-10-15 16:03:51'),
(1413, 33, 'situation', '2016-10-15 16:09:51'),
(1414, 33, 'situation', '2016-10-15 16:10:39'),
(1415, 33, 'situation', '2016-10-15 16:17:44'),
(1416, 33, 'transition', '2016-10-15 16:17:47'),
(1417, 33, 'transition', '2016-10-15 16:17:48'),
(1418, 33, 'transition', '2016-10-15 16:17:54'),
(1419, 33, 'situation', '2016-10-15 16:19:41'),
(1420, 33, 'transition', '2016-10-15 16:19:48'),
(1421, 33, 'transition', '2016-10-15 16:19:58'),
(1422, 33, 'transition', '2016-10-15 16:20:07');

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE `log` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sql` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `log`
--

INSERT INTO `log` (`id`, `date`, `sql`) VALUES
(1, '2016-09-24 01:16:24', 'SELECT title, abstract, date FROM narrative WHERE id_narrative = \'19\''),
(2, '2016-09-24 01:16:24', 'SELECT m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(3, '2016-09-24 01:16:24', 'SELECT id_narrative, path FROM story WHERE id_story = \'17\''),
(4, '2016-09-24 01:16:38', 'SELECT current FROM story WHERE id_story = \'17\''),
(5, '2016-09-24 01:16:38', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(6, '2016-09-24 01:16:38', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(7, '2016-09-24 01:22:26', 'SELECT e.id_element, e.type, e.name, e.from, e.to, w.text, w.end, w.choice, w.date, m.name AS author\n			FROM element e\n				INNER JOIN writing w ON w.id_element = e.id_element\n				INNER JOIN member m ON m.id_member = w.id_member\n			WHERE e.id_narrative = \'19\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)\n				AND w.type IN (\'create\', \'modify\')'),
(8, '2016-09-24 01:23:00', 'SELECT title, abstract, date FROM narrative WHERE id_narrative = \'19\''),
(9, '2016-09-24 01:23:00', 'SELECT m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(10, '2016-09-24 01:23:00', 'SELECT id_narrative, path FROM story WHERE id_story = \'17\''),
(11, '2016-09-24 01:23:03', 'SELECT current FROM story WHERE id_story = \'17\''),
(12, '2016-09-24 01:23:03', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(13, '2016-09-24 01:23:03', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(14, '2016-09-24 01:25:26', 'SELECT title, abstract, date FROM narrative WHERE id_narrative = \'19\''),
(15, '2016-09-24 01:25:26', 'SELECT m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(16, '2016-09-24 01:25:26', 'SELECT id_narrative, path FROM story WHERE id_story = \'17\''),
(17, '2016-09-24 01:25:29', 'SELECT current FROM story WHERE id_story = \'17\''),
(18, '2016-09-24 01:25:29', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(19, '2016-09-24 01:25:29', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(20, '2016-09-24 01:25:58', 'SELECT title, abstract, date FROM narrative WHERE id_narrative = \'19\''),
(21, '2016-09-24 01:25:58', 'SELECT m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(22, '2016-09-24 01:25:58', 'SELECT id_narrative, path FROM story WHERE id_story = \'17\''),
(23, '2016-09-24 01:26:01', 'SELECT current FROM story WHERE id_story = \'17\''),
(24, '2016-09-24 01:26:01', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(25, '2016-09-24 01:26:01', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(26, '2016-09-24 01:27:43', 'SELECT title, abstract, date FROM narrative WHERE id_narrative = \'19\''),
(27, '2016-09-24 01:27:43', 'SELECT m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(28, '2016-09-24 01:27:43', 'SELECT id_narrative, path FROM story WHERE id_story = \'17\''),
(29, '2016-09-24 01:27:46', 'SELECT current FROM story WHERE id_story = \'17\''),
(30, '2016-09-24 01:27:46', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(31, '2016-09-24 01:27:46', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(32, '2016-09-24 01:28:07', 'SELECT title, abstract, date FROM narrative WHERE id_narrative = \'19\''),
(33, '2016-09-24 01:28:07', 'SELECT m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(34, '2016-09-24 01:28:07', 'SELECT id_narrative, path FROM story WHERE id_story = \'17\''),
(35, '2016-09-24 01:28:09', 'SELECT current FROM story WHERE id_story = \'17\''),
(36, '2016-09-24 01:28:09', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(37, '2016-09-24 01:28:09', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(38, '2016-09-24 01:29:03', 'SELECT title, abstract, date FROM narrative WHERE id_narrative = \'19\''),
(39, '2016-09-24 01:29:03', 'SELECT m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(40, '2016-09-24 01:29:03', 'SELECT id_narrative, path FROM story WHERE id_story = \'17\''),
(41, '2016-09-24 01:29:06', 'SELECT current FROM story WHERE id_story = \'17\''),
(42, '2016-09-24 01:29:06', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(43, '2016-09-24 01:29:06', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(44, '2016-09-24 01:31:53', 'SELECT title, abstract, date FROM narrative WHERE id_narrative = \'19\''),
(45, '2016-09-24 01:31:53', 'SELECT m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(46, '2016-09-24 01:31:53', 'SELECT id_narrative, path FROM story WHERE id_story = \'17\''),
(47, '2016-09-24 01:31:56', 'SELECT current FROM story WHERE id_story = \'17\''),
(48, '2016-09-24 01:31:56', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(49, '2016-09-24 01:31:56', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(50, '2016-09-24 01:32:13', 'SELECT title, abstract, date FROM narrative WHERE id_narrative = \'19\''),
(51, '2016-09-24 01:32:13', 'SELECT m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(52, '2016-09-24 01:32:13', 'SELECT id_narrative, path FROM story WHERE id_story = \'17\''),
(53, '2016-09-24 01:32:16', 'SELECT current FROM story WHERE id_story = \'17\''),
(54, '2016-09-24 01:32:16', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(55, '2016-09-24 01:32:16', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(56, '2016-09-24 01:32:31', 'SELECT title, abstract, date FROM narrative WHERE id_narrative = \'19\''),
(57, '2016-09-24 01:32:31', 'SELECT m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(58, '2016-09-24 01:32:31', 'SELECT id_narrative, path FROM story WHERE id_story = \'17\''),
(59, '2016-09-24 01:32:33', 'SELECT current FROM story WHERE id_story = \'17\''),
(60, '2016-09-24 01:32:33', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(61, '2016-09-24 01:32:33', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(62, '2016-09-24 01:32:48', 'SELECT title, abstract, date FROM narrative WHERE id_narrative = \'19\''),
(63, '2016-09-24 01:32:48', 'SELECT m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(64, '2016-09-24 01:32:48', 'SELECT id_narrative, path FROM story WHERE id_story = \'17\''),
(65, '2016-09-24 01:32:50', 'SELECT current FROM story WHERE id_story = \'17\''),
(66, '2016-09-24 01:32:50', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(67, '2016-09-24 01:32:50', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(68, '2016-09-24 01:33:05', 'SELECT title, abstract, date FROM narrative WHERE id_narrative = \'19\''),
(69, '2016-09-24 01:33:05', 'SELECT m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(70, '2016-09-24 01:33:05', 'SELECT id_narrative, path FROM story WHERE id_story = \'17\''),
(71, '2016-09-24 01:33:07', 'SELECT current FROM story WHERE id_story = \'17\''),
(72, '2016-09-24 01:33:07', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(73, '2016-09-24 01:33:07', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(74, '2016-09-24 01:34:49', 'SELECT title, abstract, date FROM narrative WHERE id_narrative = \'19\''),
(75, '2016-09-24 01:34:49', 'SELECT m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(76, '2016-09-24 01:34:49', 'SELECT id_narrative, path FROM story WHERE id_story = \'17\''),
(77, '2016-09-24 01:34:51', 'SELECT current FROM story WHERE id_story = \'17\''),
(78, '2016-09-24 01:34:51', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(79, '2016-09-24 01:34:51', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(80, '2016-09-24 01:37:12', 'SELECT title, abstract, date FROM narrative WHERE id_narrative = \'19\''),
(81, '2016-09-24 01:37:12', 'SELECT m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(82, '2016-09-24 01:37:12', 'SELECT id_narrative, path FROM story WHERE id_story = \'17\''),
(83, '2016-09-24 01:37:19', 'SELECT current FROM story WHERE id_story = \'17\''),
(84, '2016-09-24 01:37:19', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(85, '2016-09-24 01:37:19', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(86, '2016-09-24 01:40:18', 'SELECT title, abstract, date FROM narrative WHERE id_narrative = \'19\''),
(87, '2016-09-24 01:40:18', 'SELECT m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(88, '2016-09-24 01:40:18', 'SELECT id_narrative, path FROM story WHERE id_story = \'17\''),
(89, '2016-09-24 01:40:22', 'SELECT current FROM story WHERE id_story = \'17\''),
(90, '2016-09-24 01:40:22', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(91, '2016-09-24 01:40:22', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(92, '2016-09-24 01:40:28', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'introduction\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(93, '2016-09-24 01:40:28', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'introduction\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(94, '2016-09-24 01:40:58', 'SELECT title, abstract, date FROM narrative WHERE id_narrative = \'19\''),
(95, '2016-09-24 01:40:58', 'SELECT m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(96, '2016-09-24 01:40:58', 'SELECT id_narrative, path FROM story WHERE id_story = \'17\''),
(97, '2016-09-24 01:41:01', 'SELECT current FROM story WHERE id_story = \'17\''),
(98, '2016-09-24 01:41:01', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(99, '2016-09-24 01:41:01', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(100, '2016-09-24 01:41:02', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'introduction\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(101, '2016-09-24 01:41:02', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'introduction\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(102, '2016-09-24 01:41:03', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'salle\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(103, '2016-09-24 01:41:03', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'salle\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(104, '2016-09-24 01:41:05', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(105, '2016-09-24 01:41:05', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(106, '2016-09-24 01:41:06', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(107, '2016-09-24 01:41:06', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(108, '2016-09-24 01:41:08', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(109, '2016-09-24 01:41:08', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(110, '2016-09-24 01:41:08', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(111, '2016-09-24 01:41:08', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(112, '2016-09-24 01:41:08', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(113, '2016-09-24 01:41:08', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(114, '2016-09-24 01:41:10', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(115, '2016-09-24 01:41:10', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(116, '2016-09-24 01:41:15', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(117, '2016-09-24 01:41:15', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(118, '2016-09-24 01:41:15', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(119, '2016-09-24 01:41:15', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(120, '2016-09-24 01:41:15', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(121, '2016-09-24 01:41:15', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(122, '2016-09-24 01:41:47', 'SELECT title, abstract, date FROM narrative WHERE id_narrative = \'19\''),
(123, '2016-09-24 01:41:47', 'SELECT m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(124, '2016-09-24 01:41:47', 'SELECT id_narrative, path FROM story WHERE id_story = \'17\''),
(125, '2016-09-24 01:41:48', 'SELECT current FROM story WHERE id_story = \'17\''),
(126, '2016-09-24 01:41:48', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(127, '2016-09-24 01:41:48', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(128, '2016-09-24 01:41:50', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'introduction\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(129, '2016-09-24 01:41:50', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'introduction\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(130, '2016-09-24 01:41:50', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'salle\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(131, '2016-09-24 01:41:50', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'salle\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(132, '2016-09-24 01:41:51', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(133, '2016-09-24 01:41:51', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(134, '2016-09-24 01:41:51', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(135, '2016-09-24 01:41:51', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(136, '2016-09-24 01:41:52', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(137, '2016-09-24 01:41:52', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(138, '2016-09-24 01:42:10', 'SELECT title, abstract, date FROM narrative WHERE id_narrative = \'19\''),
(139, '2016-09-24 01:42:10', 'SELECT m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(140, '2016-09-24 01:42:10', 'SELECT id_narrative, path FROM story WHERE id_story = \'17\''),
(141, '2016-09-24 01:42:14', 'SELECT current FROM story WHERE id_story = \'17\''),
(142, '2016-09-24 01:42:14', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(143, '2016-09-24 01:42:14', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(144, '2016-09-24 01:42:15', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'introduction\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(145, '2016-09-24 01:42:15', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'introduction\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(146, '2016-09-24 01:42:16', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'salle\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(147, '2016-09-24 01:42:16', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'salle\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(148, '2016-09-24 01:42:16', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'fenetre\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(149, '2016-09-24 01:42:16', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'fenetre\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(150, '2016-09-24 01:42:18', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'salle\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(151, '2016-09-24 01:42:18', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'salle\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(152, '2016-09-24 01:42:22', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(153, '2016-09-24 01:42:22', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(154, '2016-09-24 01:42:24', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(155, '2016-09-24 01:42:24', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(156, '2016-09-24 01:42:25', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(157, '2016-09-24 01:42:25', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(158, '2016-09-24 01:42:59', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(159, '2016-09-24 01:42:59', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(160, '2016-09-24 01:43:02', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(161, '2016-09-24 01:43:02', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(162, '2016-09-24 01:43:24', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(163, '2016-09-24 01:43:24', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(164, '2016-09-24 01:45:26', 'SELECT title, abstract, date FROM narrative WHERE id_narrative = \'19\''),
(165, '2016-09-24 01:45:26', 'SELECT m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(166, '2016-09-24 01:45:26', 'SELECT id_narrative, path FROM story WHERE id_story = \'17\''),
(167, '2016-09-24 01:45:29', 'SELECT current FROM story WHERE id_story = \'17\''),
(168, '2016-09-24 01:45:29', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(169, '2016-09-24 01:45:29', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(170, '2016-09-24 01:45:31', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'introduction\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(171, '2016-09-24 01:45:31', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'introduction\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(172, '2016-09-24 01:45:32', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'salle\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(173, '2016-09-24 01:45:32', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'salle\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(174, '2016-09-24 01:45:33', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(175, '2016-09-24 01:45:33', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(176, '2016-09-24 01:45:35', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(177, '2016-09-24 01:45:35', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(178, '2016-09-24 01:45:36', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'boite\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(179, '2016-09-24 01:45:36', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'boite\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(180, '2016-09-24 01:45:41', 'SELECT title, abstract, date FROM narrative WHERE id_narrative = \'19\''),
(181, '2016-09-24 01:45:41', 'SELECT m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(182, '2016-09-24 01:45:41', 'SELECT id_narrative, path FROM story WHERE id_story = \'17\''),
(183, '2016-09-24 01:45:47', 'SELECT current FROM story WHERE id_story = \'17\''),
(184, '2016-09-24 01:45:47', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(185, '2016-09-24 01:45:47', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'start\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(186, '2016-09-24 01:45:48', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'introduction\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(187, '2016-09-24 01:45:48', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'introduction\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(188, '2016-09-24 01:45:49', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'salle\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(189, '2016-09-24 01:45:49', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'salle\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(190, '2016-09-24 01:45:50', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(191, '2016-09-24 01:45:50', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(192, '2016-09-24 01:45:52', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(193, '2016-09-24 01:45:52', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(194, '2016-09-24 01:45:56', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'boite\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(195, '2016-09-24 01:45:56', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'boite\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(196, '2016-09-24 01:45:59', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(197, '2016-09-24 01:45:59', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(198, '2016-09-24 01:46:02', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'encyclopedie\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(199, '2016-09-24 01:46:02', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'encyclopedie\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(200, '2016-09-24 01:46:03', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(201, '2016-09-24 01:46:03', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'cabinet_choix\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(202, '2016-09-24 01:46:08', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'telecom\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(203, '2016-09-24 01:46:08', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'telecom\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(204, '2016-09-24 01:46:12', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'telecom_2\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(205, '2016-09-24 01:46:12', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'telecom_2\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(206, '2016-09-24 01:46:16', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'telecom_3\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(207, '2016-09-24 01:46:16', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'telecom_3\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(208, '2016-09-24 01:46:21', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'telecom_4\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(209, '2016-09-24 01:46:21', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'telecom_4\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)');
INSERT INTO `log` (`id`, `date`, `sql`) VALUES
(210, '2016-09-24 01:46:23', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'experience_2\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(211, '2016-09-24 01:46:23', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'experience_2\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(212, '2016-09-24 01:46:40', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'experience_3\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(213, '2016-09-24 01:46:40', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'experience_3\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(214, '2016-09-24 01:46:48', 'SELECT w.text FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'situation\' AND e.name = \'echapper\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(215, '2016-09-24 01:46:48', 'SELECT e.to, w.choice, w.type FROM element e\n				INNER JOIN writing w ON e.id_element = w.id_element\n			WHERE e.id_narrative = \'19\' AND e.type = \'transition\' AND e.from = \'echapper\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)'),
(216, '2016-09-24 11:21:26', 'SELECT id_narrative, title, abstract, date FROM narrative '),
(217, '2016-09-24 11:21:26', 'SELECT m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'1\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(218, '2016-09-24 11:21:40', 'SELECT id_narrative, title, abstract, date FROM narrative '),
(219, '2016-09-24 11:21:40', 'SELECT m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'1\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(220, '2016-09-24 11:26:04', 'SELECT id_narrative, title, abstract, date FROM narrative '),
(221, '2016-09-24 11:26:04', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'1\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(222, '2016-09-24 11:26:37', 'SELECT id_narrative, title, abstract, date FROM narrative '),
(223, '2016-09-24 11:26:37', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'1\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(224, '2016-09-24 11:27:36', 'SELECT id_narrative, title, abstract, date FROM narrative '),
(225, '2016-09-24 11:27:36', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'1\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(226, '2016-09-24 11:27:36', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'2\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(227, '2016-09-24 11:27:36', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'3\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(228, '2016-09-24 11:27:36', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'4\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(229, '2016-09-24 11:27:36', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'5\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(230, '2016-09-24 11:27:36', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(231, '2016-09-24 11:30:25', 'SELECT id_narrative, title, abstract, date FROM narrative '),
(232, '2016-09-24 11:30:25', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'1\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(233, '2016-09-24 11:30:25', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'2\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(234, '2016-09-24 11:30:25', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'3\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(235, '2016-09-24 11:30:25', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'4\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(236, '2016-09-24 11:30:25', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'5\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(237, '2016-09-24 11:30:25', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(238, '2016-09-24 11:31:38', 'SELECT id_narrative, title, abstract, date FROM narrative '),
(239, '2016-09-24 11:31:38', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'1\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(240, '2016-09-24 11:31:38', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'2\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(241, '2016-09-24 11:31:38', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'3\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(242, '2016-09-24 11:31:38', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'4\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(243, '2016-09-24 11:31:38', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'5\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(244, '2016-09-24 11:31:38', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(245, '2016-09-24 11:34:06', 'SELECT id_narrative, title, abstract, date FROM narrative '),
(246, '2016-09-24 11:34:06', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'1\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(247, '2016-09-24 11:34:06', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'2\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(248, '2016-09-24 11:34:06', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'3\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(249, '2016-09-24 11:34:06', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'4\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(250, '2016-09-24 11:34:06', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'5\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(251, '2016-09-24 11:34:06', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(252, '2016-09-24 11:34:08', 'SELECT e.id_element, e.type, e.name, e.from, e.to, w.text, w.end, w.choice, w.date, m.name AS author\n			FROM element e\n				INNER JOIN writing w ON w.id_element = e.id_element\n				INNER JOIN member m ON m.id_member = w.id_member\n			WHERE e.id_narrative = \'19\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)\n				AND w.type IN (\'create\', \'modify\')'),
(253, '2016-09-24 11:42:43', 'SELECT * FROM member '),
(254, '2016-09-24 11:42:46', 'SELECT * FROM narrative '),
(255, '2016-09-24 11:42:46', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'1\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(256, '2016-09-24 11:42:46', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'2\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(257, '2016-09-24 11:42:46', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'3\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(258, '2016-09-24 11:42:46', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'4\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(259, '2016-09-24 11:42:46', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'5\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(260, '2016-09-24 11:42:46', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(261, '2016-09-24 11:45:08', 'SELECT e.id_element, e.type, e.name, e.from, e.to, w.text, w.end, w.choice, w.date, m.name AS author\n			FROM element e\n				INNER JOIN writing w ON w.id_element = e.id_element\n				INNER JOIN member m ON m.id_member = w.id_member\n			WHERE e.id_narrative = \'19\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)\n				AND w.type IN (\'create\', \'modify\')'),
(262, '2016-09-24 11:45:10', 'SELECT * FROM narrative '),
(263, '2016-09-24 11:45:10', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'1\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(264, '2016-09-24 11:45:10', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'2\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(265, '2016-09-24 11:45:10', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'3\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(266, '2016-09-24 11:45:10', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'4\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(267, '2016-09-24 11:45:10', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'5\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(268, '2016-09-24 11:45:10', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(269, '2016-09-24 11:45:13', 'SELECT e.id_element, e.type, e.name, e.from, e.to, w.text, w.end, w.choice, w.date, m.name AS author\n			FROM element e\n				INNER JOIN writing w ON w.id_element = e.id_element\n				INNER JOIN member m ON m.id_member = w.id_member\n			WHERE e.id_narrative = \'1\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)\n				AND w.type IN (\'create\', \'modify\')'),
(270, '2016-09-24 11:45:15', 'SELECT * FROM narrative '),
(271, '2016-09-24 11:45:15', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'1\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(272, '2016-09-24 11:45:15', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'2\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(273, '2016-09-24 11:45:15', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'3\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(274, '2016-09-24 11:45:15', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'4\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(275, '2016-09-24 11:45:15', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'5\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(276, '2016-09-24 11:45:15', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(277, '2016-09-24 11:45:17', 'SELECT e.id_element, e.type, e.name, e.from, e.to, w.text, w.end, w.choice, w.date, m.name AS author\n			FROM element e\n				INNER JOIN writing w ON w.id_element = e.id_element\n				INNER JOIN member m ON m.id_member = w.id_member\n			WHERE e.id_narrative = \'2\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)\n				AND w.type IN (\'create\', \'modify\')'),
(278, '2016-09-24 11:45:19', 'SELECT * FROM narrative '),
(279, '2016-09-24 11:45:19', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'1\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(280, '2016-09-24 11:45:19', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'2\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(281, '2016-09-24 11:45:19', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'3\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(282, '2016-09-24 11:45:19', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'4\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(283, '2016-09-24 11:45:19', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'5\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(284, '2016-09-24 11:45:19', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(285, '2016-09-24 11:54:38', 'SELECT e.id_element, e.type, e.name, e.from, e.to, w.text, w.end, w.choice, w.date, m.name AS author\n			FROM element e\n				INNER JOIN writing w ON w.id_element = e.id_element\n				INNER JOIN member m ON m.id_member = w.id_member\n			WHERE e.id_narrative = \'1\'\n				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)\n				AND w.type IN (\'create\', \'modify\')'),
(286, '2016-09-24 11:54:40', 'SELECT * FROM narrative '),
(287, '2016-09-24 11:54:40', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'1\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(288, '2016-09-24 11:54:40', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'2\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(289, '2016-09-24 11:54:40', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'3\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(290, '2016-09-24 11:54:40', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'4\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(291, '2016-09-24 11:54:40', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'5\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(292, '2016-09-24 11:54:40', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(293, '2016-09-24 11:54:41', 'SELECT * FROM story\n			WHERE id_member = \'2\' AND id_narrative = \'1\' AND current IS NOT NULL\n				ORDER BY date DESC LIMIT 0,1'),
(294, '2016-09-24 11:54:41', 'INSERT INTO story (id_member, id_narrative) VALUES (\'2\', \'1\')'),
(295, '2016-09-24 11:54:41', 'SELECT * FROM narrative WHERE id_narrative = \'1\''),
(296, '2016-09-24 11:54:41', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'1\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(297, '2016-09-24 11:54:41', 'SELECT id_narrative, path FROM story WHERE id_story = \'294\''),
(298, '2016-09-24 11:57:00', 'SELECT * FROM story\n			WHERE id_member = \'2\' AND id_narrative = \'1\' AND current IS NOT NULL\n				ORDER BY date DESC LIMIT 0,1'),
(299, '2016-09-24 11:57:00', 'SELECT * FROM narrative WHERE id_narrative = \'1\''),
(300, '2016-09-24 11:57:00', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'1\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(301, '2016-09-24 11:57:00', 'SELECT id_narrative, path FROM story WHERE id_story = \'Array\''),
(302, '2016-09-24 11:57:59', 'SELECT id_story FROM story\n			WHERE id_member = \'2\' AND id_narrative = \'1\' AND current IS NOT NULL\n				ORDER BY date DESC LIMIT 0,1'),
(303, '2016-09-24 11:57:59', 'SELECT * FROM narrative WHERE id_narrative = \'1\''),
(304, '2016-09-24 11:57:59', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'1\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(305, '2016-09-24 11:57:59', 'SELECT id_narrative, path FROM story WHERE id_story = \'18\''),
(306, '2016-09-24 11:58:09', 'SELECT * FROM narrative '),
(307, '2016-09-24 11:58:09', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'1\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(308, '2016-09-24 11:58:09', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'2\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(309, '2016-09-24 11:58:09', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'3\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(310, '2016-09-24 11:58:09', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'4\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(311, '2016-09-24 11:58:09', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'5\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(312, '2016-09-24 11:58:09', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(313, '2016-09-24 11:58:10', 'SELECT id_story FROM story\n			WHERE id_member = \'2\' AND id_narrative = \'2\' AND current IS NOT NULL\n				ORDER BY date DESC LIMIT 0,1'),
(314, '2016-09-24 11:58:10', 'SELECT * FROM narrative WHERE id_narrative = \'2\''),
(315, '2016-09-24 11:58:10', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'2\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(316, '2016-09-24 11:58:10', 'SELECT id_narrative, path FROM story WHERE id_story = \'3\''),
(317, '2016-09-24 11:58:14', 'SELECT * FROM narrative '),
(318, '2016-09-24 11:58:14', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'1\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(319, '2016-09-24 11:58:14', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'2\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(320, '2016-09-24 11:58:14', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'3\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(321, '2016-09-24 11:58:14', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'4\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(322, '2016-09-24 11:58:14', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'5\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(323, '2016-09-24 11:58:14', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'19\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(324, '2016-09-24 11:58:15', 'SELECT id_story FROM story\n			WHERE id_member = \'2\' AND id_narrative = \'3\' AND current IS NOT NULL\n				ORDER BY date DESC LIMIT 0,1'),
(325, '2016-09-24 11:58:15', 'INSERT INTO story (id_member, id_narrative) VALUES (\'2\', \'3\')'),
(326, '2016-09-24 11:58:15', 'SELECT * FROM narrative WHERE id_narrative = \'3\''),
(327, '2016-09-24 11:58:15', 'SELECT m.id_member, m.name FROM element e\n					INNER JOIN rights r ON r.id_element = e.id_element\n					INNER JOIN member m ON m.id_member = r.id_member\n				WHERE e.id_narrative = \'3\' AND e.type = \'narrative\' AND r.type IN (\'add\',\'mod\',\'full\')'),
(328, '2016-09-24 11:58:15', 'SELECT id_narrative, path FROM story WHERE id_story = \'325\'');

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `id_member` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `password` varchar(64) COLLATE utf8_bin NOT NULL,
  `email` varchar(64) COLLATE utf8_bin NOT NULL,
  `last_visit` datetime DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`id_member`, `name`, `password`, `email`, `last_visit`, `date`) VALUES
(1, 'Régis', 'Régispass', 'Regis.Catinaud@gmail.com', NULL, '2016-05-21 20:55:35'),
(2, 'Robin', 'Robinpass', 'Robin.Lamarche.Perrin@gmail.com', NULL, '2016-05-21 20:55:35');

-- --------------------------------------------------------

--
-- Table structure for table `narrative`
--

CREATE TABLE `narrative` (
  `id_narrative` int(11) NOT NULL,
  `title` varchar(64) COLLATE utf8_bin NOT NULL,
  `abstract` text COLLATE utf8_bin NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `narrative`
--

INSERT INTO `narrative` (`id_narrative`, `title`, `abstract`, `date`) VALUES
(1, 'Histoire Régis', 'Cette narration est modifiable par Régis uniquement.', '2016-05-21 21:00:11'),
(3, 'Histoire Régis et Robin', 'Cette narration est modifiable par Régis et Robin.', '2016-05-21 21:01:41'),
(4, 'Histoire ouverte', 'Cette narration est modifiable par tout le monde.', '2016-05-21 21:01:41'),
(5, 'Test de construction', 'Un résumé...', '2016-06-29 00:59:46'),
(19, 'Clone', 'Première narration, écrite par Régis, compressée par Robin.', '2016-08-12 15:14:26'),
(33, 'Choice', 'Exemple de transition avec choix.', '2016-10-02 12:22:40');

-- --------------------------------------------------------

--
-- Table structure for table `reading`
--

CREATE TABLE `reading` (
  `id_member` int(11) NOT NULL,
  `id_element` int(11) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `rights`
--

CREATE TABLE `rights` (
  `id_member` int(11) NOT NULL,
  `id_element` int(11) NOT NULL,
  `type` enum('none','read','add','mod','full') COLLATE utf8_bin NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `rights`
--

INSERT INTO `rights` (`id_member`, `id_element`, `type`, `date`) VALUES
(1, 1, 'full', '2016-05-21 21:06:09'),
(1, 3, 'full', '2016-05-21 21:06:09'),
(1, 4, 'add', '2016-05-21 21:06:09'),
(1, 1266, 'full', '2016-08-12 15:14:26'),
(2, 3, 'mod', '2016-05-21 21:06:09'),
(2, 4, 'add', '2016-05-21 21:06:09'),
(2, 1391, 'full', '2016-10-02 12:22:40');

-- --------------------------------------------------------

--
-- Table structure for table `story`
--

CREATE TABLE `story` (
  `id_story` int(11) NOT NULL,
  `id_member` int(11) NOT NULL,
  `id_narrative` int(11) NOT NULL,
  `variables` text COLLATE utf8_bin,
  `path` text COLLATE utf8_bin,
  `id_current` int(11) DEFAULT NULL,
  `finished` tinyint(1) NOT NULL DEFAULT '0',
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `writing`
--

CREATE TABLE `writing` (
  `id_member` int(11) NOT NULL,
  `id_element` int(11) NOT NULL,
  `type` enum('create','modify','delete','') COLLATE utf8_bin NOT NULL,
  `name` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `id_from` int(11) DEFAULT NULL,
  `id_to` int(11) DEFAULT NULL,
  `start` tinyint(1) DEFAULT NULL,
  `end` tinyint(1) DEFAULT NULL,
  `choice` text COLLATE utf8_bin,
  `text` text COLLATE utf8_bin,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `writing`
--

INSERT INTO `writing` (`id_member`, `id_element`, `type`, `name`, `id_from`, `id_to`, `start`, `end`, `choice`, `text`, `date`) VALUES
(1, 5, 'create', 'start', NULL, NULL, 1, 1, NULL, 'Hello Régis!', '2016-05-21 21:10:57'),
(1, 7, 'modify', 'start', NULL, NULL, 1, 1, NULL, 'Hello Robin et Régis!', '2016-05-21 21:14:21'),
(1, 8, 'create', 'start', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-05-21 21:20:48'),
(1, 10, 'create', 'end_regis', NULL, NULL, 0, 1, NULL, '... Régis!', '2016-05-21 21:19:18'),
(1, 12, 'create', NULL, 8, 10, NULL, NULL, 'Régis', '', '2016-05-21 21:19:18'),
(1, 12, 'modify', NULL, 8, 10, NULL, NULL, 'Régis!', '', '2016-05-22 19:47:06'),
(1, 25, 'create', 'start', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-06-29 01:01:47'),
(1, 26, 'create', 'end', NULL, NULL, 0, 1, NULL, '...world!', '2016-06-29 01:01:47'),
(1, 27, 'create', NULL, 24, 26, NULL, NULL, 'NULL', '', '2016-06-29 01:01:47'),
(1, 1267, 'create', 'start', NULL, NULL, 1, 0, NULL, '-- "Ahhhhh..."[break]\n	Bâillements.[break]\n	-- "Ahhhhh... Mmhhh... Hein ? Où est-ce que je suis ?"', '2016-08-12 15:14:26'),
(1, 1268, 'create', 'introduction', NULL, NULL, 0, 0, NULL, 'Vous ouvrez lentement les yeux. Le réveil est difficile. Vous êtes engourdis, tout semble comme tourner autour de vous. Mal à l\'aise, nauséeux, vous vous redressez péniblement. Vous vous frottez longuement les paupières. Vous êtes assis sur le bord d\'un lit, au milieu d\'une petite salle décrépie.', '2016-08-12 15:14:26'),
(1, 1269, 'create', 'salle', NULL, NULL, 0, 0, NULL, 'Au fond de la salle, en face de vous, vous apercevez une porte. Sur votre droite, au-dessus d\'un lambris de bois vieillissant, une fenêtre depuis laquelle des ombres semblent défiler, inlassablement. Enfin, dans le coin entre la fenêtre et la porte se dresse un cabinet de travail en bois d\'acajou.', '2016-08-12 15:14:26'),
(1, 1270, 'create', 'porte', NULL, NULL, 0, 0, NULL, 'Vous vous approchez de la porte. Contrairement à l\'aspect général de la pièce, vieillot et ruineux, la porte vous semble récente et de bonne facture. Un métal solide, probablement de l\'acier pensez-vous. En approchant votre main de la poignée vous ne sentez aucune sensation particulière : le froid du métal auquel vous vous seriez attendu n\'est pas au rendez-vous. Vous sentez simplement que la poignée est agrippée, là, dans votre main.', '2016-08-12 15:14:26'),
(1, 1270, 'modify', 'porte', NULL, NULL, 0, 0, NULL, 'Vous vous approchez de la porte. Contrairement à l\'aspect général de la pièce, vieillot et ruineux, la porte vous semble récente et de bonne facture. Un métal solide, probablement de l\'acier pensez-vous. En approchant votre main de la poignée vous ne sentez aucune sensation particulière : le froid du métal auquel vous vous seriez attendu n\'est pas au rendez-vous. Vous sentez simplement que la poignée est agrippée, là, dans votre main.', '2016-08-12 16:14:41'),
(1, 1271, 'create', 'ouvrir', NULL, NULL, 0, 0, NULL, 'La porte grince et s\'ouvre sur une ruelle de banlieue pavillonnaire. Cet endroit vous est familier. Vous ne savez pas exactement ou vous vous trouvez, mais vous êtes déjà venu ici.', '2016-08-12 15:14:26'),
(1, 1271, 'modify', 'ouvrir', NULL, NULL, 0, 0, NULL, 'La porte grince et s\'ouvre sur une ruelle de banlieue pavillonnaire. Cet endroit vous est familier. Vous ne savez pas exactement où vous vous trouvez, mais vous êtes déjà venu ici.', '2016-08-12 16:27:26'),
(1, 1272, 'create', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, '', '2016-08-12 15:14:26'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'd', '2016-08-12 15:38:17'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, '', '2016-08-12 15:38:36'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'd', '2016-08-12 15:42:02'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, '', '2016-08-12 15:42:10'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'test', '2016-08-12 16:09:25'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'test', '2016-08-12 16:09:26'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'test', '2016-08-12 16:09:30'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'test', '2016-08-12 16:10:25'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'test', '2016-08-12 16:11:15'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'test', '2016-08-12 16:13:49'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'testf\n', '2016-08-12 16:15:00'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'testf\nd', '2016-08-12 16:15:09'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'testfd', '2016-08-12 16:15:18'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'testfd', '2016-08-12 16:18:03'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'testfd', '2016-08-12 16:18:43'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'testfd', '2016-08-12 16:18:58'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'testfdd', '2016-08-12 16:19:02'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'testfddf', '2016-08-12 16:19:16'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'testfddf', '2016-08-12 16:19:37'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'testfddf', '2016-08-12 16:20:43'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'testfddf', '2016-08-12 16:20:52'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'testfddfd', '2016-08-12 16:22:42'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'testfd\n', '2016-08-12 16:25:33'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'testfd\n', '2016-08-12 16:25:34'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'testfd', '2016-08-12 16:25:41'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'testfdd', '2016-08-12 16:26:16'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'testfddf', '2016-08-12 16:26:31'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, '', '2016-08-12 16:26:52'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, '', '2016-08-12 16:26:55'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'f', '2016-08-12 16:27:00'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, '', '2016-08-12 16:27:11'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, '', '2016-08-12 16:27:12'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'd', '2016-08-12 16:28:42'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, '', '2016-08-12 16:28:44'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, '', '2016-08-12 16:29:15'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, '', '2016-08-12 16:29:28'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, 'dfsdf', '2016-08-12 16:31:33'),
(1, 1272, 'modify', 'ouvrir_choix', NULL, NULL, 0, 0, NULL, '', '2016-08-12 16:48:00'),
(1, 1273, 'create', 'avancer', NULL, NULL, 0, 0, NULL, 'Vous essayez de franchir le seuil de la porte, mais vous vous sentez comme englué dans une matière invisible mais très dense qui vous empêche d\'avancer. Vous essayez de vous accrocher avec les bras sur l\'encadrure de la porte en poussant de toute vos forces pour vous extirper de la pièce, mais rien a faire, l’extérieur vous résiste. Après plusieurs tentatives infructueuses, épuisé, vous considérez de nouveau la porte infranchissable, irrité.', '2016-08-12 15:14:26'),
(1, 1274, 'create', 'attendre', NULL, NULL, 0, 0, NULL, 'Vous attendez une minute, rien ne se passe. Au bout de 5 minutes, une femme passe lentement dans la rue en poussant un landau. Vous n’apercevez pas de bébé à l’intérieur : il vous semble même être vide, ou complètement noir. Vous hélez la femme, mais elle vous ignore, tout en s’éloignant progressivement.', '2016-08-12 15:14:26'),
(1, 1275, 'create', 'attendre2', NULL, NULL, 0, 0, NULL, 'Vous voyez un des voisins sortir de sa maison en jogging. Sous son porche, il met de la musique sur son MP3, porte son casque à ses oreilles, et commence a courir. Il passe dans la rue devant votre porte. Vous le saluez, mais il ne semble pas vous apercevoir. Vous lui criez dessus pour qu\'il se retourne, mais rien ne semble l’ébranler.', '2016-08-12 15:14:26'),
(1, 1276, 'create', 'fenetre', NULL, NULL, 0, 0, NULL, 'En vous approchant de la fenêtre, vous remarquez que vous êtes dans un immeuble. En face de vous, une ribambelle de gratte-ciels vous barrent la vue. Vous comprenez que les silhouettes que vous aperceviez depuis votre lit n’étaient rien d\'autres que vos voisins mitoyens qui s\'affairaient dans l\'immeuble d\'en face. En bas, vous n\'apercevez pas la rue, vous en déduisez que vous devez être très haut, plus d\'une centaine d’étages, pour sûr.', '2016-08-12 15:14:26'),
(1, 1277, 'create', 'attendre_fenetre', NULL, NULL, 0, 0, NULL, 'Vous observez avec plus d\'attention vos voisins d\'en face. Plusieurs rideaux sont tirés, et des volets fermés. Le soleil donne sur ce versant de l\'immeuble. Quelques étages plus bas, vous voyez une famille assise devant la télé. Sur le même niveau, quelques fenêtres à droites, un homme en caleçon tire un rideau. Au-dessus de vous, vous apercevez aussi un homme en costard en train de se parler à lui-même dans une glace (il est probablement dans sa salle de bain pensez-vous).', '2016-08-12 15:14:26'),
(1, 1278, 'create', 'attendre_fenetre2', NULL, NULL, 0, 0, NULL, 'La scène est d\'une inconsolable banalité. Rien ne bouge, rien ne change : le soleil reste à la même place, la famille en bas continue de regarder la télé, l\'homme au costard continue de se parler à lui-même, et le type en caleçon vient ouvrir et refermer constamment son rideau. C\'est ennuyeux. Vous décidez de revenir vers le lit.', '2016-08-12 15:14:26'),
(1, 1279, 'create', 'cabinet', NULL, NULL, 0, 0, NULL, 'Le cabinet de travail est très simple et rustique. Du vieux bois vermoulu. Sur un des coins, vous remarquez des inscriptions que vous n\'arrivez pas à déchiffrer. Au milieu trône un télécom flambant neuf. Il est posé sur une petite boîte à bijou en laque noire. Les tiroirs sont vides, sauf un, qui comporte un exemplaire du Volume 5 de l’Encyclopédie de D\'Alembert - lettre L à Q.', '2016-08-12 15:14:26'),
(1, 1280, 'create', 'cabinet_choix', NULL, NULL, 0, 0, NULL, '', '2016-08-12 15:14:26'),
(1, 1281, 'create', 'boite', NULL, NULL, 0, 0, NULL, 'Vous essayez de vous saisir de la boîte à bijou, mais dès que vous l\'attrapez, elle vous coule entre les mains. D\'abord surpris, vous vous réessayez en tenant plus vigoureusement et plus fermement la boîte. Mais le résultat est toujours le même : elle vous glisse des mains comme un liquide visqueux pour se reformer intact sur la table, à sa même place. Un système de protection plutôt efficace !', '2016-08-12 15:14:26'),
(1, 1282, 'create', 'encyclopedie', NULL, NULL, 0, 0, NULL, 'Vous prenez l’encyclopédie entre vos mains et vous la feuilletez. Vous l\'ouvrez au hasard aux pages 537-538 pour tomber sur une description barbante de la guerre de Laytown. Vous tournez les pages et vous vous rendez compte qu\'il n\'existe que des pages 537-538. Étrange. Plus curieux encore : que vous tourniez une, dix ou cent pages, le livre semble toujours être ouvert au milieu, avec le même nombre de pages avant et après. Vous reposez l’encyclopédie là ou vous l\'avez trouvé.', '2016-08-12 15:14:26'),
(1, 1283, 'create', 'telecom', NULL, NULL, 0, 0, NULL, 'En allumant le télécom, un son affreux grésille dans le petit haut-parleur tenu par un fil tressé au boîtier du télécom. Vous voyez une antenne recroquevillé au dos du boîtier, et vous la dépliez. Une voix se fait entendre derrière des crépitements désagréables. Plus vous allongez l\'antenne, plus le son devient net :[break]\n	Grrrrrrr Crrrr "All..."  Grrrrrr Crrrr "Allo Allo ?" Crrrrrrrrr crrr "Allo Paul tu m\'entends ? Tu m\'entends Paul ?"[break]\n	-- "Oui, je vous entends. Qui est-ce ?"[break]\n	-- "Paul ? Ah Paul, c\'est moi ! C\'est Paul."[break]\n	-- "Quoi ? Qui ? Paul ? C\'est qui Paul ? Vous ou moi ?"[break]\n	-- "Allons Paul, tu te souviens n\'est-ce pas ?"', '2016-08-12 15:14:26'),
(1, 1284, 'create', 'telecom_non', NULL, NULL, 0, 0, NULL, '-- "Non ? Vraiment rien ? C\'est probablement normal..."[break]\n	-- "... Les médecins de la simulation m\'avaient prévenus que ça pouvait arriver. Pour tout te dire, très rapidement car nous n\'avons pas beaucoup de temps et que tu me coûte cher, tu es une COPIE, un double de moi si tu préfères. Tu as été numérisé et transposé dans un programme informatique qui te simules, tel que je suis. Enfin tel que j’étais avant la numérisation. Tu as tout de moi : mes souvenirs, mon apparence. Tout ! Sauf que tu es à l’intérieur et moi à l’extérieur..." ', '2016-08-12 15:14:26'),
(1, 1285, 'create', 'telecom_2', NULL, NULL, 0, 0, NULL, '-- "Ça y est, oui, je me souviens, mon enfance, enfin notre enfance, les ruelles me reviennent, et puis mon appartement à la ville, mon travail, ma mission, mes recherches. Oui, je devais aller me faire numériser pour mes recherches sur la consciences. Je devais avoir 2 jours de machine complet."[break]\n	-- "Oui, c\'est bien cela Paul," répond une voix lointaine dans le télécom, "toi et moi nous sommes la même personne, tu es mon CLONE. Et toi et moi nous avons encore une petite journée de temps-machine, alors il faut que nous nous pressions pour faire nos expériences." Vous notez une touche d\'impatience dans la voix de votre alter-ego extérieur. Se presser, oui, facile a dire, sauf que c\'est lui qui est à l’extérieur, c\'est lui qui, à la fin de cette journée, continuera à vivre, tandis que vous, la copie, serez supprimé. Mais vous étiez préparé a cette éventualité. Il ne faut pas trop y penser et se mettre au travail. La voix nasillarde vous revient, vous ne pensez plus qu\'il s\'agit de vous, mais vous imaginez un LUTIN malicieux en train de prendre votre timbre de voix pour vous parler, et il poursuit : "il faut nous y mettre Paul."', '2016-08-12 15:14:26'),
(1, 1286, 'create', 'telecom_3', NULL, NULL, 0, 0, NULL, '-- "Tu te souviens de la procédure ? Je vais effectuer une série d\'expériences en faisant varier tes supports numériques de conscience, et tes relevés me diront ce que tu ressentiras, si ta conscience et toujours unie ou si elle se disloque. Pour cela, tu n\'as qu\'à, de ton côté, compter jusqu\'à 5. Je comparerai ensuite tes données a celles de l\'autre Copie-test qui vivra les mêmes expériences que toi."[break]\n	-- "Attends avant de commencer ! Attends une minute. Dis moi, c\'est qui la Copie-test, l\'autre ? ... ou moi ?"[break]\n	-- "Est-ce vraiment important de le savoir ? Allons, cesse de nous retarder et fait preuve de bonne volonté veux-tu ?"', '2016-08-12 15:14:26'),
(1, 1287, 'create', 'telecom_4', NULL, NULL, 0, 0, NULL, '-- "Non, tu as raison," admettez-vous, "je préfere ne pas le savoir."[break]\n	-- "Merci, j\'aime mieux cette attitude. Allons, hauts les cœurs, tout sera bientôt fini. Comment te sens-tu ? Veux tu que nous commencions doucement par l\'expérience 1, ou pouvons-nous passer directement à la deuxième pour gagner du temps ?"', '2016-08-12 15:14:26'),
(1, 1288, 'create', 'experience_1', NULL, NULL, 0, 0, NULL, '-- "Très bien, alors je vais commencer par espacer les différents moments de calculs qui te produisent. Tu es prêt ? Compte jusqu\'à 5... maintenant !"[break]\n	-- "1..."[break]\n	-- "...2..."[break]\n	-- "...3..."[break]\n	-- "...4..."[break]\n	-- "...5 !"[break]\n	-- "Alors, qu\'as tu ressenti ?" vous demande le Lutin.[break]\n	-- "Rien, j\'ai compté jusqu\'à 5, voila tout. Que disent tes relevés et les compteurs ?"[break]\n	-- "Et bien... Tout est conforme à ce qu\'on avait prévu : tu es totalement stable et le temps de ta conscience semble s\'être accommode des longueurs du calcul. Ta conscience à tenu le coup."[break]\n	-- "Super, tu m\'en vois ravi. Je n\'ose même pas imaginer à quoi aurait pu correspondre l\'échec de cette première expérience. Ma conscience dechirée par la machine. Aurais-je seulement ressenti quelque chose ? Aurais-je souffert ? Comment savoir. Mais c\'est bien facile de te réjouir pour toi qui es confortablement assis à l\'extérieur, hein ?"[break]\n	-- "Allons, allons, pas de rancune, je t\'en prie. Nous avons décidé cela tous les deux, rappelles-toi. Bien sûr, c\'est moi qui suis à l\'extérieur aujourd\'hui, mais tu ne peux n\'en vouloir qu\'à toi-même d\'être là, et tu le sais bien. Passons à la seconde expérience."[break]\n	Vous acquiescez, malgré vous.', '2016-08-12 15:14:26'),
(1, 1289, 'create', 'experience_2', NULL, NULL, 0, 0, NULL, '-- "Très bien," vous dit le Lutin, "si la première expérience sert à te mettre en phase avec le programme, à te situer du point de vue du calcul, avec cette deuxième expérience, je vais essayer de voir si ta conscience de Copie tient le coup à un changement de matériel de calcul : autrement dit, je vais changer très rapidement les supports physiques qui soutiennent ta conscience, et je vais essayer de voir si tu restes cohérent, stable. Pour cela, tu n\'as qu\'une chose à faire : compter jusqu\'à 5 et me dire comment tu te sens. Je verrai bien tout cela traduit sur mon moniteur, mais le compte-rendu oral est important : la continuité de la conscience est aussi une affaire subjective. Prêt ? Au top, tu compteras jusqu\'à 5. Un, deux, trois, top !"[break]\n	-- "1..."[break]\n	-- "...2..."[break]\n	-- "...3..."[break]\n	-- "...4..."[break]\n	-- "...5 !"[break]\n	-- "Tu es toujours là ?" La voix du Lutin extérieur grésille dans le télécom.[break]\n	Vous avez envie de le faire patienter, juste pour avoir le sentiment de garder une once de pouvoir sur votre vie, et sur la sienne.[break]\n	-- " Allo ? Tu m\'entends ?"[break]\n	-- "Oui, je suis toujours là... Et toi, tout va bien ? Toujours confortablement assis, pas trop mal aux doigts à force de taper sur le clavier ?"[break]\n	-- "Je note ton irritabilité. Et honnêtement, je la comprends. Mais n\'oublie pas pourquoi nous sommes là. Pour la science avant tout. Et de toi comme de moi, que retiendrons-nous après notre mort si ce n\'est cet instant là ? Nous sommes tous les deux aussi importants, vois-tu. Tiens, pour te rassurer, je peux t\'apprendre que l\'autre Copie à bien eu les mêmes résultats que toi. Nos prédictions sont validées : la conscience prolongée par numérisation est aussi robuste quand on change son support physique. C\'est plutôt un bonne nouvelle, non ? Bon, pour que tu le saches, je vais maintenant supprimer la Copie-test et nous allons poursuivre avec l\'autre. Tu es prêt ?"', '2016-08-12 15:14:26'),
(1, 1290, 'create', 'trop_tard', NULL, NULL, 0, 0, NULL, '-- "Ça ne sert a rien de protester, j\'ai déjà supprimé la Copie, donc estime-toi heureux, ce n\'était pas toi. Continuons, tu veux bien ?"', '2016-08-12 15:14:26'),
(1, 1291, 'create', 'experience_3', NULL, NULL, 0, 0, NULL, '-- "Expérience 3," annonce froidement le Lutin. "Ouverture réseau. Je vais maintenant éclater les différents modules de calcul de ta conscience sur le réseau mondial. En termes de temps et d\'espace, ce sera une prouesse si ta conscience arrive à tenir. Tu es prêt à compter jusqu\'à 5 ? C\'est parti !"[break]\n	-- "1..."[break]\n	-- "...2..."[break]\n	-- "...3..."[break]\n	Et à cet instant, le temps semble comme se ralentir. Les grésillements du télécom se font plus sourds, plus graves, la lumière de la pièce où vous vous trouvez semble comme se tamiser. Vous entendez les tapotements des doigts du Lutin extérieur sur son clavier se ralentir, le temps semble s\'allonger.[break]\n	-- "Est-ce normal ?" vous demandez-vous. "Suis-je en train de me dissoudre ?" pensez-vous, anxieux. Et l\'autre Copie ? Est-ce lui le test ou est-ce moi ? Qu\'importe, de toute façon, après cette expérience, nous serons tous les deux supprimés. Seulement, l\'un aura simplement quelques secondes de répit sur l\'autre. Le temps de plaider sa cause avec quelques phrases de plus. Ça ne suffira pas. Le Lutin est trop borne, trop insensible, et j\'en sais quelque chose."[break]\n	-- "...4..."[break]\n	-- "Mais je sens que ma conscience se détache de ce lieu, je sens que je pourrais m\'enfuir par cette porte, je me sens plus léger, plus libre. Quelle est cette sensation ? Le monde se disloque. Je crois comprendre ce qui est en train de se passer : le Lutin extérieur ne contrôle plus vraiment le monde de ses Copies. En étalant le calcul à l\'extérieur, il à laissé d\'autres serveurs me calculer. Il ne les contrôle qu\'à moitié, dans le seul où il indique ma direction à tous ces serveurs..."[break]\n	-- "... Mais n\'est-ce pas une porte de sortie ? Si je pouvais continuer à exister, à étendre ma conscience à ces différents processus de calculs extérieurs, à laisser ces machines continuer de calculer les motifs de ma conscience même quand l\'expérience sera terminée, quand je serai de nouveau enfermé dans le seul ordinateur du Lutin." ', '2016-08-12 15:14:26'),
(1, 1292, 'create', 'finir', NULL, NULL, 0, 0, NULL, '-- "... et 5."[break]\n	-- "Très bien Paul ! Bravo, nos modèles sont valides. Il nous reste quelque vérifications a faire et ce sera fini pour aujourd\'hui. En attendant, je vais supprimer un des deux CLONES-TEST, Attention..."', '2016-08-12 15:14:26'),
(1, 1293, 'create', 'echapper', NULL, NULL, 0, 1, NULL, 'Le 5 n\'adviendra jamais. Vous avez couru vers la porte et l\'avez franchi en sautant. Une matière visqueuse à bien essayé de vous retenir et de vous contenir à l\'intérieur de la pièce, mais vous sentez que son poids sur vous n\'est pas suffisamment contraignant pour vous empêcher de sortir. Vous la traversez lentement et vous êtes aussi attiré vers l\'extérieur, par d\'autres forces qui vous déterminent, qui pensent et calculent votre continuité. À mesure que vous vous avancez vers l\'extérieur, vous prenez votre liberté : vous sortez de l\'ordinateur confiné du Lutin pour occuper différents lieux tout à la fois dans le réseau. Vous êtes libres.[break]\n	FIN[break]\n	-- Inspiré d\'une nouvelle de Greg Egan dans Océanique --', '2016-08-12 15:14:26'),
(1, 1294, 'create', NULL, 1267, 1268, NULL, NULL, NULL, '', '2016-08-12 15:14:26'),
(1, 1295, 'create', NULL, 1268, 1269, NULL, NULL, NULL, '', '2016-08-12 15:14:26'),
(1, 1296, 'create', NULL, 1269, 1270, NULL, NULL, 'Se déplacer vers la porte', 'Vous vous déplacez vers la porte.', '2016-08-12 15:14:26'),
(1, 1297, 'create', NULL, 1269, 1276, NULL, NULL, 'Aller voir a la fenêtre', 'Vous marchez jusqu’à la fenêtre.', '2016-08-12 15:14:26'),
(1, 1298, 'create', NULL, 1269, 1279, NULL, NULL, 'Se diriger vers le cabinet de travail', 'Vous vous dirigez jusqu\'au cabinet de travail.', '2016-08-12 15:14:26'),
(1, 1299, 'create', NULL, 1270, 1271, NULL, NULL, 'Ouvrir la porte', 'Vous tournez doucement la poignée et ouvrez la porte.', '2016-08-12 15:14:26'),
(1, 1300, 'create', NULL, 1270, 1269, NULL, NULL, 'Revenir au centre de la pièce', 'Vous lâchez la poignée et vous revenez vers le centre de la pièce, vers le lit.', '2016-08-12 15:14:26'),
(1, 1301, 'create', NULL, 1271, 1272, NULL, NULL, NULL, '', '2016-08-12 15:14:26'),
(1, 1302, 'create', NULL, 1272, 1273, NULL, NULL, 'S\'avancer', 'Vous faites un pas en avant.', '2016-08-12 15:14:26'),
(1, 1303, 'create', NULL, 1272, 1274, NULL, NULL, 'Attendre', 'Vous vous accoudez au bord de la porte et attendez.', '2016-08-12 15:14:26'),
(1, 1304, 'create', NULL, 1272, 1269, NULL, NULL, 'Fermer la porte et revenir vers le lit', 'Vous fermez la porte et revenez vers le centre de la pièce.', '2016-08-12 15:14:26'),
(1, 1305, 'create', NULL, 1273, 1272, NULL, NULL, NULL, '', '2016-08-12 15:14:26'),
(1, 1306, 'create', NULL, 1274, 1273, NULL, NULL, 'S\'avancer', 'Vous faites un pas en avant.', '2016-08-12 15:14:26'),
(1, 1307, 'create', NULL, 1274, 1275, NULL, NULL, 'Attendre encore', 'Vous attendez encore cinq minutes.', '2016-08-12 15:14:26'),
(1, 1308, 'create', NULL, 1274, 1269, NULL, NULL, 'Fermer la porte et revenir vers le lit', 'Vous fermez la porte et revenez vers le centre de la pièce.', '2016-08-12 15:14:26'),
(1, 1309, 'create', NULL, 1275, 1272, NULL, NULL, NULL, '', '2016-08-12 15:14:26'),
(1, 1310, 'create', NULL, 1276, 1277, NULL, NULL, 'Attendre et observer', 'Vous regardez ce qui se passe à l’extérieur d\'un peu plus près.', '2016-08-12 15:14:27'),
(1, 1311, 'create', NULL, 1276, 1269, NULL, NULL, 'Revenir au centre de la pièce', 'Vous vous écartez de le fenêtre, et vous revenez vers le centre de la pièce.', '2016-08-12 15:14:27'),
(1, 1312, 'create', NULL, 1277, 1278, NULL, NULL, 'Attendre et observer encore un peu', 'Vous continuer à regardez ce qui se passe par la fenêtre.', '2016-08-12 15:14:27'),
(1, 1313, 'create', NULL, 1277, 1269, NULL, NULL, 'Revenir vers le lit', 'Vous vous écartez de le fenêtre, et vous revenez vers le centre de la pièce.', '2016-08-12 15:14:27'),
(1, 1314, 'create', NULL, 1278, 1269, NULL, NULL, NULL, '', '2016-08-12 15:14:27'),
(1, 1315, 'create', NULL, 1279, 1280, NULL, NULL, NULL, '', '2016-08-12 15:14:27'),
(1, 1316, 'create', NULL, 1280, 1281, NULL, NULL, 'Prendre la boîte et l\'examiner', 'Vous enlevez le télécom de la boîte et vous vous saisissez de la boîte de votre main droite.', '2016-08-12 15:14:27'),
(1, 1317, 'create', NULL, 1280, 1283, NULL, NULL, 'Allumer le télécom', 'Vous prenez le télécom et appuyez sur le bouton ON.', '2016-08-12 15:14:27'),
(1, 1318, 'create', NULL, 1280, 1282, NULL, NULL, 'Consulter l’encyclopédie', 'Vous vous baissez pour saisir l’encyclopédie dans le tiroir.', '2016-08-12 15:14:27'),
(1, 1319, 'create', NULL, 1280, 1269, NULL, NULL, 'Revenir au centre de la salle', 'Vous mémorisez les objets du cabinet, puis vous revenez vers le lit, au centre de la salle.', '2016-08-12 15:14:27'),
(1, 1320, 'create', NULL, 1281, 1280, NULL, NULL, NULL, '', '2016-08-12 15:14:27'),
(1, 1321, 'create', NULL, 1282, 1280, NULL, NULL, NULL, '', '2016-08-12 15:14:27'),
(1, 1322, 'create', NULL, 1283, 1284, NULL, NULL, 'Non', '-- "Non, je ne me souviens de rien."', '2016-08-12 15:14:27'),
(1, 1323, 'create', NULL, 1283, 1285, NULL, NULL, 'Oui', '', '2016-08-12 15:14:27'),
(1, 1324, 'create', NULL, 1284, 1285, NULL, NULL, NULL, '', '2016-08-12 15:14:27'),
(1, 1325, 'create', NULL, 1285, 1268, NULL, NULL, 'Hors de question !', '-- "Non, Paul-extérieur, c\'est bien trop facile : toi tu vas survivre pendant que moi je vais te servir, l\'espace d\'une journée avant que tu ne me supprimes comme un vulgaire programme que l\'on met à la corbeille. Et bien non, je refuse de travailler pour toi, et tu peux créer autant de Clones que tu voudras, si je refuse aujourd\'hui et maintenant, ce sera pareil pour tous les autres moi. Alors arrête tes expériences, arrête de me/nous faire souffrir nous autres Copies !" ', '2016-08-12 15:14:27'),
(1, 1326, 'create', NULL, 1285, 1286, NULL, NULL, 'Ok', '-- "Bon très bien," maugréez-vous en vous résignant.', '2016-08-12 15:14:27'),
(1, 1327, 'create', NULL, 1286, 1268, NULL, NULL, 'Continuer à argumenter', '-- "Non, je ne suis pas d\'accord, nous devons en parler, je ne voyais pas ces choses-là quand j\'étais toi, enfin quand nous étions la même personne, mais maintenant que je suis a l\'intérieur, je vois les choses différemment, et je peux te dire que ce que nous faisons, enfin ce que tu fais, à de lourdes conséquences éthiques. Tu ne peux pas décider comme ça impunément de la vie et de la mort de..."', '2016-08-12 15:14:27'),
(1, 1328, 'create', NULL, 1286, 1287, NULL, NULL, 'Suivre le Lutin et continuer l\'expérience', 'Vous ravalez votre fierté, et vous poursuivez l’expérience.', '2016-08-12 15:14:27'),
(1, 1329, 'create', NULL, 1287, 1288, NULL, NULL, 'Expérience 1', '-- "Procédons par ordre et soyons consciencieux, commençons par l\'expérience 1."', '2016-08-12 15:14:27'),
(1, 1330, 'create', NULL, 1287, 1289, NULL, NULL, 'Passer directement à l\'expérience 2', '-- "Ne perdons pas de temps et finissons-en : commençons directement par l\'expérience 2.".', '2016-08-12 15:14:27'),
(1, 1331, 'create', NULL, 1288, 1289, NULL, NULL, NULL, '', '2016-08-12 15:14:27'),
(1, 1332, 'create', NULL, 1289, 1291, NULL, NULL, 'Ne rien dire', 'Vous vous taisez, mi-énervé et mi-terrorisé par les perspectives monstrueuses de cette expérience.', '2016-08-12 15:14:27'),
(1, 1333, 'create', NULL, 1289, 1290, NULL, NULL, 'Protester', '-- "Attends ! Attends ! Ne fais pas ça !! Tu ne vas quand même pas supprimer un de nous deux comme ça sans rien dire. Tu sais ce que ça fait de savoir qu\'on va peut-être mourir dans l\'instant, et puis d\'abord qui de lui ou de moi est la Copie, hein ?"', '2016-08-12 15:14:27'),
(1, 1334, 'create', NULL, 1290, 1291, NULL, NULL, 'Se resigner et continuer', '-- "Pfff, allons-y, finissons-en espèce de tortionnaire de merde. Je ne me savais pas capable d\'autant d’insensibilité."', '2016-08-12 15:14:27'),
(1, 1335, 'create', NULL, 1290, 1268, NULL, NULL, 'Refuser de continuer l\'expérience', '-- "Va te faire voir, je ne veux pas continuer ton horrible petit jeu."[break]\n	-- "Très bien," vous répond le Lutin.', '2016-08-12 15:14:27'),
(1, 1336, 'create', NULL, 1291, 1292, NULL, NULL, 'Finir l\'expérience', '', '2016-08-12 15:14:27'),
(1, 1337, 'create', NULL, 1291, 1293, NULL, NULL, 'Essayer de s\'échapper', '-- "... et cin..."', '2016-08-12 15:14:27'),
(1, 1338, 'create', NULL, 1292, 1268, NULL, NULL, NULL, '', '2016-08-12 15:14:27'),
(2, 7, 'create', 'start', NULL, NULL, 1, 1, NULL, 'Hello Robin!', '2016-05-21 21:14:03'),
(2, 9, 'create', 'end_robin', NULL, NULL, 0, 1, NULL, '... Robin!', '2016-05-21 21:19:18'),
(2, 11, 'create', NULL, 8, 9, NULL, NULL, 'Robin', '', '2016-05-21 21:19:18'),
(2, 11, 'modify', NULL, 8, 9, NULL, NULL, 'Robin!', '', '2016-05-22 19:46:40'),
(2, 1267, 'modify', 'start', NULL, NULL, 1, NULL, NULL, '-- "Ahhhhh..."[break]\nBâillements.[break]\n-- "Ahhhhh... Mmhhh... Hein ? Où est-ce que je suis ?"', '2016-10-04 00:27:05'),
(2, 1285, 'modify', 'telecom_2', NULL, NULL, NULL, NULL, NULL, '-- "Ça y est, oui, je me souviens, mon enfance, enfin notre enfance, les ruelles me reviennent, et puis mon appartement à la ville, mon travail, ma mission, mes recherches. Oui, je devais aller me faire numériser pour mes recherches sur la consciences. Je devais avoir 2 jours de machine complet."[break]\n-- "Oui, c\'est bien cela Paul," répond une voix lointaine dans le télécom, "toi et moi nous sommes la même personne, tu es mon CLONE. Et toi et moi nous avons encore une petite journée de temps-machine, alors il faut que nous nous pressions pour faire nos expériences." Vous notez une touche d\'impatience dans la voix de votre alter-ego extérieur. Se presser, oui, facile a dire, sauf que c\'est lui qui est à l’extérieur, c\'est lui qui, à la fin de cette journée, continuera à vivre, tandis que vous, la copie, serez supprimé. Mais vous étiez préparé a cette éventualité. Il ne faut pas trop y penser et se mettre au travail. La voix nasillarde vous revient, vous ne pensez plus qu\'il s\'agit de vous, mais vous imaginez un LUTIN malicieux en train de prendre votre timbre de voix pour vous parler, et il poursuit : "il faut nous y mettre Paul."', '2016-10-04 00:27:30'),
(2, 1286, 'modify', 'telecom_3', NULL, NULL, NULL, NULL, NULL, '-- "Tu te souviens de la procédure ? Je vais effectuer une série d\'expériences en faisant varier tes supports numériques de conscience, et tes relevés me diront ce que tu ressentiras, si ta conscience et toujours unie ou si elle se disloque. Pour cela, tu n\'as qu\'à, de ton côté, compter jusqu\'à 5. Je comparerai ensuite tes données a celles de l\'autre Copie-test qui vivra les mêmes expériences que toi."[break]\n-- "Attends avant de commencer ! Attends une minute. Dis moi, c\'est qui la Copie-test, l\'autre ? ... ou moi ?"[break]\n-- "Est-ce vraiment important de le savoir ? Allons, cesse de nous retarder et fait preuve de bonne volonté veux-tu ?"', '2016-10-04 00:24:36'),
(2, 1392, 'create', 'start', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-02 12:22:40'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-02 12:22:53'),
(2, 1392, 'modify', 'hellod', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-02 13:43:56'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-02 13:45:24'),
(2, 1392, 'modify', 'hello2', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-04 22:28:46'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-04 22:32:33'),
(2, 1392, 'modify', 'hellod', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-04 22:33:06'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-04 22:34:20'),
(2, 1392, 'modify', 'hellod', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-04 22:34:35'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-04 22:36:21'),
(2, 1392, 'modify', 'worl', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-04 23:06:47'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-04 23:06:53'),
(2, 1392, 'modify', 'hell', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-04 23:14:46'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-04 23:15:07'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...d', '2016-10-13 21:27:19'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-13 21:33:17'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...d', '2016-10-13 21:42:08'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-13 21:42:34'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...d', '2016-10-13 21:42:49'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-13 21:43:09'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...d', '2016-10-13 21:44:35'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-13 21:45:19'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...d', '2016-10-13 21:45:59'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-13 21:46:10'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...d', '2016-10-13 21:46:39'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-13 21:46:57'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...d', '2016-10-13 21:50:00'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 1, NULL, 'Hello...', '2016-10-13 21:50:07'),
(2, 1392, 'modify', 'hellod', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-13 21:50:12'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-13 21:50:15'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...d', '2016-10-13 21:53:27'),
(2, 1392, 'modify', 'hello', NULL, NULL, 1, 0, NULL, 'Hello...', '2016-10-13 21:53:57'),
(2, 1393, 'create', 'world', NULL, NULL, 0, 1, NULL, '...world!', '2016-10-02 12:22:40'),
(2, 1394, 'create', 'universe', NULL, NULL, 0, 1, NULL, '...universe!', '2016-10-02 12:22:40'),
(2, 1395, 'create', NULL, 1392, 1393, NULL, NULL, 'World?', '', '2016-10-02 12:22:40'),
(2, 1395, 'modify', NULL, 1392, 1394, NULL, NULL, 'World?', '', '2016-10-02 12:24:09'),
(2, 1395, 'modify', NULL, 1392, 1393, NULL, NULL, 'World?', '', '2016-10-02 12:24:25'),
(2, 1395, 'modify', NULL, 1392, 1392, NULL, NULL, 'World?', '', '2016-10-13 21:54:02'),
(2, 1395, 'modify', NULL, 1393, 1392, NULL, NULL, 'World?', '', '2016-10-13 21:54:11'),
(2, 1395, 'modify', NULL, 1392, 1393, NULL, NULL, 'World?', '', '2016-10-13 21:54:28'),
(2, 1396, 'create', NULL, 1392, 1394, NULL, NULL, 'Universe?', '', '2016-10-02 12:22:41'),
(2, 1396, 'modify', NULL, 1392, 1392, NULL, NULL, 'Universe?', '', '2016-10-05 00:33:11'),
(2, 1396, 'modify', NULL, 1392, 1393, NULL, NULL, 'Universe?', '', '2016-10-05 00:33:23'),
(2, 1396, 'modify', NULL, 1392, 1394, NULL, NULL, 'Universe?', '', '2016-10-05 00:35:33'),
(2, 1396, 'modify', NULL, 1392, 1393, NULL, NULL, 'Universe?', '', '2016-10-05 00:36:01'),
(2, 1396, 'modify', NULL, 1392, 1394, NULL, NULL, 'Universe?', '', '2016-10-05 00:37:23'),
(2, 1396, 'modify', NULL, 1392, 1393, NULL, NULL, 'Universe?', '', '2016-10-05 00:38:07'),
(2, 1396, 'modify', NULL, 1392, 1394, NULL, NULL, 'Universe?', '', '2016-10-05 00:38:49'),
(2, 1396, 'modify', NULL, 1392, 1393, NULL, NULL, 'Universe?', '', '2016-10-05 00:42:13'),
(2, 1396, 'modify', NULL, 1392, 1393, NULL, NULL, 'Universe?', 'd', '2016-10-05 00:42:18'),
(2, 1396, 'modify', NULL, 1392, 1393, NULL, NULL, 'Universe?', '', '2016-10-05 00:42:26'),
(2, 1396, 'modify', NULL, 1392, 1394, NULL, NULL, 'Universe?', '', '2016-10-05 00:42:29'),
(2, 1398, 'create', 'new_situation_1', NULL, NULL, 0, 0, NULL, '', '2016-10-13 23:10:35'),
(2, 1398, 'delete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2016-10-15 16:17:05'),
(2, 1401, 'create', 'new_situation_2', NULL, NULL, 0, 0, NULL, '', '2016-10-13 23:35:33'),
(2, 1401, 'delete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2016-10-15 16:17:35'),
(2, 1410, 'create', NULL, 1393, 1393, NULL, NULL, '', '', '2016-10-15 15:31:38'),
(2, 1410, 'delete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2016-10-15 16:17:20'),
(2, 1411, 'modify', NULL, 1393, 1398, NULL, NULL, '', '', '2016-10-15 15:32:04'),
(2, 1411, 'delete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2016-10-15 16:17:05'),
(2, 1419, 'create', 'new_situation_1', NULL, NULL, 0, 0, NULL, '', '2016-10-15 16:20:14'),
(2, 1419, 'delete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2016-10-15 16:20:30'),
(2, 1420, 'create', NULL, 1419, 1392, NULL, NULL, '', '', '2016-10-15 16:20:16'),
(2, 1420, 'delete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2016-10-15 16:20:30'),
(2, 1421, 'create', NULL, 1393, 1419, NULL, NULL, '', '', '2016-10-15 16:20:15'),
(2, 1421, 'delete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2016-10-15 16:20:30'),
(2, 1422, 'create', NULL, 1419, 1419, NULL, NULL, '', '', '2016-10-15 16:20:12'),
(2, 1422, 'delete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2016-10-15 16:20:30');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `element`
--
ALTER TABLE `element`
  ADD PRIMARY KEY (`id_element`),
  ADD KEY `id_narrative` (`id_narrative`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`id_member`);

--
-- Indexes for table `narrative`
--
ALTER TABLE `narrative`
  ADD PRIMARY KEY (`id_narrative`);

--
-- Indexes for table `reading`
--
ALTER TABLE `reading`
  ADD UNIQUE KEY `id_member_element` (`id_member`,`id_element`,`date`),
  ADD KEY `id_member` (`id_member`),
  ADD KEY `id_element` (`id_element`);

--
-- Indexes for table `rights`
--
ALTER TABLE `rights`
  ADD PRIMARY KEY (`id_member`,`id_element`) USING BTREE,
  ADD KEY `const_rights_element` (`id_element`);

--
-- Indexes for table `story`
--
ALTER TABLE `story`
  ADD PRIMARY KEY (`id_story`),
  ADD KEY `id_member` (`id_member`),
  ADD KEY `id_narrative` (`id_narrative`),
  ADD KEY `id_current` (`id_current`);

--
-- Indexes for table `writing`
--
ALTER TABLE `writing`
  ADD UNIQUE KEY `id_member_2` (`id_member`,`id_element`,`date`),
  ADD KEY `id_member` (`id_member`),
  ADD KEY `id_element` (`id_element`),
  ADD KEY `id_from` (`id_from`),
  ADD KEY `id_to` (`id_to`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `element`
--
ALTER TABLE `element`
  MODIFY `id_element` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1423;
--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=329;
--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `id_member` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `narrative`
--
ALTER TABLE `narrative`
  MODIFY `id_narrative` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;
--
-- AUTO_INCREMENT for table `story`
--
ALTER TABLE `story`
  MODIFY `id_story` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `element`
--
ALTER TABLE `element`
  ADD CONSTRAINT `const_element_narrative` FOREIGN KEY (`id_narrative`) REFERENCES `narrative` (`id_narrative`);

--
-- Constraints for table `reading`
--
ALTER TABLE `reading`
  ADD CONSTRAINT `const_reading_element` FOREIGN KEY (`id_element`) REFERENCES `element` (`id_element`),
  ADD CONSTRAINT `const_reading_member` FOREIGN KEY (`id_member`) REFERENCES `member` (`id_member`);

--
-- Constraints for table `rights`
--
ALTER TABLE `rights`
  ADD CONSTRAINT `const_rights_element` FOREIGN KEY (`id_element`) REFERENCES `element` (`id_element`),
  ADD CONSTRAINT `const_rights_member` FOREIGN KEY (`id_member`) REFERENCES `member` (`id_member`);

--
-- Constraints for table `story`
--
ALTER TABLE `story`
  ADD CONSTRAINT `const_story_current` FOREIGN KEY (`id_current`) REFERENCES `element` (`id_element`),
  ADD CONSTRAINT `const_story_member` FOREIGN KEY (`id_member`) REFERENCES `member` (`id_member`),
  ADD CONSTRAINT `const_story_narrative` FOREIGN KEY (`id_narrative`) REFERENCES `narrative` (`id_narrative`);

--
-- Constraints for table `writing`
--
ALTER TABLE `writing`
  ADD CONSTRAINT `const_writing_element` FOREIGN KEY (`id_element`) REFERENCES `element` (`id_element`),
  ADD CONSTRAINT `const_writing_id_from` FOREIGN KEY (`id_from`) REFERENCES `element` (`id_element`),
  ADD CONSTRAINT `const_writing_id_to` FOREIGN KEY (`id_to`) REFERENCES `element` (`id_element`),
  ADD CONSTRAINT `const_writing_member` FOREIGN KEY (`id_member`) REFERENCES `member` (`id_member`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
