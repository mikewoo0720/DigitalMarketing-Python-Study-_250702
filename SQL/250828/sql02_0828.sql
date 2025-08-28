# 문제 10.customer 테이블과 payment 테이블을 사용해서 각 도시별 고객의 총 결제 금액 순위를 출력!
# 고객 id, 도시, 총 결제 금액, 도시별 고객 순위

SELECT
	c.customer_id,
    ct.city,
    SUM(p.amount) AS total_amount,
	RANK() OVER (PARTITION BY ct.city_id ORDER BY SUM(amount) DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sum_amount_city_rank
FROM customer c
JOIN payment p USING(customer_id)
JOIN address a USING(address_id)
JOIN city ct USING(city_id)
GROUP BY customer_id;

# 문제 11.customer 테이블에서 고객별 대여 횟수에 따라 4개의 그룹으로 나눠주세요.
# 고객id, 대여횟수, 그룹 -> 출력

SELECT
	c.customer_id,
    COUNT(*) AS rental_count,
	NTILE(4) OVER (ORDER BY COUNT(*) DESC) AS customer_group
FROM customer c
JOIN rental r USING(customer_id)
GROUP BY c.customer_id;

# 문제 12. film 테이블에서 영화를 대여기간에 따라서 5개의 그룹으로 나누어주세요.
#영화 id, 대여기간, 그룹 -> 출력

SELECT
	film_id,
    rental_duration,
	NTILE(5) OVER (ORDER BY rental_duration DESC) AS customer_group
FROM film;

#문제 13. payment 테이블에서 각 고객별로 지불 내역에 행 번호를 부여해주세요.
#고객별 지불 내역의 행 번호는 payment_date가 낮은 순으로 부여해주세요.
#지불 id, 고객 id, 지불일정, 지불금액, 행번호

SELECT
	payment_id,
    customer_id,
    payment_date,
    amount,
	ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY payment_date
    DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS row_numbers  
FROM payment;

## 문제 14. film 테이블에서 각 등급별로 행 번호 부여
#영화는 대여기간에 따라 정렬 , film_id, rating, rental_duration, rownum
SELECT
	film_id,
    rating,
    rental_duration,
    ROW_NUMBER() OVER (PARTITION BY rating ORDER BY rating) AS row_numbers
FROM film;

## 문제 15. customer 테이블과 payment 테이블을 사용해서 고객을 총 결제금액에 따라 10개의 그룹으로 나누고 각 그룹내에서 총 결제 금액에 따라 번호를 부여하세요.
#고객 id, 총 결제 금액, 그룹, 그룹 내 행 번호 -> 출력

WITH CustomerPayments AS (
	SELECT
	c.customer_id,
    SUM(amount) AS total_amount,
    NTILE(10) OVER (ORDER BY SUM(amount) DESC) AS amount_group
	FROM customer c
	JOIN payment p USING(customer_id)
	GROUP BY customer_id
)
SELECT
	customer_id,
    total_amount,
    amount_group,
    ROW_NUMBER() OVER (PARTITION BY amount_group ORDER BY total_amount) AS row_numbers
FROM CustomerPayments
GROUP BY customer_id;