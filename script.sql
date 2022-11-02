CREATE database admin;
use admin;
-- ADMIN
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `password` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- USER
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `address` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `password` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- shopping session
CREATE TABLE `shopping_session` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `total` decimal(10,0) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`id`),
  KEY `fk_shopping_session_user_idx` (`user_id`),
  CONSTRAINT `fk_shopping_session_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- card item
CREATE TABLE `cart_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `session_id` int NOT NULL,
  `quantity` int NOT NULL,
  `product_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`id`),
  KEY `fk_cart_item_shopping_session_idx` (`session_id`),
  CONSTRAINT `fk_cart_item_shopping_session` FOREIGN KEY (`session_id`) REFERENCES `shopping_session` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- category
CREATE TABLE `product_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentID` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=31;

-- discount
CREATE TABLE `discount` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_percent` decimal(10,0) NOT NULL,
  `active` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- products
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `category_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `discount_id` int NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `modifiedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_products_cate_idx` (`category_id`),
  KEY `fk_products_discount_idx` (`discount_id`),
  FULLTEXT KEY `name` (`name`),
  CONSTRAINT `fk_products_cate` FOREIGN KEY (`category_id`) REFERENCES `product_category` (`id`),
  CONSTRAINT `fk_products_discount` FOREIGN KEY (`discount_id`) REFERENCES `discount` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- payment detail
CREATE TABLE `payment_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  'payment_type' tinyint DEFAULT NULL,
  `amount` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- order detail
CREATE TABLE `order_details` (
  `id` int AUTO_INCREMENT NOT NULL,
  `user_id` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` decimal(10,0) NOT NULL,
  `payment_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `modified_at` timestamp NULL DEFAULT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`id`),
  KEY `fk_order_details_payment details_idx` (`payment_id`),
  CONSTRAINT `fk_order_details_payment details` FOREIGN KEY (`payment_id`) REFERENCES `payment_details` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- order item
