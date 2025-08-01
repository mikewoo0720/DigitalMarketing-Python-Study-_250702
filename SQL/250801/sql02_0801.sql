DESC students;
SELECT * FROM students;

#아래 구문은 students 라는 테이블 내 name속성의 모든 데이터 값을 변경!
UPDATE students SET name = 'David';

UPDATE students SET name = '윤대협'
WHERE id = 8;

#만약 id값을 새롭게 재정렬을 하고 싶다면?
ALTER TABLE students AUTO_INCREMENT;
UPDATE students SET age = '16세', grade = "9학년"
WHERE id = 8;

#데이터의 안전을 위해 조건으로는 프라이머리 키만 사용할 수 있음
UPDATE students SET age = '16세', grade = "9학년"
WHERE name = '서태웅';

#아래 구문은 students 라는 테이블 내 모든 데이터를 delete 하겠다는 뜻!
DELETE FROM students;

DELETE FROM students
WHERE name = '서태웅';

DELETE FROM students
WHERE id = '2';

INSERT INTO students (name, age, grade)
VALUES("강백호", "15세", "8학년");

INSERT INTO students
VALUES(2, "강백호", "15세", "8학년");




CREATE DATABASE membership;
USE membership;

CREATE TABLE member (
	no INT NOT NULL AUTO_INCREMENT,
    name CHAR(20) NOT NULL,
    email VARCHAR(30) NOT NULL,    
    birth varchar(10),
    date VARCHAR(20),
	point VARCHAR(30),
	sex VARCHAR(10),
    PRIMARY KEY(no)
);

ALTER TABLE member MODIFY COLUMN birth varchar(10);

INSERT INTO member (name, email, birth, date, point, sex)
VALUES
("김민우", "1234@google.com", "123456", "250801", "1", "male"),
("우종현", "1234@google.com", "930720", "250801", "23456", "female"),
("박민주", "1234@google.com", "960102", "250801", "4567", "male"),
("이형원", "1234@google.com", "987654", "250801", "10", "female")
;

