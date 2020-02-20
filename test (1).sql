-- phpMyAdmin SQL Dump
-- version 4.9.3
-- https://www.phpmyadmin.net/
--
-- Host: mariadb:3306
-- Generation Time: Feb 20, 2020 at 01:17 AM
-- Server version: 10.3.21-MariaDB
-- PHP Version: 7.3.13

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
(2, 'fd7c53d0e70ef33c15f089fdc99c7ef1', 6, '2020-02-17 15:39:19', '2020-02-19 23:48:39'),
(3, '7f4103ea26af1d05f0105a5cac8d8c71', 4, '2020-02-18 04:25:38', '2020-02-19 09:45:22');

-- --------------------------------------------------------

--
-- Table structure for table `ber_missing_pallet`
--

CREATE TABLE `ber_missing_pallet` (
  `ber_missing_pallet_id` int(11) NOT NULL,
  `reporter_user_id` bigint(20) DEFAULT NULL,
  `approver_user_id` bigint(20) DEFAULT NULL,
  `ber_pallet` int(11) DEFAULT NULL,
  `missing_pallet` int(11) DEFAULT NULL,
  `prove` blob DEFAULT NULL,
  `note` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ber_missing_pallet`
--

INSERT INTO `ber_missing_pallet` (`ber_missing_pallet_id`, `reporter_user_id`, `approver_user_id`, `ber_pallet`, `missing_pallet`, `prove`, `note`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 5, 0, 0x30303030, 'Pallet rusak oleh transporter', '2020-02-11 09:20:05', '2020-02-11 09:20:05');

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

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `nik`, `name`, `address`, `phone`, `courier_id`, `point`, `deposit`, `created_at`, `updated_at`) VALUES
(4, '11', 'aa', 'asas', '123', NULL, 0, 0, '2020-02-17 03:39:04', '2020-02-17 03:39:04');

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `driver`
--

INSERT INTO `driver` (`driver_id`, `transporter_id`, `driver_name`, `driver_address`, `mobile_number`, `email`, `created_at`, `updated_at`) VALUES
(1, 1, 'Agus', 'bekasi', '089889888', 'agus@gmail.com', NULL, NULL);

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `organization`
--

INSERT INTO `organization` (`organization_id`, `organization_name`, `organization_address`, `phone_number`, `organization_email`, `created_at`, `updated_at`) VALUES
(1, 'PT Dinamika Logistindo Indonesia', 'Perkantoran Buncit Mas Blok B8\r\nJL. Mampang Prapatan Raya 108\r\nKel. Duren Tiga, Kec. Pancoran\r\nJakarta Selatan – 12760, Indonesia.', '+62 21 7989764, +62 21 79193612.', 'contact@dinamikalogistindo.com', NULL, NULL);

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
  `good_pallet` int(11) DEFAULT NULL,
  `tbr_pallet` int(11) DEFAULT NULL,
  `reason` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pallet_transfer`
--

INSERT INTO `pallet_transfer` (`pallet_transfer_id`, `departure_pool_pallet_id`, `destination_pool_pallet_id`, `sender_user_id`, `receiver_user_id`, `transporter_id`, `driver_id`, `vehicle_id`, `tp_number`, `good_pallet`, `tbr_pallet`, `reason`, `status`, `note`, `created_at`, `updated_at`) VALUES
(4, 1, 3, 1, NULL, 1, 1, 1, 'TP-202002-00004', 6, 0, 'Test', 'SENDING', 'Test', '2020-02-19 09:45:22', '2020-02-19 09:45:22');

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
  `good_pallet` int(11) DEFAULT NULL,
  `tbr_pallet` int(11) DEFAULT NULL,
  `ber_pallet` int(11) DEFAULT NULL,
  `missing_pallet` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pool_pallet`
--

INSERT INTO `pool_pallet` (`pool_pallet_id`, `organization_id`, `code`, `type`, `pool_name`, `pool_address`, `pool_city`, `phone_number`, `pool_email`, `pallet_quota`, `good_pallet`, `tbr_pallet`, `ber_pallet`, `missing_pallet`, `created_at`, `updated_at`) VALUES
(1, 1, 11111, 'POOL_PALLET_DLI', 'Pool Pallet DLI', 'Citereup', 'Bogor', '+62 21 7989764, +62 21 79193612.', 'contact@dinamikalogistindo.com', 3000, 2990, 0, 0, 0, NULL, '2020-02-20 00:13:17'),
(2, 1, 11112, 'WAREHOUSE', 'Gudang Wangon', 'Jl.Raya Wangon-Lumbir KM.05\r\nDs.Adilingga, Wangon, Banyumas\r\n(sebelah kantor PLN Wangon)\r\n', 'Banyumas', '0281-5705096', 'dli_wangon@yahoo.co.id', 100, 17, 0, 0, 0, NULL, '2020-02-18 06:48:51'),
(3, 1, 11113, 'WAREHOUSE', 'Gudang Boyolali', 'Jl.Boyolali-Cepogo KM.03 Tegal Rejo\r\nWining-Boyolali\r\n', 'Boyolali', '0276-3295255', NULL, 100, 20, 0, 0, 0, NULL, '2020-02-20 00:12:43');

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

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `good_pallet` int(11) NOT NULL,
  `tbr_pallet` int(11) NOT NULL,
  `ber_pallet` int(11) NOT NULL,
  `missing_pallet` int(11) NOT NULL,
  `good_cement` int(11) NOT NULL,
  `bad_cement` int(11) NOT NULL,
  `note` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sjp_status`
--

INSERT INTO `sjp_status` (`sjp_status_id`, `checker_send_user_id`, `checker_receive_user_id`, `sjp_id`, `transaction_id`, `status`, `good_pallet`, `tbr_pallet`, `ber_pallet`, `missing_pallet`, `good_cement`, `bad_cement`, `note`, `created_at`, `updated_at`) VALUES
(10, 1, 3, 7, 1, 'RECEIVED', 17, 0, 0, 0, 320, 0, 'test', '2020-02-18 06:08:13', '2020-02-18 06:48:51'),
(12, 1, 3, 9, 1, 'RECEIVED', 10, 0, 0, 0, 640, 0, NULL, '2020-02-19 23:50:55', '2020-02-20 00:09:21'),
(13, 3, 1, 9, 2, 'RECEIVED', 10, 0, 0, 0, 0, 0, NULL, '2020-02-20 00:12:43', '2020-02-20 00:13:17');

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
  `packaging` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_quantity` int(11) NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `departure_time` date NOT NULL,
  `eta` date NOT NULL,
  `pallet_quantity` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `surat_jalan_pallet`
--

INSERT INTO `surat_jalan_pallet` (`sjp_id`, `destination_pool_pallet_id`, `departure_pool_pallet_id`, `vehicle_id`, `driver_id`, `transporter_id`, `sjp_number`, `no_do`, `product_name`, `packaging`, `product_quantity`, `status`, `departure_time`, `eta`, `pallet_quantity`, `created_at`, `updated_at`) VALUES
(4, 2, 1, 1, 1, 1, 'SJP-202002-00001', '11111-11111', 'Portland Composite Cement', '50', 640, 'CLOSED', '2020-02-17', '2020-02-19', 19, '2020-02-17 15:39:19', '2020-02-18 04:18:47'),
(7, 2, 1, 1, 1, 1, 'SJP-202002-00004', '1111111-1111111', 'Portland Composite Cement', '50', 640, 'CLOSED', '2020-02-18', '2020-02-20', 16, '2020-02-18 04:04:37', '2020-02-18 15:25:57'),
(8, 2, 1, 1, 1, 1, 'SJP-202002-00005', '11111-55555', 'Portland Composite Cement', '50', 640, 'OPEN', '2020-02-19', '2020-02-21', 16, '2020-02-19 03:23:22', '2020-02-19 03:23:22'),
(9, 3, 1, 1, 1, 1, 'SJP-202002-00006', '111111-555555', 'Portland Composite Cement', '50', 640, 'CLOSED', '2020-02-20', '2020-02-22', 16, '2020-02-19 23:48:39', '2020-02-20 00:13:17');

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
  `good_pallet` int(11) DEFAULT NULL,
  `tbr_pallet` int(11) DEFAULT NULL,
  `ber_pallet` int(11) DEFAULT NULL,
  `missing_pallet` int(11) DEFAULT NULL,
  `transporter_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transporter_address` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transporter_email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transporter`
--

INSERT INTO `transporter` (`transporter_id`, `organization_id`, `pallet_quota`, `good_pallet`, `tbr_pallet`, `ber_pallet`, `missing_pallet`, `transporter_name`, `transporter_address`, `phone_number`, `transporter_email`, `created_at`, `updated_at`) VALUES
(1, 1, 300, 9, 0, 0, 0, 'DLI Transporter', 'Perkantoran Buncit Mas Blok B8\r\nJL. Mampang Prapatan Raya 108\r\nKel. Duren Tiga, Kec. Pancoran\r\nJakarta Selatan – 12760, Indonesia.', '+62 21 7989764, +62 21 79193612.', 'contact@dinamikalogistindo.com', NULL, '2020-02-20 00:13:17');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '0: superadmin, 1: admin, 2: finance, 3: courier',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `photo`, `api_token`, `role`, `created_at`, `updated_at`) VALUES
(1, 'Anugrah Sandi', 'admin@daengweb.id', '2020-02-15 06:13:34', '$2y$10$ZHdl.FbRaRAcLHPddfrbReB4efcdWqPHxd5TXlQ0RlGP3t4zF89pO', '8CQz5Ay3BZ6GNESdM3ivD3iQfc9oH06dRam6G1a4QZpZA1oRJL7wiCXIrTux', NULL, 'hjJdIj5b6BczIaJlgrSZ7vnodeGyxDyy5gNqn0YC', '0', '2020-02-15 06:13:34', '2020-02-19 15:35:29'),
(3, 'Aulia Harvy', 'auliaharvy@gmail.com', '2020-02-17 23:50:04', '$2y$10$ZHdl.FbRaRAcLHPddfrbReB4efcdWqPHxd5TXlQ0RlGP3t4zF89pO', 'HG1vHtQRbevHdSeRBO8aRiQrfqkKxkIaCszx0Wibpz1Hp5QJ3fisiwB8SLuk', NULL, '7ogEnKsYxr7m2LuQ0jZnAnxYKC67GX5zGjM3WWr5', '0', '2020-02-17 23:49:45', '2020-02-19 22:17:30'),
(4, 'Anugrah Sandi', 'harby@gmail.com', '2020-02-18 06:33:49', '$2y$10$nSyF/tsClxJz23dikU2V9eGjd0HCwcvVNoCrSkldNoWA9rL4wcm7K', NULL, NULL, 'iAdhNtrRUuX1mcP0Ts2QYTvxdCZl5nG37mxspQ6n', '0', '2020-02-18 06:33:49', '2020-02-19 15:42:21'),
(5, NULL, '', NULL, '', NULL, NULL, NULL, '', NULL, NULL);

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
(1, 1, 'B 1111 DLI', 'Tronton', NULL, NULL);

