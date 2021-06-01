-- 관리자 접속
/*
오라클에서는 관리자(sys, system, sysdba)계정이 존재하고 관리자 계정으로 접속을하면
오라클 시스템 자체를 컨트롤 할수있는 권한이 있다.
이를 sysdba 권한이라고 한다.

보안사고 : 허가받지 않은 사용자가 네트워크를 통해서 불법적으로 시스템에 침투하여
데이터, 시스템을 파괴하는 행위

관리자(sysdba)권한의 노출로 인하여 관리자 권한을 탈취

데이터 무결성 파괴 : 허가된 사용자에게 권한이 잘못 부여되거나, 과도하게 권한을 부여하여
명령을 잘못 사용하여 데이터의 문제를 일으키는 것

관리자 권한에서는 최소한으로 테이블스페이스 생성, 사용자 생성, 사용자에게 권한부여
정도로만 사용하도록 권장
*/

CREATE TABLESPACE testDB
DATAFILE 'C:/oraclexe/data/testDB.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

/*
 testUser 라는 사용자 계정(User Account)을 생성하고 비밀번호를 tsetUser 로 설정
 기본 Tablespace 를 testDB로 설정
*/
CREATE USER testUser IDENTIFIED BY testUser
DEFAULT TABLESPACE testDB;

/*
 최초로 사용자계정을 생성한 후에는 아직 아무런 권한이 없기때문에 DB에 접속하는것
 조차 할수 없다. 실습을 위하여 사용자 계정에 DBA권한을 부여
 
 DBA 권한 : 시스템관련 DB에 접근은 할 수 없으나 Table생성 등 대부분의 DBMS관련
            명령을 사용하여 DB를 핸들링 할수 있는 권한
*/

GRANT DBA TO testUser;
