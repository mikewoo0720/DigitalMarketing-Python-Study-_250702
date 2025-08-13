USE sakila;

SHOW TABLES;

SELECT * FROM actor
LIMIT 5;

SELECT title, LENGTH(title) AS title_length FROM film LIMIT 10;

SELECT 
	title, 
	LOWER(title) AS lowercased_title,
    UPPER(title) AS uppercased_title,
	LOWER(UPPER(title)) AS special_title,
	LENGTH(title) AS title_length
FROM film LIMIT 10;

SELECT
	CONCAT(first_name, " ", last_name) AS fullname,
    first_name,
    last_name
FROM actor;

SELECT
	description,
    SUBSTRING(description, 1, 10) AS Short_Description10
FROM film LIMIT 10;

SELECT
	description,
    SUBSTRING(description, 3, 10) AS Short_Description10
FROM film LIMIT 10;

SELECT description, SUBSTRING(description, 5, 10) FROM film LIMIT 10;

#film 테이블에서 영화제목이 15자인 영화를 출력하세요!

SELECT 
	title, 
	LENGTH(title) AS title FROM film
WHERE LENGTH(title) = 15;

#actor 테이브에서 첫번째 이름이 소문자로 john인 배우들의 전체 이름을 대문자로 출력하세요.

SELECT 
    UPPER(CONCAT(first_name, " ", last_name))
FROM actor
WHERE LOWER(first_name) = "john";

# film 테이블에서 description의 3번째 글자부터 6글자가
# "Action" 인 영화의 제목을 찾아서 출력해주세요

SELECT 
    title, description
FROM film
WHERE SUBSTRING(description, 3, 6) = "Action";

SELECT NOW();
SELECT CURDATE();
SELECT CURTIME();

#일 단위 값을 추가
SELECT 
	rental_date,
    DATE_ADD(rental_date, INTERVAL 7 DAY)
FROM rental
LIMIT 5;

#월 단위 값을 추가
SELECT 
	rental_date,
    DATE_ADD(rental_date, INTERVAL 8 MONTH)
FROM rental
LIMIT 5;

#시간 단위 값을 추가
SELECT 
	rental_date,
    DATE_ADD(rental_date, INTERVAL 8 HOUR)
FROM rental
LIMIT 5;

#분 단위 값을 추가
SELECT 
	rental_date,
    DATE_ADD(rental_date, INTERVAL 8 MINUTE)
FROM rental
LIMIT 5;

#초 단위 값을 제거
SELECT 
	rental_date,
    DATE_SUB(rental_date, INTERVAL 8 SECOND)
FROM rental
LIMIT 5;

SELECT * FROM payment LIMIT 5;

SELECT
	payment_date,
    EXTRACT(YEAR FROM payment_date)
FROM payment;

#구체적으로 특정 년도에 해당되는 데이터값만 추출해서 찾아오고자 할 때, 유용한 문법
SELECT
	payment_date
FROM payment
WHERE EXTRACT(YEAR FROM payment_date) = 2005;

SELECT
	payment_date
FROM payment
WHERE EXTRACT(DAY FROM payment_date) = 27;

# 렌털되고 있는 각 월 마다의 빌려가는 횟수 등을 확인
SELECT
	EXTRACT(MONTH FROM payment_date) AS payment_month, COUNT(*)
FROM payment
GROUP BY payment_month;

SELECT
	YEAR(payment_date) AS payment_year,
    MONTH(payment_date) AS payment_month,
    DAY(payment_date) AS payment_day,
    COUNT(*)
FROM payment
GROUP BY payment_year, payment_month, payment_day;

SELECT
	DAYOFWEEK(payment_date) AS payment_dayofweek, COUNT(*)
FROM payment
GROUP BY payment_dayofweek;

SELECT
	#DATE_FORMAT(payment_date, '%W') AS payment_dayname,
	DATE_FORMAT(payment_date, '%a') AS payment_dayname,
    COUNT(*) AS total_count
FROM payment
GROUP BY payment_dayname;

SELECT
	CASE DAYOFWEEK(payment_date)
		WHEN 1 THEN '일요일'
        WHEN 2 THEN '월요일'
        WHEN 3 THEN '화요일'
        WHEN 4 THEN '수요일'
        WHEN 5 THEN '목요일'
        WHEN 6 THEN '금요일'
        WHEN 7 THEN '토요일'
	END AS payment_dayname,
    COUNT(*) AS total_count
FROM payment
GROUP BY payment_dayname
ORDER BY total_count DESC;

SELECT
	rental_date,
    return_date,
	TIMESTAMPDIFF(DAY, rental_date, return_date) AS rental_days
FROM rental
LIMIT 10;

SELECT
	rental_id,
    return_date,
	DATE_FORMAT(rental_date, '%y-%m-%d') AS formatted_rental_date
FROM rental
LIMIT 5;

SELECT
	rental_id,
    return_date,
	DATE_FORMAT(rental_date, '%y:%m:%d') AS formatted_rental_date
FROM rental
LIMIT 5;

#rental 테이블에서 대여시작 날짜가 2006년 1월 1일 이후인 모든 대여에 대해 예상반납 날짜를 대여 날짜로 부터 5일 뒤로 설정하여, 출력해주세요

SELECT
    rental_date,
	DATE_ADD(rental_date, INTERVAL 5 DAY) AS expect_date
FROM rental
#WHERE EXTRACT(YEAR FROM rental_date) >= 2006;
#WHERE YEAR(rental_date) >= 2006;
WHERE rental_date >= '2006-01-01';

SELECT
	-amount,
    ABS(-amount) AS absolute_amount,
    CEIL(amount) AS ceiling_amount,
	FLOOR(amount) AS flooring_amount,
    ROUND(amount, 1) AS rounding_amount
FROM payment
LIMIT 10;

SELECT SQRT(4);

# pament 테이블에서 결제금액(amount)이 5이하인 모든 결제에 대해 절대값을 계산하여 출력해주세요alter
SELECT
ABS(amount)
FROM payment
WHERE amount <= 5;

#film 테이블에서 영화 길이가 120분 이상인 모든 영화에 대해 영화 길이의 제곱근을 계산해주세요.
SELECT
	title,
	SQRT(length)
FROM film
WHERE length >= 120;

#payment 테이블에서 결제금액을 소수점 첫번째 자리에서 반올림하여 출력해주세요.
SELECT
	ROUND(amount, 1)
FROM payment;