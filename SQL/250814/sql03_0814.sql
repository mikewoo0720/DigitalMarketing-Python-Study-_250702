SELECT film_id FROM film
UNION 
SELECT film_id FROM inventory;

SELECT film_id FROM film
UNION ALL
SELECT film_id FROM inventory;

SELECT film_id FROM film
INTERSECT
SELECT film_id FROM inventory; 

# MySQL 8.0.31 이상에서만 사용가능한 문법 아래 구문들로 대체 가능

SELECT DISTINCT f.film_id
FROM film f
JOIN inventory i USING(film_id);

SELECT film_id
FROM film
WHERE film_id IN (
	SELECT film_id
    FROM inventory
);

# 차집합

SELECT film_id FROM film
EXCEPT
SELECT film_id FROM inventory;
# MySQL 8.0.31 이상에서만 사용가능한 문법 아래 구문들로 대체 가능
SELECT F.film_id
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
WHERE i.film_id IS NULL;

SELECT f.film_id
FROM film f
WHERE film_id NOT IN (
	SELECT i.film_id
    FROM inventory i
);

SELECT f.film_id
FROM film f
WHERE NOT EXISTS (
	SELECT film_id
    FROM inventory i
    WHERE f.film_id = i.film_id
);

# film 테이블과 film_category 테이블에서 각각 중복없이 film_id를 조회하는 SQL 문을 작성해주세요
SELECT film_id FROM film
UNION
SELECT film_id FROM film_category;