--
-- Indexes for dumped tables
--

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
  ADD KEY `users_ber_missing_pallet_fk` (`reporter_user_id`) USING BTREE,
  ADD KEY `users_ber_missing_pallet_fk1` (`approver_user_id`) USING BTREE;

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customers_nik_unique` (`nik`),
  ADD KEY `customers_courier_id_foreign` (`courier_id`);

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
-- Indexes for table `sjp_status`
--
ALTER TABLE `sjp_status`
  ADD PRIMARY KEY (`sjp_status_id`),
  ADD KEY `user_sjp_status_fk` (`checker_send_user_id`),
  ADD KEY `surat_jalan_pallet_sjp_status_fk` (`sjp_id`);

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
  ADD UNIQUE KEY `users_email_unique` (`email`);

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
-- AUTO_INCREMENT for table `auto_numbers`
--
ALTER TABLE `auto_numbers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ber_missing_pallet`
--
ALTER TABLE `ber_missing_pallet`
  MODIFY `ber_missing_pallet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `detail_transactions`
--
ALTER TABLE `detail_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `driver`
--
ALTER TABLE `driver`
  MODIFY `driver_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `organization_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `outlets`
--
ALTER TABLE `outlets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pallet_transfer`
--
ALTER TABLE `pallet_transfer`
  MODIFY `pallet_transfer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pool_pallet`
--
ALTER TABLE `pool_pallet`
  MODIFY `pool_pallet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sjp_status`
--
ALTER TABLE `sjp_status`
  MODIFY `sjp_status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `surat_jalan_pallet`
--
ALTER TABLE `surat_jalan_pallet`
  MODIFY `sjp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transporter`
--
ALTER TABLE `transporter`
  MODIFY `transporter_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `vehicle`
--
ALTER TABLE `vehicle`
  MODIFY `vehicle_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
