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
#- 회원등급별 인원수 -> 가장많은 등급에 속해있는 사용자들을 분석해서 페르소나화 해야겠다.
#- 결론 : 회원등급별 인원수 출력

SELECT grade, COUNT(*) COUNT
FROM customers
GROUP BY grade
ORDER BY COUNT DESC;

#등급별 소비 최대, 최소, 평균
SELECT grade, MAX(price), MIN(price), AVG(price)
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN products p
ON o.product_id = p.product_id
GROUP BY grade
ORDER BY AVG(price) DESC;

SELECT grade, customer_id, product_id, price
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN products p
ON o.product_id = p.product_id;

# 결론 : 상품별 평균평점 출력
SELECT product_name, AVG(rating)
FROM products p
JOIN reviews r
ON p.product_id = r.product_id
GROUP BY product_name
ORDER BY AVG(rating) DESC;

#상품별 평균 가격
SELECT product_name, AVG(price)
FROM products
GROUP BY product_name
ORDER BY AVG(price);

#결론 : 최근 30일 이내에 주문된 전체 총 건수를 확인
SELECT COUNT(order_id)
FROM orders
WHERE order_date >= "2025-07-07";

SELECT COUNT(order_id)
FROM orders
WHERE order_date >= CURDATE() - INTERVAL 30 DAY;

SELECT COUNT(order_id)
FROM orders
WHERE order_date >= "2025-07-07";

#상품별 최근 한달간 주문건수를 구하세요!
SELECT o.product_id, product_name, COUNT(*) month_order_count
FROM orders o
JOIN products p
ON o.product_id = p.product_id
WHERE o.order_date >= CURDATE() - INTERVAL 30 DAY
GROUP BY product_id
ORDER BY month_order_count DESC;

#고객별 총 구매 건수와 구매 수량을 구하세요!!
SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM orders
WHERE customer_id = 7;

SELECT c.name, c.customer_id, COUNT(*), SUM(quantity), SUM(discount_price)
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN products p
ON o.product_id = p.product_id
GROUP BY customer_id
ORDER BY name;

# 고객별 총 구매금액 (*할인가를 기준)을 계산 후 출력해주세요!!

SELECT c.name, c.customer_id, COUNT(*), SUM(quantity), SUM(discount_price)
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN products p
ON o.product_id = p.product_id
GROUP BY customer_id
ORDER BY name;

# 선생님
SELECT
	o.customer_id,
    c.name,
    SUM(p.discount_price * o.quantity) total_spent
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY customer_id
ORDER BY customer_id;

#지금까지 가장 많이 판매된(판매 수량) 상품 TOP 5를 출력해주세요!
SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM orders;

SELECT p.product_id, product_name, SUM(quantity) product_quantity
FROM products p
JOIN orders o
ON p.product_id = o.product_id
GROUP BY p.product_id
ORDER BY product_quantity DESC;

#선생님
SELECT p.product_name, SUM(o.quantity) product_quantity
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY o.product_id
ORDER BY product_quantity DESC;

#평균 평점이 4.5 이상인 상품명과 평점 출력 (*인기상품)

SELECT p.product_name, AVG(r.rating) avg_rating
FROM products p
JOIN reviews r
ON p.product_id = r.product_id
GROUP BY p.product_id
HAVING avg_rating >= 4.5
ORDER BY avg_rating DESC;

#선생님

SELECT p.product_name, AVG(r.rating) avg_rating
FROM reviews r
JOIN products p ON r.product_id = p.product_id
GROUP BY r.product_id
HAVING avg_rating >= 4.5
ORDER BY avg_rating DESC;