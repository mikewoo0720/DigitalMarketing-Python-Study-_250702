#문제9. sakila DB의 “영화 대여 내역”을 바탕으로 다음 항목을 모두 출력하는 SQL 쿼리문을 작성해주세요.
#고객별 대여 순위, 1v
#이전 대여와의 간격, 다음 대여와의 간격 2v
#고객별 첫 번째 및 마지막 대여 일자 3v
#고객별 대여 건의 백분위 순위 및 누적분포 4v
#고객별 대여 내역의 3개 그룹 분할, 분할된 그룹 내 대여날짜 기준 오름차순 정렬 5
#위 항목들을 customer_id, rental_date와 함께 “모두 포함하여 출력”하는 SQL 쿼리를 작성해주세요.
USE sakila;
SELECT * FROM rental;


WITH Customer_Rank AS (
SELECT customer_id, COUNT(*) AS total_rent
FROM rental
GROUP BY customer_id
)
SELECT 
	customer_id,
    rental_date,
    DENSE_RANK() OVER(ORDER BY total_rent DESC) AS tatal_rent_rank,
    	DATEDIFF(
		rental_date,
		LAG(rental_date) OVER (PARTITION BY customer_id ORDER BY rental_date)
    ) AS pre_rental_gap,
    DATEDIFF(
		LEAD(rental_date) OVER (PARTITION BY customer_id ORDER BY rental_date),
        rental_date
	) AS next_rental_gap,
	MIN(rental_date) OVER (PARTITION BY customer_id ORDER BY rental_date) AS first_rental_date,
    MAX(rental_date) OVER (PARTITION BY customer_id ORDER BY rental_date) AS last_rental_date,
    PERCENT_RANK() OVER(ORDER BY total_rent DESC) AS rental_percentile_rank,
    CUME_DIST() OVER(ORDER BY total_rent DESC) AS rental_cumulative_dist,
    NTILE(3) OVER(PARTITION BY customer_id ORDER BY rental_date) AS group_3
FROM Customer_Rank CR
JOIN rental R USING(customer_id);