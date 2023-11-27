-- database 생성
create database wordpress;

-- database 유저생성
create user 'wordpressuser'@'%' identified by '1234';

-- database 권한
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, CREATE TEMPORARY TABLES, CREATE VIEW, EVENT, TRIGGER, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, EXECUTE ON wordpress.* TO 'wordpressuser'@'%';

-- 적용
FLUSH PRIVILEGES;

-- mariadb 10.5부터 native, socket 인증방식 동시사용가능, native인증으로 고정 및 root 패스워드 변경
ALTER USER root@localhost IDENTIFIED VIA mysql_native_password USING PASSWORD("1234");

-- '@localhost' 익명연결 허용 삭제
DELETE FROM mysql.user WHERE User='';

-- testdb 삭제
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';

-- 적용
FLUSH PRIVILEGES;