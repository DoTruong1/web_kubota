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
  `createdDate` time NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `modifiedDate` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP ,
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
INSERT INTO product_category(name, image) VALUES('THI???T B??? TH???Y L???C KTM', '/public/category/category1.jpg');
INSERT INTO product_category(name, image) VALUES('D???ng c??? t??y ch???n - C???o h?????ng - B??n ??p phanh h?????ng', '/public/category/category2.jpg');
INSERT INTO product_category(name, image) VALUES('L???c - Nh???t - M??? - N?????c l??m m??t', '/public/category/category3.jpg');
INSERT INTO product_category(name, image) VALUES('Ph??? t??ng M??y G???t', '/public/category/category4.jpg');
INSERT INTO product_category(name, image) VALUES('D??Y ??AI', '/public/category/category5.jpg');

-- child
INSERT INTO product_category(name, ParentId)
 VALUES('M???T B??CH CHIA NH???T T??? H???P R??A M??Y K??O KUBOTA 5018 4508 4018 3408 3218', 31);
INSERT INTO product_category(name, ParentId)
 VALUES('VAN 1 TAY V?? PH??? KI???N L???P ?????T ????? B???',31);
INSERT INTO product_category(name, ParentId)
 VALUES('VAN 2 TAY V?? PH??? KI???N L???P ?????T ????? B??? NH?? H??NH D?????I', 31);

INSERT INTO product_category(name, ParentId)
 VALUES('C???O TAY C??NG H?????NG H???P S??? M??Y KUBOTA DC70', 32);
INSERT INTO product_category(name, ParentId)
 VALUES('D???NG C??? ??P L?? XO H?????NG L???P PHANH PHE H???P S??? M??Y KUBOTA DC70',32);
INSERT INTO product_category(name, ParentId)
 VALUES('TAY TU??P C??N L???C XI???T ???C', 32);

INSERT INTO product_category(name, ParentId)
 VALUES('D??Y ??AI DC70', 35);
INSERT INTO product_category(name, ParentId)
 VALUES('D??Y ??AI DC60', 35);
INSERT INTO product_category(name,  ParentId)
 VALUES('D??Y ??AI DC35', 35);

-- PRODUCT
INSERT INTO products(name, category_id, quantity, price)
  VALUES('M???t b??ch nh???t h???p r??a ?????n van th???y l???c ph??a sau 5018 4018 3218', 36, 30, 390000),
  ('M???t b??ch + Coren nh???t h???p r??a m??y k??o 4508', 36, 30, 390000),
  ('M???t b??ch nh???t + 2 coren m??y k??o 3408', 36, 30, 390000);;

INSERT INTO products(name, category_id, quantity, price)
  VALUES('B??? Van 1 tay + ph??? ki???n ph?? h???p cho m??y k??o L32/4018 Kubota', 37, 30, 2180000),
  ('B??? Van 1 tay + ph??? ki???n ph?? h???p cho m??y k??o L5018 Kubota', 37, 30, 2180000),
  ('B??? Van 1 tay + ph??? ki???n ph?? h???p cho m??y k??o L31/3408 Kubota', 37, 30, 2180000),
   ('B??? Van 1 tay + ph??? ki???n ph?? h???p cho m??y k??o L4508 Kubota', 37, 30, 2180000);

INSERT INTO products(name, category_id, quantity, price)
  VALUES('B??? Van 2 tay v?? ph??? ki???n ph?? h???p cho m??y k??o L3218/4018 Kubota', 38, 30, 2480000),
  ('B??? Van 2 tay v?? ph??? ki???n ph?? h???p cho m??y k??o L5018 Kubota', 38, 30, 2480000),
  ('B??? Van 2 tay v?? ph??? ki???n ph?? h???p cho m??y k??o L31/l3408 Kubota', 38, 30, 2480000),
   ('B??? Van 2 tay v?? ph??? ki???n ph?? h???p cho m??y k??o L4508 Kubota', 38, 30, 2480000);

INSERT INTO products(name, category_id, quantity, price)
  VALUES('C???o c??ng h?????ng DC70', 41, 30, 450000);

INSERT INTO products(name, category_id, quantity, price)
  VALUES('D???ng c??? ??p l?? xo chuy???n h?????ng', 41, 30, 150000);

INSERT INTO products(name, category_id, quantity, price)
  VALUES('Tay Tu??p c??n l???c xi???t ???c', 41, 30, 900000);


INSERT INTO products(name, category_id, quantity, price)
  VALUES('D??Y ??AI qu???t gi?? k??t n?????c RF3405', 42, 30, 111000),
  ('D??Y ??AI CH??? V (V-BELT,C59) 0kg 2', 42, 30, 930000),
  ('D??Y ??AI CH??? V, B??? ?????p (V-BELT,C52) 0kg 2', 42, 30, 830000),
  ('D??Y ??AI CH??? V (V-BELT,B107) 0kg 1', 42, 30, 240000);

INSERT INTO products(name, category_id, quantity, price)
  VALUES
  ('D??Y ??AI CH??? V, HST (BELT,V) 0.000kg 2) 0kg 2', 43, 30, 930000),
  ('D??Y ??AI CH??? V, B??? ?????M (COG-BELT,V,C54,COUNTER) 0.000kg 2) 0kg 2', 43, 30, 830000),
  ('D??Y ??AI CH??? V (BELT,V) 0.000kg 1', 43, 30, 240000);

INSERT INTO products(name, category_id, quantity, price)
  VALUES('D??Y ??AI CH??? V (V-BELT(FAN,38REC)) 0.05kg 1', 44, 30, 80000),
  ('D??Y ??AI CH??? V (V-BELT(C63)) 0.4kg 1', 44, 30, 769000),
  ('D??Y ??AI CH??? V,C???M (V-BELT,ASSY) 0.4kg 1', 44, 30, 100000),
  ('D??Y ??AI CH??? V (V-BELT) 0kg 1', 44, 30, 395000);
