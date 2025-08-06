# Netflix Data 분석 마케터
# 특정 데이터 존재 = 사용자별 하루 시청시간
# A 사용자 10일 5시간 30분시청
# B 사용자 15일 3시간 시청
# ...

# STP => Segment => Target => Positioning => Persona

CREATE TABLE netflix (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
	gender ENUM('남', '여') NOT NULL,
    age VARCHAR(20) NOT NULL UNIQUE,
	w_date DATE,
    w_time VARCHAR(20)
);

INSERT INTO netflix (name, gender, age, w_date, w_time)
VALUES
('우종현', '남', '31', '2025-08-06', 1912.2000),
('김민우', '남', '25', '2025-08-01', 0031.0448),
('박민주', '남', '30', '2025-08-02', 2312.0134),
('이형원', '남', '32', '2025-08-03', 2246.0034)
;

SELECT name, gender, age, w_date, SUBSTRING_INDEX(w_time, ' . ', 1) AS start_date
FROM netflix
ORDER BY w_time DESC;

#사용자의 데이터를 받음 1, name, age, date, w_time
#심야시간 장르별 시청시간이 긴 사람들을 추출하여 어떤 장르 시청자가 가장 많고 가장 긴 시간을 봤는지 확인 그래서 심야시간에는 어떤 장르를 가장 많이보고 오래 시청하는지 알고 심야시간에는 해당 장르를 추천

CREATE DATABASE IF NOT EXISTS NetflixData_v1;
USE NetflixData_v1;

CREATE TABLE IF NOT EXISTS users (
	user_id INT PRIMARY KEY,
    user_name VARCHAR(50)
);

INSERT INTO users (user_id, user_name)
VALUES
(1, "Alice"),
(2, "David"),
(3, "Cathy")
;

CREATE TABLE watch_history (
	watch_id INT PRIMARY KEY,
    user_id INT,
    date_time DATE,
    hours_watched DECIMAL(4, 1),
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);

DESC watch_history;

INSERT INTO watch_history (watch_id, user_id, date_time, hours_watched)
VALUES
(101, 1, "2025-07-10", 5.5),
(102, 1, "2025-07-15", 3.0),
(103, 2, "2025-07-20", 7.0),
(104, 3, "2025-06-30", 2.5),
(105, 2, "2025-07-05", 4.0),
(106, 3, "2025-07-12", 6.5),
(107, 1, "2025-06-25", 1.0),
(108, 2, "2025-07-30", 2.0);

SELECT * FROM watch_history;

# 특정 사용자의 영상 시청시간 기준, 내림차순

SELECT u.user_id, u.user_name, SUM(w.hours_watched) AS total_hours
FROM users AS u
JOIN watch_history AS w ON u.user_id = w.user_id
WHERE w.date_time >= CURDATE() - INTERVAL 1 MONTH
GROUP BY u.user_id, u.user_name
ORDER BY total_hours DESC
LIMIT 2;#2명까지만 데이터를 보여줘

 
SELECT 
    u.user_id,
    u.user_name,
    SUM(w.hours_watched) AS total_hours
FROM 
    users u
JOIN 
    watch_history w ON u.user_id = w.user_id
GROUP BY 
    u.user_id, u.user_name
ORDER BY 
    total_hours DESC;