DESC ranking, items;
DESC items;

SELECT COUNT(*) FROM items; #10201
SELECT * FROM ranking
LIMIT 1000;

SELECT * FROM items i
INNER JOIN ranking r ON r.item_code = i.item_code
WHERE r.main_category = "신발/잡화";

SELECT * FROM items i
JOIN ranking r
ON r.item_code = i.item_code
WHERE r.main_category = "신발/잡화";

#에러가 발생하는 주요 원인 => ON 뒤에 어떤 테이블에서 값을 찾아왔는가!!

SELECT * FROM items i
JOIN ranking r
ON r.item_code = i.item_code
WHERE r.main_category = "신발/잡화"; # 만약 조건절에서 설정한 데이터값이 특정 테이블에서만 사용하는 경우, 테이블 언급 생략

#관습적으로 특정 테이블을 생략해서 키워드를 입력 => 해당 테이블의 첫단어를 사용!!
SELECT * FROM items I
JOIN ranking R
ON R.item_code = I.item_code
WHERE main_category = "신발/잡화";

#전체 베스트상품 -> 메인 카테고리가 ALL에서 판매자별 베스트상품 개수

SELECT * FROM RANKING
LIMIT 3;

SELECT provider, COUNT(main_category) ALLCOUNT  FROM items I
JOIN ranking R
ON R.item_code = I.item_code
WHERE main_category = "ALL"
group by provider;

SELECT provider, COUNT(main_category) ALLCOUNT  FROM items I
JOIN ranking R
ON R.item_code = I.item_code
WHERE R.main_category = "ALL"
GROUP BY provider;

SELECT *  FROM items I
JOIN ranking R
ON R.item_code = I.item_code;

#메인 카테고리가 "패션의류"인 서브카테고리 포함, 패션의류 전체 베스트 상품에서 판매자별
#베스트상품 갯수가 5이상인 판매자와 해당 베스트 상품 갯수 출력

SELECT * FROM RANKING
LIMIT 3;

SELECT * FROM ITEMS
LIMIT 3;
 
SELECT provider, COUNT(main_category) allcount  FROM items I
JOIN ranking R
ON R.item_code = I.item_code
WHERE R.main_category = "패션의류" OR R.sub_category = "패션의류"
GROUP BY provider
HAVING allcount >= 5
ORDER BY allcount desc;

#선생님
SELECT DISTINCT main_category FROM ranking;

SELECT provider, COUNT(*) FROM items
JOIN ranking
ON ranking.item_code = items.item_code
WHERE ranking.main_category = "패션의류" OR ranking.sub_category = "패션의류"
GROUP BY provider
HAVING COUNT(*) >= 5
ORDER BY COUNT(*) DESC;

#메인카테고리가 신발/잡화 인 판매자별 상품갯수가 10개 이상인 판매자명 & 상품갯수 출력

SELECT provider, COUNT(main_category) allcount  FROM items i
JOIN ranking r
ON r.item_code = i.item_code
WHERE r.main_category = "신발/잡화"
GROUP BY provider
HAVING allcount >= 10
ORDER BY allcount DESC;

#메인카테고리가 화장품/헤어 인 해당 카테고리 내 평균, 최대, 최소 할인 가격을 출력해주세요

SELECT * FROM RANKING
LIMIT 3;

SELECT * FROM ITEMS
WHERE provider = 'AMOREPACIFIC'
LIMIT 3;

SELECT provider, AVG(dis_price) avg, MAX(dis_price), MIN(dis_price)  FROM items i
JOIN ranking r
ON r.item_code = i.item_code
WHERE r.main_category = "화장품/헤어"
GROUP BY provider
ORDER BY avg DESC;

#선생님
SELECT 
	AVG(dis_price),
	MAX(dis_price),
	MIN(dis_price)
FROM items
JOIN ranking
ON items.item_code = ranking.item_code
WHERE main_category = "화장품/헤어";

# 내가 66걸즈 마케터 혹은 MD 인데 지그재그 -> 리뷰 크롤링 -> #가성비#저렴#경제적
# 크롤링 -> 지그재그 -> 주요인기상품 및 카테고리 상품명 & 상품가격 & 할인가격 크롤링
# MySQL -> 평균 // 할인 // 최대할인