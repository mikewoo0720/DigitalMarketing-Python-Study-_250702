USE sakila;

SHOW TABLES;

SELECT
	p.customer_id, p.amount, p.payment_date
FROM payment AS p
WHERE p.amount > (
	SELECT AVG(amount)
    FROM payment
    WHERE customer_id = p.customer_id
    )
LIMIT 5;

# 중고급 서브쿼리 시작!!

SELECT
	first_name,
    last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
    FROM payment
    WHERE amount > (SELECT AVG(amount) FROM payment)
);

SELECT
	first_name,
    last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
    FROM payment
    WHERE amount > 3
);

SELECT
	first_name,
    last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING COUNT(*) > (
		SELECT
			AVG(payment_count)
        FROM (
			SELECT COUNT(*) AS payment_count
            FROM payment
            GROUP BY customer_id
		) AS payment_count
    )
);

SELECT
	first_name,
    last_name
FROM customer
WHERE customer_id = (
	SELECT customer_id
	FROM (
		SELECT customer_id, COUNT(*) AS payment_count
        FROM payment
        GROUP BY customer_id
    ) AS payment_counts
    ORDER BY payment_count DESC
	LIMIT 1
);

#상관 서브쿼리
SELECT
	P.customer_id,
    P.amount,
    P.payment_date
FROM payment P
WHERE P.amount > (
	SELECT
		AVG(amount)
    FROM payment
    WHERE customer_id = P.customer_id
);

#film 테이블에서 평균 영화길이보다 긴 영화들의 제목을 찾아주세요!!(서브쿼리)

SELECT * FROM film;

SELECT
	title, length
FROM film AS f
WHERE f.length > (
	SELECT AVG(length)
    FROM film
);

#rental 테이블에서 고객별 평균 대여 횟수보다 많은 대여를 한 고객들의 이름(first, last 모두) 찾아주세요
SELECT * FROM rental;
SELECT * FROM customer;

SELECT first_name, last_name
FROM customer c
WHERE customer_id IN (
    SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) > (
        SELECT AVG(rental_count)
        FROM (
            SELECT customer_id, COUNT(*) AS rental_count
            FROM rental
            GROUP BY customer_id
        )
    )
);
#SQL에서 서브쿼리 구문이 등장하는 경우가 거의 대부분 WHERE 절에 나온다!! 단일값이냐 여러값이냐 '=' OR 'IN'
#선생님
SELECT
	first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) > (
		SELECT AVG(rental_count)
		FROM(
			SElECT COUNT(*) AS rental_count
			FROM rental
			GROUP BY customer_id
		) AS rental_counts
    )
);

#가장 많은 영화를 대여한 고객의 이름(FIRST, LAST 모두)
SELECT first_name, last_name 
FROM customer
WHERE customer_id IN (
	SELECT customer_id
    FROM rental
    HAVING COUNT(*)
	GROUP BY customer_id
    ORDER BY COUNT(*)
    );

SELECT first_name, last_name 
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) = (
        SELECT MAX(rental_count)
        FROM (
            SELECT customer_id, COUNT(*) AS rental_count
            FROM rental
            GROUP BY customer_id
        ) AS sub
    )
);

#선생님
SELECT
	first_name,
    last_name
FROM customer
WHERE customer_id = (
	SELECT customer_id
    FROM (
    	SELECT customer_id, COUNT(*) rental_count
		FROM rental
		GROUP BY customer_id
    ) AS rental_counts
	ORDER BY rental_count DESC
    LIMIT 1
);

# 각 고객에 대해 자신이 대여한 평균 영화 길이보다 긴 영화들의 제목을 출력
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    f.title,
    f.length
FROM customer AS c
JOIN rental AS r 
    ON c.customer_id = r.customer_id
JOIN inventory AS i 
    ON r.inventory_id = i.inventory_id
JOIN film AS f 
    ON i.film_id = f.film_id
WHERE f.length > (
    SELECT AVG(f2.length)
    FROM rental AS r2
    JOIN inventory AS i2 
        ON r2.inventory_id = i2.inventory_id
    JOIN film AS f2 
        ON i2.film_id = f2.film_id
    WHERE r2.customer_id = c.customer_id
)
ORDER BY c.customer_id, f.title;

#선생님
SELECT * FROM rental;
SELECT * FROM customer;
SELECT * FROM film;
SELECT * FROM inventory;

SELECT
	C.first_name, C.last_name, F.title
FROM customer C
JOIN rental R ON R.customer_id = C.customer_id
JOIN inventory I ON I.inventory_id = R.inventory_id
JOIN film F ON F.film_id = I.film_id
WHERE F.length > (
	SELECT AVG(FIL.length)
    FROM film FIL
    JOIN inventory INV ON INV.film_id = FIL.film_id
    JOIN rental REN ON REN.inventory_id = INV.inventory_id
    WHERE REN.customer_id = C.customer_id
);
ORDER BY C.first_name
