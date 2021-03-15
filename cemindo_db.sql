-- --------------------------------------------------------
-- Host:                         117.53.46.58
-- Server version:               10.5.9-MariaDB-1:10.5.9+maria~focal - mariadb.org binary distribution
-- Server OS:                    debian-linux-gnu
-- HeidiSQL Version:             10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for cemindo_prod_tufpal
CREATE DATABASE IF NOT EXISTS `cemindo_prod_tufpal` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `cemindo_prod_tufpal`;

-- Dumping structure for table cemindo_prod_tufpal.all_transaction
CREATE TABLE IF NOT EXISTS `all_transaction` (
  `all_transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `tid_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_sjp_id` int(11) DEFAULT NULL,
  `reference_sjp_status_id` int(11) DEFAULT NULL,
  `reference_pallet_transfer_id` int(11) DEFAULT NULL,
  `reference_ber_missing_id` int(11) DEFAULT NULL,
  `reference_new_pallet_id` int(11) DEFAULT NULL,
  `reference_damaged_pallet_id` int(11) DEFAULT NULL,
  `reference_repaired_pallet_id` int(11) DEFAULT NULL,
  `reference_transporter_adjusment_id` int(11) DEFAULT NULL,
  `transaction` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_do` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_no_do` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sender/reporter` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receiver/approver` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `departure_pool` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `destination_pool` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_destination` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pool_pallet` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transporter` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vehicle` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_vehicle` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `driver` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_driver` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `good_pallet` int(11) DEFAULT 0,
  `tbr_pallet` int(11) DEFAULT 0,
  `ber_pallet` int(11) DEFAULT 0,
  `missing_pallet` int(11) DEFAULT 0,
  `good_cement` int(11) DEFAULT 0,
  `bad_cement` int(11) DEFAULT 0,
  `sending_driver_approval` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Send Driver Digital Signature',
  `receiving_driver_approval` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Send Driver Digital Signature',
  `reporter_prove` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reason` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`all_transaction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- Dumping data for table cemindo_prod_tufpal.all_transaction: ~12 rows (approximately)
/*!40000 ALTER TABLE `all_transaction` DISABLE KEYS */;
REPLACE INTO `all_transaction` (`all_transaction_id`, `tid_number`, `reference_sjp_id`, `reference_sjp_status_id`, `reference_pallet_transfer_id`, `reference_ber_missing_id`, `reference_new_pallet_id`, `reference_damaged_pallet_id`, `reference_repaired_pallet_id`, `reference_transporter_adjusment_id`, `transaction`, `no_do`, `new_no_do`, `status`, `sender/reporter`, `receiver/approver`, `departure_pool`, `destination_pool`, `new_destination`, `pool_pallet`, `transporter`, `vehicle`, `new_vehicle`, `driver`, `new_driver`, `good_pallet`, `tbr_pallet`, `ber_pallet`, `missing_pallet`, `good_cement`, `bad_cement`, `sending_driver_approval`, `receiving_driver_approval`, `reporter_prove`, `reason`, `note`, `created_at`, `updated_at`) VALUES
	(1, 'TID-202103-00001', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, 'New Pallet Report', NULL, NULL, 'REPORTED', 'Rizki Saputra', NULL, NULL, NULL, NULL, 'Pool Pallet Ciwandan', NULL, 'BK9617CW', NULL, 'marhadi', NULL, 250, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 'penerimaan pallet baru 250 pcs', '2021-03-09 00:40:47', '2021-03-09 00:40:47'),
	(2, 'TID-202103-00002', NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, 'New Pallet Report', NULL, NULL, 'REPORTED', 'Rizki Saputra', NULL, NULL, NULL, NULL, 'Pool Pallet Ciwandan', NULL, 'BK9632CW', NULL, 'NURDIN', NULL, 250, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 'penerimaan pallet baru 250 pcs dri loscam', '2021-03-09 00:50:05', '2021-03-09 00:50:05'),
	(3, 'TID-202103-00003', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'SJP Status Send', 'D010-1DC210300064', NULL, 'SEND', 'Gomes Hardianto', NULL, 'Pool Pallet Ciwandan', 'JATI ASIH WH', NULL, NULL, 'Andalan Nusa pratama', 'B 9505 YM', NULL, 'Paring', NULL, 24, 0, 0, 0, 1350, 0, NULL, NULL, NULL, NULL, NULL, '2021-03-09 11:00:16', '2021-03-09 11:00:16'),
	(4, 'TID-202103-00004', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Surat Jalan Pallet Cancel', 'D010-1DC210300065', NULL, 'CANCELLED', 'Gomes Hardianto', NULL, 'Pool Pallet Ciwandan', 'JATI ASIH WH', NULL, NULL, 'Andalan Nusa pratama', 'B 9644 YN', NULL, 'Hendra BE', NULL, 27, 0, 0, 0, 1350, 0, NULL, NULL, NULL, NULL, NULL, '2021-03-09 11:31:08', '2021-03-09 11:31:08'),
	(5, 'TID-202103-00005', 3, 2, NULL, NULL, NULL, NULL, NULL, NULL, 'SJP Status Send', 'D010-d1dc210300063', NULL, 'SEND', 'Gomes Hardianto', NULL, 'Pool Pallet Ciwandan', 'JATI ASIH WH', NULL, NULL, 'Andalan Nusa pratama', 'B9644yn', NULL, 'Hendra BE', NULL, 24, 0, 0, 0, 1350, 0, NULL, NULL, NULL, NULL, NULL, '2021-03-09 12:08:20', '2021-03-09 12:08:20'),
	(6, 'TID-202103-00006', 4, 3, NULL, NULL, NULL, NULL, NULL, NULL, 'SJP Status Send', 'D010-1dc210300063', NULL, 'SEND', 'Gomes Hardianto', NULL, 'Pool Pallet Ciwandan', 'JATI ASIH WH', NULL, NULL, 'Andalan Nusa pratama', 'B9867 YN', NULL, 'Jaenudin', NULL, 24, 0, 0, 0, 1350, 0, NULL, NULL, NULL, NULL, NULL, '2021-03-09 12:08:34', '2021-03-09 12:08:34'),
	(7, 'TID-202103-00007', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'SJP Status Receive', 'D010-1DC210300064', NULL, 'RECEIVE', NULL, 'Tommy', 'Pool Pallet Ciwandan', 'JATI ASIH WH', NULL, NULL, 'Andalan Nusa pratama', 'B 9505 YM', NULL, 'Paring', NULL, 24, 0, 0, 0, 1350, 0, NULL, NULL, NULL, NULL, 'null', '2021-03-09 12:58:37', '2021-03-09 12:58:37'),
	(8, 'TID-202103-00008', 1, 4, NULL, NULL, NULL, NULL, NULL, NULL, 'SJP Status Sendback', 'D010-1DC210300064', NULL, 'SENDBACK', 'Tommy', NULL, 'JATI ASIH WH', 'Pool Pallet Ciwandan', NULL, NULL, 'Andalan Nusa pratama', 'B 9505 YM', NULL, 'Paring', NULL, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, '2021-03-09 13:00:42', '2021-03-09 13:00:42'),
	(9, 'TID-202103-00009', 3, 2, NULL, NULL, NULL, NULL, NULL, NULL, 'SJP Status Receive', 'D010-d1dc210300063', NULL, 'RECEIVE', NULL, 'Tommy', 'Pool Pallet Ciwandan', 'JATI ASIH WH', NULL, NULL, 'Andalan Nusa pratama', 'B9644yn', NULL, 'Hendra BE', NULL, 24, 0, 0, 0, 1350, 0, NULL, NULL, NULL, NULL, 'null', '2021-03-09 13:01:11', '2021-03-09 13:01:11'),
	(10, 'TID-202103-00010', 3, 5, NULL, NULL, NULL, NULL, NULL, NULL, 'SJP Status Sendback', 'D010-d1dc210300063', NULL, 'SENDBACK', 'Tommy', NULL, 'JATI ASIH WH', 'Pool Pallet Ciwandan', NULL, NULL, 'Andalan Nusa pratama', 'B9644yn', NULL, 'Hendra BE', NULL, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, '2021-03-09 13:01:20', '2021-03-09 13:01:20'),
	(11, 'TID-202103-00011', 4, 3, NULL, NULL, NULL, NULL, NULL, NULL, 'SJP Status Receive', 'D010-1dc210300063', NULL, 'RECEIVE', NULL, 'Tommy', 'Pool Pallet Ciwandan', 'JATI ASIH WH', NULL, NULL, 'Andalan Nusa pratama', 'B9867 YN', NULL, 'Jaenudin', NULL, 24, 0, 0, 0, 1350, 0, NULL, NULL, NULL, NULL, 'null', '2021-03-09 13:01:40', '2021-03-09 13:01:40'),
	(12, 'TID-202103-00012', 4, 6, NULL, NULL, NULL, NULL, NULL, NULL, 'SJP Status Sendback', 'D010-1dc210300063', NULL, 'SENDBACK', 'Tommy', NULL, 'JATI ASIH WH', 'Pool Pallet Ciwandan', NULL, NULL, 'Andalan Nusa pratama', 'B9867 YN', NULL, 'Jaenudin', NULL, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, '2021-03-09 13:01:47', '2021-03-09 13:01:47');
/*!40000 ALTER TABLE `all_transaction` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.approval_log
CREATE TABLE IF NOT EXISTS `approval_log` (
  `approval_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approval` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`approval_log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Dumping data for table cemindo_prod_tufpal.approval_log: ~9 rows (approximately)
/*!40000 ALTER TABLE `approval_log` DISABLE KEYS */;
REPLACE INTO `approval_log` (`approval_log_id`, `transaction_id`, `transaction_name`, `approval`, `created_by`, `created_at`, `updated_at`) VALUES
	(1, 'SJP-202103-00001', 'SJP Sending Driver Approval', NULL, 'Gomes Hardianto', '2021-03-09 11:00:16', '2021-03-09 11:00:16'),
	(2, 'SJP-202103-00003', 'SJP Sending Driver Approval', NULL, 'Gomes Hardianto', '2021-03-09 12:08:20', '2021-03-09 12:08:20'),
	(3, 'SJP-202103-00004', 'SJP Sending Driver Approval', NULL, 'Gomes Hardianto', '2021-03-09 12:08:34', '2021-03-09 12:08:34'),
	(4, 'SJP-202103-00001', 'SJP Receive Driver Approval', NULL, 'Tommy', '2021-03-09 12:58:37', '2021-03-09 12:58:37'),
	(5, 'SJP-202103-00001', 'SJP Sending Back Driver Approval', NULL, 'Tommy', '2021-03-09 13:00:41', '2021-03-09 13:00:41'),
	(6, 'SJP-202103-00003', 'SJP Receive Driver Approval', NULL, 'Tommy', '2021-03-09 13:01:11', '2021-03-09 13:01:11'),
	(7, 'SJP-202103-00003', 'SJP Sending Back Driver Approval', NULL, 'Tommy', '2021-03-09 13:01:20', '2021-03-09 13:01:20'),
	(8, 'SJP-202103-00004', 'SJP Receive Driver Approval', NULL, 'Tommy', '2021-03-09 13:01:40', '2021-03-09 13:01:40'),
	(9, 'SJP-202103-00004', 'SJP Sending Back Driver Approval', NULL, 'Tommy', '2021-03-09 13:01:47', '2021-03-09 13:01:47');
/*!40000 ALTER TABLE `approval_log` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.auto_numbers
CREATE TABLE IF NOT EXISTS `auto_numbers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.auto_numbers: ~70 rows (approximately)
/*!40000 ALTER TABLE `auto_numbers` DISABLE KEYS */;
REPLACE INTO `auto_numbers` (`id`, `name`, `number`, `created_at`, `updated_at`) VALUES
	(2, 'fd7c53d0e70ef33c15f089fdc99c7ef1', 0, '2020-02-17 15:39:19', '2020-02-29 12:07:06'),
	(3, '7f4103ea26af1d05f0105a5cac8d8c71', 0, '2020-02-18 04:25:38', '2020-02-27 07:08:44'),
	(4, 'dd34d1d8dc6e256e521cee25bf1bc62a', 0, '2020-02-24 03:10:17', '2020-02-29 09:32:20'),
	(5, 'c5222f6fb3335f287443eea4d2d41afc', 0, '2020-02-24 15:25:06', '2020-02-28 07:53:15'),
	(6, '5ce89064e886f6641c9e7df9fbf57e53', 0, '2020-02-25 20:26:48', '2020-02-28 08:15:05'),
	(7, 'fc97c15fa08e4839ff41ea6ff6045503', 0, '2020-03-01 07:56:45', '2020-03-26 16:46:47'),
	(8, '8ca66ac4259bb2b324802795ffe20795', 0, '2020-03-01 07:59:13', '2020-03-26 16:51:29'),
	(9, '7d832d236702be7843de2d3a52523a0f', 0, '2020-03-02 11:07:04', '2020-03-26 16:53:31'),
	(10, 'e8c9e00b282869306536dba156a38150', 0, '2020-03-02 11:16:14', '2020-03-30 23:26:20'),
	(11, 'a04bf20ca1839074e30da08d9dade4e2', 0, '2020-03-03 07:17:52', '2020-03-26 16:45:58'),
	(12, '4a1110f409e3637831a944a3477c44b3', 0, '2020-03-04 09:10:03', '2020-03-17 08:44:24'),
	(13, '49af879a17b9bfe521af94fd2d0c9a7e', 0, '2020-03-04 10:02:05', '2020-03-26 16:53:02'),
	(14, 'ac2f39c83a5930cb99e08bceecf7e341', 0, '2020-03-08 04:05:05', '2020-03-30 23:26:20'),
	(15, 'b66f659f6e479ad219411cbedf21edb7', 0, '2020-03-08 05:25:14', '2020-03-26 16:53:31'),
	(16, '9b646c2b8edd0ece3888b50ac4973d6f', 0, '2020-03-16 16:14:06', '2020-03-25 18:28:54'),
	(17, '7ee90e5de4448d5e8a1fd36fa652bf28', 0, '2020-03-16 16:25:28', '2020-03-17 08:33:06'),
	(27, '1b85462cf87ea7fabcd8983de4493ab5', 0, '2020-03-30 23:20:33', '2020-03-31 04:40:45'),
	(28, '04b9c42d9b6ad17a8550696a7374396e', 0, '2020-04-06 14:48:56', '2020-04-06 14:58:30'),
	(29, '618112b12bfb2d59259848522c6cfa03', 0, '2020-04-06 14:56:14', '2020-04-30 06:35:01'),
	(32, 'a134bf983db14952d03ccf07a1ac1464', 0, '2020-04-07 00:36:58', '2020-04-24 05:02:11'),
	(47, '2ffd4c7ad062fae1673552eec490f65a', 0, '2020-04-07 01:39:08', '2020-04-07 01:39:08'),
	(57, 'b492842cafe74aa9c4dc2bfd77b4ba1d', 0, '2020-04-07 03:00:22', '2020-04-07 03:00:22'),
	(58, 'cc917315567be8600606809039a00079', 0, '2020-04-08 01:51:10', '2020-04-29 15:04:34'),
	(59, '4a18d41f000aa0c8d8a7431ea547e2e4', 0, '2020-04-08 01:53:47', '2020-04-08 14:21:34'),
	(60, '1e0410f10609c7deae384eab8c420108', 0, '2020-04-08 02:03:52', '2020-04-25 07:44:01'),
	(61, '157e1e7d7560a4976fe901d0ef10bf1d', 0, '2020-04-08 11:04:11', '2020-04-29 14:59:49'),
	(62, '01888e72bca62c0a79f40e6508a79c98', 0, '2020-04-28 13:02:39', '2020-04-28 13:18:01'),
	(68, '7d158064733c85ad2d1b70c08d7a1046', 128, '2020-05-04 04:29:46', '2020-05-30 14:30:46'),
	(69, '04620f1027ab127b7eeaf4e8ddb3cba7', 259, '2020-05-04 04:29:46', '2020-05-31 14:30:07'),
	(70, 'f0de683623cec9dc8fa5ccf78ed26cb7', 63, '2020-05-04 05:22:07', '2020-05-30 14:24:50'),
	(71, 'ba540c3a1b637cecc7b94ba4f15e1a45', 0, '2020-05-04 19:07:15', '2020-05-17 07:07:51'),
	(72, 'f83270638377d400c69988cd72d59bb7', 1, '2020-05-13 13:51:07', '2020-05-29 12:03:27'),
	(73, '80f73b385697b03a639274fa6f8ade92', 5, '2020-05-13 13:59:59', '2020-05-31 14:28:20'),
	(74, '2f8fb68060c4f263691102bffd367ff7', 6, '2020-05-13 16:03:38', '2020-05-30 03:14:04'),
	(75, 'f3af794faf8ce202a4a9e82e8eaced28', 1, '2020-05-13 16:08:44', '2020-05-31 14:23:16'),
	(76, 'e43b8c145352cc58994ab4f3d22b40c4', 57, '2020-06-01 02:13:00', '2020-06-30 10:27:29'),
	(77, '2bc905d89f58b14e468374b5445b4c53', 7348, '2020-06-01 02:13:00', '2020-06-30 16:59:42'),
	(82, 'db6c4821bd446c9694625ababf0b3532', 17, '2020-06-01 17:06:51', '2020-06-30 07:13:20'),
	(83, '7305444e475ff899a6107eb1a4b20332', 3368, '2020-06-01 17:21:03', '2020-06-30 16:59:42'),
	(84, '1997f6609f5e48c0ac75380de0334a07', 1720, '2020-06-01 17:38:48', '2020-06-30 16:46:50'),
	(88, 'c44f82ac045ff24849c3eb8b8b94a8dd', 6, '2020-06-13 15:59:41', '2020-06-19 07:18:46'),
	(89, 'c518b89e003c793eeefe911b4ace8149', 642, '2020-06-15 15:56:55', '2020-06-27 00:27:33'),
	(90, '12b5901c96aba8aa4ef2c4f1647eefbc', 1, '2020-06-27 10:50:39', '2020-06-27 10:50:39'),
	(91, 'be6f8a1b59084d006790eaf63be748d4', 4112, '2020-06-30 17:02:13', '2020-07-26 18:46:54'),
	(92, 'f6c4fbc8b6f4921096f81eaf7ae208c0', 15935, '2020-06-30 17:05:43', '2020-07-29 14:48:40'),
	(93, 'd9f184f616fb21ff18a1fbbf70ac1e54', 8008, '2020-06-30 17:05:50', '2020-07-26 18:51:03'),
	(94, '37e0ba390a64b641e3753ffc6f2b6556', 114, '2020-06-30 17:21:55', '2020-07-26 00:38:09'),
	(95, '336a7ec9eaa7b3daf914dcb303253a76', 2, '2020-07-01 05:52:53', '2020-07-14 02:02:25'),
	(96, 'a28f488f65b955d65be3d5a340567e8b', 20, '2020-07-01 06:20:08', '2020-07-24 08:23:51'),
	(97, '612cd321395bb702bf0a3c1099f7a580', 60, '2020-07-01 23:07:28', '2020-07-26 04:13:04'),
	(98, 'bbb8dbbf5f5a9d96ed433fb4d9ae1dca', 3, '2020-07-07 21:07:56', '2020-07-24 08:54:49'),
	(99, '0e8b4b84ff1f78dc7a4554ca3019943b', 9, '2020-07-07 23:57:25', '2020-07-19 21:28:06'),
	(101, 'a0a5d4e04d0bf8381b6ecc786cdc3e70', 2, '2020-07-29 14:30:54', '2020-07-29 14:48:40'),
	(102, 'adc6ed8c00e44ddd1498893cda745fd5', 35, '2020-09-14 03:31:13', '2020-09-25 05:50:29'),
	(103, 'a4806c8cd07f14a20347952dce1b3294', 8, '2020-09-14 03:35:38', '2020-09-22 06:21:03'),
	(104, '740cf040c24b3ccb9a56621910ce50a3', 1, '2020-09-23 07:27:52', '2020-09-23 07:27:52'),
	(105, '337ea09e37b42b0e10b5c3eacdb8e0fd', 1, '2020-09-25 05:43:23', '2020-09-25 05:43:23'),
	(106, 'e1b3f8ef5e65a9f187379ec8b0029499', 20, '2020-10-01 15:19:47', '2020-10-27 08:33:03'),
	(107, '7e2481d4504cfc1817331ad58bd49b30', 32, '2020-10-01 15:19:47', '2020-10-27 08:33:03'),
	(108, '8d090b0fc3988eac4ebbe74b96ef2ea4', 18, '2020-10-05 15:31:36', '2020-10-27 08:32:58'),
	(109, '83ed0b24bfd902bf99114299a7a63045', 2, '2020-12-10 18:04:17', '2020-12-13 17:37:21'),
	(110, 'efd1d5a25e937bff30fdc88d4f3fb7c8', 2, '2020-12-10 18:04:17', '2020-12-13 17:37:21'),
	(111, 'd9bf2625f0e24f2a6a1bfa7e25713d1f', 7, '2021-01-13 04:59:09', '2021-01-22 07:31:47'),
	(112, '45eeb951280df6c613c0f99bdf4ae199', 4, '2021-01-13 05:11:30', '2021-01-22 07:31:47'),
	(113, 'c51eda99e93cd835bb6db4a98f5f695b', 2, '2021-01-22 07:06:46', '2021-01-22 07:09:42'),
	(114, 'a7cfa46152424e2c3f58d3078767fc3f', 2, '2021-02-08 01:48:50', '2021-02-08 01:49:10'),
	(115, '5b21233d6ebbd3fa10176b7c9f4bdfc7', 2, '2021-03-09 00:40:47', '2021-03-09 00:50:05'),
	(116, 'cacf34d3ccbbf4663eb8dac647b1ccf5', 12, '2021-03-09 00:40:47', '2021-03-09 13:01:47'),
	(117, '1f2d4ce53a839ae60adc8b9e45fcbb58', 4, '2021-03-09 10:58:03', '2021-03-09 12:07:08'),
	(118, '1172b14a42fc00d33dceb99d5a6bf3c3', 6, '2021-03-09 11:00:16', '2021-03-09 13:01:47');
/*!40000 ALTER TABLE `auto_numbers` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.ber_missing_pallet
CREATE TABLE IF NOT EXISTS `ber_missing_pallet` (
  `ber_missing_pallet_id` int(11) NOT NULL AUTO_INCREMENT,
  `reporter_user_id` bigint(20) DEFAULT NULL,
  `approver_user_id` bigint(20) DEFAULT NULL,
  `pool_pallet_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transporter_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_sjp_status_id` int(11) DEFAULT NULL,
  `bmp_number` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ber_pallet` int(11) DEFAULT NULL,
  `missing_pallet` int(11) DEFAULT NULL,
  `reporter_prove` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL COMMENT '0: reported, 1: approved, 2: disapproved',
  `berita_acara` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ber_missing_pallet_id`),
  KEY `pool_pallet_fk` (`pool_pallet_id`),
  KEY `reporter_user_fk` (`reporter_user_id`),
  KEY `approver_user_fk` (`approver_user_id`),
  KEY `transporter_fk` (`transporter_id`) USING BTREE,
  KEY `reference_sjp_status_fk` (`reference_sjp_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.ber_missing_pallet: ~0 rows (approximately)
/*!40000 ALTER TABLE `ber_missing_pallet` DISABLE KEYS */;
/*!40000 ALTER TABLE `ber_missing_pallet` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.ber_missing_pallet_approved
CREATE TABLE IF NOT EXISTS `ber_missing_pallet_approved` (
  `ber_missing_pallet_approved_id` int(11) NOT NULL AUTO_INCREMENT,
  `ber_missing_id` int(11) DEFAULT NULL,
  `status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approver` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pool_pallet` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transporter` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_sjp_status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ber_pallet` int(11) NOT NULL DEFAULT 0,
  `missing_pallet` int(11) NOT NULL DEFAULT 0,
  `reporter_prove` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `berita_acara` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ber_missing_pallet_approved_id`),
  KEY `ber_missing_id` (`ber_missing_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- Dumping data for table cemindo_prod_tufpal.ber_missing_pallet_approved: ~0 rows (approximately)
/*!40000 ALTER TABLE `ber_missing_pallet_approved` DISABLE KEYS */;
/*!40000 ALTER TABLE `ber_missing_pallet_approved` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.ber_missing_pallet_disapproved
CREATE TABLE IF NOT EXISTS `ber_missing_pallet_disapproved` (
  `ber_missing_pallet_disapproved_id` int(11) NOT NULL AUTO_INCREMENT,
  `ber_missing_id` int(11) DEFAULT NULL,
  `status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disapprover` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pool_pallet` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transporter` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_sjp_status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ber_pallet` int(11) NOT NULL DEFAULT 0,
  `missing_pallet` int(11) NOT NULL DEFAULT 0,
  `reporter_prove` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `berita_acara` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ber_missing_pallet_disapproved_id`),
  KEY `ber_missing_id` (`ber_missing_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;

-- Dumping data for table cemindo_prod_tufpal.ber_missing_pallet_disapproved: ~0 rows (approximately)
/*!40000 ALTER TABLE `ber_missing_pallet_disapproved` DISABLE KEYS */;
/*!40000 ALTER TABLE `ber_missing_pallet_disapproved` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.ber_missing_pallet_reported
CREATE TABLE IF NOT EXISTS `ber_missing_pallet_reported` (
  `ber_missing_pallet_reported_id` int(11) NOT NULL AUTO_INCREMENT,
  `ber_missing_id` int(11) DEFAULT NULL,
  `status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reporter` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pool_pallet` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transporter` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_sjp_status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ber_pallet` int(11) NOT NULL DEFAULT 0,
  `missing_pallet` int(11) NOT NULL DEFAULT 0,
  `reporter_prove` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `berita_acara` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ber_missing_pallet_reported_id`),
  KEY `ber_missing_id` (`ber_missing_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table cemindo_prod_tufpal.ber_missing_pallet_reported: ~0 rows (approximately)
/*!40000 ALTER TABLE `ber_missing_pallet_reported` DISABLE KEYS */;
/*!40000 ALTER TABLE `ber_missing_pallet_reported` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.customers
CREATE TABLE IF NOT EXISTS `customers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nik` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `courier_id` bigint(20) unsigned DEFAULT NULL,
  `point` int(11) NOT NULL,
  `deposit` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customers_nik_unique` (`nik`),
  KEY `customers_courier_id_foreign` (`courier_id`),
  CONSTRAINT `customers_courier_id_foreign` FOREIGN KEY (`courier_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.customers: ~1 rows (approximately)
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
REPLACE INTO `customers` (`id`, `nik`, `name`, `address`, `phone`, `courier_id`, `point`, `deposit`, `created_at`, `updated_at`) VALUES
	(5, '1231231', 'Aulia Harvy', 'jl.iisss', '0892132', NULL, 10, 100000, NULL, NULL);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.damaged_pallet
CREATE TABLE IF NOT EXISTS `damaged_pallet` (
  `damaged_pallet_id` int(11) NOT NULL AUTO_INCREMENT,
  `reporter_user_id` bigint(20) NOT NULL,
  `pool_pallet_id` varchar(100) DEFAULT NULL,
  `transporter_id` varchar(100) DEFAULT NULL,
  `reference_sjp_status_id` int(11) DEFAULT NULL,
  `dp_number` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tbr_pallet` int(11) NOT NULL,
  `note` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`damaged_pallet_id`),
  KEY `pool_pallet_fk` (`pool_pallet_id`),
  KEY `reporter_user_fk` (`reporter_user_id`) USING BTREE,
  KEY `transporter_id` (`transporter_id`),
  KEY `reference_sjp_status_id` (`reference_sjp_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table cemindo_prod_tufpal.damaged_pallet: ~0 rows (approximately)
/*!40000 ALTER TABLE `damaged_pallet` DISABLE KEYS */;
/*!40000 ALTER TABLE `damaged_pallet` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.deleted_item
CREATE TABLE IF NOT EXISTS `deleted_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bmp_number` varchar(100) DEFAULT NULL,
  `dp_number` varchar(100) DEFAULT NULL,
  `np_number` varchar(100) DEFAULT NULL,
  `tp_number` varchar(100) DEFAULT NULL,
  `rp_number` varchar(100) DEFAULT NULL,
  `sjp_number` varchar(100) DEFAULT NULL,
  `sjps_number` varchar(100) DEFAULT NULL,
  `departure_pool` varchar(100) DEFAULT NULL,
  `destination_pool` varchar(100) DEFAULT NULL,
  `pool_pallet` varchar(100) DEFAULT NULL,
  `transporter` varchar(100) DEFAULT NULL,
  `reporter/sender` varchar(100) DEFAULT NULL,
  `receiver/approver` varchar(100) DEFAULT NULL,
  `driver` varchar(100) DEFAULT NULL,
  `vehicle` varchar(100) DEFAULT NULL,
  `good_pallet` int(11) DEFAULT 0,
  `tbr_pallet` int(11) DEFAULT 0,
  `ber_pallet` int(11) DEFAULT 0,
  `missing_pallet` int(11) DEFAULT 0,
  `good_cement` int(11) DEFAULT 0,
  `bad_cement` int(11) DEFAULT 0,
  `note` varchar(150) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table cemindo_prod_tufpal.deleted_item: ~0 rows (approximately)
/*!40000 ALTER TABLE `deleted_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `deleted_item` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.detail_transactions
CREATE TABLE IF NOT EXISTS `detail_transactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` bigint(20) unsigned NOT NULL,
  `laundry_price_id` bigint(20) unsigned NOT NULL,
  `laundry_type_id` bigint(20) unsigned NOT NULL,
  `qty` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `subtotal` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `detail_transactions_transaction_id_foreign` (`transaction_id`),
  KEY `detail_transactions_laundry_price_id_foreign` (`laundry_price_id`),
  KEY `detail_transactions_laundry_type_id_foreign` (`laundry_type_id`),
  CONSTRAINT `detail_transactions_laundry_price_id_foreign` FOREIGN KEY (`laundry_price_id`) REFERENCES `laundry_prices` (`id`),
  CONSTRAINT `detail_transactions_laundry_type_id_foreign` FOREIGN KEY (`laundry_type_id`) REFERENCES `laundry_types` (`id`),
  CONSTRAINT `detail_transactions_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.detail_transactions: ~0 rows (approximately)
/*!40000 ALTER TABLE `detail_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `detail_transactions` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.driver
CREATE TABLE IF NOT EXISTS `driver` (
  `driver_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transporter_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `driver_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `driver_address` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`driver_id`),
  KEY `transporter_driver_fk` (`transporter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.driver: ~5 rows (approximately)
/*!40000 ALTER TABLE `driver` DISABLE KEYS */;
REPLACE INTO `driver` (`driver_id`, `transporter_id`, `driver_name`, `driver_address`, `mobile_number`, `email`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
	('1', '11111', 'MARHADI', NULL, NULL, NULL, 'PT Dinamika Logistindo Indonesia', NULL, '2021-03-07 16:04:33', '2021-03-07 16:04:33'),
	('120067', '0012764', 'Jaenudin', 'Ciwandan', '085795241748', 'Jaenudin@gmail.com', 'Gomes Hardianto', NULL, '2021-03-09 12:04:15', '2021-03-09 12:04:15'),
	('1200762', '0012764', 'Hendra BE', 'Ciwandan', '081364750254', 'Hendra@gmail.com', 'Gomes Hardianto', NULL, '2021-03-09 11:27:40', '2021-03-09 11:27:40'),
	('12078963', '0012764', 'Paring', NULL, NULL, NULL, 'Gomes Hardianto', NULL, '2021-03-09 10:54:20', '2021-03-09 10:54:20'),
	('2', '11111', 'NURDIN', NULL, NULL, NULL, 'PT Dinamika Logistindo Indonesia', NULL, '2021-03-07 16:04:50', '2021-03-07 16:04:50');
/*!40000 ALTER TABLE `driver` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.expenses
CREATE TABLE IF NOT EXISTS `expenses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '0:open, 1: approved, 2: canceled',
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_user_id_foreign` (`user_id`),
  CONSTRAINT `expenses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.expenses: ~0 rows (approximately)
/*!40000 ALTER TABLE `expenses` DISABLE KEYS */;
REPLACE INTO `expenses` (`id`, `description`, `price`, `note`, `user_id`, `status`, `reason`, `created_at`, `updated_at`) VALUES
	(3, 'as', 12456, 'test', 3, '1', NULL, '2020-03-13 16:39:19', '2020-03-13 16:39:19');
/*!40000 ALTER TABLE `expenses` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.failed_jobs: ~0 rows (approximately)
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.laundry_prices
CREATE TABLE IF NOT EXISTS `laundry_prices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `laundry_type_id` bigint(20) unsigned NOT NULL,
  `price` int(11) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `laundry_prices_laundry_type_id_foreign` (`laundry_type_id`),
  KEY `laundry_prices_user_id_foreign` (`user_id`),
  CONSTRAINT `laundry_prices_laundry_type_id_foreign` FOREIGN KEY (`laundry_type_id`) REFERENCES `laundry_types` (`id`),
  CONSTRAINT `laundry_prices_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.laundry_prices: ~0 rows (approximately)
/*!40000 ALTER TABLE `laundry_prices` DISABLE KEYS */;
/*!40000 ALTER TABLE `laundry_prices` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.laundry_types
CREATE TABLE IF NOT EXISTS `laundry_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.laundry_types: ~0 rows (approximately)
/*!40000 ALTER TABLE `laundry_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `laundry_types` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.migrations: ~34 rows (approximately)
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
REPLACE INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2019_04_07_142933_create_outlets_table', 1),
	(4, '2019_04_07_143639_add_relationships_users_to_outlets_table', 1),
	(5, '2019_04_07_144026_create_customers_table', 1),
	(6, '2019_04_07_145202_create_expenses_table', 1),
	(7, '2019_04_07_150135_create_laundry_types_table', 1),
	(8, '2019_04_07_150816_create_laundry_prices_table', 1),
	(9, '2019_04_07_151531_create_transactions_table', 1),
	(10, '2019_04_07_152723_create_detail_transactions_table', 1),
	(11, '2019_07_19_024300_create_permission_tables', 1),
	(12, '2019_07_26_094047_add_field_status_to_expenses_table', 1),
	(22, '2020_02_10_182017_create_surat_jalan_pallet_table', 2),
	(39, '2020_02_15_090834_create_auto_numbers_table', 4),
	(40, '2020_02_15_090834_create_ber_missing_pallet_table', 4),
	(41, '2020_02_15_090834_create_driver_table', 4),
	(42, '2020_02_15_090834_create_failed_jobs_table', 4),
	(43, '2020_02_15_090834_create_mst_transaction_table', 4),
	(44, '2020_02_15_090834_create_oauth_access_tokens_table', 4),
	(45, '2020_02_15_090834_create_oauth_auth_codes_table', 4),
	(46, '2020_02_15_090834_create_oauth_clients_table', 4),
	(47, '2020_02_15_090834_create_oauth_personal_access_clients_table', 4),
	(48, '2020_02_15_090834_create_oauth_refresh_tokens_table', 4),
	(49, '2020_02_15_090834_create_organization_table', 4),
	(50, '2020_02_15_090834_create_pallet_transfer_table', 4),
	(51, '2020_02_15_090834_create_pool_pallet_table', 4),
	(52, '2020_02_15_090834_create_sjp_status_table', 4),
	(53, '2020_02_15_090834_create_surat_jalan_pallet_table', 4),
	(54, '2020_02_15_090834_create_transporter_table', 4),
	(55, '2020_02_15_090834_create_user_table', 4),
	(56, '2020_02_15_090834_create_vehicle_table', 4),
	(57, '2020_02_15_090844_add_foreign_keys_to_ber_missing_pallet_table', 4),
	(67, '2019_07_26_110801_create_notifications_table', 5),
	(68, '2019_08_13_005334_change_field_courier_id_on_customers_table', 5);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.model_has_permissions
CREATE TABLE IF NOT EXISTS `model_has_permissions` (
  `permission_id` int(10) unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.model_has_permissions: ~0 rows (approximately)
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.model_has_roles
CREATE TABLE IF NOT EXISTS `model_has_roles` (
  `role_id` int(10) unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.model_has_roles: ~186 rows (approximately)
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
REPLACE INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
	(1, 'App\\User', 1),
	(1, 'App\\User', 3),
	(1, 'App\\User', 18),
	(1, 'App\\User', 87),
	(1, 'App\\User', 11111111243),
	(2, 'App\\User', 48),
	(2, 'App\\User', 11111111118),
	(2, 'App\\User', 11111111119),
	(2, 'App\\User', 11111111120),
	(2, 'App\\User', 11111111121),
	(2, 'App\\User', 11111111122),
	(2, 'App\\User', 11111111123),
	(2, 'App\\User', 11111111124),
	(2, 'App\\User', 11111111125),
	(2, 'App\\User', 11111111126),
	(2, 'App\\User', 11111111135),
	(2, 'App\\User', 11111111151),
	(2, 'App\\User', 11111111169),
	(2, 'App\\User', 11111111231),
	(4, 'App\\User', 20),
	(4, 'App\\User', 40),
	(4, 'App\\User', 41),
	(4, 'App\\User', 42),
	(4, 'App\\User', 47),
	(4, 'App\\User', 11111111116),
	(4, 'App\\User', 11111111144),
	(4, 'App\\User', 11111111242),
	(4, 'App\\User', 11111111244),
	(5, 'App\\User', 19),
	(5, 'App\\User', 11111111136),
	(5, 'App\\User', 11111111137),
	(5, 'App\\User', 11111111138),
	(5, 'App\\User', 11111111143),
	(5, 'App\\User', 11111111154),
	(5, 'App\\User', 11111111158),
	(5, 'App\\User', 11111111162),
	(5, 'App\\User', 11111111166),
	(5, 'App\\User', 11111111167),
	(5, 'App\\User', 11111111174),
	(5, 'App\\User', 11111111175),
	(5, 'App\\User', 11111111178),
	(5, 'App\\User', 11111111179),
	(5, 'App\\User', 11111111182),
	(5, 'App\\User', 11111111183),
	(5, 'App\\User', 11111111185),
	(5, 'App\\User', 11111111189),
	(5, 'App\\User', 11111111190),
	(5, 'App\\User', 11111111191),
	(5, 'App\\User', 11111111192),
	(5, 'App\\User', 11111111196),
	(5, 'App\\User', 11111111197),
	(5, 'App\\User', 11111111198),
	(5, 'App\\User', 11111111199),
	(5, 'App\\User', 11111111202),
	(5, 'App\\User', 11111111203),
	(5, 'App\\User', 11111111204),
	(5, 'App\\User', 11111111205),
	(5, 'App\\User', 11111111207),
	(5, 'App\\User', 11111111208),
	(5, 'App\\User', 11111111209),
	(5, 'App\\User', 11111111232),
	(5, 'App\\User', 11111111238),
	(6, 'App\\User', 15),
	(6, 'App\\User', 16),
	(6, 'App\\User', 55),
	(6, 'App\\User', 56),
	(6, 'App\\User', 57),
	(6, 'App\\User', 58),
	(6, 'App\\User', 59),
	(6, 'App\\User', 60),
	(6, 'App\\User', 61),
	(6, 'App\\User', 62),
	(6, 'App\\User', 63),
	(6, 'App\\User', 64),
	(6, 'App\\User', 65),
	(6, 'App\\User', 66),
	(6, 'App\\User', 67),
	(6, 'App\\User', 68),
	(6, 'App\\User', 69),
	(6, 'App\\User', 70),
	(6, 'App\\User', 71),
	(6, 'App\\User', 72),
	(6, 'App\\User', 73),
	(6, 'App\\User', 74),
	(6, 'App\\User', 75),
	(6, 'App\\User', 76),
	(6, 'App\\User', 77),
	(6, 'App\\User', 78),
	(6, 'App\\User', 79),
	(6, 'App\\User', 80),
	(6, 'App\\User', 11111111206),
	(6, 'App\\User', 11111111214),
	(6, 'App\\User', 11111111215),
	(6, 'App\\User', 11111111216),
	(6, 'App\\User', 11111111217),
	(8, 'App\\User', 7),
	(8, 'App\\User', 23),
	(8, 'App\\User', 24),
	(8, 'App\\User', 11111111145),
	(8, 'App\\User', 11111111234),
	(8, 'App\\User', 11111111236),
	(9, 'App\\User', 6),
	(9, 'App\\User', 8),
	(9, 'App\\User', 9),
	(9, 'App\\User', 10),
	(9, 'App\\User', 11),
	(9, 'App\\User', 12),
	(9, 'App\\User', 13),
	(9, 'App\\User', 14),
	(9, 'App\\User', 26),
	(9, 'App\\User', 43),
	(9, 'App\\User', 44),
	(9, 'App\\User', 45),
	(9, 'App\\User', 46),
	(9, 'App\\User', 49),
	(9, 'App\\User', 51),
	(9, 'App\\User', 52),
	(9, 'App\\User', 53),
	(9, 'App\\User', 54),
	(9, 'App\\User', 86),
	(9, 'App\\User', 11111111115),
	(9, 'App\\User', 11111111127),
	(9, 'App\\User', 11111111128),
	(9, 'App\\User', 11111111129),
	(9, 'App\\User', 11111111130),
	(9, 'App\\User', 11111111132),
	(9, 'App\\User', 11111111133),
	(9, 'App\\User', 11111111134),
	(9, 'App\\User', 11111111139),
	(9, 'App\\User', 11111111140),
	(9, 'App\\User', 11111111141),
	(9, 'App\\User', 11111111142),
	(9, 'App\\User', 11111111146),
	(9, 'App\\User', 11111111147),
	(9, 'App\\User', 11111111148),
	(9, 'App\\User', 11111111149),
	(9, 'App\\User', 11111111150),
	(9, 'App\\User', 11111111152),
	(9, 'App\\User', 11111111153),
	(9, 'App\\User', 11111111155),
	(9, 'App\\User', 11111111156),
	(9, 'App\\User', 11111111157),
	(9, 'App\\User', 11111111159),
	(9, 'App\\User', 11111111160),
	(9, 'App\\User', 11111111161),
	(9, 'App\\User', 11111111163),
	(9, 'App\\User', 11111111164),
	(9, 'App\\User', 11111111165),
	(9, 'App\\User', 11111111168),
	(9, 'App\\User', 11111111170),
	(9, 'App\\User', 11111111171),
	(9, 'App\\User', 11111111172),
	(9, 'App\\User', 11111111173),
	(9, 'App\\User', 11111111176),
	(9, 'App\\User', 11111111177),
	(9, 'App\\User', 11111111180),
	(9, 'App\\User', 11111111181),
	(9, 'App\\User', 11111111184),
	(9, 'App\\User', 11111111186),
	(9, 'App\\User', 11111111187),
	(9, 'App\\User', 11111111188),
	(9, 'App\\User', 11111111193),
	(9, 'App\\User', 11111111194),
	(9, 'App\\User', 11111111195),
	(9, 'App\\User', 11111111200),
	(9, 'App\\User', 11111111201),
	(9, 'App\\User', 11111111210),
	(9, 'App\\User', 11111111211),
	(9, 'App\\User', 11111111212),
	(9, 'App\\User', 11111111213),
	(9, 'App\\User', 11111111218),
	(9, 'App\\User', 11111111219),
	(9, 'App\\User', 11111111220),
	(9, 'App\\User', 11111111221),
	(9, 'App\\User', 11111111222),
	(9, 'App\\User', 11111111223),
	(9, 'App\\User', 11111111224),
	(9, 'App\\User', 11111111225),
	(9, 'App\\User', 11111111226),
	(9, 'App\\User', 11111111227),
	(9, 'App\\User', 11111111228),
	(9, 'App\\User', 11111111229),
	(9, 'App\\User', 11111111230),
	(9, 'App\\User', 11111111233),
	(9, 'App\\User', 11111111235),
	(9, 'App\\User', 11111111237);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.mst_transaction
CREATE TABLE IF NOT EXISTS `mst_transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.mst_transaction: ~2 rows (approximately)
/*!40000 ALTER TABLE `mst_transaction` DISABLE KEYS */;
REPLACE INTO `mst_transaction` (`id`, `transaction`, `description`) VALUES
	(1, 'SEND', 'send from departure to destination'),
	(2, 'SEND_BACK', 'send back from destination to departure');
/*!40000 ALTER TABLE `mst_transaction` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.new_pallet
CREATE TABLE IF NOT EXISTS `new_pallet` (
  `new_pallet_id` int(11) NOT NULL AUTO_INCREMENT,
  `adder_user_id` bigint(20) DEFAULT NULL,
  `pool_pallet_id` varchar(100) NOT NULL,
  `np_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `good_pallet` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '0: Added, 1: Cancelled',
  `vendor` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vehicle` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `driver` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`new_pallet_id`),
  KEY `adder_user_id_fk` (`adder_user_id`),
  KEY `pool_pallet_id_fk` (`pool_pallet_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table cemindo_prod_tufpal.new_pallet: ~2 rows (approximately)
/*!40000 ALTER TABLE `new_pallet` DISABLE KEYS */;
REPLACE INTO `new_pallet` (`new_pallet_id`, `adder_user_id`, `pool_pallet_id`, `np_number`, `good_pallet`, `status`, `vendor`, `vehicle`, `driver`, `note`, `updated_by`, `created_at`, `updated_at`) VALUES
	(1, 11111111244, 'pooldli', 'NP-202103-00001', 250, 0, 'Pallet Vendor', 'BK9617CW', 'marhadi', 'penerimaan pallet baru 250 pcs', NULL, '2021-03-09 00:40:47', '2021-03-09 00:40:47'),
	(2, 11111111244, 'pooldli', 'NP-202103-00002', 250, 0, 'Pallet Vendor', 'BK9632CW', 'NURDIN', 'penerimaan pallet baru 250 pcs dri loscam', NULL, '2021-03-09 00:50:05', '2021-03-09 00:50:05');
/*!40000 ALTER TABLE `new_pallet` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.notifications
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint(20) unsigned NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.notifications: ~46 rows (approximately)
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
REPLACE INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
	('076c0296-04cc-4dc4-ae7e-6528e1871f21', 'App\\Notifications\\ExpensesNotification', 'App\\User', 11, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":1,"description":"Satu","price":10000,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 05:56:04","updated_at":"2020-02-27 05:56:04"}}', NULL, '2020-02-27 05:56:10', '2020-02-27 05:56:10'),
	('0a8e52ba-93b1-47a2-9c1c-34bda04b512c', 'App\\Notifications\\ExpensesNotification', 'App\\User', 8, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":1,"description":"Satu","price":10000,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 05:56:04","updated_at":"2020-02-27 05:56:04"}}', NULL, '2020-02-27 05:56:09', '2020-02-27 05:56:09'),
	('0c2a79a5-b591-4ed0-9c75-b8524cda8210', 'App\\Notifications\\ExpensesNotification', 'App\\User', 7, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":1,"description":"Satu","price":10000,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 05:56:04","updated_at":"2020-02-27 05:56:04"}}', NULL, '2020-02-27 05:56:09', '2020-02-27 05:56:09'),
	('11b0c4a5-96ee-4788-a46f-fd7ac61e234a', 'App\\Notifications\\ExpensesNotification', 'App\\User', 4, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":2,"description":"a","price":111111,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 06:12:37","updated_at":"2020-02-27 06:12:37"}}', NULL, '2020-02-27 06:12:38', '2020-02-27 06:12:38'),
	('178edbd6-a091-448c-930d-c52be6a4de04', 'App\\Notifications\\ExpensesNotification', 'App\\User', 9, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":2,"description":"a","price":111111,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 06:12:37","updated_at":"2020-02-27 06:12:37"}}', NULL, '2020-02-27 06:12:40', '2020-02-27 06:12:40'),
	('1e6c8f9b-b2c4-4017-9dbd-17ec81f79487', 'App\\Notifications\\ExpensesNotification', 'App\\User', 10, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":1,"description":"Satu","price":10000,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 05:56:04","updated_at":"2020-02-27 05:56:04"}}', NULL, '2020-02-27 05:56:10', '2020-02-27 05:56:10'),
	('28886527-dc31-4816-ba42-0b0629433f87', 'App\\Notifications\\ExpensesNotification', 'App\\User', 12, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":1,"description":"Satu","price":10000,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 05:56:04","updated_at":"2020-02-27 05:56:04"}}', NULL, '2020-02-27 05:56:11', '2020-02-27 05:56:11'),
	('28a86ba8-7b3b-4041-97fe-2a357d5cd7ed', 'App\\Notifications\\ExpensesNotification', 'App\\User', 17, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":1,"description":"Satu","price":10000,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 05:56:04","updated_at":"2020-02-27 05:56:04"}}', NULL, '2020-02-27 05:56:13', '2020-02-27 05:56:13'),
	('34b516ab-205a-4934-beac-7d328a24262e', 'App\\Notifications\\ExpensesNotification', 'App\\User', 17, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":2,"description":"a","price":111111,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 06:12:37","updated_at":"2020-02-27 06:12:37"}}', NULL, '2020-02-27 06:12:43', '2020-02-27 06:12:43'),
	('3d44adcc-b4f2-4ba4-bc7c-09275c6bae56', 'App\\Notifications\\ExpensesNotification', 'App\\User', 14, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":1,"description":"Satu","price":10000,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 05:56:04","updated_at":"2020-02-27 05:56:04"}}', NULL, '2020-02-27 05:56:12', '2020-02-27 05:56:12'),
	('3f8aaff9-b265-4608-b941-8986d33dd8fa', 'App\\Notifications\\ExpensesNotification', 'App\\User', 16, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":1,"description":"Satu","price":10000,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 05:56:04","updated_at":"2020-02-27 05:56:04"}}', NULL, '2020-02-27 05:56:13', '2020-02-27 05:56:13'),
	('40b47c1e-d6aa-4695-a899-fe63e7ecdc8e', 'App\\Notifications\\ExpensesNotification', 'App\\User', 12, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":2,"description":"a","price":111111,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 06:12:37","updated_at":"2020-02-27 06:12:37"}}', NULL, '2020-02-27 06:12:41', '2020-02-27 06:12:41'),
	('413451c8-64e7-4a46-9525-aba80b8af513', 'App\\Notifications\\ExpensesNotification', 'App\\User', 3, '{"sender_id":3,"sender_name":"Aulia Harvy","expenses":{"id":3,"description":"as","price":12456,"note":"test","user_id":3,"status":"1","reason":null,"created_at":"2020-03-13 16:39:19","updated_at":"2020-03-13 16:39:19"}}', NULL, '2020-03-13 16:39:20', '2020-03-13 16:39:20'),
	('435d8252-b511-44b0-a883-e299343c031f', 'App\\Notifications\\ExpensesNotification', 'App\\User', 11, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":2,"description":"a","price":111111,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 06:12:37","updated_at":"2020-02-27 06:12:37"}}', NULL, '2020-02-27 06:12:40', '2020-02-27 06:12:40'),
	('43d2e0d6-ac9a-4438-b166-de9de9046432', 'App\\Notifications\\ExpensesNotification', 'App\\User', 4, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":1,"description":"Satu","price":10000,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 05:56:04","updated_at":"2020-02-27 05:56:04"}}', NULL, '2020-02-27 05:56:08', '2020-02-27 05:56:08'),
	('445fdd3c-3140-4985-96fd-aa316063df0a', 'App\\Notifications\\ExpensesNotification', 'App\\User', 12, '{"sender_id":3,"sender_name":"Aulia Harvy","expenses":{"id":3,"description":"as","price":12456,"note":"test","user_id":3,"status":"1","reason":null,"created_at":"2020-03-13 16:39:19","updated_at":"2020-03-13 16:39:19"}}', NULL, '2020-03-13 16:39:21', '2020-03-13 16:39:21'),
	('494824a0-ef1d-4ed9-a6ef-04d53d5be940', 'App\\Notifications\\ExpensesNotification', 'App\\User', 1, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":2,"description":"a","price":111111,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 06:12:37","updated_at":"2020-02-27 06:12:37"}}', NULL, '2020-02-27 06:12:37', '2020-02-27 06:12:37'),
	('4bfae4ff-1a6c-4c9a-955e-65d38d61cf38', 'App\\Notifications\\ExpensesNotification', 'App\\User', 13, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":2,"description":"a","price":111111,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 06:12:37","updated_at":"2020-02-27 06:12:37"}}', NULL, '2020-02-27 06:12:41', '2020-02-27 06:12:41'),
	('53e3495e-ef9e-415d-8309-32ebb4550dac', 'App\\Notifications\\ExpensesNotification', 'App\\User', 13, '{"sender_id":3,"sender_name":"Aulia Harvy","expenses":{"id":3,"description":"as","price":12456,"note":"test","user_id":3,"status":"1","reason":null,"created_at":"2020-03-13 16:39:19","updated_at":"2020-03-13 16:39:19"}}', NULL, '2020-03-13 16:39:21', '2020-03-13 16:39:21'),
	('55c7e84a-7ab2-4b3c-885a-8e46c0861806', 'App\\Notifications\\ExpensesNotification', 'App\\User', 15, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":1,"description":"Satu","price":10000,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 05:56:04","updated_at":"2020-02-27 05:56:04"}}', NULL, '2020-02-27 05:56:12', '2020-02-27 05:56:12'),
	('56d34ccc-bb00-4427-8e92-c51e9c697f0d', 'App\\Notifications\\ExpensesNotification', 'App\\User', 1, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":1,"description":"Satu","price":10000,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 05:56:04","updated_at":"2020-02-27 05:56:04"}}', NULL, '2020-02-27 05:56:07', '2020-02-27 05:56:07'),
	('5c64d074-4716-449f-9115-6d52c52d28e4', 'App\\Notifications\\ExpensesNotification', 'App\\User', 13, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":1,"description":"Satu","price":10000,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 05:56:04","updated_at":"2020-02-27 05:56:04"}}', NULL, '2020-02-27 05:56:11', '2020-02-27 05:56:11'),
	('65d049e7-b3ab-491f-9faa-c7f9226a021f', 'App\\Notifications\\ExpensesNotification', 'App\\User', 14, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":2,"description":"a","price":111111,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 06:12:37","updated_at":"2020-02-27 06:12:37"}}', NULL, '2020-02-27 06:12:42', '2020-02-27 06:12:42'),
	('748593b3-7a3f-499b-b23d-27083fc48f63', 'App\\Notifications\\ExpensesNotification', 'App\\User', 9, '{"sender_id":3,"sender_name":"Aulia Harvy","expenses":{"id":3,"description":"as","price":12456,"note":"test","user_id":3,"status":"1","reason":null,"created_at":"2020-03-13 16:39:19","updated_at":"2020-03-13 16:39:19"}}', NULL, '2020-03-13 16:39:20', '2020-03-13 16:39:20'),
	('798dbec7-aa60-41a7-b820-d822ff5b3d9a', 'App\\Notifications\\ExpensesNotification', 'App\\User', 5, '{"sender_id":3,"sender_name":"Aulia Harvy","expenses":{"id":3,"description":"as","price":12456,"note":"test","user_id":3,"status":"1","reason":null,"created_at":"2020-03-13 16:39:19","updated_at":"2020-03-13 16:39:19"}}', NULL, '2020-03-13 16:39:20', '2020-03-13 16:39:20'),
	('7c099b18-466c-4001-8bb9-4e54bd33c75c', 'App\\Notifications\\ExpensesNotification', 'App\\User', 11, '{"sender_id":3,"sender_name":"Aulia Harvy","expenses":{"id":3,"description":"as","price":12456,"note":"test","user_id":3,"status":"1","reason":null,"created_at":"2020-03-13 16:39:19","updated_at":"2020-03-13 16:39:19"}}', NULL, '2020-03-13 16:39:21', '2020-03-13 16:39:21'),
	('7d07d52c-43e6-4e57-8d86-2a85eeff4b91', 'App\\Notifications\\ExpensesNotification', 'App\\User', 14, '{"sender_id":3,"sender_name":"Aulia Harvy","expenses":{"id":3,"description":"as","price":12456,"note":"test","user_id":3,"status":"1","reason":null,"created_at":"2020-03-13 16:39:19","updated_at":"2020-03-13 16:39:19"}}', NULL, '2020-03-13 16:39:21', '2020-03-13 16:39:21'),
	('87555ff6-e29a-4d59-a0d5-bab9465a7093', 'App\\Notifications\\ExpensesNotification', 'App\\User', 16, '{"sender_id":3,"sender_name":"Aulia Harvy","expenses":{"id":3,"description":"as","price":12456,"note":"test","user_id":3,"status":"1","reason":null,"created_at":"2020-03-13 16:39:19","updated_at":"2020-03-13 16:39:19"}}', NULL, '2020-03-13 16:39:21', '2020-03-13 16:39:21'),
	('8b46c3fd-e25d-466a-8706-ad5de5d45220', 'App\\Notifications\\ExpensesNotification', 'App\\User', 20, '{"sender_id":3,"sender_name":"Aulia Harvy","expenses":{"id":3,"description":"as","price":12456,"note":"test","user_id":3,"status":"1","reason":null,"created_at":"2020-03-13 16:39:19","updated_at":"2020-03-13 16:39:19"}}', NULL, '2020-03-13 16:39:21', '2020-03-13 16:39:21'),
	('8e4f06ee-f23b-423a-8865-bd686d950844', 'App\\Notifications\\ExpensesNotification', 'App\\User', 9, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":1,"description":"Satu","price":10000,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 05:56:04","updated_at":"2020-02-27 05:56:04"}}', NULL, '2020-02-27 05:56:10', '2020-02-27 05:56:10'),
	('99d3c7c8-f11a-489a-82fd-58851fce460e', 'App\\Notifications\\ExpensesNotification', 'App\\User', 7, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":2,"description":"a","price":111111,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 06:12:37","updated_at":"2020-02-27 06:12:37"}}', NULL, '2020-02-27 06:12:39', '2020-02-27 06:12:39'),
	('9aa29f9c-cfb1-47df-a6b3-cd0727a27229', 'App\\Notifications\\ExpensesNotification', 'App\\User', 8, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":2,"description":"a","price":111111,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 06:12:37","updated_at":"2020-02-27 06:12:37"}}', NULL, '2020-02-27 06:12:39', '2020-02-27 06:12:39'),
	('a2ce42f6-d1a9-4d39-873e-dbe9bd4c06d5', 'App\\Notifications\\ExpensesNotification', 'App\\User', 6, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":2,"description":"a","price":111111,"note":null,"user_id":6,"status":"2","reason":"test","created_at":"2020-02-27 06:12:37","updated_at":"2020-02-27 06:15:46","user":{"id":6,"reference_pool_pallet_id":1,"reference_driver_id":null,"reference_transporter_id":null,"name":"Checker Pool Pallet DLI","email":"checkerpooldli@gmail.com","email_verified_at":"2020-02-18 06:33:49","photo":null,"role":"9","created_at":"2020-02-18 06:33:49","updated_at":"2020-02-27 04:07:19"}}}', NULL, '2020-02-27 06:15:46', '2020-02-27 06:15:46'),
	('a322ea81-8165-4bbe-9bcf-003f8707c2b8', 'App\\Notifications\\ExpensesNotification', 'App\\User', 10, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":2,"description":"a","price":111111,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 06:12:37","updated_at":"2020-02-27 06:12:37"}}', NULL, '2020-02-27 06:12:40', '2020-02-27 06:12:40'),
	('a6681f1d-5fae-4ba5-89d2-829e42600629', 'App\\Notifications\\ExpensesNotification', 'App\\User', 15, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":2,"description":"a","price":111111,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 06:12:37","updated_at":"2020-02-27 06:12:37"}}', NULL, '2020-02-27 06:12:42', '2020-02-27 06:12:42'),
	('b0c2bb83-85b8-49f0-92fe-c3f0165c3e0a', 'App\\Notifications\\ExpensesNotification', 'App\\User', 19, '{"sender_id":3,"sender_name":"Aulia Harvy","expenses":{"id":3,"description":"as","price":12456,"note":"test","user_id":3,"status":"1","reason":null,"created_at":"2020-03-13 16:39:19","updated_at":"2020-03-13 16:39:19"}}', NULL, '2020-03-13 16:39:21', '2020-03-13 16:39:21'),
	('b1cd1317-cf9d-472e-9151-07025617aaef', 'App\\Notifications\\ExpensesNotification', 'App\\User', 15, '{"sender_id":3,"sender_name":"Aulia Harvy","expenses":{"id":3,"description":"as","price":12456,"note":"test","user_id":3,"status":"1","reason":null,"created_at":"2020-03-13 16:39:19","updated_at":"2020-03-13 16:39:19"}}', NULL, '2020-03-13 16:39:21', '2020-03-13 16:39:21'),
	('b75643dd-058d-4732-ac8a-75faff542c35', 'App\\Notifications\\ExpensesNotification', 'App\\User', 5, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":2,"description":"a","price":111111,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 06:12:37","updated_at":"2020-02-27 06:12:37"}}', NULL, '2020-02-27 06:12:38', '2020-02-27 06:12:38'),
	('bb36bf18-11e6-40bf-97da-fefe773de36b', 'App\\Notifications\\ExpensesNotification', 'App\\User', 17, '{"sender_id":3,"sender_name":"Aulia Harvy","expenses":{"id":3,"description":"as","price":12456,"note":"test","user_id":3,"status":"1","reason":null,"created_at":"2020-03-13 16:39:19","updated_at":"2020-03-13 16:39:19"}}', NULL, '2020-03-13 16:39:21', '2020-03-13 16:39:21'),
	('d6173f5b-1bf1-499b-8d80-c4b50b1fbe24', 'App\\Notifications\\ExpensesNotification', 'App\\User', 6, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":1,"description":"Satu","price":10000,"note":null,"user_id":6,"status":"1","reason":null,"created_at":"2020-02-27 05:56:04","updated_at":"2020-02-27 05:56:34","user":{"id":6,"reference_pool_pallet_id":1,"reference_driver_id":null,"reference_transporter_id":null,"name":"Checker Pool Pallet DLI","email":"checkerpooldli@gmail.com","email_verified_at":"2020-02-18 06:33:49","photo":null,"role":"9","created_at":"2020-02-18 06:33:49","updated_at":"2020-02-27 04:07:19"}}}', NULL, '2020-02-27 05:56:35', '2020-02-27 05:56:35'),
	('d6f1a752-22cf-4da2-a31f-374c9c16dc8e', 'App\\Notifications\\ExpensesNotification', 'App\\User', 10, '{"sender_id":3,"sender_name":"Aulia Harvy","expenses":{"id":3,"description":"as","price":12456,"note":"test","user_id":3,"status":"1","reason":null,"created_at":"2020-03-13 16:39:19","updated_at":"2020-03-13 16:39:19"}}', NULL, '2020-03-13 16:39:20', '2020-03-13 16:39:20'),
	('e4ba0d93-7f1d-4891-9a7c-a5d5fa4ef5d7', 'App\\Notifications\\ExpensesNotification', 'App\\User', 16, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":2,"description":"a","price":111111,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 06:12:37","updated_at":"2020-02-27 06:12:37"}}', NULL, '2020-02-27 06:12:42', '2020-02-27 06:12:42'),
	('e6f1ad11-5c10-4450-ae8f-2a77d73baab5', 'App\\Notifications\\ExpensesNotification', 'App\\User', 18, '{"sender_id":3,"sender_name":"Aulia Harvy","expenses":{"id":3,"description":"as","price":12456,"note":"test","user_id":3,"status":"1","reason":null,"created_at":"2020-03-13 16:39:19","updated_at":"2020-03-13 16:39:19"}}', NULL, '2020-03-13 16:39:21', '2020-03-13 16:39:21'),
	('e6fdf33e-0479-41f7-8619-7282027ad8e8', 'App\\Notifications\\ExpensesNotification', 'App\\User', 8, '{"sender_id":3,"sender_name":"Aulia Harvy","expenses":{"id":3,"description":"as","price":12456,"note":"test","user_id":3,"status":"1","reason":null,"created_at":"2020-03-13 16:39:19","updated_at":"2020-03-13 16:39:19"}}', NULL, '2020-03-13 16:39:20', '2020-03-13 16:39:20'),
	('ea359bb9-dd93-48b0-ad7f-280ba1234c27', 'App\\Notifications\\ExpensesNotification', 'App\\User', 5, '{"sender_id":6,"sender_name":"Checker Pool Pallet DLI","expenses":{"id":1,"description":"Satu","price":10000,"note":null,"user_id":6,"status":"0","reason":null,"created_at":"2020-02-27 05:56:04","updated_at":"2020-02-27 05:56:04"}}', NULL, '2020-02-27 05:56:08', '2020-02-27 05:56:08'),
	('f3f469cf-b585-4d1d-9e12-d60777bebf5d', 'App\\Notifications\\ExpensesNotification', 'App\\User', 7, '{"sender_id":3,"sender_name":"Aulia Harvy","expenses":{"id":3,"description":"as","price":12456,"note":"test","user_id":3,"status":"1","reason":null,"created_at":"2020-03-13 16:39:19","updated_at":"2020-03-13 16:39:19"}}', NULL, '2020-03-13 16:39:20', '2020-03-13 16:39:20');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.oauth_access_tokens
CREATE TABLE IF NOT EXISTS `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.oauth_access_tokens: ~0 rows (approximately)
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.oauth_auth_codes
CREATE TABLE IF NOT EXISTS `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.oauth_auth_codes: ~0 rows (approximately)
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.oauth_clients
CREATE TABLE IF NOT EXISTS `oauth_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.oauth_clients: ~0 rows (approximately)
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.oauth_personal_access_clients
CREATE TABLE IF NOT EXISTS `oauth_personal_access_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.oauth_personal_access_clients: ~0 rows (approximately)
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.oauth_refresh_tokens
CREATE TABLE IF NOT EXISTS `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.oauth_refresh_tokens: ~0 rows (approximately)
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.organization
CREATE TABLE IF NOT EXISTS `organization` (
  `organization_id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organization_address` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organization_email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.organization: ~4 rows (approximately)
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
REPLACE INTO `organization` (`organization_id`, `organization_name`, `organization_address`, `phone_number`, `organization_email`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
	(1, 'PT Dinamika Logistindo Indonesia', 'Perkantoran Buncit Mas Blok B8\r\nJL. Mampang Prapatan Raya 108\r\nKel. Duren Tiga, Kec. Pancoran\r\nJakarta Selatan â€“ 12760, Indonesia.', '+62 21 7989764, +62 21 79193612.', 'contact@dinamikalogistindo.com', NULL, NULL, NULL, NULL),
	(6, 'ARK LOGISTIC', 'Jakarta', NULL, NULL, 'PT Dinamika Logistindo Indonesia', NULL, '2021-03-07 13:13:07', '2021-03-07 13:13:07'),
	(7, 'PT CEMINDO GEMILANG', 'JAKARTA', NULL, NULL, 'PT Dinamika Logistindo Indonesia', NULL, '2021-03-08 11:51:04', '2021-03-08 11:51:04'),
	(8, 'PT Dinamika logistindo indonesia', 'Perkantoran buncit mas block B8JL Mampang Prapatan raya 108.kel duren', '62 217989764', 'Contact@dinamikalogistindo.com', 'Gomes Hardianto', NULL, '2021-03-09 10:45:28', '2021-03-09 10:45:28');
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.outlets
CREATE TABLE IF NOT EXISTS `outlets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `outlets_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.outlets: ~1 rows (approximately)
/*!40000 ALTER TABLE `outlets` DISABLE KEYS */;
REPLACE INTO `outlets` (`id`, `code`, `name`, `status`, `address`, `phone`, `created_at`, `updated_at`) VALUES
	(1, '123', 'asdasf', 0, 'asead', '1231', NULL, NULL);
/*!40000 ALTER TABLE `outlets` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.pallet_transfer
CREATE TABLE IF NOT EXISTS `pallet_transfer` (
  `pallet_transfer_id` int(11) NOT NULL AUTO_INCREMENT,
  `departure_pool_pallet_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `destination_pool_pallet_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sender_user_id` bigint(20) DEFAULT NULL,
  `receiver_user_id` bigint(20) DEFAULT NULL,
  `transporter_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `driver_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vehicle_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tp_number` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `good_pallet` int(11) DEFAULT 0,
  `tbr_pallet` int(11) DEFAULT 0,
  `reason` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL COMMENT '0: SENDING, 1: RECEIVED',
  `note` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`pallet_transfer_id`),
  UNIQUE KEY `tp_number` (`tp_number`),
  KEY `pool_pallet_pallet_transfer_fk` (`departure_pool_pallet_id`),
  KEY `pool_pallet_pallet_transfer_fk1` (`destination_pool_pallet_id`),
  KEY `user_pallet_transfer_fk` (`sender_user_id`),
  KEY `user_pallet_transfer_fk1` (`receiver_user_id`),
  KEY `transporter_pallet_transfer_fk` (`transporter_id`),
  KEY `driver_pallet_transfer_fk` (`driver_id`),
  KEY `vehicle_pallet_transfer_fk` (`vehicle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.pallet_transfer: ~0 rows (approximately)
/*!40000 ALTER TABLE `pallet_transfer` DISABLE KEYS */;
/*!40000 ALTER TABLE `pallet_transfer` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.pallet_transfer_receive_pallet
CREATE TABLE IF NOT EXISTS `pallet_transfer_receive_pallet` (
  `pallet_transfer_receive_pallet_id` int(11) NOT NULL AUTO_INCREMENT,
  `pallet_transfer_id` int(11) NOT NULL DEFAULT 0,
  `tp_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pallet_transfer_status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `receiver` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `departure_pool` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `destination_pool` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `transporter` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `driver` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `vehicle` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `good_pallet` int(11) NOT NULL DEFAULT 0,
  `tbr_pallet` int(11) NOT NULL DEFAULT 0,
  `note` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`pallet_transfer_receive_pallet_id`),
  KEY `pallet_transfer_id` (`pallet_transfer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table cemindo_prod_tufpal.pallet_transfer_receive_pallet: ~0 rows (approximately)
/*!40000 ALTER TABLE `pallet_transfer_receive_pallet` DISABLE KEYS */;
/*!40000 ALTER TABLE `pallet_transfer_receive_pallet` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.pallet_transfer_send_pallet
CREATE TABLE IF NOT EXISTS `pallet_transfer_send_pallet` (
  `pallet_transfer_send_pallet_id` int(11) NOT NULL AUTO_INCREMENT,
  `pallet_transfer_id` int(11) NOT NULL DEFAULT 0,
  `pallet_transfer_status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `departure_pool` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `destination_pool` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `transporter` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `driver` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `vehicle` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `good_pallet` int(11) NOT NULL DEFAULT 0,
  `tbr_pallet` int(11) NOT NULL DEFAULT 0,
  `note` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`pallet_transfer_send_pallet_id`),
  KEY `pallet_transfer_id` (`pallet_transfer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table cemindo_prod_tufpal.pallet_transfer_send_pallet: ~0 rows (approximately)
/*!40000 ALTER TABLE `pallet_transfer_send_pallet` DISABLE KEYS */;
/*!40000 ALTER TABLE `pallet_transfer_send_pallet` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.password_resets: ~0 rows (approximately)
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.permissions: ~80 rows (approximately)
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
REPLACE INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(1, 'read sjps', 'web', '2020-02-24 09:38:14', '2020-02-24 09:38:14'),
	(2, 'create sjps', 'web', '2020-02-24 09:38:26', '2020-02-24 09:38:26'),
	(3, 'update sjps', 'web', '2020-02-24 09:38:39', '2020-02-24 09:38:39'),
	(4, 'delete sjps', 'web', '2020-02-24 09:38:48', '2020-02-24 09:38:48'),
	(5, 'read sjpstatuss', 'web', '2020-02-24 09:38:59', '2020-02-24 09:38:59'),
	(6, 'create sjpstatuss', 'web', '2020-02-24 09:39:07', '2020-02-24 09:39:07'),
	(7, 'update sjpstatuss', 'web', '2020-02-24 09:39:17', '2020-02-24 09:39:17'),
	(8, 'delete sjpstatuss', 'web', '2020-02-24 09:39:24', '2020-02-24 09:39:24'),
	(9, 'read pallettransfers', 'web', '2020-02-24 09:39:38', '2020-02-24 09:39:38'),
	(10, 'create pallettransfers', 'web', '2020-02-24 09:39:44', '2020-02-24 09:39:44'),
	(11, 'update pallettransfers', 'web', '2020-02-24 09:39:54', '2020-02-24 09:39:54'),
	(12, 'delete pallettransfers', 'web', '2020-02-24 09:40:18', '2020-02-24 09:40:18'),
	(13, 'read bermissingpallets', 'web', '2020-02-24 09:40:32', '2020-02-24 09:40:32'),
	(14, 'create bermissingpallets', 'web', '2020-02-24 09:40:51', '2020-02-24 09:40:51'),
	(15, 'update bermissingpallets', 'web', '2020-02-24 09:41:23', '2020-02-24 09:41:23'),
	(16, 'delete bermissingpallets', 'web', '2020-02-24 09:41:31', '2020-02-24 09:41:31'),
	(17, 'read poolpallets', 'web', '2020-02-24 09:41:43', '2020-02-24 09:41:43'),
	(18, 'create poolpallets', 'web', '2020-02-24 09:41:50', '2020-02-24 09:41:50'),
	(19, 'update poolpallets', 'web', '2020-02-24 09:41:56', '2020-02-24 09:41:56'),
	(20, 'delete poolpallets', 'web', '2020-02-24 09:42:03', '2020-02-24 09:42:03'),
	(21, 'read transporters', 'web', '2020-02-24 09:42:23', '2020-02-24 09:42:23'),
	(22, 'create transporters', 'web', '2020-02-24 09:42:31', '2020-02-24 09:42:31'),
	(23, 'update transporters', 'web', '2020-02-24 09:42:38', '2020-02-24 09:42:38'),
	(24, 'delete transporters', 'web', '2020-02-24 09:42:45', '2020-02-24 09:42:45'),
	(25, 'read drivers', 'web', '2020-02-24 09:43:39', '2020-02-24 09:43:39'),
	(26, 'create drivers', 'web', '2020-02-24 09:43:48', '2020-02-24 09:43:48'),
	(27, 'update drivers', 'web', '2020-02-24 09:44:00', '2020-02-24 09:44:00'),
	(28, 'delete drivers', 'web', '2020-02-24 09:44:06', '2020-02-24 09:44:06'),
	(29, 'read organizations', 'web', '2020-02-24 09:44:18', '2020-02-24 09:44:18'),
	(30, 'create organizations', 'web', '2020-02-24 09:44:23', '2020-02-24 09:44:23'),
	(31, 'update organizations', 'web', '2020-02-24 09:44:30', '2020-02-24 09:44:30'),
	(32, 'delete organizations', 'web', '2020-02-24 09:44:40', '2020-02-24 09:44:40'),
	(33, 'read newpallet', 'web', '2020-02-28 06:32:58', '2020-02-28 06:32:58'),
	(34, 'create newpallet', 'web', '2020-02-28 06:33:04', '2020-02-28 06:33:04'),
	(35, 'update newpallet', 'web', '2020-02-28 06:33:12', '2020-02-28 06:33:12'),
	(36, 'delete newpallet', 'web', '2020-02-28 06:33:21', '2020-02-28 06:33:21'),
	(37, 'read dashboard', 'web', '2020-02-28 06:33:33', '2020-02-28 06:33:33'),
	(38, 'read palletmovement', 'web', '2020-02-28 06:33:44', '2020-02-28 06:33:44'),
	(39, 'read palletdeposit', 'web', '2020-02-28 06:34:14', '2020-02-28 06:34:14'),
	(40, 'read setting', 'web', '2020-02-28 06:34:22', '2020-02-28 06:34:22'),
	(41, 'read user', 'web', '2020-02-28 06:34:39', '2020-02-28 06:34:39'),
	(42, 'create user', 'web', '2020-02-28 06:34:51', '2020-02-28 06:34:51'),
	(43, 'update user', 'web', '2020-02-28 06:34:59', '2020-02-28 06:34:59'),
	(44, 'delete user', 'web', '2020-02-28 06:35:07', '2020-02-28 06:35:07'),
	(45, 'read permission', 'web', '2020-02-28 06:37:53', '2020-02-28 06:37:53'),
	(46, 'set permission', 'web', '2020-02-28 06:38:09', '2020-02-28 06:38:09'),
	(47, 'read location', 'web', '2020-03-02 06:04:54', '2020-03-02 06:04:54'),
	(48, 'read damagedpallet', 'web', '2020-03-04 09:00:33', '2020-03-04 09:00:33'),
	(49, 'create damagedpallet', 'web', '2020-03-04 09:00:46', '2020-03-04 09:00:46'),
	(50, 'update damagedpallet', 'web', '2020-03-04 09:00:53', '2020-03-04 09:00:53'),
	(51, 'delete damagedpallet', 'web', '2020-03-04 09:00:59', '2020-03-04 09:00:59'),
	(52, 'read repairedpallet', 'web', '2020-03-04 09:52:23', '2020-03-04 09:52:23'),
	(53, 'create repairedpallet', 'web', '2020-03-04 09:52:31', '2020-03-04 09:52:31'),
	(54, 'update repairedpallet', 'web', '2020-03-04 09:52:40', '2020-03-04 09:52:40'),
	(55, 'delete repairedpallet', 'web', '2020-03-04 09:52:47', '2020-03-04 09:52:47'),
	(56, 'read sjpadjusment', 'web', '2020-03-06 03:20:18', '2020-03-06 03:20:18'),
	(57, 'read sjppalletsend', 'web', '2020-03-08 18:12:28', '2020-03-08 18:12:28'),
	(58, 'read sjppalletreceive', 'web', '2020-03-08 18:12:36', '2020-03-08 18:12:36'),
	(59, 'read pallettransfersend', 'web', '2020-03-08 18:52:17', '2020-03-08 18:52:17'),
	(60, 'read pallettransferreceive', 'web', '2020-03-08 18:52:23', '2020-03-08 18:52:23'),
	(61, 'update sjpsdest', 'web', '2020-03-11 10:44:25', '2020-03-11 10:44:25'),
	(62, 'read sjpchangedestination', 'web', '2020-03-11 11:41:12', '2020-03-11 11:41:12'),
	(63, 'read alltransaction', 'web', '2020-03-26 14:33:59', '2020-03-26 14:33:59'),
	(64, 'read vehicle', 'web', '2020-05-16 16:19:55', '2020-05-16 16:19:55'),
	(65, 'read driver', 'web', '2020-05-16 16:20:02', '2020-05-16 16:20:02'),
	(66, 'create vehicle', 'web', '2020-05-16 16:20:25', '2020-05-16 16:20:25'),
	(67, 'create driver', 'web', '2020-05-16 16:20:30', '2020-05-16 16:20:30'),
	(68, 'edit vehicle', 'web', '2020-05-16 16:21:04', '2020-05-16 16:21:04'),
	(69, 'edit driver', 'web', '2020-05-16 16:21:09', '2020-05-16 16:21:09'),
	(70, 'delete vehicle', 'web', '2020-05-16 16:21:15', '2020-05-16 16:21:15'),
	(71, 'delete driver', 'web', '2020-05-16 16:21:22', '2020-05-16 16:21:22'),
	(72, 'read organization', 'web', '2020-05-16 16:21:40', '2020-05-16 16:21:40'),
	(73, 'create organization', 'web', '2020-05-16 16:21:46', '2020-05-16 16:21:46'),
	(74, 'edit organization', 'web', '2020-05-16 16:21:53', '2020-05-16 16:21:53'),
	(75, 'delete organization', 'web', '2020-05-16 16:21:59', '2020-05-16 16:21:59'),
	(76, 'read transporter adjusment', 'web', '2020-07-29 12:36:53', '2020-07-29 12:36:53'),
	(77, 'create transporter adjusment', 'web', '2020-07-29 12:37:01', '2020-07-29 12:37:01'),
	(78, 'edit transporter adjusment', 'web', '2020-07-29 12:37:09', '2020-07-29 12:37:09'),
	(79, 'delete transporter adjusment', 'web', '2020-07-29 12:37:16', '2020-07-29 12:37:16'),
	(80, 'read dashboard organization', 'web', '2020-11-01 11:24:01', '2020-11-01 11:24:01');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.photo
CREATE TABLE IF NOT EXISTS `photo` (
  `photo_id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`photo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table cemindo_prod_tufpal.photo: ~0 rows (approximately)
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.pool_pallet
CREATE TABLE IF NOT EXISTS `pool_pallet` (
  `pool_pallet_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pool_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pool_address` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pool_city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pool_email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pallet_quota` int(11) DEFAULT NULL,
  `good_pallet` int(11) DEFAULT 0,
  `tbr_pallet` int(11) DEFAULT 0,
  `ber_pallet` int(11) DEFAULT 0,
  `missing_pallet` int(11) DEFAULT 0,
  `tag` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'POOL PALLET',
  `created_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`pool_pallet_id`),
  UNIQUE KEY `pool_pallet_code_unique` (`code`),
  KEY `organization_pool_pallet_fk` (`organization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.pool_pallet: ~2 rows (approximately)
/*!40000 ALTER TABLE `pool_pallet` DISABLE KEYS */;
REPLACE INTO `pool_pallet` (`pool_pallet_id`, `organization_id`, `code`, `type`, `pool_name`, `pool_address`, `pool_city`, `phone_number`, `pool_email`, `pallet_quota`, `good_pallet`, `tbr_pallet`, `ber_pallet`, `missing_pallet`, `tag`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
	('JA001', 7, 'JA001', 'WAREHOUSE', 'JATI ASIH WH', 'Jatiasih', 'Bekasi', NULL, NULL, 1000, 72, 0, 0, 0, 'POOL PALLET', NULL, NULL, '2021-03-08 11:52:18', '2021-03-09 13:01:40'),
	('pooldli', 1, 'pooldli', 'POOL_PALLET_DLI', 'Pool Pallet Ciwandan', 'Ciwandan', 'Bogor', '089652847221', 'contact@dinamikalogistindo.com', 5000, 428, 0, 0, 0, 'POOL PALLET', NULL, 'PT Dinamika Logistindo Indonesia', '2020-03-05 07:05:37', '2021-03-09 12:08:34');
/*!40000 ALTER TABLE `pool_pallet` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.repaired_pallet
CREATE TABLE IF NOT EXISTS `repaired_pallet` (
  `repaired_pallet_id` int(11) NOT NULL AUTO_INCREMENT,
  `reporter_user_id` bigint(20) NOT NULL,
  `pool_pallet_id` varchar(100) NOT NULL,
  `rp_number` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `good_pallet` int(11) NOT NULL,
  `note` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`repaired_pallet_id`),
  KEY `reported_user_fk` (`reporter_user_id`),
  KEY `pool_pallet_fk` (`pool_pallet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table cemindo_prod_tufpal.repaired_pallet: ~0 rows (approximately)
/*!40000 ALTER TABLE `repaired_pallet` DISABLE KEYS */;
/*!40000 ALTER TABLE `repaired_pallet` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.roles: ~9 rows (approximately)
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
REPLACE INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(1, 'superadmin', 'web', '2020-02-21 08:23:48', '2020-02-21 08:23:48'),
	(2, 'director', 'web', '2020-02-21 08:24:02', '2020-02-21 08:24:02'),
	(3, 'palletcoordinator', 'web', '2020-02-21 08:24:14', '2020-02-21 08:24:14'),
	(4, 'palletcontroller', 'web', '2020-02-21 08:24:24', '2020-02-21 08:24:24'),
	(5, 'supervisor', 'web', '2020-02-21 08:24:34', '2020-02-21 08:24:34'),
	(6, 'transporteradmin', 'web', '2020-02-21 08:24:51', '2020-02-21 08:24:51'),
	(7, 'driver', 'web', '2020-02-21 08:25:01', '2020-02-21 08:25:01'),
	(8, 'inputadmin', 'web', '2020-02-21 08:25:09', '2020-02-21 08:25:09'),
	(9, 'checker', 'web', '2020-02-21 08:25:16', '2020-02-21 08:25:16');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.role_has_permissions
CREATE TABLE IF NOT EXISTS `role_has_permissions` (
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.role_has_permissions: ~183 rows (approximately)
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
REPLACE INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
	(1, 1),
	(1, 2),
	(1, 3),
	(1, 4),
	(1, 5),
	(1, 6),
	(1, 7),
	(1, 8),
	(1, 9),
	(2, 1),
	(2, 4),
	(2, 8),
	(3, 1),
	(3, 4),
	(3, 6),
	(3, 8),
	(4, 1),
	(5, 1),
	(5, 3),
	(5, 4),
	(5, 5),
	(5, 6),
	(5, 7),
	(5, 8),
	(5, 9),
	(6, 1),
	(6, 4),
	(6, 9),
	(7, 1),
	(7, 4),
	(7, 6),
	(7, 9),
	(8, 1),
	(9, 1),
	(9, 3),
	(9, 4),
	(9, 5),
	(9, 8),
	(9, 9),
	(10, 1),
	(10, 4),
	(10, 9),
	(11, 1),
	(11, 4),
	(11, 9),
	(12, 1),
	(13, 1),
	(13, 3),
	(13, 4),
	(13, 5),
	(13, 8),
	(14, 1),
	(14, 4),
	(15, 1),
	(15, 4),
	(16, 1),
	(17, 1),
	(17, 3),
	(17, 4),
	(17, 5),
	(17, 7),
	(17, 8),
	(17, 9),
	(18, 1),
	(18, 4),
	(19, 1),
	(19, 4),
	(20, 1),
	(21, 1),
	(21, 3),
	(21, 4),
	(21, 6),
	(21, 7),
	(22, 1),
	(22, 4),
	(23, 1),
	(23, 4),
	(24, 1),
	(25, 1),
	(26, 1),
	(27, 1),
	(28, 1),
	(29, 1),
	(29, 5),
	(30, 1),
	(31, 1),
	(32, 1),
	(33, 1),
	(33, 3),
	(33, 4),
	(34, 1),
	(34, 4),
	(35, 1),
	(35, 4),
	(36, 1),
	(37, 1),
	(37, 3),
	(37, 4),
	(38, 1),
	(38, 3),
	(38, 4),
	(38, 5),
	(38, 6),
	(38, 7),
	(39, 1),
	(39, 4),
	(39, 5),
	(40, 1),
	(41, 1),
	(42, 1),
	(43, 1),
	(44, 1),
	(45, 1),
	(46, 1),
	(47, 1),
	(47, 7),
	(48, 1),
	(48, 3),
	(48, 4),
	(48, 5),
	(48, 9),
	(49, 1),
	(49, 4),
	(49, 9),
	(50, 1),
	(50, 4),
	(51, 1),
	(52, 1),
	(52, 3),
	(52, 4),
	(53, 1),
	(53, 4),
	(54, 1),
	(54, 4),
	(55, 1),
	(56, 1),
	(56, 4),
	(56, 5),
	(57, 1),
	(57, 4),
	(57, 5),
	(57, 6),
	(58, 1),
	(58, 4),
	(58, 5),
	(58, 6),
	(59, 1),
	(59, 4),
	(59, 5),
	(60, 1),
	(60, 4),
	(60, 5),
	(61, 1),
	(61, 4),
	(61, 8),
	(62, 1),
	(62, 4),
	(62, 5),
	(62, 8),
	(63, 1),
	(63, 3),
	(63, 4),
	(63, 5),
	(63, 8),
	(64, 1),
	(65, 1),
	(66, 1),
	(67, 1),
	(68, 1),
	(69, 1),
	(70, 1),
	(71, 1),
	(72, 1),
	(72, 5),
	(73, 1),
	(74, 1),
	(75, 1),
	(76, 1),
	(77, 1),
	(78, 1),
	(79, 1),
	(80, 1),
	(80, 5);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.sjp_adjusment
CREATE TABLE IF NOT EXISTS `sjp_adjusment` (
  `sjp_adjusment_id` int(11) NOT NULL AUTO_INCREMENT,
  `sjp_id` int(11) NOT NULL DEFAULT 0,
  `sa_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sjp_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `transporter` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vehicle` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_vehicle` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `driver` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_driver` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adjust_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`sjp_adjusment_id`),
  KEY `sjp_id` (`sjp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table cemindo_prod_tufpal.sjp_adjusment: ~0 rows (approximately)
/*!40000 ALTER TABLE `sjp_adjusment` DISABLE KEYS */;
/*!40000 ALTER TABLE `sjp_adjusment` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.sjp_change_destination
CREATE TABLE IF NOT EXISTS `sjp_change_destination` (
  `sjp_change_destination_id` int(11) NOT NULL AUTO_INCREMENT,
  `sjp_id` int(11) NOT NULL DEFAULT 0,
  `scd_number` varchar(100) DEFAULT NULL,
  `sjp_number` varchar(100) DEFAULT NULL,
  `no_do` varchar(50) DEFAULT NULL,
  `new_no_do` varchar(50) DEFAULT NULL,
  `destination` varchar(100) DEFAULT NULL,
  `new_destination` varchar(100) DEFAULT NULL,
  `adjust_by` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`sjp_change_destination_id`),
  KEY `sjp_id` (`sjp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table cemindo_prod_tufpal.sjp_change_destination: ~0 rows (approximately)
/*!40000 ALTER TABLE `sjp_change_destination` DISABLE KEYS */;
/*!40000 ALTER TABLE `sjp_change_destination` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.sjp_pallet_receive
CREATE TABLE IF NOT EXISTS `sjp_pallet_receive` (
  `sjp_pallet_receive_id` int(11) NOT NULL AUTO_INCREMENT,
  `sjp_status_id` int(11) NOT NULL DEFAULT 0,
  `sjp_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sjp_status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receiver` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `departure_pool` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `destination_pool` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transporter` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `driver` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vehicle` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `good_pallet` int(11) DEFAULT 0,
  `tbr_pallet` int(11) DEFAULT 0,
  `ber_pallet` int(11) DEFAULT 0,
  `missing_pallet` int(11) DEFAULT 0,
  `good_cement` int(11) DEFAULT 0,
  `bad_cement` int(11) DEFAULT 0,
  `receiving_driver_approval` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Send Driver Digital Signature',
  `note` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`sjp_pallet_receive_id`),
  KEY `sjp_status_id` (`sjp_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data for table cemindo_prod_tufpal.sjp_pallet_receive: ~3 rows (approximately)
/*!40000 ALTER TABLE `sjp_pallet_receive` DISABLE KEYS */;
REPLACE INTO `sjp_pallet_receive` (`sjp_pallet_receive_id`, `sjp_status_id`, `sjp_number`, `sjp_status`, `receiver`, `departure_pool`, `destination_pool`, `transporter`, `driver`, `vehicle`, `good_pallet`, `tbr_pallet`, `ber_pallet`, `missing_pallet`, `good_cement`, `bad_cement`, `receiving_driver_approval`, `note`, `created_at`, `updated_at`) VALUES
	(1, 1, 'SJP-202103-00001', 'RECEIVE', 'Tommy', 'Pool Pallet Ciwandan', 'JATI ASIH WH', 'Andalan Nusa pratama', 'Paring', 'B 9505 YM', 24, 0, 0, 0, 1350, 0, NULL, 'null', '2021-03-09 12:58:37', '2021-03-09 12:58:37'),
	(2, 2, 'SJP-202103-00003', 'RECEIVE', 'Tommy', 'Pool Pallet Ciwandan', 'JATI ASIH WH', 'Andalan Nusa pratama', 'Hendra BE', 'B9644yn', 24, 0, 0, 0, 1350, 0, NULL, 'null', '2021-03-09 13:01:11', '2021-03-09 13:01:11'),
	(3, 3, 'SJP-202103-00004', 'RECEIVE', 'Tommy', 'Pool Pallet Ciwandan', 'JATI ASIH WH', 'Andalan Nusa pratama', 'Jaenudin', 'B9867 YN', 24, 0, 0, 0, 1350, 0, NULL, 'null', '2021-03-09 13:01:40', '2021-03-09 13:01:40');
/*!40000 ALTER TABLE `sjp_pallet_receive` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.sjp_pallet_send
CREATE TABLE IF NOT EXISTS `sjp_pallet_send` (
  `sjp_pallet_send_id` int(11) NOT NULL AUTO_INCREMENT,
  `sjp_status_id` int(11) NOT NULL DEFAULT 0,
  `sjp_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sjp_status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sender` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `departure_pool` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `destination_pool` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transporter` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `driver` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vehicle` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `good_pallet` int(11) DEFAULT 0,
  `tbr_pallet` int(11) DEFAULT 0,
  `ber_pallet` int(11) DEFAULT 0,
  `missing_pallet` int(11) DEFAULT 0,
  `good_cement` int(11) DEFAULT 0,
  `bad_cement` int(11) DEFAULT 0,
  `sending_driver_approval` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Send Driver Digital Signature',
  `note` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`sjp_pallet_send_id`),
  KEY `sjp_status_id` (`sjp_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Dumping data for table cemindo_prod_tufpal.sjp_pallet_send: ~6 rows (approximately)
/*!40000 ALTER TABLE `sjp_pallet_send` DISABLE KEYS */;
REPLACE INTO `sjp_pallet_send` (`sjp_pallet_send_id`, `sjp_status_id`, `sjp_number`, `sjp_status`, `sender`, `departure_pool`, `destination_pool`, `transporter`, `driver`, `vehicle`, `good_pallet`, `tbr_pallet`, `ber_pallet`, `missing_pallet`, `good_cement`, `bad_cement`, `sending_driver_approval`, `note`, `created_at`, `updated_at`) VALUES
	(1, 1, 'SJP-202103-00001', 'SEND', 'Gomes Hardianto', 'Pool Pallet Ciwandan', 'JATI ASIH WH', 'Andalan Nusa pratama', 'Paring', 'B 9505 YM', 24, 0, 0, 0, 1350, 0, NULL, NULL, '2021-03-09 11:00:16', '2021-03-09 11:00:16'),
	(2, 2, 'SJP-202103-00003', 'SEND', 'Gomes Hardianto', 'Pool Pallet Ciwandan', 'JATI ASIH WH', 'Andalan Nusa pratama', 'Hendra BE', 'B9644yn', 24, 0, 0, 0, 1350, 0, NULL, NULL, '2021-03-09 12:08:20', '2021-03-09 12:08:20'),
	(3, 3, 'SJP-202103-00004', 'SEND', 'Gomes Hardianto', 'Pool Pallet Ciwandan', 'JATI ASIH WH', 'Andalan Nusa pratama', 'Jaenudin', 'B9867 YN', 24, 0, 0, 0, 1350, 0, NULL, NULL, '2021-03-09 12:08:34', '2021-03-09 12:08:34'),
	(4, 4, 'SJP-202103-00001', 'SEND BACK', 'Tommy', 'JATI ASIH WH', 'Pool Pallet Ciwandan', 'Andalan Nusa pratama', 'Paring', 'B 9505 YM', 0, 0, 0, 0, 0, 0, NULL, NULL, '2021-03-09 13:00:42', '2021-03-09 13:00:42'),
	(5, 5, 'SJP-202103-00003', 'SEND BACK', 'Tommy', 'JATI ASIH WH', 'Pool Pallet Ciwandan', 'Andalan Nusa pratama', 'Hendra BE', 'B9644yn', 0, 0, 0, 0, 0, 0, NULL, NULL, '2021-03-09 13:01:20', '2021-03-09 13:01:20'),
	(6, 6, 'SJP-202103-00004', 'SEND BACK', 'Tommy', 'JATI ASIH WH', 'Pool Pallet Ciwandan', 'Andalan Nusa pratama', 'Jaenudin', 'B9867 YN', 0, 0, 0, 0, 0, 0, NULL, NULL, '2021-03-09 13:01:47', '2021-03-09 13:01:47');
/*!40000 ALTER TABLE `sjp_pallet_send` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.sjp_photo
CREATE TABLE IF NOT EXISTS `sjp_photo` (
  `sjp_id` int(11) NOT NULL,
  `photo_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table cemindo_prod_tufpal.sjp_photo: ~0 rows (approximately)
/*!40000 ALTER TABLE `sjp_photo` DISABLE KEYS */;
/*!40000 ALTER TABLE `sjp_photo` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.sjp_status
CREATE TABLE IF NOT EXISTS `sjp_status` (
  `sjp_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `checker_send_user_id` bigint(20) NOT NULL,
  `checker_receive_user_id` bigint(20) DEFAULT NULL,
  `sjp_id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `sjps_number` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(11) DEFAULT NULL COMMENT '0: send, 1: received, 2: cancel_open,',
  `good_pallet` int(11) NOT NULL DEFAULT 0,
  `tbr_pallet` int(11) NOT NULL DEFAULT 0,
  `ber_pallet` int(11) NOT NULL DEFAULT 0,
  `missing_pallet` int(11) NOT NULL DEFAULT 0,
  `good_cement` int(11) DEFAULT 0,
  `bad_cement` int(11) NOT NULL DEFAULT 0,
  `driver_approve` int(11) NOT NULL DEFAULT 0 COMMENT '1: Send Approve, 2: Receive Approve',
  `sending_driver_approval` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Send Driver Digital Signature',
  `receiving_driver_approval` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Receive Driver Digital Signature',
  `note` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`sjp_status_id`),
  KEY `user_sjp_status_fk` (`checker_send_user_id`),
  KEY `surat_jalan_pallet_sjp_status_fk` (`sjp_id`),
  KEY `transaction_fk` (`transaction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.sjp_status: ~6 rows (approximately)
/*!40000 ALTER TABLE `sjp_status` DISABLE KEYS */;
REPLACE INTO `sjp_status` (`sjp_status_id`, `checker_send_user_id`, `checker_receive_user_id`, `sjp_id`, `transaction_id`, `sjps_number`, `status`, `good_pallet`, `tbr_pallet`, `ber_pallet`, `missing_pallet`, `good_cement`, `bad_cement`, `driver_approve`, `sending_driver_approval`, `receiving_driver_approval`, `note`, `created_at`, `updated_at`) VALUES
	(1, 11111111243, 11111111242, 1, 1, 'SJPS-202103-00001', 1, 24, 0, 0, 0, 1350, 0, 2, NULL, NULL, 'null', '2021-03-09 11:00:16', '2021-03-09 12:58:37'),
	(2, 11111111243, 11111111242, 3, 1, 'SJPS-202103-00002', 1, 24, 0, 0, 0, 1350, 0, 2, NULL, NULL, 'null', '2021-03-09 12:08:20', '2021-03-09 13:01:11'),
	(3, 11111111243, 11111111242, 4, 1, 'SJPS-202103-00003', 1, 24, 0, 0, 0, 1350, 0, 2, NULL, NULL, 'null', '2021-03-09 12:08:34', '2021-03-09 13:01:40'),
	(4, 11111111242, 5, 1, 2, 'SJPS-202103-00004', 0, 0, 0, 0, 0, 0, 0, 1, NULL, NULL, NULL, '2021-03-09 13:00:41', '2021-03-09 13:00:41'),
	(5, 11111111242, 5, 3, 2, 'SJPS-202103-00005', 0, 0, 0, 0, 0, 0, 0, 1, NULL, NULL, NULL, '2021-03-09 13:01:20', '2021-03-09 13:01:20'),
	(6, 11111111242, 5, 4, 2, 'SJPS-202103-00006', 0, 0, 0, 0, 0, 0, 0, 1, NULL, NULL, NULL, '2021-03-09 13:01:47', '2021-03-09 13:01:47');
/*!40000 ALTER TABLE `sjp_status` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.surat_jalan_pallet
CREATE TABLE IF NOT EXISTS `surat_jalan_pallet` (
  `sjp_id` int(11) NOT NULL AUTO_INCREMENT,
  `destination_pool_pallet_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `departure_pool_pallet_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vehicle_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `driver_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transporter_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sjp_number` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_do` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tonnage` int(11) NOT NULL,
  `packaging` int(11) NOT NULL,
  `product_quantity` int(11) NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `departure_time` date NOT NULL,
  `eta` date NOT NULL,
  `pallet_quantity` int(11) NOT NULL,
  `state` int(11) NOT NULL COMMENT '0: draft, 1: send, 2: received, 3: send back, 4: received sendback, 5: cancelled',
  `created_by` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adjust_by` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_sendback` int(11) NOT NULL DEFAULT 0 COMMENT '0: send, 1: snedback',
  `distribution` int(11) NOT NULL DEFAULT 0 COMMENT '0: main distribution, 1: Secondary Distribution Warehouse, 2: Secondary Distribution Station, 3: Third Distribution Station',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`sjp_id`),
  UNIQUE KEY `sjp_number` (`sjp_number`),
  UNIQUE KEY `no_do` (`no_do`),
  KEY `pool_pallet_surat_jalan_pallet_fk` (`destination_pool_pallet_id`),
  KEY `pool_pallet_surat_jalan_pallet_fk1` (`departure_pool_pallet_id`),
  KEY `vehicle_surat_jalan_pallet_fk` (`vehicle_id`),
  KEY `driver_surat_jalan_pallet_fk` (`driver_id`),
  KEY `transporter_surat_jalan_pallet_fk` (`transporter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.surat_jalan_pallet: ~4 rows (approximately)
/*!40000 ALTER TABLE `surat_jalan_pallet` DISABLE KEYS */;
REPLACE INTO `surat_jalan_pallet` (`sjp_id`, `destination_pool_pallet_id`, `departure_pool_pallet_id`, `vehicle_id`, `driver_id`, `transporter_id`, `sjp_number`, `no_do`, `product_name`, `tonnage`, `packaging`, `product_quantity`, `status`, `departure_time`, `eta`, `pallet_quantity`, `state`, `created_by`, `adjust_by`, `is_sendback`, `distribution`, `created_at`, `updated_at`) VALUES
	(1, 'JA001', 'pooldli', 'B 9505 YM', '12078963', '0012764', 'SJP-202103-00001', 'D010-1DC210300064', 'Portland Composite Cement', 48, 40, 1350, 'OPEN', '2021-03-09', '2021-03-10', 24, 3, 'Gomes Hardianto', NULL, 1, 0, '2021-03-09 10:58:03', '2021-03-09 13:00:41'),
	(2, 'JA001', 'pooldli', 'B 9644 YN', '1200762', '0012764', 'SJP-202103-00002', 'D010-1DC210300065', 'Portland Composite Cement', 54, 40, 1350, 'CLOSED', '2021-03-09', '2021-03-10', 25, 5, 'Gomes Hardianto', 'Gomes Hardianto', 0, 0, '2021-03-09 11:30:55', '2021-03-09 11:31:08'),
	(3, 'JA001', 'pooldli', 'B9644yn', '1200762', '0012764', 'SJP-202103-00003', 'D010-d1dc210300063', 'Portland Composite Cement', 54, 40, 1350, 'OPEN', '2021-03-09', '2021-03-10', 24, 3, 'Gomes Hardianto', NULL, 1, 0, '2021-03-09 11:58:43', '2021-03-09 13:01:20'),
	(4, 'JA001', 'pooldli', 'B9867 YN', '120067', '0012764', 'SJP-202103-00004', 'D010-1dc210300063', 'Portland Composite Cement', 54, 40, 1350, 'OPEN', '2021-03-09', '2021-03-10', 24, 3, 'Gomes Hardianto', NULL, 1, 0, '2021-03-09 12:07:08', '2021-03-09 13:01:47');
/*!40000 ALTER TABLE `surat_jalan_pallet` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.transactions
CREATE TABLE IF NOT EXISTS `transactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `amount` int(11) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transactions_customer_id_foreign` (`customer_id`),
  KEY `transactions_user_id_foreign` (`user_id`),
  CONSTRAINT `transactions_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.transactions: ~1 rows (approximately)
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
REPLACE INTO `transactions` (`id`, `customer_id`, `user_id`, `amount`, `start_date`, `end_date`, `status`, `created_at`, `updated_at`) VALUES
	(2, 5, 23, 1000000, '2020-04-16 21:57:30', '2020-04-16 21:57:30', 0, '2020-04-16 21:58:19', '2020-04-16 21:58:19');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.transporter
CREATE TABLE IF NOT EXISTS `transporter` (
  `transporter_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `organization_id` int(11) NOT NULL,
  `transporter_code` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pallet_quota` int(11) NOT NULL,
  `good_pallet` int(11) DEFAULT 0,
  `tbr_pallet` int(11) DEFAULT 0,
  `ber_pallet` int(11) DEFAULT 0,
  `missing_pallet` int(11) DEFAULT 0,
  `transporter_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transporter_address` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transporter_email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tag` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'TRANSPORTER',
  `created_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`transporter_id`),
  KEY `organization_transporter_fk` (`organization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.transporter: ~2 rows (approximately)
/*!40000 ALTER TABLE `transporter` DISABLE KEYS */;
REPLACE INTO `transporter` (`transporter_id`, `organization_id`, `transporter_code`, `pallet_quota`, `good_pallet`, `tbr_pallet`, `ber_pallet`, `missing_pallet`, `transporter_name`, `transporter_address`, `phone_number`, `transporter_email`, `tag`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
	('0012764', 8, '0012764', 24, 0, 0, 0, 0, 'Andalan Nusa pratama', 'Ciwandan', '085795261548', 'anp@gmail.com', 'TRANSPORTER', 'Gomes Hardianto', NULL, '2021-03-09 10:50:43', '2021-03-09 13:01:40'),
	('11111', 6, '11111', 1000, 0, 0, 0, 0, 'ARK LOGISTIC', 'JAKARTA', '12345677', 'arklogistic@gmail.com', 'TRANSPORTER', 'PT Dinamika Logistindo Indonesia', NULL, '2021-03-07 16:01:51', '2021-03-07 16:01:51');
/*!40000 ALTER TABLE `transporter` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.transporter_adjusment
CREATE TABLE IF NOT EXISTS `transporter_adjusment` (
  `transporter_adjusment_id` int(11) NOT NULL AUTO_INCREMENT,
  `reporter_user_id` bigint(20) NOT NULL,
  `pool_pallet_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transporter_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ta_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `good_pallet` int(11) DEFAULT 0,
  `tbr_pallet` int(11) DEFAULT 0,
  `ber_pallet` int(11) DEFAULT 0,
  `missing_pallet` int(11) DEFAULT 0,
  `is_from_pool` int(11) NOT NULL COMMENT '0:from pool, 1:from transporter',
  `reason` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`transporter_adjusment_id`),
  KEY `reporter_user_id` (`reporter_user_id`),
  KEY `pool_pallet_id` (`pool_pallet_id`),
  KEY `transporter_id` (`transporter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.transporter_adjusment: ~0 rows (approximately)
/*!40000 ALTER TABLE `transporter_adjusment` DISABLE KEYS */;
/*!40000 ALTER TABLE `transporter_adjusment` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `reference_pool_pallet_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_driver_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_transporter_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT current_timestamp(),
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` char(12) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '1: superadmin, 2: director, 3: palletcoordinator, 4: palletcontroller, 5: supervisor, 6: transporteradmin, 7: driver, 8: inputadmin, 9: checker',
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `created_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `reference_pool_pallet_fk` (`reference_pool_pallet_id`),
  KEY `reference_driver_fk` (`reference_driver_id`),
  KEY `reference_transporter_fk` (`reference_transporter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11111111245 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.users: ~7 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
REPLACE INTO `users` (`id`, `reference_pool_pallet_id`, `reference_driver_id`, `reference_transporter_id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `photo`, `api_token`, `role`, `latitude`, `longitude`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
	(1, 'pooldli', NULL, NULL, 'PT Dinamika Logistindo Indonesia', 'superadmin', '2020-02-15 06:13:34', '$2y$10$Xq8B9FkPFqGmEwjTkuSNr.30AG4s9KBr5hQiCsBlT7bg5DtUtN7eW', '8CQz5Ay3BZ6GNESdM3ivD3iQfc9oH06dRam6G1a4QZpZA1oRJL7wiCXIrTux', NULL, 'gmEPl2UkupPrv44tzqcLrTahddFU6foP6tDwwK1H', '1', NULL, 0, NULL, NULL, '2020-02-15 06:13:34', '2021-03-09 16:00:35'),
	(3, 'pooldli', NULL, NULL, 'Aulia Harvy', 'auliaharvy', '2020-02-17 23:50:04', '$2y$10$R8iUHKlVIrphy7NEZqXwHuqBC3GLaz4bTqfJ.EKRBSwI1Mi8vUv.6', 'HG1vHtQRbevHdSeRBO8aRiQrfqkKxkIaCszx0Wibpz1Hp5QJ3fisiwB8SLuk', NULL, 'JGg6Ev10av67oQHRlvCvu6KPk6606GYtnbdjCipz', '1', NULL, 0, NULL, NULL, '2020-02-17 23:49:45', '2021-03-09 13:22:12'),
	(5, NULL, NULL, NULL, NULL, '', NULL, '', NULL, NULL, NULL, '', NULL, 0, NULL, NULL, NULL, '2020-07-26 20:07:00'),
	(23, '3', NULL, NULL, 'Admin Input BCTD', 'admininputbctd', '2020-02-18 06:33:49', '$2y$10$nSyF/tsClxJz23dikU2V9eGjd0HCwcvVNoCrSkldNoWA9rL4wcm7K', 'bvXVBvbFxRhkONSOGDJwt3QP2FfhmIVOgycq0cySP6pfp6c1pXMy0nYjW0j1', NULL, 'lnF9H353Ej0ffpiqlMcujT1Y06gjga86fJNMIZ4B', '8', NULL, 0, NULL, NULL, '2020-02-18 06:33:49', '2020-07-26 20:07:00'),
	(11111111242, 'JA001', NULL, NULL, 'Tommy', '120002', '2021-03-08 05:55:09', '$2y$10$/cEQ0Wg.P8eIu7oXDp6o5.vkY5rqDDJ7y./Zg0fW/UXc48l4CfaOm', 'FNSiQAZ9HYmmgtCQmYUKd2BKu6GSbLPsnUJlIDqhiVsBVO7WYSYuxgStUeCS', NULL, 'ApXdQCtqQD2OF49mNNGAh5PMTArkUBAKsg9NWZqS', '0', NULL, NULL, NULL, NULL, '2021-03-08 12:55:09', '2021-03-09 12:22:27'),
	(11111111243, 'pooldli', NULL, NULL, 'Gomes Hardianto', '110002', '2021-03-08 06:10:41', '$2y$10$RUw253bLFDoeyJ8YWTJgf.twMBZF5QYtmnuC7m2GBKc3uZKt6tNy.', NULL, NULL, 'Yj0Nf5dEcqpRpDiLNXiYJyBKCEQp4ZOCp26r1xyZ', '0', NULL, NULL, NULL, NULL, '2021-03-08 13:10:41', '2021-03-09 01:43:34'),
	(11111111244, 'pooldli', NULL, NULL, 'Rizki Saputra', '110004', '2021-03-08 06:11:07', '$2y$10$YvFskVSe4jjLBcuP9pXyY.vmpUw5VKyAilfxQsm.Go40KCRBZl2lC', NULL, NULL, 'ctAM7yXsJnS8aZePO3VIlUFUnrgOw3u9v6fGaTNa', '0', NULL, NULL, NULL, NULL, '2021-03-08 13:11:07', '2021-03-09 09:13:40');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table cemindo_prod_tufpal.vehicle
CREATE TABLE IF NOT EXISTS `vehicle` (
  `vehicle_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transporter_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vehicle_number` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vehicle_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'Tronton',
  `created_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`vehicle_id`),
  UNIQUE KEY `vehicle_vehicle_number_unique` (`vehicle_number`),
  KEY `transporter_vehicle_fk` (`transporter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cemindo_prod_tufpal.vehicle: ~7 rows (approximately)
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
REPLACE INTO `vehicle` (`vehicle_id`, `transporter_id`, `vehicle_number`, `vehicle_type`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
	('B 9505 YM', '0012764', 'B 9505 YM', 'Tronton', 'Autocreate in SJP No.Dispatch:D010-1DC210300064', NULL, '2021-03-09 10:58:03', '2021-03-09 10:58:03'),
	('B 9644 YN', '0012764', 'B 9644 YN', 'Trailer', 'Gomes Hardianto', NULL, '2021-03-09 11:28:17', '2021-03-09 11:28:17'),
	('B 9867 YN', '0012764', 'B 9867 YN', 'Trailer', 'Gomes Hardianto', NULL, '2021-03-09 12:04:50', '2021-03-09 12:04:50'),
	('B9644yn', '0012764', 'B9644yn', 'Tronton', 'Autocreate in SJP No.Dispatch:D010-d1dc210300063', NULL, '2021-03-09 11:58:43', '2021-03-09 11:58:43'),
	('B9867 YN', '0012764', 'B9867 YN', 'Tronton', 'Autocreate in SJP No.Dispatch:D010-1dc210300063', NULL, '2021-03-09 12:07:08', '2021-03-09 12:07:08'),
	('BK 9017 CW', '11111', 'BK 9017 CW', 'TRONTON', 'PT Dinamika Logistindo Indonesia', NULL, '2021-03-07 16:10:26', '2021-03-07 16:10:26'),
	('BK 9632 CW', '11111', 'BK 9632 CW', 'TRONTON', 'PT Dinamika Logistindo Indonesia', NULL, '2021-03-07 16:11:13', '2021-03-07 16:11:13');
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
