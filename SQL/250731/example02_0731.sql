-- CREATE DATABASE IF NOT EXISTS dave;
-- USE Dave;

-- CREATE TABLE model_info (
-- 	id INT NOT NULL AUTO_INCREMENT,
--     name VARCHAR(20) NOT NULL,
--     model_num VARCHAR(10) NOT NULL,
--     model_type VARCHAR(10) NOT NULL,
--     PRIMARY KEY(id)
-- );

DESC model_info;

-- ALTER TABLE mytable CHANGE COLUMN Modelnumber Model_number VARCHAR(10) NOT NULL;
-- ALTER TABLE mytable MODIFY COLUMN Name VARCHAR(20) NOT NULL;
-- ALTER TABLE mytable MODIFY COLUMN Model_type VARCHAR(10) NOT NULL;
-- ALTER TABLE mytable CHANGE COLUMN Series Model_type VARCHAR(10) not null;

#CREATE DATABASE IF NOT EXISTS dave;
#DROP TABLE IF EXISTS mytable;
#USE dave;
-- CREATE TABLE IF NOT EXISTS model_info (
-- 	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
--     name VARCHAR(20) NOT NULL,
--     model_num VARCHAR(10) NOT NULL,
--     model_type VARCHAR(10) NOT NULL,
--     PRIMARY KEY(id)
-- );