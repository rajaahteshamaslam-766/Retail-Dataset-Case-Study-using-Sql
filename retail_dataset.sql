-- MySQL Workbench compatible practice dataset

-- Run this entire file in MySQL Workbench. It recreates the practice database.

CREATE DATABASE IF NOT EXISTS sql_practice_retail;

USE sql_practice_retail;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS order_items;

DROP TABLE IF EXISTS orders;

DROP TABLE IF EXISTS products;

DROP TABLE IF EXISTS customers;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(100) NOT NULL,
  city VARCHAR(60) NOT NULL,
  region VARCHAR(40) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  category VARCHAR(50) NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  stock_quantity INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date DATE NOT NULL,
  status ENUM('Completed','Pending','Cancelled') NOT NULL,
  CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
) ENGINE=InnoDB;

CREATE TABLE order_items (
  order_item_id INT PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_items_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
  CONSTRAINT fk_items_product FOREIGN KEY (product_id) REFERENCES products(product_id)
) ENGINE=InnoDB;

INSERT INTO customers (customer_id, customer_name, city, region) VALUES

(1,'Ali Khan','Muzaffarabad','AJK'),
(2,'Sara Ahmed','Islamabad','ICT'),
(3,'Usman Malik','Rawalpindi','Punjab'),
(4,'Ayesha Noor','Lahore','Punjab'),
(5,'Hamza Raza','Karachi','Sindh'),
(6,'Fatima Shah','Peshawar','KPK'),
(7,'Bilal Hussain','Mirpur','AJK'),
(8,'Zainab Iqbal','Faisalabad','Punjab'),
(9,'Danish Akram','Quetta','Balochistan'),
(10,'Hira Javed','Multan','Punjab'),
(11,'Omar Farooq','Islamabad','ICT'),
(12,'Maryam Tariq','Lahore','Punjab'),
(13,'Ahmed Saeed','Karachi','Sindh'),
(14,'Noor Fatima','Abbottabad','KPK'),
(15,'Saad Qureshi','Mirpur','AJK');

INSERT INTO products (product_id, product_name, category, unit_price, stock_quantity) VALUES

(1,'Wireless Mouse','Accessories',2500.00,50),
(2,'Keyboard','Accessories',4200.00,35),
(3,'USB-C Hub','Accessories',6500.00,20),
(4,'Laptop Stand','Office',3800.00,25),
(5,'Notebook Pack','Office',800.00,100),
(6,'Office Chair','Furniture',18500.00,12),
(7,'Desk Lamp','Furniture',5200.00,18),
(8,'Webcam','Electronics',9200.00,15),
(9,'Headphones','Electronics',7800.00,22),
(10,'External SSD','Electronics',16500.00,10);

INSERT INTO orders (order_id, customer_id, order_date, status) VALUES

(1,11,'2025-02-27','Completed'),
(2,5,'2025-05-06','Completed'),
(3,12,'2025-02-22','Completed'),
(4,15,'2025-10-07','Completed'),
(5,7,'2025-01-17','Completed'),
(6,4,'2025-04-30','Completed'),
(7,1,'2025-10-15','Completed'),
(8,11,'2025-10-07','Completed'),
(9,8,'2025-05-23','Pending'),
(10,1,'2025-03-23','Completed'),
(11,6,'2025-05-23','Completed'),
(12,13,'2025-06-22','Completed'),
(13,7,'2025-02-19','Completed'),
(14,6,'2025-05-16','Pending'),
(15,12,'2025-08-24','Completed'),
(16,15,'2025-07-13','Completed'),
(17,5,'2025-07-05','Completed'),
(18,12,'2025-02-05','Completed'),
(19,4,'2025-05-29','Cancelled'),
(20,14,'2025-04-30','Pending'),
(21,7,'2025-05-23','Completed'),
(22,14,'2025-07-06','Completed'),
(23,6,'2025-04-18','Completed'),
(24,12,'2025-02-06','Completed'),
(25,3,'2025-10-01','Pending'),
(26,3,'2025-08-25','Completed'),
(27,15,'2025-10-13','Completed'),
(28,6,'2025-01-29','Completed'),
(29,1,'2025-06-11','Completed'),
(30,2,'2025-04-19','Cancelled'),
(31,10,'2025-06-11','Completed'),
(32,8,'2025-07-22','Pending'),
(33,11,'2025-08-23','Completed'),
(34,3,'2025-05-07','Pending'),
(35,9,'2025-05-15','Pending'),
(36,7,'2025-10-26','Completed'),
(37,4,'2025-03-12','Completed'),
(38,2,'2025-01-25','Pending'),
(39,3,'2025-03-23','Pending'),
(40,7,'2025-02-02','Completed'),
(41,10,'2025-08-28','Completed'),
(42,9,'2025-01-06','Completed'),
(43,2,'2025-10-02','Pending'),
(44,13,'2025-06-24','Completed'),
(45,7,'2025-03-22','Completed'),
(46,12,'2025-05-15','Cancelled'),
(47,13,'2025-04-02','Completed'),
(48,2,'2025-06-02','Pending'),
(49,9,'2025-04-12','Completed'),
(50,13,'2025-03-24','Completed'),
(51,13,'2025-09-29','Cancelled'),
(52,10,'2025-06-15','Completed'),
(53,2,'2025-07-05','Pending'),
(54,14,'2025-06-07','Completed'),
(55,4,'2025-10-18','Cancelled'),
(56,2,'2025-09-06','Pending'),
(57,13,'2025-09-30','Pending'),
(58,3,'2025-09-01','Cancelled'),
(59,3,'2025-05-16','Completed'),
(60,10,'2025-08-05','Cancelled');

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES

