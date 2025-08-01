USE mysql;

SELECT host, user FROM user;

# localhost => 127.0.0.1 => DNS

CREATE USER 'mike7'@'localhost'
IDENTIFIED BY 'mike1234';

CREATE USER 'mike8'@'%'
IDENTIFIED BY 'mike1234';

SET PASSWORD FOR 'mike7'@'localhost' = 'mike5678';

DROP USER 'mike7'@'localhost';
DROP USER 'mike8'@'%';

SHOW GRANTS FOR 'root'@'localhost';
SHOW GRANTS FOR 'mike7'@'localhost';

GRANT SELECT ON school.students TO 'mike7'@'localhost';
GRANT ALL ON school.* TO 'mike7'@'localhost';