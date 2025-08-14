# rental과 inventory 테이블을 JOIN하고, film 테이블에 있는 replcement_cost가 $20 이상인 영화를 대여한 곡객의 이름을 찾아주세요. 고객의 이름은 소문자로 출력
SELECT * FROM customer;
SELECT * FROM rental;
SELECT * FROM inventory;
SELECT * FROM film;

SELECT
	LOWER(c.first_name), LOWER(c.last_name)
FROM customer c
JOIN rental r ON r.customer_id = c.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
WHERE f.replacement_cost > 20;

#선생님

SELECT 
	CONCAT(LOWER(c.first_name), " ", LOWER(c.last_name)) AS name
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
WHERE f.replacement_cost > 20;

# film 테이블에서 rating 이 "PG-13"등급인 영화들에서, discription 의 길이가 rating이 "PG-13"등급인 영화들의 평균 description길이보다 긴 영화의 제목을 찾아주세요.

SELECT
	title, length(description)
FROM customer c
JOIN rental r ON r.customer_id = c.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
WHERE f.rating = 'PG-13' IN (
	SELECT AVG(FIL.length)
    FROM film FIL
    JOIN inventory INV ON INV.film_id = FIL.film_id
    JOIN rental REN ON REN.inventory_id = INV.inventory_id
    WHERE REN.customer_id = C.customer_id
);

#선생님
SELECT title, description
FROM film
WHERE rating = "PG-13" AND LENGTH(description) > (
	SELECT AVG(LENGTH(description)) AS avg_length
    FROM film
    WHERE rating = "PG-13"
);

# customer와 rental, inventory, film 테이블을 join하여 / 2005년 8월에 대여된 모든 "R"등급 영화의 제목과 해당 영화를 대여한 고객의 이메일을 찾아주세요.

SELECT * FROM customer;
SELECT * FROM rental;
SELECT * FROM inventory;
SELECT * FROM film;

SELECT rental_date, EXTRACT(MONTH FROM rental_date) AS rental_month from rental;

SELECT title, email, rental_date
FROM customer c
JOIN rental r ON r.customer_id = c.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
WHERE f.rating = "R" AND EXTRACT(MONTH FROM rental_date) = "5";

#선생님 (USING을 이용해서 외래키 한번에 선언하기)
SELECT title, email, rental_date
FROM customer c
JOIN rental r USING(customer_id)
JOIN inventory i USING(inventory_id)
JOIN film f USING(film_id)
WHERE
	YEAR(r.rental_date) = 2005
    AND MONTH(r.rental_date) = 5
    AND f.rating = "R";
    
#payment 테이블에서 가장 마지막에 결제된 일시에서 30일 이전까지의 모든 결제 내역을 찾고 / 해당 결제 내역에 대해서 각 고객별 총 결제 금액과 평균 결제금액을 소수점 둘째 자리에서 반올림하여 출력
SELECT * FROM payment;

SELECT
    customer_id,
    SUM(amount) AS total_amount,
    ROUND(AVG(amount), 2) AS avg_amount,
    DATE_ADD(payment_date, INTERVAL 30 DAY) AS payment_plus_30
FROM payment
WHERE DATE_ADD(payment_date, INTERVAL 30 DAY) = '2025-08-14'
GROUP BY customer_id;

#선생님
SELECT
	customer_id,
    ROUND(SUM(amount), 1) AS total_amount,
    ROUND(AVG(amount), 1) AS avg_amount
FROM payment
WHERE payment_date >= DATE_SUB(
	(SELECT MAX(payment_date) FROM payment), INTERVAL 30 DAY
)
GROUP BY customer_id
ORDER BY total_amount DESC;

#actor와 film_actor 테이블을 join하고 "Sci-Fi" /// 카테고리에 속한 영화에 출연한 배우의 이름을 찾으세요. 해당 배우의 이름은 성과 이름을 연결해서 대문자 출력
SELECT * FROM actor;
SELECT * FROM film_actor;
SELECT * FROM film_category;
SELECT * FROM category;
SELECT * FROM film;

SELECT CONCAT(UPPER(a.first_name), " ", UPPER(a.last_name)) AS name
FROM actor a
JOIN film_actor fa USING(actor_id)
JOIN film_category fc USING(film_id)
JOIN category c USING(category_id)
WHERE c.name = "Sci-Fi"
