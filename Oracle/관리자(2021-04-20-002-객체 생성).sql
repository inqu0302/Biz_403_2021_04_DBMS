-- 여기는 관리자 접속
-- 실습을 위해 기존 객체 삭제
-- scuser 사용자 삭제
DROP USER scuser CASCADE;

-- TABLSPACE 삭제
DROP TABLESPACE schoolDB
INCLUDING CONTENTS AND DATAFILES
CASCADE CONSTRAINTS;


--------------------------------------------------------
-- TABLSPACE 생성
-- 이름 : schoolDB, DATAFILE : school.dbf, SIZE : 1M, Ex : 1k
CREATE TABLESPACE schoolDB
DATAFILE 'C:/oraclexe/data/school.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

-- 사용자 생성
-- id : scuser, pw : scuser
-- Default tablespace : schoolDB
CREATE USER scuser IDENTIFIED BY scuser
DEFAULT TABLESPACE schoolDB;

-- 사용자 권한 부여
-- 편의상 DBA 권한을 부여
GRANT DBA TO scuser;










