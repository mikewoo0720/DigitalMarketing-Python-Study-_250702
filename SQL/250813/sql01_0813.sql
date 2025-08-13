CREATE DATABASE ecommerce_v1;
USE ecommerce_v1;
DESC product;

select * from product;

CREATE DATABASE ecommerce_v2;
USE ecommerce_v2;

CREATE TABLE teddyproducts (
	ID INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    TITLE VARCHAR(200) NOT NULL,
    CATEGORY VARCHAR(20) NOT NULL
    
);
DESC teddyproducts;

SELECT * FROM teddyproducts;