SELECT rating FROM film
GROUP BY rating;

SELECT rating FROM film;

SELECT rating, COUNT(*) FROM film
GROUP BY rating;

SELECT rating, COUNT(*) FROM film
WHERE rating = "PG" OR rating = "G"
GROUP BY rating;

# film 테이블에서 영화등급이 G등급인 영화 제목을 출력해주세요

SELECT * FROM film
LIMIT 20;

SELECT rating, title  FROM film
WHERE rating = "G" OR rating = "PG"
GROUP BY title, rating;

SELECT rental_duration, title  FROM film
WHERE rental_duration >= 4
GROUP BY rental_duration, title
ORDER BY rental_duration DESC;

SELECT AVG(rental_duration), title  FROM film
WHERE rental_duration >= 4
GROUP BY rental_duration, title
ORDER BY rental_duration DESC;

# 필름 테이블에서 영화개봉 년도가 2006년 또는 2007년이고, 영화등급이 PG 또는 G 등급인 영화의 제목만 출력해주세요

SELECT rating, title, release_year  FROM film
WHERE (rating = "G" OR rating = "PG") AND (release_year = 2006 OR release_year = 2007)
GROUP BY rating, title, release_year
ORDER BY rating DESC;

SELECT title FROM film
WHERE (rating = "G" OR rating = "PG") AND (release_year = 2006 OR release_year = 2007)
GROUP BY title;
-- ORDER BY rating DESC;

# film 테이블에서 rating 으로 그룹을 묶어서 각 등급별 영화 갯수와 등급, 각 그룹별 평균 rental_rate를 출력해주세요
SELECT rating, COUNT(*), AVG(rental_rate) FROM film
GROUP BY rating;
# GROUP BY -> 집계함수를 사용해서 들어오면, 해당 컬럼값이 실제 그룹핑과 관계가 없더라도 출력값으로 허용(*예외 조항)

/*
필름 테이블에서 레이팅으로 그룹을 묶어서 각 등급별 영화 갯수와 각 등급별 평균 렌탈비용을 출력하고, 평균 렌탈 비용이 높은 순으로 출력
*/
SELECT rating, COUNT(*), AVG(rental_rate) FROM film
GROUP BY rating
ORDER BY AVG(rental_rate) DESC;

SELECT 
	rating,
	COUNT(*) AS total_films,
    AVG(rental_rate) AS avg_rental_rate 
FROM film
GROUP BY rating
ORDER BY AVG(rental_rate) DESC;

/*
각 등급별 영화 길이가 130분 이상인 영화의 갯수와 등급을 출력해보세요!!
*/
SELECT * FROM film
LIMIT 20;

SELECT rating, COUNT(*) length  FROM film
WHERE length >= 130
GROUP BY rating
ORDER BY length DESC;