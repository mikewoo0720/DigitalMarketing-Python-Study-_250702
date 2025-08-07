CREATE DATABASE IF NOT EXISTS musinsa_db_v1;
USE musinsa_db_v1;

CREATE TABLE IF NOT EXISTS customers (
	customer_id INT PRIMARY KEY,
	name VARCHAR(100),
	age INT,
	gender VARCHAR(10),
    address TEXT, # 2바이트 메모리 값을 고정값으로 가져감
    phone VARCHAR(50),
    email VARCHAR(100),
    grade VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS products (
	product_id INT PRIMARY KEY,
	product_name VARCHAR(100),
	stock INT,
	main_category VARCHAR(50),
    sub_category VARCHAR(50),
    price INT,
    discount_price INT,
    discount_rate INT
);

CREATE TABLE IF NOT EXISTS orders (
	order_id INT PRIMARY KEY,
	customer_id INT,
	product_id INT,
	quantity INT,
	order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE IF NOT EXISTS reviews (
	review_id INT PRIMARY KEY,
	customer_id INT,
	product_id INT,
	rating INT,
	review_text TEXT,
	review_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM reviews;