CREATE TABLE `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `quantity` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`id`),
  KEY `fk_order_items_order_details_idx` (`order_id`),
  CONSTRAINT `fk_order_items_order_details` FOREIGN KEY (`order_id`) REFERENCES `order_details` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci; 

-- transaction
CREATE TABLE `transaction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `status` tinyint NOT NULL DEFAULT '0',
  `user_id` int NOT NULL DEFAULT '0',
  `user_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `user_email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `user_phone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `amount` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `payment` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `payment_info` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `message` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `security` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `created` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- alter
-- ALTER TABLE `product`
--  MODIFY FOREIGN KEY (category_id) REFERENCES product_category(id)
--  ON DELETE CASCADE
--  ON UPDATE CASCADE;


-- INSERT DATA

-- ADMIN

-- USER

INSERT INTO user(username, email, address, phone,password) 
  VALUES('khachhang1', 'khachhang1@gmail.com', 'HN', '098765542','@khachhang123');

INSERT INTO user(username, email, address,  phone,password) 
  VALUES('khachhang2', 'khachhang2@gmail.com', 'HN','098765542','@khachhang123');

INSERT INTO user(username, email, address,  phone,password) 
  VALUES('khachhang3', 'khachhang3@gmail.com', 'HN','098765542', '@khachhang123');

INSERT INTO user(username, email, address,  phone,password) 
  VALUES('khachhang4', 'khachhang4@gmail.com', 'HN','098765542', '@khachhang123');

INSERT INTO user(username, email, address,  phone,password) 
  VALUES('khachhang5', 'khachhang5@gmail.com', 'HN','098765542', '@khachhang123');

-- CATEGORY

-- parent
INSERT INTO product_category(name, image) VALUES('THIẾT BỊ THỦY LỰC KTM', '/public/category/category1.jpg');
INSERT INTO product_category(name, image) VALUES('Dụng cụ tùy chọn - Cảo hướng - Bàn ép phanh hướng', '/public/category/category2.jpg');
INSERT INTO product_category(name, image) VALUES('Lọc - Nhớt - Mỡ - Nước làm mát', '/public/category/category3.jpg');
INSERT INTO product_category(name, image) VALUES('Phụ tùng Máy Gặt', '/public/category/category4.jpg');
INSERT INTO product_category(name, image) VALUES('DÂY ĐAI', '/public/category/category5.jpg');

-- child

INSERT INTO admin.product_category
(name, image, description, parentID)
VALUES('MẶT BÍCH CHIA NHỚT TỪ HỘP RÙA MÁY KÉO KUBOTA 5018 4508 4018 3408 3218', 'none', 'none', 31);
INSERT INTO admin.product_category
(name, image, description, parentID)
VALUES('VAN 1 TAY VÀ PHỤ KIỆN LẮP ĐẶT ĐỦ BỘ', 'none', 'none', 31);
INSERT INTO admin.product_category
(name, image, description, parentID)
VALUES('VAN 2 TAY VÀ PHỤ KIỆN LẮP ĐẶT ĐỦ BỘ NHƯ HÌNH DƯỚI', 'none', 'none', 31);


INSERT INTO product_category(name, image, description, ParentId)
 VALUES('CẢO TAY CÀNG HƯỚNG HỘP SỐ MÁY KUBOTA DC70','' ,'',32);
INSERT INTO product_category(name, image, description, ParentId)
 VALUES('DỤNG CỤ ÉP LÒ XO HƯỚNG LẮP PHANH PHE HỘP SỐ MÁY KUBOTA DC70','' ,'',32);
INSERT INTO product_category(name, image, description, ParentId)
 VALUES('TAY TUÝP CÂN LỰC XIẾT ỐC','' ,'',32);


INSERT INTO product_category(name,image,description , ParentId)
 VALUES('DÂY ĐAI DC70','' ,'',35);
INSERT INTO product_category(name,image ,description,  ParentId)
 VALUES('DÂY ĐAI DC60','' ,'',35);
INSERT INTO product_category(name,image ,description , ParentId)
 VALUES('DÂY ĐAI DC35','','', 35);

-- PRODUCT
INSERT INTO products(name, category_id, quantity, price)
  VALUES('Mặt bích nhớt hộp rùa đến van thủy lực phía sau 5018 4018 3218', 36, 30, 390000),
  ('Mặt bích + Coren nhớt hộp rùa máy kéo 4508', 36, 30, 390000),
  ('Mặt bích nhớt + 2 coren máy kéo 3408', 36, 30, 390000);;

INSERT INTO products(name, category_id, quantity, price)
  VALUES('Bộ Van 1 tay + phụ kiện phù hợp cho máy kéo L32/4018 Kubota', 37, 30, 2180000),
  ('Bộ Van 1 tay + phụ kiện phù hợp cho máy kéo L5018 Kubota', 37, 30, 2180000),
  ('Bộ Van 1 tay + phụ kiện phù hợp cho máy kéo L31/3408 Kubota', 37, 30, 2180000),
   ('Bộ Van 1 tay + phụ kiện phù hợp cho máy kéo L4508 Kubota', 37, 30, 2180000);

INSERT INTO products(name, category_id, quantity, price)
  VALUES('Bộ Van 2 tay và phụ kiện phù hợp cho máy kéo L3218/4018 Kubota', 38, 30, 2480000),
  ('Bộ Van 2 tay và phụ kiện phù hợp cho máy kéo L5018 Kubota', 38, 30, 2480000),
  ('Bộ Van 2 tay và phụ kiện phù hợp cho máy kéo L31/l3408 Kubota', 38, 30, 2480000),
   ('Bộ Van 2 tay và phụ kiện phù hợp cho máy kéo L4508 Kubota', 38, 30, 2480000);

INSERT INTO products(name, category_id, quantity, price)
  VALUES('Cảo càng hướng DC70', 41, 30, 450000);

INSERT INTO products(name, category_id, quantity, price)
  VALUES('Dụng cụ ép lò xo chuyển hướng', 41, 30, 150000);

INSERT INTO products(name, category_id, quantity, price)
  VALUES('Tay Tuýp cân lực xiết ốc', 41, 30, 900000);

--
INSERT INTO products(name, category_id, quantity, price)
  VALUES('DÂY ĐAI quạt gió két nước RF3405', 42, 30, 111000),
  ('DÂY ĐAI CHỮ V (V-BELT,C59) 0kg 2', 42, 30, 930000),
  ('DÂY ĐAI CHỮ V, BỘ Đập (V-BELT,C52) 0kg 2', 42, 30, 830000),
  ('DÂY ĐAI CHỮ V (V-BELT,B107) 0kg 1', 42, 30, 240000);

INSERT INTO products(name, category_id, quantity, price)
  VALUES
  ('DÂY ĐAI CHỮ V, HST (BELT,V) 0.000kg 2) 0kg 2', 43, 30, 930000),
  ('DÂY ĐAI CHỮ V, BỘ ĐẾM (COG-BELT,V,C54,COUNTER) 0.000kg 2) 0kg 2', 43, 30, 830000),
  ('DÂY ĐAI CHỮ V (BELT,V) 0.000kg 1', 43, 30, 240000);

INSERT INTO products(name, category_id, quantity, price)
  VALUES('DÂY ĐAI CHỮ V (V-BELT(FAN,38REC)) 0.05kg 1', 44, 30, 80000),
  ('DÂY ĐAI CHỮ V (V-BELT(C63)) 0.4kg 1', 44, 30, 769000),
  ('DÂY ĐAI CHỮ V,CỤM (V-BELT,ASSY) 0.4kg 1', 44, 30, 100000),
  ('DÂY ĐAI CHỮ V (V-BELT) 0kg 1', 44, 30, 395000);
 
 ALTER USER 'root'@'127.0.0.1' IDENTIFIED WITH mysql_native_password BY 'ASD123qwe@';
 flush privileges;

 --
 GRANT ALL PRIVILEGES ON . TO 'do'@'localhost' IDENTITY BY 'ASD123qwe@';

 

