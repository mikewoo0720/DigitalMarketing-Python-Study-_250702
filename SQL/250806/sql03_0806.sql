# 여러분들은 모두 나이키 브랜드의 데이터 마케팅 담당자
# 어떤 데이터가 존재 -> 최근 1년간 월별 제품별 평균 매출을 계산해야하는 미션!!!
# 데이터 베이스 => 테이블 => 필드 정의 => 최근 1년 월별 제품별 평균 매출 출력!!


CREATE DATABASE IF NOT EXISTS nike;
USE nike;

CREATE TABLE IF NOT EXISTS items(
	item_id INT PRIMARY KEY,
    item_name VARCHAR(50)
    );
    
#월별 매출 때문에 (월, 매출, )
CREATE TABLE IF NOT EXISTS item_sales(
	sales_id INT PRIMARY KEY,
    item_id INT,
    month INT,
    sales DECIMAL(4, 1),
    FOREIGN KEY(item_id) REFERENCES items(item_id)
    );

INSERT INTO items (item_id, item_name)
VALUES
(1, "shoes1"),
(2, "shoes2"),
(3, "shoes3"),
(4, "shoes4"),
(5, "shoes5")
;

INSERT INTO item_sales (sales_id, item_id, month, sales)
VALUES
(101, 1, 1, 10.5),
(102, 1, 2, 12.5),
(103, 1, 3, 3.5),
(104, 2, 1, 45.5),
(105, 2, 2, 65.5),
(106, 3, 1, 333.5),
(107, 3, 2, 23.5),
(108, 4, 1, 43.5),
(109, 4, 2, 12.5),
(110, 4, 3, 98.5),
(111, 4, 4, 203.5)
;

SELECT 
    i.item_id,
    i.item_name,
    AVG(s.sales) AS year_avg
FROM 
    items i
JOIN 
    item_sales s ON i.item_id = s.item_id
GROUP BY 
    i.item_id, i.item_name
ORDER BY 
    year_avg DESC;
    
####선생님 풀이

SELECT 
	product_id,
    DATE_FORMAT(sales, '%Y-%M') AS sales_month,
    AVG(amount) AS avg_monthly_sales
FROM sales
WHERE sales_date >= CURDATE() - INTERVAL 1 YEAR
GROUP BY product_id, sales_month
ORDER BY product_id, sales_month;