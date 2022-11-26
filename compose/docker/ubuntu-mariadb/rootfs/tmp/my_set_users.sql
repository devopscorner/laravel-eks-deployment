-- root (Access to All)
USE mysql;

CREATE USER 'root'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;

-- root (Update Host)
-- UPDATE user set host='%' where user='root' and host='localhost';

-- admin (Access to All)
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION;

FLUSH PRIVILEGES;