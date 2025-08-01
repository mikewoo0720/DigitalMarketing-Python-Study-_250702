-- CREATE DATABASE IF NOT EXISTS school;
-- USE school;

-- CREATE TABLE students (
-- 	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
--     PRIMARY KEY(id)
-- );

CREATE TABLE students (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT UNSIGNED,
    grade VARCHAR(10)
);

DESC students;
SELECT * FROM students;

-- INSERT INTO students VALUES(1, "강백호", 15, "8학년");

INSERT INTO students (name, age, grade)
VALUES("서태웅", "15", "8학년");

INSERT INTO students (grade, name, age)
VALUES("10학년", "채치수", "17");

INSERT INTO students (grade, name, age)
VALUES("9학년", "정대만", "16");

INSERT INTO students (grade, name, age)
VALUES("8학년", "송태섭", "15");

SELECT name FROM students;
SELECT grade FROM students;
SELECT name, grade FROM students;
#where 절 속성값과 연산자를 통해서 원하는 레코드 값 찾아오기!!
SELECT * FROM students WHERE age = 16;#대입연산자
SELECT * FROM students WHERE age != 15;#부정연산자 -1
SELECT * FROM students WHERE age <> 15;#부정연산자 -2