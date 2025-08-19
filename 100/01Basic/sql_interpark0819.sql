USE interpark1;
SHOW TABLES;
SELECT * FROM performances;

SELECT
	AVG(price),
    MAX(price),
    MIN(price)
FROM performances
GROUP BY genre;