-- 在线商品销售平台数据库设计
-- 创建数据库
CREATE DATABASE IF NOT EXISTS shopping_mall DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE shopping_mall;

-- 1. 用户表
CREATE TABLE `user` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '用户ID',
  `username` VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
  `password` VARCHAR(100) NOT NULL COMMENT '密码（加密存储）',
  `real_name` VARCHAR(50) COMMENT '真实姓名',
  `email` VARCHAR(100) COMMENT '邮箱',
  `phone` VARCHAR(20) COMMENT '手机号',
  `address` VARCHAR(200) COMMENT '收货地址',
  `role` VARCHAR(20) NOT NULL DEFAULT 'USER' COMMENT '角色：USER-普通用户，ADMIN-管理员',
  `status` TINYINT NOT NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  INDEX idx_username (`username`),
  INDEX idx_phone (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 2. 商品分类表
CREATE TABLE `category` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '分类ID',
  `name` VARCHAR(50) NOT NULL COMMENT '分类名称',
  `parent_id` BIGINT DEFAULT 0 COMMENT '父分类ID，0表示顶级分类',
  `sort_order` INT DEFAULT 0 COMMENT '排序',
  `status` TINYINT NOT NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  INDEX idx_parent_id (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品分类表';

-- 3. 商品表
CREATE TABLE `product` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '商品ID',
  `category_id` BIGINT NOT NULL COMMENT '分类ID',
  `name` VARCHAR(100) NOT NULL COMMENT '商品名称',
  `subtitle` VARCHAR(200) COMMENT '商品副标题',
  `main_image` VARCHAR(200) COMMENT '主图URL',
  `detail` TEXT COMMENT '商品详情',
  `price` DECIMAL(10,2) NOT NULL COMMENT '价格',
  `stock` INT NOT NULL DEFAULT 0 COMMENT '库存数量',
  `status` TINYINT NOT NULL DEFAULT 1 COMMENT '状态：0-下架，1-上架',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  INDEX idx_category_id (`category_id`),
  INDEX idx_name (`name`),
  INDEX idx_status (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品表';

-- 4. 购物车表
CREATE TABLE `cart` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '购物车ID',
  `user_id` BIGINT NOT NULL COMMENT '用户ID',
  `product_id` BIGINT NOT NULL COMMENT '商品ID',
  `quantity` INT NOT NULL DEFAULT 1 COMMENT '购买数量',
  `checked` TINYINT NOT NULL DEFAULT 1 COMMENT '是否选中：0-未选中，1-选中',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  UNIQUE KEY uk_user_product (`user_id`, `product_id`),
  INDEX idx_user_id (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='购物车表';

-- 5. 订单表
CREATE TABLE `order_info` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '订单ID',
  `order_no` VARCHAR(50) NOT NULL UNIQUE COMMENT '订单号',
  `user_id` BIGINT NOT NULL COMMENT '用户ID',
  `receiver_name` VARCHAR(50) NOT NULL COMMENT '收货人姓名',
  `receiver_phone` VARCHAR(20) NOT NULL COMMENT '收货人电话',
  `receiver_address` VARCHAR(200) NOT NULL COMMENT '收货地址',
  `total_price` DECIMAL(10,2) NOT NULL COMMENT '订单总价',
  `status` INT NOT NULL DEFAULT 0 COMMENT '订单状态：0-待支付，1-已支付，2-已发货，3-已完成，4-已取消',
  `payment_time` DATETIME COMMENT '支付时间',
  `send_time` DATETIME COMMENT '发货时间',
  `end_time` DATETIME COMMENT '完成时间',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  INDEX idx_order_no (`order_no`),
  INDEX idx_user_id (`user_id`),
  INDEX idx_status (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

-- 6. 订单明细表
CREATE TABLE `order_item` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '订单明细ID',
  `order_id` BIGINT NOT NULL COMMENT '订单ID',
  `order_no` VARCHAR(50) NOT NULL COMMENT '订单号',
  `product_id` BIGINT NOT NULL COMMENT '商品ID',
  `product_name` VARCHAR(100) NOT NULL COMMENT '商品名称',
  `product_image` VARCHAR(200) COMMENT '商品图片',
  `current_price` DECIMAL(10,2) NOT NULL COMMENT '购买时单价',
  `quantity` INT NOT NULL COMMENT '购买数量',
  `total_price` DECIMAL(10,2) NOT NULL COMMENT '小计',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  INDEX idx_order_id (`order_id`),
  INDEX idx_order_no (`order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单明细表';

-- 插入初始数据

-- 插入管理员用户（密码：admin123，实际应用中需要加密）
INSERT INTO `user` (`username`, `password`, `real_name`, `email`, `phone`, `role`, `status`) 
VALUES ('admin', 'admin123', '管理员', 'admin@example.com', '13800138000', 'ADMIN', 1);

-- 插入测试用户（密码：user123）
INSERT INTO `user` (`username`, `password`, `real_name`, `email`, `phone`, `address`, `role`, `status`) 
VALUES ('user1', 'user123', '张三', 'zhangsan@example.com', '13800138001', '北京市朝阳区XX街道XX号', 'USER', 1);

-- 插入商品分类
INSERT INTO `category` (`name`, `parent_id`, `sort_order`) VALUES
('电子产品', 0, 1),
('服装鞋帽', 0, 2),
('图书音像', 0, 3),
('食品饮料', 0, 4),
('家居用品', 0, 5);

INSERT INTO `category` (`name`, `parent_id`, `sort_order`) VALUES
('手机', 1, 1),
('电脑', 1, 2),
('男装', 2, 1),
('女装', 2, 2),
('小说', 3, 1);

-- 插入测试商品
INSERT INTO `product` (`category_id`, `name`, `subtitle`, `main_image`, `detail`, `price`, `stock`, `status`) VALUES
(6, 'iPhone 15 Pro', '全新A17 Pro芯片，钛金属设计', '/images/iphone15.jpg', 'iPhone 15 Pro详细介绍...', 7999.00, 100, 1),
(6, '小米14', '骁龙8 Gen3，徕卡光学镜头', '/images/mi14.jpg', '小米14详细介绍...', 3999.00, 150, 1),
(7, 'MacBook Pro', 'M3芯片，16GB内存，512GB存储', '/images/macbook.jpg', 'MacBook Pro详细介绍...', 12999.00, 50, 1),
(7, '联想ThinkPad', '商务办公首选，稳定可靠', '/images/thinkpad.jpg', 'ThinkPad详细介绍...', 5999.00, 80, 1),
(8, '男士T恤', '纯棉舒适，多色可选', '/images/tshirt.jpg', '男士T恤详细介绍...', 99.00, 200, 1),
(9, '连衣裙', '优雅气质，适合多种场合', '/images/dress.jpg', '连衣裙详细介绍...', 299.00, 150, 1),
(10, '三体', '刘慈欣科幻巨著', '/images/santi.jpg', '三体详细介绍...', 59.00, 300, 1),
(10, '活着', '余华经典作品', '/images/huozhe.jpg', '活着详细介绍...', 39.00, 250, 1);
