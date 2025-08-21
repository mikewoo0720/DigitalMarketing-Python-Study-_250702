SELECT
	title,
    rental_rate,
CASE
	WHEN rental_rate < 1 THEN "Cheap"
    WHEN rental_rate BETWEEN 1 AND 3 THEN "Moderate"
    ELSE "Expensive"
END AS PriceCategory
FROM film;

# WITH를 사용해서, sakila 데이터베이스의 각 등급별 영화의 평균 길이를 알아보세요.

WITH avg_length AS (
	SELECT AVG(length), rating
	FROM film
	GROUP BY rating
	ORDER BY AVG(length)
)
SELECT * FROM avg_length;

# CASE WHEN절을 사용해서 customer 테이블의 고객들을 active 컬럼에 따라 "Active" 또는 "Inactive"로 불류 출력해주세요.

SELECT
	first_name,
    active,
CASE
	WHEN active = 1 THEN "Active"
    WHEN active = 0 THEN "Inactive"
END AS ActiveUser
FROM customer;

# WITH를 사용해서, sakila의 film 테이블에서 각 rating에 따른 평균 rental_duration을 계산해보세요.
WITH Avg_duration AS (
	SELECT rating, AVG(rental_duration)
	FROM film
	GROUP BY rating)
SELECT * FROM Avg_duration;

# WITH를 사용해서 sakila의 payment 테이블에서 각 고객별 총 지불액을 계산하고, 그 지불액에 따라 고객을 "Low, Midium, High" 로 분류하세요.
# LOW : 0 - 50
# Medium : 51 - 100
# High : 100 초과

WITH Midium AS (
	SElECT customer_id, SUM(amount) sum
	FROM payment
	GROUP BY customer_id
	HAVING sum <= 100)
SELECT * FROM Midium;

#선생님

WITH CustomerPayments AS (
	SELECT customer_id, SUM(amount) total_payment
    FROM payment
    GROUP BY customer_id)
SELECT customer_id, total_payment,
	CASE
		WHEN total_payment BETWEEN 0 AND 50 THEN "LOW"
        WHEN total_payment BETWEEN 50 AND 100 THEN "MEDIUM"
        ELSE "HIGH"
	END AS PaymentStatus
FROM CustomerPayments
ORDER BY customer_id;

SELECT
	C.customer_id,
    CONCAT(C.first_name, " ", C.last_name) AS customer_name,
    GROUP_CONCAT(F.title ORDER BY F.title ASC SEPARATOR " / ") AS rented_movies
FROM customer C
JOIN rental R USING(customer_id)
JOIN inventory I USING(inventory_id)
JOIN film F USING(film_id)
GROUP BY C.customer_id
;

# 각 배우(actor)가 출연한 영화들의 제목을 세미콜론(;)으로 구분하여 하나의 문자열로 출력하세요. 결과에는 배우id, 배우이름, 출연영화 제목 리스트가 포함되도록 해주세요alter

SELECT 
	a.actor_id,
    CONCAT(a.first_name, " ", a.last_name) AS actor_name,
    GROUP_CONCAT(f.title ORDER BY f.title ASC SEPARATOR " ; ") AS film_actor
FROM actor a
JOIN film_actor fa USING(actor_id)
JOIN film f USING(film_id)
GROUP BY a.actor_id;

#선생님

#actor -> actor_id, first_name, last_name -> CONCAT()
#film_actor -> actor_id, film_id -> JOIN()
#film -> film_id, title -> GROUP_CONCAT()

SELECT
	A.actor_id,
    CONCAT(A.first_name, " ", A.last_name) AS actor_name,
    GROUP_CONCAT(F.title ORDER BY F.title ASC SEPARATOR " ; ") AS films
FROM actor AS A
JOIN film_actor FA USING(actor_id)
JOIN film F USING(film_id)
GROUP BY a.actor_id;

#"프로그래머스"를 참고하여 만든 문제들