-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 28, 2024 at 05:58 PM
-- Server version: 9.0.1
-- PHP Version: 8.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `restaurant_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `chefs`
--

CREATE TABLE `chefs` (
  `chef_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `speciality` varchar(255) NOT NULL,
  `contact` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `hired_at` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `chefs`
--

INSERT INTO `chefs` (`chef_id`, `name`, `speciality`, `contact`, `email`, `hired_at`) VALUES
(1, 'Chef Mario', 'Italian Cuisine', '1122334455', 'mario@outlook.com', '2023-01-15'),
(2, 'Chef Pierre', 'French Cuisine', '9988776655', 'pierre@yahoo.com', '2022-06-10');

-- --------------------------------------------------------

--
-- Table structure for table `dishes`
--

CREATE TABLE `dishes` (
  `dish_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `chef_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `dishes`
--

INSERT INTO `dishes` (`dish_id`, `name`, `description`, `price`, `image`, `chef_id`) VALUES
(1, 'Spaghetti Carbonara', 'Classic Italian pasta dish with creamy sauce and pancetta.', 15.99, 'burrito.webp', 1),
(2, 'Beef Bourguignon', 'French stew with tender beef and red wine sauce.', 19.99, 'caviar1.webp', 2),
(3, 'Margherita Pizza', 'Simple pizza with fresh tomato sauce, mozzarella, and basil.', 12.99, 'brownie.webp', 1),
(4, 'Coq au Vin', 'French braised chicken in red wine sauce.', 17.99, 'churros.jpg', 2);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int NOT NULL,
  `user_id` int NOT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('pending','completed','cancelled') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `order_date`, `total_amount`, `status`) VALUES
(1, 1, '2024-11-29 16:57:59', 35.97, 'completed'),
(2, 2, '2024-11-29 16:57:59', 29.98, 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL,
  `order_id` int NOT NULL,
  `dish_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `dish_id`, `quantity`, `price`) VALUES
(1, 1, 1, 2, 15.99),
(2, 1, 3, 1, 12.99),
(3, 2, 2, 1, 19.99),
(4, 2, 4, 1, 17.99);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `address`, `password`, `profile_image`, `created_at`) VALUES
(1, 'Nada', 'nada@outlook.com', '1234567890', 'Jnoub', 'password123', 'nada.jpg', '2024-11-29 16:57:59'),
(2, 'Mohammad Hamadani', 'mohammad@yahoo.com', '9876543210', 'Beirut', 'securepass456', 'mohammad.jpg', '2024-11-29 16:57:59'),
(3, '', '', '', '', '', NULL, '2024-12-23 23:37:46'),
(5, 'Omar Arja', 'omar2@gmail.com', '70', 'test', '$2y$12$6VfqMsZeLadxWsEcPGsbyuwRHaK8hhiGo7SFenRG883kaQmy1pAR2', '677037d8a405c_Low-resolution-test-images.webp', '2024-12-23 23:42:13'),
(7, 'Omar', 'omar1@gmail.com', '70', 'test', '$2y$12$zsfrl0Xf3v5CShuI41Fc6eNA2anfo28MOLBwWk18yamKWqx2tTsl6', NULL, '2024-12-23 23:46:15'),
(8, 'Omar', 'omar5@gmail.com', '70', 'test', '$2y$12$QtRU7xG374utsy5PFaOQVOSJXNoT4rmDp9R1JCi7KL97QcO8NW6QO', NULL, '2024-12-24 00:01:19'),
(9, 'Omar', 'omar6@gmail.com', '70', 'test', '$2y$12$BEJci9.A5VtypJkvkYo8R.BaO3be8SGfz/e71dUB8RI2IHAaGLmw.', '6769fa7751380_Low-resolution-test-images.webp', '2024-12-24 00:04:07'),
(10, 'Omar', 'omar7@gmail.com', '70', 'test', '$2y$12$IlRtZIzed5X7hqHobz49Qurj1XjehYoFhOqE2wHOpcxQdTvEk7JiC', NULL, '2024-12-26 15:18:56'),
(11, 'Omar Arja', 'admin@admin.com', '12344', 'Lebanon', '$2y$12$tHt9fhiTcYjjnSFd5UawR.2SGjsUnHSjNCKIeicy2o3lxm6W1Q5pi', '6770386f11ab5_Low-resolution-test-images.webp', '2024-12-28 16:56:02'),
(12, 'Nada Baalb', 'nada@gmail.comm', '12347', 'ggj', '$2y$12$CLhEOWjt9VBxTUSJ.8gqi.blaUgw36d7emCeJHWWvxfPUjwHHprUq', '67703ba72267c_Low-resolution-test-images.webp', '2024-12-28 17:51:05');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chefs`
--
ALTER TABLE `chefs`
  ADD PRIMARY KEY (`chef_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `dishes`
--
ALTER TABLE `dishes`
  ADD PRIMARY KEY (`dish_id`),
  ADD KEY `chef_id` (`chef_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `dish_id` (`dish_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chefs`
--
ALTER TABLE `chefs`
  MODIFY `chef_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `dishes`
--
ALTER TABLE `dishes`
  MODIFY `dish_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `dishes`
--
ALTER TABLE `dishes`
  ADD CONSTRAINT `dishes_ibfk_1` FOREIGN KEY (`chef_id`) REFERENCES `chefs` (`chef_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
