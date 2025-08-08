USE bestproducts;

#메인카테고리와 서브카테고리별 평균 할인 가격과 평균할인률을 출력

SELECT * FROM items;
SELECT * FROM ranking;

SELECT r.main_category, r.sub_category, AVG(i.dis_price), AVG(i.discount_percent)
FROM ranking r
JOIN items i
ON r.item_code = i.item_code
GROUP BY r.main_category, r.sub_category;

#선생님
SELECT AVG(dis_price), AVG(discount_percent)
FROM items i
JOIN ranking r
ON i.item_code = r.item_code
GROUP BY r.main_category, r.sub_category
ORDER BY AVG(discount_percent) DESC;

#판매자별 베스트 상품 갯수와 평균할인가격, 평균할인률 내림차순 / 상품갯수 순으로 내림차순
SELECT * FROM items;
SELECT * FROM ranking;

SELECT provider, COUNT(i.item_code) count_item, AVG(dis_price), AVG(discount_percent)
FROM items i
JOIN ranking r
ON i.item_code = r.item_code
GROUP BY provider
ORDER BY count_item DESC;

#선생님

SELECT provider, COUNT(*) count, AVG(dis_price), AVG(discount_percent)
FROM items
GROUP BY provider
ORDER BY count DESC;

#메인카테고리별 베스트 상품 갯수가 20개 이상인 판매자의 판매자별 평균할인가격, 평균할인률, 베스트 상품갯수 출력

SELECT * FROM items;
SELECT * FROM ranking;

#선생님

SELECT r.main_category, i.provider, COUNT(*) count, AVG(dis_price), AVG(discount_percent)
FROM items i
JOIN ranking r ON i.item_code = r.item_code
WHERE provider IS NOT NULL AND provider != ''
GROUP BY i.provider, r.main_category
ORDER BY count DESC;

#아이템 테이블에서 dis_price가 5만원 이상인 상품들 중 main_category별 평균 dis_price와 discount_percent

SELECT r.main_category, AVG(dis_price), AVG(discount_percent)
FROM items i
JOIN ranking r ON i.item_code = r.item_code
WHERE i.dis_price >= 50000
GROUP BY r.main_category
ORDER BY r.main_category DESC;

#선생님
SELECT
	r.main_category, AVG(dis_price) avg_price, AVG(discount_percent) avg_percent
FROM items i
JOIN ranking r ON i.item_code = r.item_code
WHERE dis_price >= 50000
GROUP BY r.main_category
ORDER BY avg_percent;