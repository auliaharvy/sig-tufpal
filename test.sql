-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: mariadb:3306
-- Generation Time: Apr 09, 2020 at 12:24 AM
-- Server version: 10.3.22-MariaDB
-- PHP Version: 7.3.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Table structure for table `all_transaction`
--

CREATE TABLE `all_transaction` (
  `all_transaction_id` int(11) NOT NULL,
  `tid_number` varchar(100) NOT NULL,
  `reference_sjp_id` int(11) DEFAULT NULL,
  `reference_sjp_status_id` int(11) DEFAULT NULL,
  `reference_pallet_transfer_id` int(11) DEFAULT NULL,
  `reference_ber_missing_id` int(11) DEFAULT NULL,
  `reference_new_pallet_id` int(11) DEFAULT NULL,
  `reference_damaged_pallet_id` int(11) DEFAULT NULL,
  `reference_repaired_pallet_id` int(11) DEFAULT NULL,
  `transaction` varchar(50) DEFAULT NULL,
  `no_do` varchar(50) DEFAULT NULL,
  `new_no_do` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `sender/reporter` varchar(100) DEFAULT NULL,
  `receiver/approver` varchar(100) DEFAULT NULL,
  `departure_pool` varchar(100) DEFAULT NULL,
  `destination_pool` varchar(100) DEFAULT NULL,
  `new_destination` varchar(100) DEFAULT NULL,
  `pool_pallet` varchar(100) DEFAULT NULL,
  `transporter` varchar(100) DEFAULT NULL,
  `vehicle` varchar(100) DEFAULT NULL,
  `new_vehicle` varchar(100) DEFAULT NULL,
  `driver` varchar(100) DEFAULT NULL,
  `new_driver` varchar(100) DEFAULT NULL,
  `good_pallet` int(11) DEFAULT 0,
  `tbr_pallet` int(11) DEFAULT 0,
  `ber_pallet` int(11) DEFAULT 0,
  `missing_pallet` int(11) DEFAULT 0,
  `good_cement` int(11) DEFAULT 0,
  `bad_cement` int(11) DEFAULT 0,
  `reporter_prove` varchar(100) DEFAULT NULL,
  `reason` varchar(100) DEFAULT NULL,
  `note` varchar(150) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `all_transaction`
--

INSERT INTO `all_transaction` (`all_transaction_id`, `tid_number`, `reference_sjp_id`, `reference_sjp_status_id`, `reference_pallet_transfer_id`, `reference_ber_missing_id`, `reference_new_pallet_id`, `reference_damaged_pallet_id`, `reference_repaired_pallet_id`, `transaction`, `no_do`, `new_no_do`, `status`, `sender/reporter`, `receiver/approver`, `departure_pool`, `destination_pool`, `new_destination`, `pool_pallet`, `transporter`, `vehicle`, `new_vehicle`, `driver`, `new_driver`, `good_pallet`, `tbr_pallet`, `ber_pallet`, `missing_pallet`, `good_cement`, `bad_cement`, `reporter_prove`, `reason`, `note`, `created_at`, `updated_at`) VALUES
(22, 'TID-202004-00001', NULL, NULL, NULL, NULL, 122, NULL, NULL, 'New Pallet Report', NULL, NULL, 'REPORTED', 'Aulia Harvy', NULL, NULL, NULL, NULL, 'Pool Pallet DLI', NULL, 'B 1189 JJS', NULL, 'Subyo', NULL, 500, 0, 0, 0, 0, 0, NULL, NULL, 'Pallet Belum Di QC', '2020-04-08 14:17:52', '2020-04-08 14:17:52'),
(25, 'TID-202004-00002', 141, 277, NULL, NULL, NULL, NULL, NULL, 'SJP Status Send', '1', NULL, 'SEND', 'Aulia Harvy', NULL, 'Pool Pallet DLI', 'BCTD', NULL, NULL, 'DLI Transporter', 'B 1111 DLI', NULL, 'Agus', NULL, 16, 0, 0, 0, 640, 0, NULL, NULL, NULL, '2020-04-08 14:20:00', '2020-04-08 14:20:00'),
(26, 'TID-202004-00003', 141, NULL, NULL, NULL, NULL, NULL, NULL, 'Surat Jalan Pallet Adjusment', NULL, NULL, 'ADJUST', 'Aulia Harvy', NULL, NULL, NULL, NULL, NULL, 'DLI Transporter', 'B 1111 DLI', 'B 1112 DLI', 'Agus', 'Budi', 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, '2020-04-08 14:21:34', '2020-04-08 14:21:34'),
(27, 'TID-202004-00004', 141, NULL, NULL, NULL, NULL, NULL, NULL, 'Surat Jalan Pallet Change Destination', '1', '2', 'ADJUST', 'Aulia Harvy', NULL, NULL, 'BCTD', 'Sukabumi', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, '2020-04-08 14:21:42', '2020-04-08 14:21:42'),
(28, 'TID-202004-00005', 141, 277, NULL, NULL, NULL, NULL, NULL, 'SJP Status Receive', '2', NULL, 'RECEIVE', NULL, 'Checker Gudang Sukabumi', 'Pool Pallet DLI', 'Sukabumi', NULL, NULL, 'DLI Transporter', 'B 1112 DLI', NULL, 'Budi', NULL, 16, 0, 0, 0, 640, 0, NULL, NULL, NULL, '2020-04-08 14:22:38', '2020-04-08 14:22:38'),
(31, 'TID-202004-00006', 141, 280, NULL, NULL, NULL, NULL, NULL, 'SJP Status Sendback', '2', NULL, 'SENDBACK', 'Checker Gudang Sukabumi', NULL, 'Sukabumi', 'Pool Pallet DLI', NULL, NULL, 'DLI Transporter', 'B 1112 DLI', NULL, 'Budi', NULL, 16, 0, 0, 0, 0, 0, NULL, NULL, NULL, '2020-04-08 14:26:18', '2020-04-08 14:26:18'),
(32, 'TID-202004-00007', 141, 280, NULL, NULL, NULL, NULL, NULL, 'SJP Status Receive Sendback', '2', NULL, 'RECEIVE SENDBACK', NULL, 'Aulia Harvy', 'Sukabumi', 'Pool Pallet DLI', NULL, NULL, 'DLI Transporter', 'B 1112 DLI', NULL, 'Budi', NULL, 16, 0, 0, 0, 0, 0, NULL, NULL, NULL, '2020-04-08 14:26:47', '2020-04-08 14:26:47');

-- --------------------------------------------------------

--
-- Table structure for table `auto_numbers`
--

CREATE TABLE `auto_numbers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auto_numbers`
--

INSERT INTO `auto_numbers` (`id`, `name`, `number`, `created_at`, `updated_at`) VALUES
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
(29, '618112b12bfb2d59259848522c6cfa03', 7, '2020-04-06 14:56:14', '2020-04-08 14:26:47'),
(32, 'a134bf983db14952d03ccf07a1ac1464', 1, '2020-04-07 00:36:58', '2020-04-08 14:17:52'),
(47, '2ffd4c7ad062fae1673552eec490f65a', 0, '2020-04-07 01:39:08', '2020-04-07 01:39:08'),
(57, 'b492842cafe74aa9c4dc2bfd77b4ba1d', 0, '2020-04-07 03:00:22', '2020-04-07 03:00:22'),
(58, 'cc917315567be8600606809039a00079', 1, '2020-04-08 01:51:10', '2020-04-08 14:18:48'),
(59, '4a18d41f000aa0c8d8a7431ea547e2e4', 1, '2020-04-08 01:53:47', '2020-04-08 14:21:34'),
(60, '1e0410f10609c7deae384eab8c420108', 1, '2020-04-08 02:03:52', '2020-04-08 14:21:42'),
(61, '157e1e7d7560a4976fe901d0ef10bf1d', 2, '2020-04-08 11:04:11', '2020-04-08 14:26:18');

-- --------------------------------------------------------

--
-- Table structure for table `ber_missing_pallet`
--

CREATE TABLE `ber_missing_pallet` (
  `ber_missing_pallet_id` int(11) NOT NULL,
  `reporter_user_id` bigint(20) DEFAULT NULL,
  `approver_user_id` bigint(20) DEFAULT NULL,
  `pool_pallet_id` int(11) DEFAULT NULL,
  `transporter_id` int(11) DEFAULT NULL,
  `reference_sjp_status_id` int(11) DEFAULT NULL,
  `bmp_number` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ber_pallet` int(11) DEFAULT NULL,
  `missing_pallet` int(11) DEFAULT NULL,
  `reporter_prove` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL COMMENT '0: reported, 1: approved, 2: disapproved',
  `berita_acara` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ber_missing_pallet_approved`
--

CREATE TABLE `ber_missing_pallet_approved` (
  `ber_missing_pallet_approved_id` int(11) NOT NULL,
  `ber_missing_id` int(11) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `approver` varchar(100) NOT NULL,
  `pool_pallet` varchar(100) DEFAULT NULL,
  `transporter` varchar(100) DEFAULT NULL,
  `reference_sjp_status` varchar(100) DEFAULT NULL,
  `ber_pallet` int(11) NOT NULL DEFAULT 0,
  `missing_pallet` int(11) NOT NULL DEFAULT 0,
  `reporter_prove` varchar(100) DEFAULT NULL,
  `berita_acara` varchar(100) DEFAULT NULL,
  `note` varchar(150) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ber_missing_pallet_disapproved`
--

CREATE TABLE `ber_missing_pallet_disapproved` (
  `ber_missing_pallet_disapproved_id` int(11) NOT NULL,
  `ber_missing_id` int(11) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `disapprover` varchar(100) NOT NULL,
  `pool_pallet` varchar(100) DEFAULT NULL,
  `transporter` varchar(100) DEFAULT NULL,
  `reference_sjp_status` varchar(100) DEFAULT NULL,
  `ber_pallet` int(11) NOT NULL DEFAULT 0,
  `missing_pallet` int(11) NOT NULL DEFAULT 0,
  `reporter_prove` varchar(100) DEFAULT NULL,
  `berita_acara` varchar(100) DEFAULT NULL,
  `note` varchar(150) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ber_missing_pallet_reported`
--

CREATE TABLE `ber_missing_pallet_reported` (
  `ber_missing_pallet_reported_id` int(11) NOT NULL,
  `ber_missing_id` int(11) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `reporter` varchar(100) NOT NULL,
  `pool_pallet` varchar(100) DEFAULT NULL,
  `transporter` varchar(100) DEFAULT NULL,
  `reference_sjp_status` varchar(100) DEFAULT NULL,
  `ber_pallet` int(11) NOT NULL DEFAULT 0,
  `missing_pallet` int(11) NOT NULL DEFAULT 0,
  `reporter_prove` varchar(100) DEFAULT NULL,
  `berita_acara` varchar(100) DEFAULT NULL,
  `note` varchar(150) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nik` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `courier_id` bigint(20) UNSIGNED DEFAULT NULL,
  `point` int(11) NOT NULL,
  `deposit` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `damaged_pallet`
--

CREATE TABLE `damaged_pallet` (
  `damaged_pallet_id` int(11) NOT NULL,
  `reporter_user_id` bigint(20) NOT NULL,
  `pool_pallet_id` int(11) DEFAULT NULL,
  `transporter_id` int(11) DEFAULT NULL,
  `reference_sjp_status_id` int(11) DEFAULT NULL,
  `dp_number` varchar(25) NOT NULL,
  `tbr_pallet` int(11) NOT NULL,
  `note` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `detail_transactions`
--

CREATE TABLE `detail_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transaction_id` bigint(20) UNSIGNED NOT NULL,
  `laundry_price_id` bigint(20) UNSIGNED NOT NULL,
  `laundry_type_id` bigint(20) UNSIGNED NOT NULL,
  `qty` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `subtotal` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `driver`
--

CREATE TABLE `driver` (
  `driver_id` int(11) NOT NULL,
  `transporter_id` int(11) NOT NULL,
  `driver_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `driver_address` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `driver`
--

INSERT INTO `driver` (`driver_id`, `transporter_id`, `driver_name`, `driver_address`, `mobile_number`, `email`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 1, 'Agus', 'bekasi', '089889888', 'agus@gmail.com', NULL, NULL, NULL, NULL),
(2, 1, 'Budi', 'bekasi', '089889888', 'agus@gmail.com', NULL, NULL, NULL, NULL),
(3, 1, 'Imam', 'bekasi', '089889888', 'agus@gmail.com', NULL, NULL, NULL, NULL),
(4, 1, 'Soni', 'bekasi', '089889888', 'agus@gmail.com', NULL, NULL, NULL, NULL),
(5, 1, 'Adi', 'bekasi', '089889888', 'agus@gmail.com', NULL, NULL, NULL, NULL),
(6, 1, 'Sumanto', 'bekasi', '089889888', 'agus@gmail.com', NULL, NULL, NULL, NULL),
(7, 1, 'Azhari', 'bekasi', '089889888', 'agus@gmail.com', NULL, NULL, NULL, NULL),
(8, 1, 'Ahmad', 'bekasi', '089889888', 'agus@gmail.com', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '0:open, 1: approved, 2: canceled',
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `description`, `price`, `note`, `user_id`, `status`, `reason`, `created_at`, `updated_at`) VALUES
(3, 'as', 12456, 'test', 3, '1', NULL, '2020-03-13 16:39:19', '2020-03-13 16:39:19');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `laundry_prices`
--

CREATE TABLE `laundry_prices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `laundry_type_id` bigint(20) UNSIGNED NOT NULL,
  `price` int(11) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `laundry_types`
--

CREATE TABLE `laundry_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
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

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\User', 1),
(1, 'App\\User', 3),
(1, 'App\\User', 4),
(1, 'App\\User', 18),
(4, 'App\\User', 20),
(5, 'App\\User', 19),
(6, 'App\\User', 15),
(6, 'App\\User', 16),
(8, 'App\\User', 7),
(8, 'App\\User', 23),
(8, 'App\\User', 24),
(9, 'App\\User', 6),
(9, 'App\\User', 8),
(9, 'App\\User', 9),
(9, 'App\\User', 10),
(9, 'App\\User', 11),
(9, 'App\\User', 12),
(9, 'App\\User', 13),
(9, 'App\\User', 14);

-- --------------------------------------------------------

--
-- Table structure for table `mst_transaction`
--

CREATE TABLE `mst_transaction` (
  `id` int(11) NOT NULL,
  `transaction` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mst_transaction`
--

INSERT INTO `mst_transaction` (`id`, `transaction`, `description`) VALUES
(1, 'SEND', 'send from departure to destination'),
(2, 'SEND_BACK', 'send back from destination to departure');

-- --------------------------------------------------------

--
-- Table structure for table `new_pallet`
--

CREATE TABLE `new_pallet` (
  `new_pallet_id` int(11) NOT NULL,
  `adder_user_id` bigint(20) DEFAULT NULL,
  `pool_pallet_id` int(11) NOT NULL,
  `np_number` varchar(20) NOT NULL,
  `good_pallet` int(11) NOT NULL,
  `vendor` varchar(100) DEFAULT NULL,
  `vehicle` varchar(100) DEFAULT NULL,
  `driver` varchar(100) DEFAULT NULL,
  `note` varchar(250) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `new_pallet`
--

INSERT INTO `new_pallet` (`new_pallet_id`, `adder_user_id`, `pool_pallet_id`, `np_number`, `good_pallet`, `vendor`, `vehicle`, `driver`, `note`, `created_at`, `updated_at`) VALUES
(122, 3, 1, 'NP-202004-00001', 500, 'Pallet Vendor', 'B 1189 JJS', 'Subyo', 'Pallet Belum Di QC', '2020-04-08 14:17:52', '2020-04-08 14:17:52');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('076c0296-04cc-4dc4-ae7e-6528e1871f21', 'App\\Notifications\\ExpensesNotification', 'App\\User', 11, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":1,\"description\":\"Satu\",\"price\":10000,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 05:56:04\",\"updated_at\":\"2020-02-27 05:56:04\"}}', NULL, '2020-02-27 05:56:10', '2020-02-27 05:56:10'),
('0a8e52ba-93b1-47a2-9c1c-34bda04b512c', 'App\\Notifications\\ExpensesNotification', 'App\\User', 8, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":1,\"description\":\"Satu\",\"price\":10000,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 05:56:04\",\"updated_at\":\"2020-02-27 05:56:04\"}}', NULL, '2020-02-27 05:56:09', '2020-02-27 05:56:09'),
('0c2a79a5-b591-4ed0-9c75-b8524cda8210', 'App\\Notifications\\ExpensesNotification', 'App\\User', 7, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":1,\"description\":\"Satu\",\"price\":10000,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 05:56:04\",\"updated_at\":\"2020-02-27 05:56:04\"}}', NULL, '2020-02-27 05:56:09', '2020-02-27 05:56:09'),
('11b0c4a5-96ee-4788-a46f-fd7ac61e234a', 'App\\Notifications\\ExpensesNotification', 'App\\User', 4, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":2,\"description\":\"a\",\"price\":111111,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 06:12:37\",\"updated_at\":\"2020-02-27 06:12:37\"}}', NULL, '2020-02-27 06:12:38', '2020-02-27 06:12:38'),
('178edbd6-a091-448c-930d-c52be6a4de04', 'App\\Notifications\\ExpensesNotification', 'App\\User', 9, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":2,\"description\":\"a\",\"price\":111111,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 06:12:37\",\"updated_at\":\"2020-02-27 06:12:37\"}}', NULL, '2020-02-27 06:12:40', '2020-02-27 06:12:40'),
('1e6c8f9b-b2c4-4017-9dbd-17ec81f79487', 'App\\Notifications\\ExpensesNotification', 'App\\User', 10, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":1,\"description\":\"Satu\",\"price\":10000,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 05:56:04\",\"updated_at\":\"2020-02-27 05:56:04\"}}', NULL, '2020-02-27 05:56:10', '2020-02-27 05:56:10'),
('28886527-dc31-4816-ba42-0b0629433f87', 'App\\Notifications\\ExpensesNotification', 'App\\User', 12, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":1,\"description\":\"Satu\",\"price\":10000,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 05:56:04\",\"updated_at\":\"2020-02-27 05:56:04\"}}', NULL, '2020-02-27 05:56:11', '2020-02-27 05:56:11'),
('28a86ba8-7b3b-4041-97fe-2a357d5cd7ed', 'App\\Notifications\\ExpensesNotification', 'App\\User', 17, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":1,\"description\":\"Satu\",\"price\":10000,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 05:56:04\",\"updated_at\":\"2020-02-27 05:56:04\"}}', NULL, '2020-02-27 05:56:13', '2020-02-27 05:56:13'),
('34b516ab-205a-4934-beac-7d328a24262e', 'App\\Notifications\\ExpensesNotification', 'App\\User', 17, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":2,\"description\":\"a\",\"price\":111111,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 06:12:37\",\"updated_at\":\"2020-02-27 06:12:37\"}}', NULL, '2020-02-27 06:12:43', '2020-02-27 06:12:43'),
('3d44adcc-b4f2-4ba4-bc7c-09275c6bae56', 'App\\Notifications\\ExpensesNotification', 'App\\User', 14, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":1,\"description\":\"Satu\",\"price\":10000,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 05:56:04\",\"updated_at\":\"2020-02-27 05:56:04\"}}', NULL, '2020-02-27 05:56:12', '2020-02-27 05:56:12'),
('3f8aaff9-b265-4608-b941-8986d33dd8fa', 'App\\Notifications\\ExpensesNotification', 'App\\User', 16, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":1,\"description\":\"Satu\",\"price\":10000,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 05:56:04\",\"updated_at\":\"2020-02-27 05:56:04\"}}', NULL, '2020-02-27 05:56:13', '2020-02-27 05:56:13'),
('40b47c1e-d6aa-4695-a899-fe63e7ecdc8e', 'App\\Notifications\\ExpensesNotification', 'App\\User', 12, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":2,\"description\":\"a\",\"price\":111111,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 06:12:37\",\"updated_at\":\"2020-02-27 06:12:37\"}}', NULL, '2020-02-27 06:12:41', '2020-02-27 06:12:41'),
('413451c8-64e7-4a46-9525-aba80b8af513', 'App\\Notifications\\ExpensesNotification', 'App\\User', 3, '{\"sender_id\":3,\"sender_name\":\"Aulia Harvy\",\"expenses\":{\"id\":3,\"description\":\"as\",\"price\":12456,\"note\":\"test\",\"user_id\":3,\"status\":\"1\",\"reason\":null,\"created_at\":\"2020-03-13 16:39:19\",\"updated_at\":\"2020-03-13 16:39:19\"}}', NULL, '2020-03-13 16:39:20', '2020-03-13 16:39:20'),
('435d8252-b511-44b0-a883-e299343c031f', 'App\\Notifications\\ExpensesNotification', 'App\\User', 11, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":2,\"description\":\"a\",\"price\":111111,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 06:12:37\",\"updated_at\":\"2020-02-27 06:12:37\"}}', NULL, '2020-02-27 06:12:40', '2020-02-27 06:12:40'),
('43d2e0d6-ac9a-4438-b166-de9de9046432', 'App\\Notifications\\ExpensesNotification', 'App\\User', 4, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":1,\"description\":\"Satu\",\"price\":10000,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 05:56:04\",\"updated_at\":\"2020-02-27 05:56:04\"}}', NULL, '2020-02-27 05:56:08', '2020-02-27 05:56:08'),
('445fdd3c-3140-4985-96fd-aa316063df0a', 'App\\Notifications\\ExpensesNotification', 'App\\User', 12, '{\"sender_id\":3,\"sender_name\":\"Aulia Harvy\",\"expenses\":{\"id\":3,\"description\":\"as\",\"price\":12456,\"note\":\"test\",\"user_id\":3,\"status\":\"1\",\"reason\":null,\"created_at\":\"2020-03-13 16:39:19\",\"updated_at\":\"2020-03-13 16:39:19\"}}', NULL, '2020-03-13 16:39:21', '2020-03-13 16:39:21'),
('494824a0-ef1d-4ed9-a6ef-04d53d5be940', 'App\\Notifications\\ExpensesNotification', 'App\\User', 1, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":2,\"description\":\"a\",\"price\":111111,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 06:12:37\",\"updated_at\":\"2020-02-27 06:12:37\"}}', NULL, '2020-02-27 06:12:37', '2020-02-27 06:12:37'),
('4bfae4ff-1a6c-4c9a-955e-65d38d61cf38', 'App\\Notifications\\ExpensesNotification', 'App\\User', 13, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":2,\"description\":\"a\",\"price\":111111,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 06:12:37\",\"updated_at\":\"2020-02-27 06:12:37\"}}', NULL, '2020-02-27 06:12:41', '2020-02-27 06:12:41'),
('53e3495e-ef9e-415d-8309-32ebb4550dac', 'App\\Notifications\\ExpensesNotification', 'App\\User', 13, '{\"sender_id\":3,\"sender_name\":\"Aulia Harvy\",\"expenses\":{\"id\":3,\"description\":\"as\",\"price\":12456,\"note\":\"test\",\"user_id\":3,\"status\":\"1\",\"reason\":null,\"created_at\":\"2020-03-13 16:39:19\",\"updated_at\":\"2020-03-13 16:39:19\"}}', NULL, '2020-03-13 16:39:21', '2020-03-13 16:39:21'),
('55c7e84a-7ab2-4b3c-885a-8e46c0861806', 'App\\Notifications\\ExpensesNotification', 'App\\User', 15, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":1,\"description\":\"Satu\",\"price\":10000,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 05:56:04\",\"updated_at\":\"2020-02-27 05:56:04\"}}', NULL, '2020-02-27 05:56:12', '2020-02-27 05:56:12'),
('56d34ccc-bb00-4427-8e92-c51e9c697f0d', 'App\\Notifications\\ExpensesNotification', 'App\\User', 1, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":1,\"description\":\"Satu\",\"price\":10000,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 05:56:04\",\"updated_at\":\"2020-02-27 05:56:04\"}}', NULL, '2020-02-27 05:56:07', '2020-02-27 05:56:07'),
('5c64d074-4716-449f-9115-6d52c52d28e4', 'App\\Notifications\\ExpensesNotification', 'App\\User', 13, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":1,\"description\":\"Satu\",\"price\":10000,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 05:56:04\",\"updated_at\":\"2020-02-27 05:56:04\"}}', NULL, '2020-02-27 05:56:11', '2020-02-27 05:56:11'),
('65d049e7-b3ab-491f-9faa-c7f9226a021f', 'App\\Notifications\\ExpensesNotification', 'App\\User', 14, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":2,\"description\":\"a\",\"price\":111111,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 06:12:37\",\"updated_at\":\"2020-02-27 06:12:37\"}}', NULL, '2020-02-27 06:12:42', '2020-02-27 06:12:42'),
('748593b3-7a3f-499b-b23d-27083fc48f63', 'App\\Notifications\\ExpensesNotification', 'App\\User', 9, '{\"sender_id\":3,\"sender_name\":\"Aulia Harvy\",\"expenses\":{\"id\":3,\"description\":\"as\",\"price\":12456,\"note\":\"test\",\"user_id\":3,\"status\":\"1\",\"reason\":null,\"created_at\":\"2020-03-13 16:39:19\",\"updated_at\":\"2020-03-13 16:39:19\"}}', NULL, '2020-03-13 16:39:20', '2020-03-13 16:39:20'),
('798dbec7-aa60-41a7-b820-d822ff5b3d9a', 'App\\Notifications\\ExpensesNotification', 'App\\User', 5, '{\"sender_id\":3,\"sender_name\":\"Aulia Harvy\",\"expenses\":{\"id\":3,\"description\":\"as\",\"price\":12456,\"note\":\"test\",\"user_id\":3,\"status\":\"1\",\"reason\":null,\"created_at\":\"2020-03-13 16:39:19\",\"updated_at\":\"2020-03-13 16:39:19\"}}', NULL, '2020-03-13 16:39:20', '2020-03-13 16:39:20'),
('7c099b18-466c-4001-8bb9-4e54bd33c75c', 'App\\Notifications\\ExpensesNotification', 'App\\User', 11, '{\"sender_id\":3,\"sender_name\":\"Aulia Harvy\",\"expenses\":{\"id\":3,\"description\":\"as\",\"price\":12456,\"note\":\"test\",\"user_id\":3,\"status\":\"1\",\"reason\":null,\"created_at\":\"2020-03-13 16:39:19\",\"updated_at\":\"2020-03-13 16:39:19\"}}', NULL, '2020-03-13 16:39:21', '2020-03-13 16:39:21'),
('7d07d52c-43e6-4e57-8d86-2a85eeff4b91', 'App\\Notifications\\ExpensesNotification', 'App\\User', 14, '{\"sender_id\":3,\"sender_name\":\"Aulia Harvy\",\"expenses\":{\"id\":3,\"description\":\"as\",\"price\":12456,\"note\":\"test\",\"user_id\":3,\"status\":\"1\",\"reason\":null,\"created_at\":\"2020-03-13 16:39:19\",\"updated_at\":\"2020-03-13 16:39:19\"}}', NULL, '2020-03-13 16:39:21', '2020-03-13 16:39:21'),
('87555ff6-e29a-4d59-a0d5-bab9465a7093', 'App\\Notifications\\ExpensesNotification', 'App\\User', 16, '{\"sender_id\":3,\"sender_name\":\"Aulia Harvy\",\"expenses\":{\"id\":3,\"description\":\"as\",\"price\":12456,\"note\":\"test\",\"user_id\":3,\"status\":\"1\",\"reason\":null,\"created_at\":\"2020-03-13 16:39:19\",\"updated_at\":\"2020-03-13 16:39:19\"}}', NULL, '2020-03-13 16:39:21', '2020-03-13 16:39:21'),
('8b46c3fd-e25d-466a-8706-ad5de5d45220', 'App\\Notifications\\ExpensesNotification', 'App\\User', 20, '{\"sender_id\":3,\"sender_name\":\"Aulia Harvy\",\"expenses\":{\"id\":3,\"description\":\"as\",\"price\":12456,\"note\":\"test\",\"user_id\":3,\"status\":\"1\",\"reason\":null,\"created_at\":\"2020-03-13 16:39:19\",\"updated_at\":\"2020-03-13 16:39:19\"}}', NULL, '2020-03-13 16:39:21', '2020-03-13 16:39:21'),
('8e4f06ee-f23b-423a-8865-bd686d950844', 'App\\Notifications\\ExpensesNotification', 'App\\User', 9, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":1,\"description\":\"Satu\",\"price\":10000,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 05:56:04\",\"updated_at\":\"2020-02-27 05:56:04\"}}', NULL, '2020-02-27 05:56:10', '2020-02-27 05:56:10'),
('99d3c7c8-f11a-489a-82fd-58851fce460e', 'App\\Notifications\\ExpensesNotification', 'App\\User', 7, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":2,\"description\":\"a\",\"price\":111111,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 06:12:37\",\"updated_at\":\"2020-02-27 06:12:37\"}}', NULL, '2020-02-27 06:12:39', '2020-02-27 06:12:39'),
('9aa29f9c-cfb1-47df-a6b3-cd0727a27229', 'App\\Notifications\\ExpensesNotification', 'App\\User', 8, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":2,\"description\":\"a\",\"price\":111111,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 06:12:37\",\"updated_at\":\"2020-02-27 06:12:37\"}}', NULL, '2020-02-27 06:12:39', '2020-02-27 06:12:39'),
('a2ce42f6-d1a9-4d39-873e-dbe9bd4c06d5', 'App\\Notifications\\ExpensesNotification', 'App\\User', 6, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":2,\"description\":\"a\",\"price\":111111,\"note\":null,\"user_id\":6,\"status\":\"2\",\"reason\":\"test\",\"created_at\":\"2020-02-27 06:12:37\",\"updated_at\":\"2020-02-27 06:15:46\",\"user\":{\"id\":6,\"reference_pool_pallet_id\":1,\"reference_driver_id\":null,\"reference_transporter_id\":null,\"name\":\"Checker Pool Pallet DLI\",\"email\":\"checkerpooldli@gmail.com\",\"email_verified_at\":\"2020-02-18 06:33:49\",\"photo\":null,\"role\":\"9\",\"created_at\":\"2020-02-18 06:33:49\",\"updated_at\":\"2020-02-27 04:07:19\"}}}', NULL, '2020-02-27 06:15:46', '2020-02-27 06:15:46'),
('a322ea81-8165-4bbe-9bcf-003f8707c2b8', 'App\\Notifications\\ExpensesNotification', 'App\\User', 10, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":2,\"description\":\"a\",\"price\":111111,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 06:12:37\",\"updated_at\":\"2020-02-27 06:12:37\"}}', NULL, '2020-02-27 06:12:40', '2020-02-27 06:12:40'),
('a6681f1d-5fae-4ba5-89d2-829e42600629', 'App\\Notifications\\ExpensesNotification', 'App\\User', 15, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":2,\"description\":\"a\",\"price\":111111,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 06:12:37\",\"updated_at\":\"2020-02-27 06:12:37\"}}', NULL, '2020-02-27 06:12:42', '2020-02-27 06:12:42'),
('b0c2bb83-85b8-49f0-92fe-c3f0165c3e0a', 'App\\Notifications\\ExpensesNotification', 'App\\User', 19, '{\"sender_id\":3,\"sender_name\":\"Aulia Harvy\",\"expenses\":{\"id\":3,\"description\":\"as\",\"price\":12456,\"note\":\"test\",\"user_id\":3,\"status\":\"1\",\"reason\":null,\"created_at\":\"2020-03-13 16:39:19\",\"updated_at\":\"2020-03-13 16:39:19\"}}', NULL, '2020-03-13 16:39:21', '2020-03-13 16:39:21'),
('b1cd1317-cf9d-472e-9151-07025617aaef', 'App\\Notifications\\ExpensesNotification', 'App\\User', 15, '{\"sender_id\":3,\"sender_name\":\"Aulia Harvy\",\"expenses\":{\"id\":3,\"description\":\"as\",\"price\":12456,\"note\":\"test\",\"user_id\":3,\"status\":\"1\",\"reason\":null,\"created_at\":\"2020-03-13 16:39:19\",\"updated_at\":\"2020-03-13 16:39:19\"}}', NULL, '2020-03-13 16:39:21', '2020-03-13 16:39:21'),
('b75643dd-058d-4732-ac8a-75faff542c35', 'App\\Notifications\\ExpensesNotification', 'App\\User', 5, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":2,\"description\":\"a\",\"price\":111111,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 06:12:37\",\"updated_at\":\"2020-02-27 06:12:37\"}}', NULL, '2020-02-27 06:12:38', '2020-02-27 06:12:38'),
('bb36bf18-11e6-40bf-97da-fefe773de36b', 'App\\Notifications\\ExpensesNotification', 'App\\User', 17, '{\"sender_id\":3,\"sender_name\":\"Aulia Harvy\",\"expenses\":{\"id\":3,\"description\":\"as\",\"price\":12456,\"note\":\"test\",\"user_id\":3,\"status\":\"1\",\"reason\":null,\"created_at\":\"2020-03-13 16:39:19\",\"updated_at\":\"2020-03-13 16:39:19\"}}', NULL, '2020-03-13 16:39:21', '2020-03-13 16:39:21'),
('d6173f5b-1bf1-499b-8d80-c4b50b1fbe24', 'App\\Notifications\\ExpensesNotification', 'App\\User', 6, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":1,\"description\":\"Satu\",\"price\":10000,\"note\":null,\"user_id\":6,\"status\":\"1\",\"reason\":null,\"created_at\":\"2020-02-27 05:56:04\",\"updated_at\":\"2020-02-27 05:56:34\",\"user\":{\"id\":6,\"reference_pool_pallet_id\":1,\"reference_driver_id\":null,\"reference_transporter_id\":null,\"name\":\"Checker Pool Pallet DLI\",\"email\":\"checkerpooldli@gmail.com\",\"email_verified_at\":\"2020-02-18 06:33:49\",\"photo\":null,\"role\":\"9\",\"created_at\":\"2020-02-18 06:33:49\",\"updated_at\":\"2020-02-27 04:07:19\"}}}', NULL, '2020-02-27 05:56:35', '2020-02-27 05:56:35'),
('d6f1a752-22cf-4da2-a31f-374c9c16dc8e', 'App\\Notifications\\ExpensesNotification', 'App\\User', 10, '{\"sender_id\":3,\"sender_name\":\"Aulia Harvy\",\"expenses\":{\"id\":3,\"description\":\"as\",\"price\":12456,\"note\":\"test\",\"user_id\":3,\"status\":\"1\",\"reason\":null,\"created_at\":\"2020-03-13 16:39:19\",\"updated_at\":\"2020-03-13 16:39:19\"}}', NULL, '2020-03-13 16:39:20', '2020-03-13 16:39:20'),
('e4ba0d93-7f1d-4891-9a7c-a5d5fa4ef5d7', 'App\\Notifications\\ExpensesNotification', 'App\\User', 16, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":2,\"description\":\"a\",\"price\":111111,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 06:12:37\",\"updated_at\":\"2020-02-27 06:12:37\"}}', NULL, '2020-02-27 06:12:42', '2020-02-27 06:12:42'),
('e6f1ad11-5c10-4450-ae8f-2a77d73baab5', 'App\\Notifications\\ExpensesNotification', 'App\\User', 18, '{\"sender_id\":3,\"sender_name\":\"Aulia Harvy\",\"expenses\":{\"id\":3,\"description\":\"as\",\"price\":12456,\"note\":\"test\",\"user_id\":3,\"status\":\"1\",\"reason\":null,\"created_at\":\"2020-03-13 16:39:19\",\"updated_at\":\"2020-03-13 16:39:19\"}}', NULL, '2020-03-13 16:39:21', '2020-03-13 16:39:21'),
('e6fdf33e-0479-41f7-8619-7282027ad8e8', 'App\\Notifications\\ExpensesNotification', 'App\\User', 8, '{\"sender_id\":3,\"sender_name\":\"Aulia Harvy\",\"expenses\":{\"id\":3,\"description\":\"as\",\"price\":12456,\"note\":\"test\",\"user_id\":3,\"status\":\"1\",\"reason\":null,\"created_at\":\"2020-03-13 16:39:19\",\"updated_at\":\"2020-03-13 16:39:19\"}}', NULL, '2020-03-13 16:39:20', '2020-03-13 16:39:20'),
('ea359bb9-dd93-48b0-ad7f-280ba1234c27', 'App\\Notifications\\ExpensesNotification', 'App\\User', 5, '{\"sender_id\":6,\"sender_name\":\"Checker Pool Pallet DLI\",\"expenses\":{\"id\":1,\"description\":\"Satu\",\"price\":10000,\"note\":null,\"user_id\":6,\"status\":\"0\",\"reason\":null,\"created_at\":\"2020-02-27 05:56:04\",\"updated_at\":\"2020-02-27 05:56:04\"}}', NULL, '2020-02-27 05:56:08', '2020-02-27 05:56:08'),
('f3f469cf-b585-4d1d-9e12-d60777bebf5d', 'App\\Notifications\\ExpensesNotification', 'App\\User', 7, '{\"sender_id\":3,\"sender_name\":\"Aulia Harvy\",\"expenses\":{\"id\":3,\"description\":\"as\",\"price\":12456,\"note\":\"test\",\"user_id\":3,\"status\":\"1\",\"reason\":null,\"created_at\":\"2020-03-13 16:39:19\",\"updated_at\":\"2020-03-13 16:39:19\"}}', NULL, '2020-03-13 16:39:20', '2020-03-13 16:39:20');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `organization`
--

CREATE TABLE `organization` (
  `organization_id` int(11) NOT NULL,
  `organization_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organization_address` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organization_email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `organization`
--

INSERT INTO `organization` (`organization_id`, `organization_name`, `organization_address`, `phone_number`, `organization_email`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'PT Dinamika Logistindo Indonesia', 'Perkantoran Buncit Mas Blok B8\r\nJL. Mampang Prapatan Raya 108\r\nKel. Duren Tiga, Kec. Pancoran\r\nJakarta Selatan – 12760, Indonesia.', '+62 21 7989764, +62 21 79193612.', 'contact@dinamikalogistindo.com', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `outlets`
--

CREATE TABLE `outlets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `outlets`
--

INSERT INTO `outlets` (`id`, `code`, `name`, `status`, `address`, `phone`, `created_at`, `updated_at`) VALUES
(1, '123', 'asdasf', 0, 'asead', '1231', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pallet_transfer`
--

CREATE TABLE `pallet_transfer` (
  `pallet_transfer_id` int(11) NOT NULL,
  `departure_pool_pallet_id` int(11) DEFAULT NULL,
  `destination_pool_pallet_id` int(11) DEFAULT NULL,
  `sender_user_id` int(11) DEFAULT NULL,
  `receiver_user_id` int(11) DEFAULT NULL,
  `transporter_id` int(11) DEFAULT NULL,
  `driver_id` int(11) DEFAULT NULL,
  `vehicle_id` int(11) DEFAULT NULL,
  `tp_number` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `good_pallet` int(11) DEFAULT 0,
  `tbr_pallet` int(11) DEFAULT 0,
  `reason` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL COMMENT '0: SENDING, 1: RECEIVED',
  `note` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pallet_transfer_receive_pallet`
--

CREATE TABLE `pallet_transfer_receive_pallet` (
  `pallet_transfer_receive_pallet_id` int(11) NOT NULL,
  `pallet_transfer_id` int(11) NOT NULL DEFAULT 0,
  `tp_number` varchar(100) DEFAULT NULL,
  `pallet_transfer_status` varchar(100) NOT NULL,
  `receiver` varchar(100) NOT NULL,
  `departure_pool` varchar(100) NOT NULL,
  `destination_pool` varchar(100) NOT NULL,
  `transporter` varchar(100) NOT NULL,
  `driver` varchar(100) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `good_pallet` int(11) NOT NULL DEFAULT 0,
  `tbr_pallet` int(11) NOT NULL DEFAULT 0,
  `note` varchar(150) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pallet_transfer_send_pallet`
--

CREATE TABLE `pallet_transfer_send_pallet` (
  `pallet_transfer_send_pallet_id` int(11) NOT NULL,
  `pallet_transfer_id` int(11) NOT NULL DEFAULT 0,
  `pallet_transfer_status` varchar(100) NOT NULL,
  `sender` varchar(100) NOT NULL,
  `departure_pool` varchar(100) NOT NULL,
  `destination_pool` varchar(100) NOT NULL,
  `transporter` varchar(100) NOT NULL,
  `driver` varchar(100) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `good_pallet` int(11) NOT NULL DEFAULT 0,
  `tbr_pallet` int(11) NOT NULL DEFAULT 0,
  `note` varchar(150) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
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
(63, 'read alltransaction', 'web', '2020-03-26 14:33:59', '2020-03-26 14:33:59');

-- --------------------------------------------------------

--
-- Table structure for table `pool_pallet`
--

CREATE TABLE `pool_pallet` (
  `pool_pallet_id` int(11) NOT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `code` int(11) DEFAULT NULL,
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
  `created_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pool_pallet`
--

INSERT INTO `pool_pallet` (`pool_pallet_id`, `organization_id`, `code`, `type`, `pool_name`, `pool_address`, `pool_city`, `phone_number`, `pool_email`, `pallet_quota`, `good_pallet`, `tbr_pallet`, `ber_pallet`, `missing_pallet`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 1, 11111, 'POOL_PALLET_DLI', 'Pool Pallet DLI', 'Citereup', 'Bogor', '089652847221', 'contact@dinamikalogistindo.com', 1000, 500, 0, 0, 0, NULL, NULL, '2020-03-05 07:05:37', '2020-04-08 14:26:47'),
(2, 1, 11112, 'WORKSHOP', 'Workshop DLI', 'Citereup', 'Bogor', '081280768088', 'contact@dinamikalogistindo.com', 1000, 0, 0, 0, 0, NULL, NULL, '2020-03-05 07:06:29', '2020-04-07 03:00:22'),
(3, 1, 11113, 'WAREHOUSE', 'BCTD', 'Jl. Mayor Oking Jayaatmaja\r\nCiteueruep Bogor\r\n', 'Bogor', '0811-9690-7560', 'contact@dinamikalogistindo.com', 100, 0, 0, 0, 0, NULL, NULL, '2020-03-05 07:07:48', '2020-03-26 16:51:29'),
(4, 1, 11114, 'WAREHOUSE', 'Sukabumi', 'Jl. Plabuhan II, Lembur Situ KM.7,5\r\nSukabumi, Jawa Barat 43169\r\n', 'Sukabumi', '0811-9690-7560', 'contact@dinamikalogistindo.com', 100, 0, 0, 0, 0, NULL, NULL, '2020-03-05 07:07:48', '2020-04-08 14:26:18'),
(5, 1, 11115, 'SHOP', 'Toko Bangunan ', 'Citereup', 'Bogor', '02167854', 'toko@gmail.com', 0, 0, 0, 0, 0, 'Aulia Harvy', NULL, '2020-03-18 22:51:43', '2020-03-25 19:38:54');

-- --------------------------------------------------------

--
-- Table structure for table `repaired_pallet`
--

CREATE TABLE `repaired_pallet` (
  `repaired_pallet_id` int(11) NOT NULL,
  `reporter_user_id` bigint(20) NOT NULL,
  `pool_pallet_id` int(11) NOT NULL,
  `rp_number` varchar(250) NOT NULL,
  `good_pallet` int(11) NOT NULL,
  `note` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'superadmin', 'web', '2020-02-21 08:23:48', '2020-02-21 08:23:48'),
(2, 'director', 'web', '2020-02-21 08:24:02', '2020-02-21 08:24:02'),
(3, 'palletcoordinator', 'web', '2020-02-21 08:24:14', '2020-02-21 08:24:14'),
(4, 'palletcontroller', 'web', '2020-02-21 08:24:24', '2020-02-21 08:24:24'),
(5, 'supervisor', 'web', '2020-02-21 08:24:34', '2020-02-21 08:24:34'),
(6, 'transporteradmin', 'web', '2020-02-21 08:24:51', '2020-02-21 08:24:51'),
(7, 'driver', 'web', '2020-02-21 08:25:01', '2020-02-21 08:25:01'),
(8, 'inputadmin', 'web', '2020-02-21 08:25:09', '2020-02-21 08:25:09'),
(9, 'checker', 'web', '2020-02-21 08:25:16', '2020-02-21 08:25:16');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(1, 2),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(2, 1),
(2, 4),
(2, 5),
(2, 8),
(3, 1),
(3, 4),
(3, 5),
(3, 6),
(3, 8),
(4, 1),
(5, 1),
(5, 2),
(5, 4),
(5, 5),
(5, 6),
(5, 7),
(5, 8),
(5, 9),
(6, 1),
(6, 4),
(6, 5),
(6, 9),
(7, 1),
(7, 4),
(7, 5),
(7, 9),
(8, 1),
(8, 4),
(9, 1),
(9, 2),
(9, 4),
(9, 5),
(9, 6),
(9, 8),
(9, 9),
(10, 1),
(10, 4),
(10, 5),
(10, 9),
(11, 1),
(11, 4),
(11, 5),
(11, 9),
(12, 1),
(13, 1),
(13, 2),
(13, 4),
(13, 5),
(13, 6),
(13, 8),
(13, 9),
(14, 1),
(14, 4),
(14, 5),
(14, 9),
(15, 1),
(15, 4),
(15, 5),
(15, 9),
(16, 1),
(17, 1),
(17, 2),
(17, 4),
(17, 5),
(17, 7),
(17, 8),
(17, 9),
(18, 1),
(18, 4),
(18, 5),
(19, 1),
(19, 4),
(19, 5),
(20, 1),
(21, 1),
(21, 2),
(21, 4),
(21, 5),
(21, 6),
(21, 7),
(22, 1),
(22, 4),
(22, 5),
(23, 1),
(23, 4),
(23, 5),
(24, 1),
(25, 1),
(25, 2),
(25, 4),
(25, 5),
(25, 6),
(26, 1),
(26, 4),
(27, 1),
(27, 4),
(28, 1),
(29, 1),
(29, 2),
(29, 4),
(29, 5),
(30, 1),
(30, 4),
(31, 1),
(31, 4),
(31, 5),
(32, 1),
(33, 1),
(33, 2),
(33, 4),
(34, 1),
(34, 4),
(35, 1),
(35, 4),
(36, 1),
(37, 1),
(37, 2),
(37, 4),
(37, 5),
(38, 1),
(38, 2),
(38, 4),
(38, 5),
(38, 6),
(38, 7),
(39, 1),
(39, 2),
(39, 4),
(39, 5),
(40, 1),
(40, 5),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(47, 2),
(47, 6),
(47, 7),
(48, 1),
(48, 2),
(48, 4),
(48, 5),
(49, 1),
(49, 4),
(49, 5),
(50, 1),
(50, 4),
(50, 5),
(51, 1),
(52, 1),
(52, 2),
(52, 4),
(52, 5),
(53, 1),
(53, 4),
(53, 5),
(54, 1),
(54, 4),
(54, 5),
(55, 1),
(56, 1),
(56, 2),
(56, 4),
(56, 5),
(57, 1),
(57, 2),
(57, 4),
(58, 1),
(58, 2),
(58, 4),
(59, 1),
(59, 2),
(59, 4),
(60, 1),
(60, 2),
(60, 4),
(61, 1),
(61, 4),
(62, 1),
(62, 2),
(62, 4),
(63, 1),
(63, 4);

-- --------------------------------------------------------

--
-- Table structure for table `sjp_adjusment`
--

CREATE TABLE `sjp_adjusment` (
  `sjp_adjusment_id` int(11) NOT NULL,
  `sjp_id` int(11) NOT NULL DEFAULT 0,
  `sa_number` varchar(100) DEFAULT NULL,
  `sjp_number` varchar(100) NOT NULL,
  `transporter` varchar(100) DEFAULT NULL,
  `vehicle` varchar(100) DEFAULT NULL,
  `new_vehicle` varchar(100) DEFAULT NULL,
  `driver` varchar(100) DEFAULT NULL,
  `new_driver` varchar(100) DEFAULT NULL,
  `adjust_by` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sjp_adjusment`
--

INSERT INTO `sjp_adjusment` (`sjp_adjusment_id`, `sjp_id`, `sa_number`, `sjp_number`, `transporter`, `vehicle`, `new_vehicle`, `driver`, `new_driver`, `adjust_by`, `created_at`, `updated_at`) VALUES
(19, 0, 'SA-202004-00001', 'SJP-202004-00001', 'DLI Transporter', 'B 1111 DLI', 'B 1112 DLI', 'Agus', 'Budi', 'Aulia Harvy', '2020-04-08 14:21:34', '2020-04-08 14:21:34');

-- --------------------------------------------------------

--
-- Table structure for table `sjp_change_destination`
--

CREATE TABLE `sjp_change_destination` (
  `sjp_change_destination_id` int(11) NOT NULL,
  `sjp_id` int(11) NOT NULL DEFAULT 0,
  `scd_number` varchar(100) DEFAULT NULL,
  `sjp_number` varchar(100) DEFAULT NULL,
  `no_do` varchar(50) DEFAULT NULL,
  `new_no_do` varchar(50) DEFAULT NULL,
  `destination` varchar(100) DEFAULT NULL,
  `new_destination` varchar(100) DEFAULT NULL,
  `adjust_by` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sjp_change_destination`
--

INSERT INTO `sjp_change_destination` (`sjp_change_destination_id`, `sjp_id`, `scd_number`, `sjp_number`, `no_do`, `new_no_do`, `destination`, `new_destination`, `adjust_by`, `created_at`, `updated_at`) VALUES
(11, 0, 'SCD-202004-00001', 'SJP-202004-00001', '1', '2', 'BCTD', 'Sukabumi', 'Aulia Harvy', '2020-04-08 14:21:42', '2020-04-08 14:21:42');

-- --------------------------------------------------------

--
-- Table structure for table `sjp_pallet_receive`
--

CREATE TABLE `sjp_pallet_receive` (
  `sjp_pallet_receive_id` int(11) NOT NULL,
  `sjp_status_id` int(11) NOT NULL DEFAULT 0,
  `sjp_number` varchar(100) NOT NULL,
  `sjp_status` varchar(100) DEFAULT NULL,
  `receiver` varchar(100) NOT NULL,
  `departure_pool` varchar(100) DEFAULT NULL,
  `destination_pool` varchar(100) DEFAULT NULL,
  `transporter` varchar(100) DEFAULT NULL,
  `driver` varchar(100) DEFAULT NULL,
  `vehicle` varchar(100) DEFAULT NULL,
  `good_pallet` int(11) DEFAULT 0,
  `tbr_pallet` int(11) DEFAULT 0,
  `ber_pallet` int(11) DEFAULT 0,
  `missing_pallet` int(11) DEFAULT 0,
  `good_cement` int(11) DEFAULT 0,
  `bad_cement` int(11) DEFAULT 0,
  `note` varchar(150) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sjp_pallet_receive`
--

INSERT INTO `sjp_pallet_receive` (`sjp_pallet_receive_id`, `sjp_status_id`, `sjp_number`, `sjp_status`, `receiver`, `departure_pool`, `destination_pool`, `transporter`, `driver`, `vehicle`, `good_pallet`, `tbr_pallet`, `ber_pallet`, `missing_pallet`, `good_cement`, `bad_cement`, `note`, `created_at`, `updated_at`) VALUES
(102, 277, 'SJP-202004-00001', 'RECEIVE', 'Checker Gudang Sukabumi', 'Pool Pallet DLI', 'Sukabumi', 'DLI Transporter', 'Budi', 'B 1112 DLI', 16, 0, 0, 0, 640, 0, NULL, '2020-04-08 14:22:38', '2020-04-08 14:22:38'),
(103, 280, 'SJP-202004-00001', 'RECEIVE SENDBACK', 'Aulia Harvy', 'Sukabumi', 'Pool Pallet DLI', 'DLI Transporter', 'Budi', 'B 1112 DLI', 16, 0, 0, 0, 0, 0, NULL, '2020-04-08 14:26:47', '2020-04-08 14:26:47');

-- --------------------------------------------------------

--
-- Table structure for table `sjp_pallet_send`
--

CREATE TABLE `sjp_pallet_send` (
  `sjp_pallet_send_id` int(11) NOT NULL,
  `sjp_status_id` int(11) NOT NULL DEFAULT 0,
  `sjp_number` varchar(100) NOT NULL,
  `sjp_status` varchar(100) DEFAULT NULL,
  `sender` varchar(100) DEFAULT NULL,
  `departure_pool` varchar(100) DEFAULT NULL,
  `destination_pool` varchar(100) DEFAULT NULL,
  `transporter` varchar(100) DEFAULT NULL,
  `driver` varchar(100) DEFAULT NULL,
  `vehicle` varchar(100) DEFAULT NULL,
  `good_pallet` int(11) DEFAULT 0,
  `tbr_pallet` int(11) DEFAULT 0,
  `ber_pallet` int(11) DEFAULT 0,
  `missing_pallet` int(11) DEFAULT 0,
  `good_cement` int(11) DEFAULT 0,
  `bad_cement` int(11) DEFAULT 0,
  `note` varchar(150) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sjp_pallet_send`
--

INSERT INTO `sjp_pallet_send` (`sjp_pallet_send_id`, `sjp_status_id`, `sjp_number`, `sjp_status`, `sender`, `departure_pool`, `destination_pool`, `transporter`, `driver`, `vehicle`, `good_pallet`, `tbr_pallet`, `ber_pallet`, `missing_pallet`, `good_cement`, `bad_cement`, `note`, `created_at`, `updated_at`) VALUES
(138, 277, 'SJP-202004-00001', 'SEND', 'Aulia Harvy', 'Pool Pallet DLI', 'BCTD', 'DLI Transporter', 'Agus', 'B 1111 DLI', 16, 0, 0, 0, 640, 0, NULL, '2020-04-08 14:20:00', '2020-04-08 14:20:00'),
(139, 280, 'SJP-202004-00001', 'SEND BACK', 'Checker Gudang Sukabumi', 'Sukabumi', 'Pool Pallet DLI', 'DLI Transporter', 'Budi', 'B 1112 DLI', 16, 0, 0, 0, 0, 0, NULL, '2020-04-08 14:26:18', '2020-04-08 14:26:18');

-- --------------------------------------------------------

--
-- Table structure for table `sjp_status`
--

CREATE TABLE `sjp_status` (
  `sjp_status_id` int(11) NOT NULL,
  `checker_send_user_id` int(11) NOT NULL,
  `checker_receive_user_id` int(11) DEFAULT NULL,
  `sjp_id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `sjps_number` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(11) DEFAULT NULL COMMENT '0: send, 1: received',
  `good_pallet` int(11) NOT NULL DEFAULT 0,
  `tbr_pallet` int(11) NOT NULL DEFAULT 0,
  `ber_pallet` int(11) NOT NULL DEFAULT 0,
  `missing_pallet` int(11) DEFAULT 0,
  `good_cement` int(11) DEFAULT 0,
  `bad_cement` int(11) NOT NULL DEFAULT 0,
  `note` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sjp_status`
--

INSERT INTO `sjp_status` (`sjp_status_id`, `checker_send_user_id`, `checker_receive_user_id`, `sjp_id`, `transaction_id`, `sjps_number`, `status`, `good_pallet`, `tbr_pallet`, `ber_pallet`, `missing_pallet`, `good_cement`, `bad_cement`, `note`, `created_at`, `updated_at`) VALUES
(277, 3, 13, 141, 1, 'SJPS-202004-00001', 1, 16, 0, 0, 0, 640, 0, NULL, '2020-04-08 14:20:00', '2020-04-08 14:22:38'),
(280, 13, 3, 141, 2, 'SJPS-202004-00002', 1, 16, 0, 0, 0, 0, 0, NULL, '2020-04-08 14:26:18', '2020-04-08 14:26:47');

-- --------------------------------------------------------

--
-- Table structure for table `surat_jalan_pallet`
--

CREATE TABLE `surat_jalan_pallet` (
  `sjp_id` int(11) NOT NULL,
  `destination_pool_pallet_id` int(11) NOT NULL,
  `departure_pool_pallet_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `transporter_id` int(11) NOT NULL,
  `sjp_number` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_do` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tonnage` int(11) NOT NULL,
  `product_quantity` int(11) NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `departure_time` date NOT NULL,
  `eta` date NOT NULL,
  `pallet_quantity` int(11) NOT NULL,
  `state` int(11) NOT NULL COMMENT '0: draft, 1: send, 2: received, 3: send back, 4: received sendback',
  `created_by` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adjust_by` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_sendback` int(11) NOT NULL DEFAULT 0 COMMENT '0: send, 1: snedback',
  `distribution` int(11) NOT NULL DEFAULT 0 COMMENT '0: main distribution, 1: Secondary Distribution',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `surat_jalan_pallet`
--

INSERT INTO `surat_jalan_pallet` (`sjp_id`, `destination_pool_pallet_id`, `departure_pool_pallet_id`, `vehicle_id`, `driver_id`, `transporter_id`, `sjp_number`, `no_do`, `product_name`, `tonnage`, `product_quantity`, `status`, `departure_time`, `eta`, `pallet_quantity`, `state`, `created_by`, `adjust_by`, `is_sendback`, `distribution`, `created_at`, `updated_at`) VALUES
(141, 4, 1, 2, 2, 1, 'SJP-202004-00001', '2', 'Portland Composite Cement', 32, 640, 'CLOSED', '2020-04-08', '2020-04-09', 16, 4, 'Aulia Harvy', 'Aulia Harvy', 1, 0, '2020-04-08 14:18:48', '2020-04-08 14:26:47');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `amount` int(11) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transporter`
--

CREATE TABLE `transporter` (
  `transporter_id` int(11) NOT NULL,
  `organization_id` int(11) NOT NULL,
  `pallet_quota` int(11) NOT NULL,
  `good_pallet` int(11) DEFAULT 0,
  `tbr_pallet` int(11) DEFAULT 0,
  `ber_pallet` int(11) DEFAULT 0,
  `missing_pallet` int(11) DEFAULT 0,
  `transporter_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transporter_address` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transporter_email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transporter`
--

INSERT INTO `transporter` (`transporter_id`, `organization_id`, `pallet_quota`, `good_pallet`, `tbr_pallet`, `ber_pallet`, `missing_pallet`, `transporter_name`, `transporter_address`, `phone_number`, `transporter_email`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 1, 200, 0, 0, 0, 0, 'DLI Transporter', 'Perkantoran Buncit Mas Blok B8\r\nJL. Mampang Prapatan Raya 108\r\nKel. Duren Tiga, Kec. Pancoran\r\nJakarta Selatan – 12760, Indonesia.', '+62 21 7989764, +62 21 79193612.', 'contact@dinamikalogistindo.com', NULL, NULL, '2020-02-24 16:36:46', '2020-04-08 14:26:47'),
(3, 1, 200, 0, 0, 0, 0, 'Mitra Transporter', 'Perkantoran Buncit Mas Blok B8\r\nJL. Mampang Prapatan Raya 108\r\nKel. Duren Tiga, Kec. Pancoran\r\nJakarta Selatan – 12760, Indonesia.', '+62 21 7989764, +62 21 79193612.', 'contact@dinamikalogistindo.com', NULL, NULL, '2020-02-24 16:36:46', '2020-04-07 01:51:29');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference_pool_pallet_id` int(11) DEFAULT NULL,
  `reference_driver_id` int(11) DEFAULT NULL,
  `reference_transporter_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT current_timestamp(),
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` char(12) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1: superadmin, 2: director, 3: palletcoordinator, 4: palletcontroller, 5: supervisor, 6: transporteradmin, 7: driver, 8: inputadmin, 9: checker',
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `created_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `reference_pool_pallet_id`, `reference_driver_id`, `reference_transporter_id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `photo`, `api_token`, `role`, `latitude`, `longitude`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL, 'DLI', 'superadmin', '2020-02-15 06:13:34', '$2y$10$ZHdl.FbRaRAcLHPddfrbReB4efcdWqPHxd5TXlQ0RlGP3t4zF89pO', '8CQz5Ay3BZ6GNESdM3ivD3iQfc9oH06dRam6G1a4QZpZA1oRJL7wiCXIrTux', NULL, 'bpmTLoLlxEzx2soqhPpwinAVy1VqYIl1KTnFlahN', '1', NULL, 0, NULL, NULL, '2020-02-15 06:13:34', '2020-03-05 09:58:54'),
(3, 1, NULL, NULL, 'Aulia Harvy', 'auliaharvy', '2020-02-17 23:50:04', '$2y$10$ZHdl.FbRaRAcLHPddfrbReB4efcdWqPHxd5TXlQ0RlGP3t4zF89pO', 'HG1vHtQRbevHdSeRBO8aRiQrfqkKxkIaCszx0Wibpz1Hp5QJ3fisiwB8SLuk', NULL, 'KD2HaO1nKQQ1u0FCFvnFN91MorJRGCnO8atYuVji', '0', NULL, 0, NULL, NULL, '2020-02-17 23:49:45', '2020-04-08 14:26:23'),
(4, 2, NULL, NULL, 'Harby Anwardi', 'harby', '2020-02-18 06:33:49', '$2y$10$nSyF/tsClxJz23dikU2V9eGjd0HCwcvVNoCrSkldNoWA9rL4wcm7K', NULL, NULL, 'pDuR3B1rDFGpAp7uHBoTyBLGSstKxX4avsC1MJvS', '1', NULL, 0, NULL, NULL, '2020-02-18 06:33:49', '2020-04-07 02:43:03'),
(5, NULL, NULL, NULL, NULL, '', NULL, '', NULL, NULL, NULL, '', NULL, 0, NULL, NULL, NULL, NULL),
(6, 1, NULL, NULL, 'Checker Pool Pallet DLI', 'checkerpooldli', '2020-02-18 06:33:49', '$2y$10$nSyF/tsClxJz23dikU2V9eGjd0HCwcvVNoCrSkldNoWA9rL4wcm7K', NULL, NULL, 'hPTcL5ZxzMgEhLOJjYKxuzVJ982Cny4bhU7JnUdb', '9', NULL, 0, NULL, NULL, '2020-02-18 06:33:49', '2020-03-23 04:39:58'),
(7, 1, NULL, NULL, 'Admin Input DLI', 'admininputdli', '2020-02-18 06:33:49', '$2y$10$nSyF/tsClxJz23dikU2V9eGjd0HCwcvVNoCrSkldNoWA9rL4wcm7K', 'bvXVBvbFxRhkONSOGDJwt3QP2FfhmIVOgycq0cySP6pfp6c1pXMy0nYjW0j1', NULL, 'LBynrJnxDZNUiyi2CVI4rAeD0cWSic4ZF1ul36ek', '0', NULL, 0, NULL, NULL, '2020-02-18 06:33:49', '2020-03-17 08:34:55'),
(13, 4, NULL, NULL, 'Checker Gudang Sukabumi', 'checkerwhsukabumi', '2020-02-18 06:33:49', '$2y$10$nSyF/tsClxJz23dikU2V9eGjd0HCwcvVNoCrSkldNoWA9rL4wcm7K', 'RU85Y0DQb951wDo3GHiQivdiHwASeJfqWImD45X92g7XwNWlfSdZoUrB3mMS', NULL, 'fQEUMvoiYf8Pf46k4qz8pRANZ0g5rKMkw4TApESL', '0', NULL, 0, NULL, NULL, '2020-02-18 06:33:49', '2020-04-08 14:22:30'),
(14, 3, NULL, NULL, 'Checker Gudang BCTD', 'checkerwhbctd', '2020-02-18 06:33:49', '$2y$10$nSyF/tsClxJz23dikU2V9eGjd0HCwcvVNoCrSkldNoWA9rL4wcm7K', 'dCoqn8YQ2idocT5GJxWUyuKZy750dxw4CrcMz6YfAgyFDWn1PDLHvYj5LNkR', NULL, 'iODk9IykvSmiPSQwzh0mmL03mjmBhTTBbD5Te7pb', '0', NULL, 0, NULL, NULL, '2020-02-18 06:33:49', '2020-03-26 16:47:29'),
(15, NULL, NULL, 1, 'Admin Transporter DLI', 'admintransporterdli', '2020-02-18 06:33:49', '$2y$10$nSyF/tsClxJz23dikU2V9eGjd0HCwcvVNoCrSkldNoWA9rL4wcm7K', '7xrIPaIRsqp1MmpMAWa9vOet0PG5W6Y26OTNwdcjBgzriWFiJavEBTv9vYi0', NULL, 'BHj9w3xdpkHdf2fShO3JchG9bgMEeGUkuFxm0EjF', '0', NULL, 0, NULL, NULL, '2020-02-18 06:33:49', '2020-03-17 08:24:45'),
(16, NULL, NULL, 3, 'Admin Transporter Mitra', 'admintransportermitra', '2020-02-18 06:33:49', '$2y$10$nSyF/tsClxJz23dikU2V9eGjd0HCwcvVNoCrSkldNoWA9rL4wcm7K', NULL, NULL, 'yjd36RgOa8u1WuSOkiCkJmX1mYLlCKcn4vAZBtIP', '0', NULL, 0, NULL, NULL, '2020-02-18 06:33:49', '2020-03-16 18:21:01'),
(18, 1, NULL, NULL, 'Supervisor Pool Pallet DLI', 'supervisorpooldli', '2020-02-18 06:33:49', '$2y$10$nSyF/tsClxJz23dikU2V9eGjd0HCwcvVNoCrSkldNoWA9rL4wcm7K', NULL, NULL, '8FvJY6zsiUuhYGXvpdzZU8UyJfSUO1Q5irUmuWFg', '0', NULL, 0, NULL, NULL, '2020-02-18 06:33:49', '2020-03-12 01:47:40'),
(19, 2, NULL, NULL, 'Supervisor Gudang BCTD', 'supervisorwhbctd', '2020-02-18 06:33:49', '$2y$10$nSyF/tsClxJz23dikU2V9eGjd0HCwcvVNoCrSkldNoWA9rL4wcm7K', NULL, NULL, 'ZcpkLdvuzp7xgGQyBtVFHCBwusGpjPE1DXSyIKDN', '0', NULL, 0, NULL, NULL, '2020-02-18 06:33:49', '2020-03-06 08:52:21'),
(20, 1, NULL, NULL, 'Pallet Controller DLI', 'palletcontrollerdli', '2020-02-18 06:33:49', '$2y$10$nSyF/tsClxJz23dikU2V9eGjd0HCwcvVNoCrSkldNoWA9rL4wcm7K', NULL, NULL, 'xNJckAa8CCL7IBfdlpkG1fKZ40CsyTC86o4UCY5p', '0', NULL, 0, NULL, NULL, '2020-02-18 06:33:49', '2020-03-17 07:47:32'),
(23, 3, NULL, NULL, 'Admin Input BCTD', 'admininputbctd', '2020-02-18 06:33:49', '$2y$10$nSyF/tsClxJz23dikU2V9eGjd0HCwcvVNoCrSkldNoWA9rL4wcm7K', 'bvXVBvbFxRhkONSOGDJwt3QP2FfhmIVOgycq0cySP6pfp6c1pXMy0nYjW0j1', NULL, '1YhfEduxHHKZci2hinTGu7dLMzPWsYwrPtdzc80o', '0', NULL, 0, NULL, NULL, '2020-02-18 06:33:49', '2020-03-26 16:30:59'),
(24, 4, NULL, NULL, 'Admin Input Sukabumi', 'admininputsukabumi', '2020-02-18 06:33:49', '$2y$10$nSyF/tsClxJz23dikU2V9eGjd0HCwcvVNoCrSkldNoWA9rL4wcm7K', 'bvXVBvbFxRhkONSOGDJwt3QP2FfhmIVOgycq0cySP6pfp6c1pXMy0nYjW0j1', NULL, 'ZcKScEX6RWo1U4npEEZEjNc9l5qNuMe6ykZHaCD8', '0', NULL, 0, NULL, NULL, '2020-02-18 06:33:49', '2020-03-26 16:31:13');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle`
--

CREATE TABLE `vehicle` (
  `vehicle_id` int(11) NOT NULL,
  `transporter_id` int(11) NOT NULL,
  `vehicle_number` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vehicle_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vehicle`
--

INSERT INTO `vehicle` (`vehicle_id`, `transporter_id`, `vehicle_number`, `vehicle_type`, `created_at`, `updated_at`) VALUES
(1, 1, 'B 1111 DLI', 'Tronton', NULL, NULL),
(2, 1, 'B 1112 DLI', 'Tronton', NULL, NULL),
(5, 1, 'B 1113 DLI', 'Tronton', NULL, NULL),
(6, 1, 'B 1114 DLI', 'Tronton', NULL, NULL),
(7, 1, 'B 1115 DLI', 'Tronton', NULL, NULL),
(8, 1, 'B 1116 DLI', 'Tronton', NULL, NULL),
(9, 1, 'B 1117 DLI', 'Tronton', NULL, NULL),
(10, 1, 'B 1118 DLI', 'Tronton', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `all_transaction`
--
ALTER TABLE `all_transaction`
  ADD PRIMARY KEY (`all_transaction_id`);

--
-- Indexes for table `auto_numbers`
--
ALTER TABLE `auto_numbers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ber_missing_pallet`
--
ALTER TABLE `ber_missing_pallet`
  ADD PRIMARY KEY (`ber_missing_pallet_id`),
  ADD KEY `pool_pallet_fk` (`pool_pallet_id`),
  ADD KEY `reporter_user_fk` (`reporter_user_id`),
  ADD KEY `approver_user_fk` (`approver_user_id`),
  ADD KEY `transporter_fk` (`transporter_id`) USING BTREE,
  ADD KEY `reference_sjp_status_fk` (`reference_sjp_status_id`);

--
-- Indexes for table `ber_missing_pallet_approved`
--
ALTER TABLE `ber_missing_pallet_approved`
  ADD PRIMARY KEY (`ber_missing_pallet_approved_id`),
  ADD KEY `ber_missing_id` (`ber_missing_id`);

--
-- Indexes for table `ber_missing_pallet_disapproved`
--
ALTER TABLE `ber_missing_pallet_disapproved`
  ADD PRIMARY KEY (`ber_missing_pallet_disapproved_id`),
  ADD KEY `ber_missing_id` (`ber_missing_id`);

--
-- Indexes for table `ber_missing_pallet_reported`
--
ALTER TABLE `ber_missing_pallet_reported`
  ADD PRIMARY KEY (`ber_missing_pallet_reported_id`),
  ADD KEY `ber_missing_id` (`ber_missing_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customers_nik_unique` (`nik`),
  ADD KEY `customers_courier_id_foreign` (`courier_id`);

--
-- Indexes for table `damaged_pallet`
--
ALTER TABLE `damaged_pallet`
  ADD PRIMARY KEY (`damaged_pallet_id`),
  ADD KEY `pool_pallet_fk` (`pool_pallet_id`),
  ADD KEY `reporter_user_fk` (`reporter_user_id`) USING BTREE,
  ADD KEY `transporter_id` (`transporter_id`),
  ADD KEY `reference_sjp_status_id` (`reference_sjp_status_id`);

--
-- Indexes for table `detail_transactions`
--
ALTER TABLE `detail_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `detail_transactions_transaction_id_foreign` (`transaction_id`),
  ADD KEY `detail_transactions_laundry_price_id_foreign` (`laundry_price_id`),
  ADD KEY `detail_transactions_laundry_type_id_foreign` (`laundry_type_id`);

--
-- Indexes for table `driver`
--
ALTER TABLE `driver`
  ADD PRIMARY KEY (`driver_id`),
  ADD KEY `transporter_driver_fk` (`transporter_id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expenses_user_id_foreign` (`user_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `laundry_prices`
--
ALTER TABLE `laundry_prices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `laundry_prices_laundry_type_id_foreign` (`laundry_type_id`),
  ADD KEY `laundry_prices_user_id_foreign` (`user_id`);

--
-- Indexes for table `laundry_types`
--
ALTER TABLE `laundry_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `mst_transaction`
--
ALTER TABLE `mst_transaction`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `new_pallet`
--
ALTER TABLE `new_pallet`
  ADD PRIMARY KEY (`new_pallet_id`),
  ADD KEY `adder_user_id_fk` (`adder_user_id`),
  ADD KEY `pool_pallet_id_fk` (`pool_pallet_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `organization`
--
ALTER TABLE `organization`
  ADD PRIMARY KEY (`organization_id`);

--
-- Indexes for table `outlets`
--
ALTER TABLE `outlets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `outlets_code_unique` (`code`);

--
-- Indexes for table `pallet_transfer`
--
ALTER TABLE `pallet_transfer`
  ADD PRIMARY KEY (`pallet_transfer_id`),
  ADD UNIQUE KEY `tp_number` (`tp_number`),
  ADD KEY `pool_pallet_pallet_transfer_fk` (`departure_pool_pallet_id`),
  ADD KEY `pool_pallet_pallet_transfer_fk1` (`destination_pool_pallet_id`),
  ADD KEY `user_pallet_transfer_fk` (`sender_user_id`),
  ADD KEY `user_pallet_transfer_fk1` (`receiver_user_id`),
  ADD KEY `transporter_pallet_transfer_fk` (`transporter_id`),
  ADD KEY `driver_pallet_transfer_fk` (`driver_id`),
  ADD KEY `vehicle_pallet_transfer_fk` (`vehicle_id`);

--
-- Indexes for table `pallet_transfer_receive_pallet`
--
ALTER TABLE `pallet_transfer_receive_pallet`
  ADD PRIMARY KEY (`pallet_transfer_receive_pallet_id`),
  ADD KEY `pallet_transfer_id` (`pallet_transfer_id`);

--
-- Indexes for table `pallet_transfer_send_pallet`
--
ALTER TABLE `pallet_transfer_send_pallet`
  ADD PRIMARY KEY (`pallet_transfer_send_pallet_id`),
  ADD KEY `pallet_transfer_id` (`pallet_transfer_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pool_pallet`
--
ALTER TABLE `pool_pallet`
  ADD PRIMARY KEY (`pool_pallet_id`),
  ADD UNIQUE KEY `pool_pallet_code_unique` (`code`),
  ADD KEY `organization_pool_pallet_fk` (`organization_id`);

--
-- Indexes for table `repaired_pallet`
--
ALTER TABLE `repaired_pallet`
  ADD PRIMARY KEY (`repaired_pallet_id`),
  ADD KEY `reported_user_fk` (`reporter_user_id`),
  ADD KEY `pool_pallet_fk` (`pool_pallet_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `sjp_adjusment`
--
ALTER TABLE `sjp_adjusment`
  ADD PRIMARY KEY (`sjp_adjusment_id`),
  ADD KEY `sjp_id` (`sjp_id`);

--
-- Indexes for table `sjp_change_destination`
--
ALTER TABLE `sjp_change_destination`
  ADD PRIMARY KEY (`sjp_change_destination_id`),
  ADD KEY `sjp_id` (`sjp_id`);

--
-- Indexes for table `sjp_pallet_receive`
--
ALTER TABLE `sjp_pallet_receive`
  ADD PRIMARY KEY (`sjp_pallet_receive_id`),
  ADD KEY `sjp_status_id` (`sjp_status_id`);

--
-- Indexes for table `sjp_pallet_send`
--
ALTER TABLE `sjp_pallet_send`
  ADD PRIMARY KEY (`sjp_pallet_send_id`),
  ADD KEY `sjp_status_id` (`sjp_status_id`);

--
-- Indexes for table `sjp_status`
--
ALTER TABLE `sjp_status`
  ADD PRIMARY KEY (`sjp_status_id`),
  ADD KEY `user_sjp_status_fk` (`checker_send_user_id`),
  ADD KEY `surat_jalan_pallet_sjp_status_fk` (`sjp_id`),
  ADD KEY `transaction_fk` (`transaction_id`);

--
-- Indexes for table `surat_jalan_pallet`
--
ALTER TABLE `surat_jalan_pallet`
  ADD PRIMARY KEY (`sjp_id`),
  ADD UNIQUE KEY `sjp_number` (`sjp_number`),
  ADD KEY `pool_pallet_surat_jalan_pallet_fk` (`destination_pool_pallet_id`),
  ADD KEY `pool_pallet_surat_jalan_pallet_fk1` (`departure_pool_pallet_id`),
  ADD KEY `vehicle_surat_jalan_pallet_fk` (`vehicle_id`),
  ADD KEY `driver_surat_jalan_pallet_fk` (`driver_id`),
  ADD KEY `transporter_surat_jalan_pallet_fk` (`transporter_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transactions_customer_id_foreign` (`customer_id`),
  ADD KEY `transactions_user_id_foreign` (`user_id`);

--
-- Indexes for table `transporter`
--
ALTER TABLE `transporter`
  ADD PRIMARY KEY (`transporter_id`),
  ADD KEY `organization_transporter_fk` (`organization_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `reference_pool_pallet_fk` (`reference_pool_pallet_id`),
  ADD KEY `reference_driver_fk` (`reference_driver_id`),
  ADD KEY `reference_transporter_fk` (`reference_transporter_id`);

--
-- Indexes for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD PRIMARY KEY (`vehicle_id`),
  ADD UNIQUE KEY `vehicle_vehicle_number_unique` (`vehicle_number`),
  ADD KEY `transporter_vehicle_fk` (`transporter_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `all_transaction`
--
ALTER TABLE `all_transaction`
  MODIFY `all_transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `auto_numbers`
--
ALTER TABLE `auto_numbers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `ber_missing_pallet`
--
ALTER TABLE `ber_missing_pallet`
  MODIFY `ber_missing_pallet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `ber_missing_pallet_approved`
--
ALTER TABLE `ber_missing_pallet_approved`
  MODIFY `ber_missing_pallet_approved_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `ber_missing_pallet_disapproved`
--
ALTER TABLE `ber_missing_pallet_disapproved`
  MODIFY `ber_missing_pallet_disapproved_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `ber_missing_pallet_reported`
--
ALTER TABLE `ber_missing_pallet_reported`
  MODIFY `ber_missing_pallet_reported_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `damaged_pallet`
--
ALTER TABLE `damaged_pallet`
  MODIFY `damaged_pallet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `detail_transactions`
--
ALTER TABLE `detail_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `driver`
--
ALTER TABLE `driver`
  MODIFY `driver_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `laundry_prices`
--
ALTER TABLE `laundry_prices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `laundry_types`
--
ALTER TABLE `laundry_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `mst_transaction`
--
ALTER TABLE `mst_transaction`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `new_pallet`
--
ALTER TABLE `new_pallet`
  MODIFY `new_pallet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `organization`
--
ALTER TABLE `organization`
  MODIFY `organization_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `outlets`
--
ALTER TABLE `outlets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pallet_transfer`
--
ALTER TABLE `pallet_transfer`
  MODIFY `pallet_transfer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `pallet_transfer_receive_pallet`
--
ALTER TABLE `pallet_transfer_receive_pallet`
  MODIFY `pallet_transfer_receive_pallet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `pallet_transfer_send_pallet`
--
ALTER TABLE `pallet_transfer_send_pallet`
  MODIFY `pallet_transfer_send_pallet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `pool_pallet`
--
ALTER TABLE `pool_pallet`
  MODIFY `pool_pallet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `repaired_pallet`
--
ALTER TABLE `repaired_pallet`
  MODIFY `repaired_pallet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `sjp_adjusment`
--
ALTER TABLE `sjp_adjusment`
  MODIFY `sjp_adjusment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `sjp_change_destination`
--
ALTER TABLE `sjp_change_destination`
  MODIFY `sjp_change_destination_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `sjp_pallet_receive`
--
ALTER TABLE `sjp_pallet_receive`
  MODIFY `sjp_pallet_receive_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT for table `sjp_pallet_send`
--
ALTER TABLE `sjp_pallet_send`
  MODIFY `sjp_pallet_send_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=140;

--
-- AUTO_INCREMENT for table `sjp_status`
--
ALTER TABLE `sjp_status`
  MODIFY `sjp_status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=281;

--
-- AUTO_INCREMENT for table `surat_jalan_pallet`
--
ALTER TABLE `surat_jalan_pallet`
  MODIFY `sjp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=142;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transporter`
--
ALTER TABLE `transporter`
  MODIFY `transporter_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `vehicle`
--
ALTER TABLE `vehicle`
  MODIFY `vehicle_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_courier_id_foreign` FOREIGN KEY (`courier_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `detail_transactions`
--
ALTER TABLE `detail_transactions`
  ADD CONSTRAINT `detail_transactions_laundry_price_id_foreign` FOREIGN KEY (`laundry_price_id`) REFERENCES `laundry_prices` (`id`),
  ADD CONSTRAINT `detail_transactions_laundry_type_id_foreign` FOREIGN KEY (`laundry_type_id`) REFERENCES `laundry_types` (`id`),
  ADD CONSTRAINT `detail_transactions_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`);

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `expenses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `laundry_prices`
--
ALTER TABLE `laundry_prices`
  ADD CONSTRAINT `laundry_prices_laundry_type_id_foreign` FOREIGN KEY (`laundry_type_id`) REFERENCES `laundry_types` (`id`),
  ADD CONSTRAINT `laundry_prices_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