(1,1,4,3,3800.00),
(2,1,7,3,5200.00),
(3,1,8,4,9200.00),
(4,2,4,2,3800.00),
(5,3,6,1,18500.00),
(6,4,9,2,7800.00),
(7,4,10,2,16500.00),
(8,4,1,1,2500.00),
(9,5,1,2,2500.00),
(10,5,2,1,4200.00),
(11,5,6,1,18500.00),
(12,6,4,3,3800.00),
(13,6,8,2,9200.00),
(14,6,9,2,7800.00),
(15,7,10,4,16500.00),
(16,7,4,4,3800.00),
(17,7,7,2,5200.00),
(18,8,2,4,4200.00),
(19,9,7,4,5200.00),
(20,9,8,1,9200.00),
(21,10,2,1,4200.00),
(22,10,7,3,5200.00),
(23,10,2,2,4200.00),
(24,11,4,4,3800.00),
(25,12,7,2,5200.00),
(26,13,8,2,9200.00),
(27,13,2,4,4200.00),
(28,14,2,1,4200.00),
(29,14,9,1,7800.00),
(30,14,2,2,4200.00),
(31,15,7,4,5200.00),
(32,16,4,4,3800.00),
(33,16,1,2,2500.00),
(34,17,1,4,2500.00),
(35,17,5,4,800.00),
(36,18,7,4,5200.00),
(37,18,3,2,6500.00),
(38,19,4,1,3800.00),
(39,19,10,1,16500.00),
(40,20,6,1,18500.00),
(41,20,1,4,2500.00),
(42,20,9,2,7800.00),
(43,21,9,1,7800.00),
(44,22,2,1,4200.00),
(45,23,4,4,3800.00),
(46,23,2,2,4200.00),
(47,23,10,1,16500.00),
(48,24,2,4,4200.00),
(49,24,10,3,16500.00),
(50,24,5,2,800.00),
(51,25,6,2,18500.00),
(52,25,5,4,800.00),
(53,25,3,3,6500.00),
(54,26,6,1,18500.00),
(55,26,1,4,2500.00),
(56,27,10,1,16500.00),
(57,27,2,2,4200.00),
(58,27,9,3,7800.00),
(59,28,6,1,18500.00),
(60,29,6,3,18500.00),
(61,30,8,3,9200.00),
(62,31,9,1,7800.00),
(63,31,9,3,7800.00),
(64,31,2,2,4200.00),
(65,32,2,1,4200.00),
(66,32,9,2,7800.00),
(67,33,5,2,800.00),
(68,33,6,2,18500.00),
(69,34,5,4,800.00),
(70,34,5,1,800.00),
(71,34,2,4,4200.00),
(72,35,1,1,2500.00),
(73,35,6,2,18500.00),
(74,36,5,2,800.00),
(75,36,8,4,9200.00),
(76,36,9,1,7800.00),
(77,37,2,2,4200.00),
(78,38,1,3,2500.00),
(79,38,10,2,16500.00),
(80,38,7,2,5200.00),
(81,39,5,3,800.00),
(82,40,6,2,18500.00),
(83,41,4,1,3800.00),
(84,41,6,4,18500.00),
(85,41,10,2,16500.00),
(86,42,3,2,6500.00),
(87,43,1,2,2500.00),
(88,43,6,4,18500.00),
(89,44,4,3,3800.00),
(90,44,3,1,6500.00),
(91,44,7,1,5200.00),
(92,45,4,2,3800.00),
(93,45,8,3,9200.00),
(94,46,4,2,3800.00),
(95,46,1,2,2500.00),
(96,47,6,3,18500.00),
(97,47,2,3,4200.00),
(98,48,9,4,7800.00),
(99,48,9,3,7800.00),
(100,49,2,3,4200.00),
(101,50,10,3,16500.00),
(102,51,2,4,4200.00),
(103,52,6,4,18500.00),
(104,52,10,1,16500.00),
(105,53,10,2,16500.00),
(106,53,5,1,800.00),
(107,54,7,1,5200.00),
(108,54,9,2,7800.00),
(109,54,6,4,18500.00),
(110,55,6,3,18500.00),
(111,56,2,3,4200.00),
(112,56,9,3,7800.00),
(113,56,7,3,5200.00),
(114,57,5,2,800.00),
(115,57,4,4,3800.00),
(116,58,7,2,5200.00),
(117,58,10,3,16500.00),
(118,58,7,1,5200.00),
(119,59,5,2,800.00),
(120,59,7,3,5200.00),
(121,60,8,4,9200.00),
(122,60,4,4,3800.00);

-- Quick check

SELECT COUNT(*) AS customer_count FROM customers;

SELECT COUNT(*) AS order_count FROM orders;

SELECT COUNT(*) AS order_item_count FROM order_items;