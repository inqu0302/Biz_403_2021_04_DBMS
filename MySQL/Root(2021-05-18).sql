-- DataBase Schema
-- 물리적 저장공간
-- Oracle : TableSpace + User 생성하여 연동을 하면 User를 통해서 모든 물리적 DB에 접근이 된다
-- MySQL : DataBase가 schema가 되고 모든 데이터의 저장공간이 된다
--			User는 단지 DB SW에 접속하는 사용자 개념, 구체적으로 DB Schema 와 연결이 되지 않는다

CREATE DATABASE GuestBook;

-- gbUser 사용자를 등록하고 접근권한을 localhost로 제한하겠다
CREATE USER gbUser@localhost;

-- MySQL DATABase는 MySQL에서 매우 중요한 정보가 저장되는 곳
-- DB정보를 확인하기 위하여 DB사전에 접근
USE MYSQL; 
SHOW TABLES;
DESC USER;

-- 사용자 정보가 등록된 Table select
SELECT Host,User From USER;

-- 등록된 사용자의 권한 확인
SHOW GRANTS FOR gbUser@localhost;

-- gbUser에게 모든 권한을 부여하겠다.
-- localhost 에서만 접근가능
GRANT all privileges on *.* TO gbUser@localhost;

-- 192.168.0.*** 
-- 현재 공유기에 공통으로 연결된 pc에서 MySQL Server 에 접근하라
CREATE USER gbUser@'192.168.0.%';

-- 현재 공유기에서 공통으로 연결된 PC에서 접근할때 모든 권한을 부여하겠다.
GRANT ALL privileges ON *.* TO 'gbUser'@'192.168.0.%';

GRANT ALL privileges on *.* TO gbUser@'127.0.0.1%';

-- 5.7버전에서 user 비밀번호 변경하기
UPDATE USER SET password=password('1234')
WHERE user='gbUser';

-- MySQL 8.X 에서 비번변경하기
ALTER USER 'gbUser'@'localhost'
IDENTIFIED WITH mysql_native_password
BY '12345';

flush privileges;