DROP TABLE IF EXISTS user_list;

CREATE TABLE user_list (
user_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
username VARCHAR(255) NOT NULL,
password VARCHAR(255) NOT NULL,
fullname VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL);