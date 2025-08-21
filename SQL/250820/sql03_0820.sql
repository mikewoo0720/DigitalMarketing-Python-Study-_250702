#"프로그래머스"를 참고하여 만든 문제들

#1. category 테이블에서 Comedy, Sports, Family 카테고리의 category_id와 카테고리 명을 출력해주세요.

SELECT * FROM category;

SELECT category_id, name 
FROM category
WHERE name = "Comedy" OR name = "Sports" OR name = "Family"
GROUP BY category_id
ORDER BY category_id ASC;

#선생님
SELECT
	category_id,
    name
FROM category
WHERE
	name = "Comedy" OR
    name = "Sports" OR
    name = "Family";

SELECT
	category_id,
    name
FROM category
WHERE
	name IN("Comedy", "Sports", "Family");
    
# 2. film_category 테이블에서 카테고리 id별 영화 갯수 확인

SELECT category_id, COUNT(*)
FROM film_category
GROUP BY category_id;

# 3. 카테고리가 Comedy인 영화 갯수 확인 및 출력 (JOIN)
SELECT * FROM film_category;
SELECT COUNT(*)
FROM category c
JOIN film_category fc USING(category_id)
WHERE c.name = "Comedy";

# 4. 카테고리가 Comedy인 영화 갯수 확인 및 출력 (SUBQUERY)

SELECT COUNT(*)
FROM film_category fc
WHERE fc.category_id IN (
	SELECT c.category_id
    FROM category c
    WHERE c.name = "Comedy"
);

# 5. Comedy, Sports, Family 각각의 카테고리별 영화 수 확인하기

SELECT name, COUNT(*)
FROM category c
JOIN film_category fc USING(category_id)
WHERE name IN("Comedy", "Sports", "Family")
GROUP BY category_id;

#선생님
SELECT C.name, COUNT(*)
FROM category C
JOIN film_category FC USING(category_id)
WHERE C.name IN("Comedy", "Sports", "Family")
GROUP BY C.category_id;

# 6. 각 카테고리를 기준으로 영화 수가 70 이상인 카테고리명을 출력해주세요
SELECT name, COUNT(*) movie_count
FROM category c
JOIN film_category fc USING(category_id)
GROUP BY category_id
HAVING movie_count >= 70;

# 7. 각 카테고리에 포함된 영화들의 렌탈 횟수 구하기
SELECT * FROM film;#filmid
SELECT * FROM category; #categoryid
SELECT * FROM film_category;#film category
SELECT * FROM rental;#rental id inventory id customer id
SELECT * FROM inventory;#inventory film

SELECT c.name, COUNT(*) rental_count
FROM category c
JOIN film_category fc USING(category_id)
JOIN inventory i USING(film_id)
JOIN rental r USING(inventory_id)
GROUP BY category_id
ORDER BY rental_count DESC;

#선생님
SELECT
	C.name, COUNT(*)
FROM category C
JOIN film_category FC USING(category_id)
JOIN inventory I USING(film_id)
JOIN rental R USING(inventory_id)
GROUP BY C.category_id;

# 8. Comedy, Sports, Family 카테고리에 포함되는 영화들의 렌탈 횟수 구하기
SELECT c.name, COUNT(*) rental_count
FROM category c
JOIN film_category fc USING(category_id)
JOIN inventory i USING(film_id)
JOIN rental r USING(inventory_id)
WHERE c.name IN ("Comedy", "Sports", "Family")
GROUP BY category_id
ORDER BY rental_count DESC;

# 9. 카테고리가 Comedy인 데이터의 렌탈 횟수 출력 (*서브쿼리)
SELECT c.name,
       (SELECT COUNT(*)
        FROM film_category fc
        JOIN inventory i USING(film_id)
        JOIN rental r USING(inventory_id)
        WHERE fc.category_id = c.category_id) AS rental_count
FROM category c
WHERE c.name IN ("Comedy")
ORDER BY rental_count DESC;

# 선생님

SELECT
	COUNT(*)
FROM rental
WHERE inventory_id IN (
	SELECT inventory_id FROM inventory WHERE film_id IN(
		SELECT film_id FROM film_category WHERE category_id IN (
			SELECT category_id FROM category WHERE name = "Comedy"
        )  
    )
);

# 문제9. address 테이블에는 address_id가 있지만, customer 테이블에는 없는 데이터의 갯수 출력!!
# (*INNER JOIN // RIGHT JOIN)

