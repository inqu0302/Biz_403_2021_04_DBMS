-- 여기는 관리자 접속

CREATE TABLESPACE schoolDB
DATAFILE 'C:/oraclexe/data/school.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

-- schema : table, index, view 등등 데이터의 전체적인 모음집
-- 객체들의 정보를 담는곳
-- 데이터들의 모음
-- 표준 SQL : CREATE SCHEMA
-- 오라클에서는 USER로 사용

CREATE USER scUser IDENTIFIED BY scUser
DEFAULT TABLESPACE schoolDB;

-- GRANT : 권한을 지정하는 명령어
-- DBA 권한을 많이주면(남발하면) DB 보안적인 측면에서 무결성을 해칠수 있는
-- 여지가 많아진다.
-- DB와 관련된 보안용어
-- 보안침해 : 허가받지 않은 사용자가 접속하여 문제를 일으키는 것(해킹의 개념)
-- 무결성 침해(파괴) : 허가받은 사용자가 권한을 남용하여 문제를 일으키는 것
--          CUD(데이터 추가, 수정, 삭제)등을 잘못하여 데이터에 문제가 생기는 것
--          CUD(CREATE, UPDATE, DROP)
GRANT DBA TO scUser;

