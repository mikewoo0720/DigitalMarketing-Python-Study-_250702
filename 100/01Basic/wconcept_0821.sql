use wconcept;
select * from performances;

#파이썬 크롤링 과정에서 테이블 값 설정 고민을 잘 못해서 데이터 값 일괄변경
UPDATE performances
SET rate = 0
WHERE rate = '평점 없음' AND id > 0;

UPDATE performances
SET review_num = 0
WHERE review_num = '리뷰수 없음' AND id > 0;

#평균 평점과 리뷰수 구하고 
#평균 평점 기준 Top Rated > 4.5 / Good > 3.5 / else Low Rated 
#평균 리뷰수 기준 Excellent > 100 / Average > 80 / else Poor 로 설정
SELECT
	AVG(rate),
    AVG(review_num)
FROM performances
GROUP BY category;


SELECT 
    category,
    AVG(rate) AS avg_rate,
    AVG(review_num) AS avg_review_num,
    CASE
        WHEN AVG(review_num) > 100 THEN 'Excellent'
        WHEN AVG(review_num) BETWEEN 80 AND 100 THEN 'Average'
        ELSE 'Poor'
    END AS ReviewGrade,
    CASE
        WHEN AVG(rate) >= 4.5 THEN 'Top Rated'
        WHEN AVG(rate) >= 3.5 THEN 'Good'
        ELSE 'Low Rated'
    END AS RateGrade
FROM performances
GROUP BY category;