SELECT * FROM address
INTERSECTION
SELECT * FROM customer;

SELECT COUNT(*)
FROM address a
RIGHT JOIN customer c USING(address_id);

#선생님
SELECT
	COUNT(A.address_id)
FROM address A
JOIN customer C USING(address_id);

#INNER JOIN
SELECT
	(SELECT COUNT(*) FROM address) -
    ((SELECT COUNT(A.address_id)
	FROM address A
	JOIN customer C USING(address_id))
    AS no_customer_address;

#OUTER JOIN
SELECT COUNT(*) AS no_customer_address
FROM customer C
RIGHT OUTER JOIN address A
ON A.address_id = C.address_id
WHERE customer_id IS NULL;

# 10. 캐나다 고객에게 이메일 마케팅을 진행하고자 합니다. 캐나다 고객의 이름과 이메일 주소 리스트를 출력해주세요.

SELECT * FROM customer;
SELECT * FROM address;
SELECT * FROM country;
SELECT * FROM city;

SELECT CONCAT(c.first_name, " ", c.last_name) name, c.email
FROM customer c
JOIN address a USING(address_id)
JOIN city ct USING(city_id)
JOIN country cr USING(country_id)
WHERE country_id = 20
GROUP BY customer_id;

# 11. 신혼부부 타겟고객들의 매출이 최근 저조해져서 가족영화를 홍보대상으로 삼고자 합니다. 가족 영화로 분류된 모든 영화 리스트를 출력해주세요

SELECT * FROM category;
SELECT * FROM film;
SELECT * FROM film_category;

SELECT film_id, f.title, c.name
FROM category c
JOIN film_category fc USING(category_id)
JOIN film f USING(film_id)
WHERE c.name = "Family";

# 12. 가장 자주 대여하는 영화 리스트를 참고로 보고 싶습니다. 가장 자주 대여하는 영화 순으로 100개만 뽑아주세요.
#영화제목, 렌탈횟수

SELECT * FROM film;#FILM
SELECT * FROM rental;#RENTAL
SELECT * FROM customer;
SELECT * FROM inventory;

SELECT title, COUNT(*) rental_num
FROM film
JOIN inventory USING(film_id)
JOIN rental USING(inventory_id)
GROUP BY film_id
ORDER BY rental_num DESC
LIMIT 100;

# 13. 각 스토어 별로 매출을 확인하고 싶습니다. 관련 데이터를 출력해주세요.
#관련 데이터는 다음과 같습니다.
#도시, 국가, 스토어ID, 스토어 아이디별 총 매출
SELECT * FROM inventory;
SELECT * FROM rental;
SELECT * FROM payment;
SELECT * FROM store;
SELECT * FROM customer;

SELECT store_id, SUM(p.amount)
FROM customer c
JOIN address a USING(address_id)
JOIN city ct USING(city_id)
JOIN country cr USING(country_id)
JOIN rental r USING(customer_id)
JOIN payment p USING(customer_id)
GROUP BY store_id;

#선생님

#payment -> amount // staff_id
#staff -> staff_id & store_id
#store -> store_id & address_id
#address -> address_id & city_id
#city -> city_id & country_id
#country -> country_id // country

SELECT 
	CONCAT(CI.city, ", ", CO.country) AS Store,
    STO.store_id AS Store_id,
    SUM(P.amount) AS Total_Sales
FROM payment P
JOIN staff STA ON STA.staff_id = P.staff_id
JOIN store STO ON STO.store_id = STA.store_id
JOIN address A ON STO.address_id = A.address_id
JOIN city CI ON CI.city_id = A.city_id
JOIN country CO ON CI.country_id = CO.country_id
GROUP BY STO.store_id;

# 14. 가장 렌탈 비용을 많이 지불한 상위 10명의 vip고객에게 선물을 배송하고자 합니다. 해당 vip 고객들의 이름과 주소, 이메일, 그리고 각 고객별 총 지불 비용을 출력해주세요
SELECT * FROM payment; #customer_id
SELECT * FROM customer; #customer_id, address_id
SELECT * FROM address; #address_id

SELECT
	CONCAT(c.first_name, " ", c.last_name) customer_name,
	CONCAT(a.address, ", ", ci.city, ", ", co.country) full_add,
    c.email,
	SUM(amount) total_payment
FROM payment p
JOIN customer c USING(customer_id)
JOIN address a USING(address_id)
JOIN city ci USING(city_id)
JOIN country co USING(country_id)
GROUP BY c.customer_id
ORDER BY total_payment DESC
LIMIT 10;

# 15. actor 테이블의 배우 이름을 first_name과 last_name 의 조합으로 출력해주세요 단 소문자로 출력, Actor_Name이라는 필드명으로 출력!! 

SELECT LOWER(CONCAT(first_name, " ", last_name)) Actor_Name
FROM actor;

SELECT 
	CONCAT(
		UPPER(LEFT(first_name, 1)), 
		LOWER(SUBSTRING(first_name, 2)),
        " ",
		UPPER(LEFT(last_name, 1)), 
		LOWER(SUBSTRING(last_name, 2))
		) AS Actor_Name
FROM actor;

# 16. 언어가 영어인 영화 중 영화 타이틀이 K와 Q로 시작하는 영화의 타이틀만 출력!! 단, 서브쿼리로
SELECT * FROM film;
SELECT * FROM language;

SELECT title
FROM film f
WHERE f.language_id = (
    SELECT l.language_id
    FROM language l
    WHERE l.name = 'English'
)
AND (f.title LIKE 'K%' OR f.title LIKE 'Q%');

# 17. Alone Trip에 나오는 배우 이름을 모두 출력하세요. 단, 배우 이름은 actor_name 이라는 필드 명으로 출력 / 서브쿼리

SELECT * FROM film;
SELECT * FROM actor;
SELECT * FROM film_actor;

SELECT CONCAT(a.first_name, " ", a.last_name) actor_name
FROM actor a
WHERE actor_id IN (
	SELECT actor_id
    FROM film_actor
    WHERE film_id IN (
		SELECT film_id
        FROM film
        WHERE title = "Alone Trip"
    )
);

# 18. 2005년 8월에 각 스탭 멤버가 올린 매출을 출력해주세요. 스탭 멤버 필드명은 Staff_Member로, 매출 필드명은 Total_Amount로

SELECT * FROM staff;
SELECT * FROM payment;

SELECT 
	CONCAT(s.first_name, " ", s.last_name) Staff_Member, 
    SUM(p.amount) Total_Amount
FROM staff s
JOIN payment p USING(staff_id)
WHERE payment_date LIKE '2005-08%'
GROUP BY staff_id;

SELECT 
	CONCAT(s.first_name, " ", s.last_name) Staff_Member, 
    SUM(p.amount) Total_Amount
FROM staff s
JOIN payment p USING(staff_id)
WHERE 
	YEAR(payment_date) = 2005 AND
    MONTH(payment_date) = 8
GROUP BY staff_id;

# 20. 각 카테고리의 평균 영화 러닝타임이 전체 평균 러닝타임보다 큰 카테고리들의 카테고리명과 해당 카테고리의 평균 러닝 타임을 출력하세요.

SELECT * FROM film;
SELECT * FROM category;
SELECT * FROM film_category;

SELECT 
    c.name AS category,
    AVG(f.length) AS avg_length
FROM film f
JOIN film_category fc USING(film_id)
JOIN category c USING(category_id)
GROUP BY c.name
HAVING AVG(f.length) < (
    SELECT AVG(length)
    FROM film
);

# 21. 각 카테고리별 평균 영화대여시간과 해당 카테고리명을 출력하세요. 단, 영화대여시간 => 영화 대여 및 반납 시간의 차이, hour를 단위로 사용하세요!

SELECT * FROM film;
SELECT * FROM film_category;
SELECT * FROM category;
SELECT * FROM inventory;
SELECT * FROM rental;

SELECT c.name, AVG(TIMESTAMPDIFF(HOUR, rental_date, return_date)) category_avghour
FROM category c
JOIN film_category fc USING(category_id)
JOIN film f USING(film_id)
JOIN inventory i USING(film_id)
JOIN rental r USING(inventory_id)
GROUP BY c.name;

# 22. 새로운 임원이 부임했습니다. 총 매출액 상위 5개 장르의 매출액을 수시로 확인하고자 합니다.
# 각 장르별 총 매출액(Total_Sales), 각 장르 이름(Genre)으로 해당 데이터를 수시로 확인 할 수 있는 VIEW를 생성해주세요.
# VIEW의 이름은 top5_genres로 만들어 주시고, 총 매출액 상위 5개 장르의 매출액이 출력될 수 있도록 해주세요.

SELECT * FROM category;
SELECT * FROM film_category;
SELECT * FROM film;
SELECT * FROM inventory;
SELECT * FROM rental;
SELECT * FROM payment;

CREATE VIEW top5_genres AS
SELECT 
	c.name AS Genre, 
    SUM(p.amount) AS Total_Sales
FROM category AS c
JOIN film_category AS fc USING(category_id)
JOIN film AS f USING(film_id)
JOIN inventory AS i USING(film_id)
JOIN rental AS r USING(inventory_id)
JOIN payment AS p USING(rental_id)
GROUP BY c.category_id
ORDER BY Total_Sales DESC
LIMIT 5;

SELECT * FROM top5_genres;
DROP VIEW top5_genres;

# 23. 2005년 5월에 가장 많이 대여된 영화 3개를 찾아주세요. 영화제목과 대여횟수를 출력하면 됩니다.

SELECT f.title, COUNT(rental_id) rental_count
FROM film f
JOIN film_category fc USING(film_id)
JOIN category c USING(category_id)
JOIN inventory i USING(film_id)
JOIN rental r USING(inventory_id)
WHERE rental_date LIKE "2005-05%"
GROUP BY film_id
ORDER BY rental_count DESC
LIMIT 3;

# 24. 대여된 적이 없는 영화를 찾으세요.

SELECT * FROM rental;
SELECT * FROM inventory;
SELECT * FROM film;

SELECT f.title, COUNT(*) film_rental
FROM rental r
JOIN inventory i USING(inventory_id)
JOIN film f USING(film_id)
GROUP BY film_id
ORDER BY film_rental;

#NOT IN 사용
SELECT f.title
FROM film f
WHERE f.film_id NOT IN(
	SELECT film_id
    FROM inventory i
    JOIN rental r USING(inventory_id)
);

# 25. 각 고객의 총 지출 금액의 평균 보다 총 지출 금액이 더 큰 고객 리스트를 찾으세요. 그들의 이름과 그들이 지출한 총 금액을 보여주세요
SELECT * FROM customer;
SELECT * FROM payment;
SELECT * FROM rental;

SELECT 
    c.customer_id,
	CONCAT(c.first_name, " ", c.last_name) customer_name, 
    SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p USING(customer_id)
GROUP BY c.customer_id
HAVING SUM(p.amount) > (
    SELECT AVG(total_amount)
    FROM (
        SELECT SUM(p2.amount) AS total_amount
        FROM customer c2
        JOIN payment p2 USING(customer_id)
        GROUP BY c2.customer_id
    ) AS customer_totals
)
ORDER BY total_spent DESC;

# 26. 가장 많은 결제건을 처리한 직원이 누구인지 찾아주세요.
SELECT CONCAT(s.first_name, " ", s.last_name) staff_name, COUNT(*) payment_count
FROM payment p
JOIN staff s USING(staff_id)
GROUP BY p.staff_id;

# 27. "액션" 카테고리에서 높은 영화 영상 등급을 받은 순으로, 상위 5개의 영화를 보여주세요.(*높은 영화 영상 등급 순으로의 정렬은 ODER BY rating DESC 을 기준으로)

SELECT f.title, f.rating
FROM film f
JOIN film_category fc USING(film_id)
JOIN category c USING(category_id)
WHERE c.name = "Action"
ORDER BY f.rating DESC;

# 28. 각 영화 영상등급을 기준으로 영화별 대여기간의 평균을 찾아주세요.

SELECT * FROM rental;

SELECT rating, AVG(rental_duration)
FROM film
GROUP BY rating;

# 29. 매장 ID별 총 매출을 보여주는 VIEW 를 생성하세요.

SELECT * FROM payment; #staff_id
SELECT * FROM staff; #store_id
SELECT * FROM store;

CREATE VIEW Total_Amount AS
SELECT SUM(amount) sum_amount
FROM payment
JOIN staff USING(staff_id)
JOIN store USING(store_id)
GROUP BY store_id;

SELECT * FROM Total_Amount;
drop view Total_Amount;

# 30. 가장 많은 고객이 있는 상위 5개 국가를 보여주세요.

SELECT * FROM customer;#address_id
SELECT * FROM address;#city_id
SELECT * FROM city;#country_id
SELECT * FROM country;

SELECT country, COUNT(customer_id) customer_count
FROM customer cu
JOIN address a USING(address_id)
JOIN city ci USING(city_id)
JOIN country co USING(country_id)
GROUP BY country_id
ORDER BY customer_count DESC
LIMIT 5;