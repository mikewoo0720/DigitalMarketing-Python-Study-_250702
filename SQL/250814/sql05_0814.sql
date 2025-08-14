-- 1) 배우 성 검색 (LIKE)
-- 목표: 성(last_name)이 ‘%SON’ 으로 끝나는 배우의 actor_id, first_name, last_name 출력, 성 오름차순.
#끝나는 말고 중간 또는 다른 값 적용도 다시한번 확인해보기

SELECT actor_id, first_name, last_name
FROM actor 
WHERE last_name LIKE "%SON"
ORDER BY last_name ASC;

-- 2) 특정 등급 영화 조회
-- 목표: 영화 rating='PG-13' 인 영화의 film_id, title, rating 10개만, title 오름차순.
#오름차순 ASC

SELECT film_id, title, rating
FROM film
WHERE rating = 'PG-13'
ORDER BY title ASC
LIMIT 10;

-- 3) 대여 가격 상위 정렬
-- 목표: rental_rate 내림차순 상위 15편의 film_id, title, rental_rate 조회.

SELECT film_id, title, rental_rate
FROM film
ORDER BY rental_rate DESC;

-- 4) 카테고리별 영화 수(기초 집계)
-- 목표: 카테고리 이름과(없으면 NULL) 영화 수를 구해 개수 내림차순 정렬.
#카테고리 이름, film 갯수 를 구할 수 있는 테이블 확인, 없으면 null left 조인

SELECT * FROM category;
SELECT * FROM film;
SELECT * FROM film_category;

SELECT c.name, COUNT(*) AS category_count
FROM category c
LEFT JOIN film_category fc USING(category_id)
LEFT JOIN film f USING(film_id)
GROUP BY c.name
ORDER BY category_count DESC;
