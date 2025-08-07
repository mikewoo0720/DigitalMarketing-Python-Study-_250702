USE sakila;

SELECT * FROM address
LIMIT 1;

SELECT * FROM customer
LIMIT 1;

#address_id, address, address2, district, city_id, postal_code, phone, location, last_update
#customer_id, store_id, first_name, last_name, email, address_id, active, create_date, last_update

SELECT COUNT(*) FROM customer C
RIGHT OUTER JOIN address A
ON C.address_id = A.address_id
WHERE customer_id IS NULL;

#서브 카테고리가 "여성신발"인 상품 타이틀만 가져오기
USE bestproducts;

SELECT * FROM items i
JOIN ranking r
ON i.item_code = r.item_code
WHERE sub_category = "여성신발";

#서브쿼리 구문을 활용해서 서로 다른 두개의 테이블을 연결해서 값을 찾아온다면?!

SELECT item_code FROM items
LIMIT 3;

SELECT title FROM items
WHERE
	item_code = "102425348" OR
	item_code = "104914497" OR
	item_code = "106332300";

SELECT title FROM items
WHERE item_code IN
	("102425348",
    "104914497",
	"106332300");

SELECT title FROM items
WHERE item_code IN (
	SELECT item_code
    FROM ranking
    WHERE sub_category = "여성신발"
);

    
    
SELECT *
FROM items i
WHERE i.sub_category = "여성신발"
AND i.item_code IN (
    SELECT r.item_code
    FROM ranking r
);

USE sakila;

SELECT * FROM category;

SELECT category_id, COUNT(*)
FROM film_category f
WHERE f.category_id > (
	SELECT c.category_id
    FROM category c
    WHERE c.name = "Comedy"
)
GROUP BY f.category_id;

#bestproducts > 메인카테고리 별로 할인 가격이 10만원 이상인 상품이 몇 개 있는지 출력하기(*JOIN활용)alter

USE bestproducts;

SELECT * FROM ITEMS
LIMIT 5;

SELECT * FROM RANKING
LIMIT 5;

SELECT main_category, COUNT(main_category) COUNT
FROM items i
JOIN ranking r
ON i.item_code = r.item_code
WHERE i.ori_price >= 100000
GROUP BY main_category;

#Subquery
SELECT main_category, COUNT(*) FROM ranking
WHERE item_code IN (
	SELECT item_code FROM items
    WHERE dis_price >= 100000
)
GROUP BY main_category
ORDER BY COUNT(*) DESC;

#dis_price가 20만원 이상인 상품들의 서브 카테고리별 상품 갯수를 출력해주세요

SELECT sub_category, COUNT(*)
FROM ranking r
JOIN items i
ON i.item_code = r.item_code
WHERE i.dis_price >= 200000
GROUP BY sub_category
ORDER BY COUNT(*) DESC;

SELECT sub_category, COUNT(*)
FROM ranking
WHERE item_code IN (
	SELECT 	item_code FROM items
    WHERE dis_price >= 200000
)
GROUP BY sub_category
ORDER BY COUNT(*) DESC;

#dis_price가 10퍼센트 이상인 상품들의 메인 카테고리별 상품 갯수를 출력해주세요

SELECT main_category, COUNT(*)
FROM ranking r
JOIN items i
ON r.item_code = i.item_code
WHERE discount_percent >= 10
GROUP BY main_category
ORDER BY COUNT(*);

SELECT main_category, COUNT(*)
FROM ranking
WHERE item_code IN (
	SELECT item_code FROM items
    WHERE discount_percent >= 10
)
GROUP BY main_category
ORDER BY COUNT(*);

SELECT main_category, AVG(discount_percent), MAX(discount_percent), MIN(discount_percent)
FROM ranking r
JOIN items i
ON r.item_code = i.item_code
WHERE discount_percent >= 10
GROUP BY main_category
ORDER BY COUNT(*);