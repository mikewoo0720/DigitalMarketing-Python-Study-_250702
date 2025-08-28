# 영화 길이에 대한 백분위 순위와 누적분포 계산
# 백분위 순위 : 전체를 100% -> 0 ~ 1 => PERCENT_RANK()
#누적분포 : 전체를 기준으로 각 그룹의 비율이 몇프로대까지인지를 누적해서 보는 것 => CUME_DIST()

#백분위 순위 문법
SELECT
	title, length,
	PERCENT_RANK() OVER (ORDER BY length) AS percent,
    CUME_DIST() OVER (ORDER BY length) AS cume
FROM film;

SELECT
	customer_id,
    CONCAT(first_name, ' ', last_name) AS customer_name,
    NTILE(4) OVER (ORDER BY customer_id) AS customer_group
FROM customer;

# 문제1. payment 테이블에서 각 고객들의 결제금액을 출력하세요. 단, 출력 내용은 다음과 같아야 합니다. 고객 id, 고객 결제금액, 해당 행의 결제 금액의 이전 결제금액, 해당 행의 결제 금액의 다음 결제금액
SELECT * FROM payment;

SELECT 
	customer_id,
    LAG(customer_id, 1, 0)
    OVER(ORDER BY amount) AS pre_amount,
	LEAD(customer_id, 1, 0)
    OVER(ORDER BY amount) AS next_amount
FROM payment;

#선생님
SELECT
	customer_id,
    amount,
    LAG(amount) OVER (PARTITION BY  customer_id ORDER BY payment_date) AS pre_amount,
    LEAD(amount) OVER (PARTITION BY  customer_id ORDER BY payment_date) AS next_amount
FROM payment;

# 문제2. rental 테이블에서 각 고객별로 첫번째 대여일자와 마지막 대여일자를 출력하세요. 출력결과물 : 고객id, 첫번째 대여일자, 마지막 대여일자가 포함되어 있으면 됩니다.

SELECT 
	DISTINCT customer_id,
    FIRST_VALUE(rental_date)
    OVER (PARTITION BY customer_id ORDER BY rental_date) AS first_rental_date,
    LAST_VALUE(rental_date)
    OVER (PARTITION BY customer_id ORDER BY rental_date
			ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_rental_date
FROM rental;

# 문제3. payment 테이블에서 각 직원이 처리한 첫번째 결제와 마지막 결제 금액을 출력, 출력결과물 : 고객id, 첫번째 결제금액, 해당직원이 처리한 마지막 결제금액

SELECT 
	DISTINCT staff_id,
    FIRST_VALUE(amount) OVER
		(PARTITION BY staff_id ORDER BY payment_date) AS first_payment_amount,
    LAST_VALUE(amount) OVER
		(PARTITION BY staff_id ORDER BY payment_date
		ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_payment_amount
FROM payment;

# 문제4. film 테이블에서 각 영화의 대여기간에 대한 백분위 순위, 누적분포를 계산해주세요.#영화제목, 대여기간, 백분위순위, 누적분포 -> 출력
SELECT 
	title,
    rental_duration,
	PERCENT_RANK() OVER (ORDER BY rental_duration) AS percent_rental_duration,
    CUME_DIST() OVER (ORDER BY rental_duration) AS cume_rental_duration
FROM film;

# 문제5. customer 테이블에서 각 고객의 결제 금액에 대한 백분위 순위와 누적분포를 계산해주세요.

SELECT
	c.customer_id,
    SUM(p.amount) AS total_amount,
	PERCENT_RANK() OVER (ORDER BY SUM(p.amount) DESC) AS total_amount_percent,
    CUME_DIST() OVER (ORDER BY SUM(p.amount) DESC) AS total_amount_cume
FROM customer c
JOIN payment p USING(customer_id)
GROUP BY c.customer_id
ORDER BY total_amount;

# 문제 6. rental 테이블에서 각 고객별로 대여순서에 따른 누적 대여 횟수를 출력해주세요.
# 대여 id, 고객 id, 대여 날짜, 누적 대여 횟수 -> 출력

SELECT
	rental_id,
    customer_id,
    rental_date,
    COUNT(*) OVER (PARTITION BY customer_id ORDER BY rental_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS count_rentals
FROM rental;

# 문제 7. payment 테이블에서 각 고객별로 결제 일자에 따른 누적 결제 금액을 출력해주세요.
# 결제 ID, 고객 id,  결제 날짜, 결제 금액, 누적 결제 금액

SELECT
	payment_id,
    customer_id,
    payment_date,
    amount,
	SUM(amount) OVER (PARTITION BY customer_id ORDER BY payment_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sum_amounts
FROM payment;

# 문제 8. rental 테이블에서 각 직원들의 대여 날짜에 따른 대여횟수와 각 직원별 누적 대여 횟수를 출력!
# 대여id, 직원id, 대여날짜, 대여횟수, 누적대여횟수 -> 출력되어야하는 값!

SELECT
	rental_id, staff_id, rental_date,
    COUNT(*) OVER (PARTITION BY staff_id, DATE(rental_date) ORDER BY DATE(rental_date)
					ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS total_rental_staff,
    COUNT(*) OVER (PARTITION BY staff_id ORDER BY DATE(rental_date)
					ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sum_rental_count
FROM rental;