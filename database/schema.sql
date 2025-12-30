-- Shopping Mall Database Design
-- Create Database
CREATE DATABASE IF NOT EXISTS shopping_mall DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE shopping_mall;

-- 1. User Table
CREATE TABLE `user` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'User ID',
  `username` VARCHAR(50) NOT NULL UNIQUE COMMENT 'Username',
  `password` VARCHAR(100) NOT NULL COMMENT 'Password (encrypted)',
  `real_name` VARCHAR(50) COMMENT 'Real Name',
  `email` VARCHAR(100) COMMENT 'Email',
  `phone` VARCHAR(20) COMMENT 'Phone Number',
  `address` VARCHAR(200) COMMENT 'Shipping Address',
  `role` VARCHAR(20) NOT NULL DEFAULT 'USER' COMMENT 'Role: USER-Regular User, ADMIN-Administrator',
  `status` TINYINT NOT NULL DEFAULT 1 COMMENT 'Status: 0-Disabled, 1-Enabled',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Create Time',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update Time',
  INDEX idx_username (`username`),
  INDEX idx_phone (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='User Table';

-- 2. Category Table
CREATE TABLE `category` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'Category ID',
  `name` VARCHAR(50) NOT NULL COMMENT 'Category Name',
  `parent_id` BIGINT DEFAULT 0 COMMENT 'Parent Category ID, 0 means top level',
  `sort_order` INT DEFAULT 0 COMMENT 'Sort Order',
  `status` TINYINT NOT NULL DEFAULT 1 COMMENT 'Status: 0-Disabled, 1-Enabled',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Create Time',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update Time',
  INDEX idx_parent_id (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Category Table';

-- 3. Product Table
CREATE TABLE `product` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'Product ID',
  `category_id` BIGINT NOT NULL COMMENT 'Category ID',
  `name` VARCHAR(100) NOT NULL COMMENT 'Product Name',
  `subtitle` VARCHAR(200) COMMENT 'Product Subtitle',
  `main_image` VARCHAR(200) COMMENT 'Main Image URL',
  `detail` TEXT COMMENT 'Product Detail',
  `price` DECIMAL(10,2) NOT NULL COMMENT 'Price',
  `stock` INT NOT NULL DEFAULT 0 COMMENT 'Stock Quantity',
  `status` TINYINT NOT NULL DEFAULT 1 COMMENT 'Status: 0-Offline, 1-Online',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Create Time',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update Time',
  INDEX idx_category_id (`category_id`),
  INDEX idx_name (`name`),
  INDEX idx_status (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Product Table';

-- 4. Cart Table
CREATE TABLE `cart` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'Cart ID',
  `user_id` BIGINT NOT NULL COMMENT 'User ID',
  `product_id` BIGINT NOT NULL COMMENT 'Product ID',
  `quantity` INT NOT NULL DEFAULT 1 COMMENT 'Quantity',
  `checked` TINYINT NOT NULL DEFAULT 1 COMMENT 'Checked: 0-Unchecked, 1-Checked',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Create Time',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update Time',
  UNIQUE KEY uk_user_product (`user_id`, `product_id`),
  INDEX idx_user_id (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Cart Table';

-- 5. Order Table
CREATE TABLE `order_info` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'Order ID',
  `order_no` VARCHAR(50) NOT NULL UNIQUE COMMENT 'Order Number',
  `user_id` BIGINT NOT NULL COMMENT 'User ID',
  `receiver_name` VARCHAR(50) NOT NULL COMMENT 'Receiver Name',
  `receiver_phone` VARCHAR(20) NOT NULL COMMENT 'Receiver Phone',
  `receiver_address` VARCHAR(200) NOT NULL COMMENT 'Receiver Address',
  `total_price` DECIMAL(10,2) NOT NULL COMMENT 'Total Price',
  `status` INT NOT NULL DEFAULT 0 COMMENT 'Order Status: 0-Pending Payment, 1-Paid, 2-Shipped, 3-Completed, 4-Cancelled',
  `payment_time` DATETIME COMMENT 'Payment Time',
  `send_time` DATETIME COMMENT 'Shipping Time',
  `end_time` DATETIME COMMENT 'Completion Time',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Create Time',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update Time',
  INDEX idx_order_no (`order_no`),
  INDEX idx_user_id (`user_id`),
  INDEX idx_status (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Order Table';

-- 6. Order Item Table
CREATE TABLE `order_item` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'Order Item ID',
  `order_id` BIGINT NOT NULL COMMENT 'Order ID',
  `order_no` VARCHAR(50) NOT NULL COMMENT 'Order Number',
  `product_id` BIGINT NOT NULL COMMENT 'Product ID',
  `product_name` VARCHAR(100) NOT NULL COMMENT 'Product Name',
  `product_image` VARCHAR(200) COMMENT 'Product Image',
  `current_price` DECIMAL(10,2) NOT NULL COMMENT 'Unit Price at Purchase',
  `quantity` INT NOT NULL COMMENT 'Quantity',
  `total_price` DECIMAL(10,2) NOT NULL COMMENT 'Subtotal',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Create Time',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update Time',
  INDEX idx_order_id (`order_id`),
  INDEX idx_order_no (`order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Order Item Table';

-- Insert Initial Data

-- Insert Admin User (password: admin123, should be encrypted in production)
INSERT INTO `user` (`username`, `password`, `real_name`, `email`, `phone`, `role`, `status`) 
VALUES ('admin', 'admin123', 'Administrator', 'admin@example.com', '13800138000', 'ADMIN', 1);

-- Insert Test User (password: user123)
INSERT INTO `user` (`username`, `password`, `real_name`, `email`, `phone`, `address`, `role`, `status`) 
VALUES ('user1', 'user123', 'John Doe', 'john@example.com', '13800138001', 'Room 101, Building 1, XX Street, Chaoyang District, Beijing', 'USER', 1);

-- Insert Product Categories
INSERT INTO `category` (`name`, `parent_id`, `sort_order`) VALUES
('Electronics', 0, 1),
('Clothing', 0, 2),
('Books', 0, 3),
('Food & Beverage', 0, 4),
('Home & Garden', 0, 5);

INSERT INTO `category` (`name`, `parent_id`, `sort_order`) VALUES
('Mobile Phones', 1, 1),
('Computers', 1, 2),
('Men''s Clothing', 2, 1),
('Women''s Clothing', 2, 2),
('Novels', 3, 1);

-- Insert Test Products
INSERT INTO `product` (`category_id`, `name`, `subtitle`, `main_image`, `detail`, `price`, `stock`, `status`) VALUES
(6, 'iPhone 15 Pro', 'New A17 Pro chip, Titanium design', '/images/iphone15.jpg', 'iPhone 15 Pro detailed description...', 7999.00, 100, 1),
(6, 'Xiaomi 14', 'Snapdragon 8 Gen3, Leica optics', '/images/mi14.jpg', 'Xiaomi 14 detailed description...', 3999.00, 150, 1),
(7, 'MacBook Pro', 'M3 chip, 16GB RAM, 512GB storage', '/images/macbook.jpg', 'MacBook Pro detailed description...', 12999.00, 50, 1),
(7, 'Lenovo ThinkPad', 'Business laptop, stable and reliable', '/images/thinkpad.jpg', 'ThinkPad detailed description...', 5999.00, 80, 1),
(8, 'Men''s T-Shirt', 'Pure cotton, comfortable, multiple colors', '/images/tshirt.jpg', 'Men''s T-Shirt detailed description...', 99.00, 200, 1),
(9, 'Dress', 'Elegant style, suitable for various occasions', '/images/dress.jpg', 'Dress detailed description...', 299.00, 150, 1),
(10, 'The Three-Body Problem', 'Liu Cixin''s sci-fi masterpiece', '/images/santi.jpg', 'The Three-Body Problem detailed description...', 59.00, 300, 1),
(10, 'To Live', 'Yu Hua''s classic work', '/images/huozhe.jpg', 'To Live detailed description...', 39.00, 250, 1);
