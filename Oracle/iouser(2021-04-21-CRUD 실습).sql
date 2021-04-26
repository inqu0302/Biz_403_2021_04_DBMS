-- iouser 접속
-- IOUSER는 DBA 권한을 갖고 있기 때문에 일반적인 표준 DDL, DML, DCL 명령들을 사용할 수  있다.
-- DDL(Data Definition Lang. 데이터 정의어)
-- 객체 생성    CREATE (TABLE, INDEX, VIEW) 생성
-- 객체 삭제    DROP (TABLE, INDEX, VIEW)
-- 객체 변경(수정)ALTER (TABLE, INDEX)
-- ORACLE 전용 DDL
--  객체 생성 CREATE SEQUENCE

-- 거래내역 저장할 Table
CREATE TABLE tbl_iolist(
    io_date VARCHAR2(10), -- 2021-04-21
    io_buyer NVARCHAR2(20), -- varchar == 가변형 문자열
    io_pname NVARCHAR2(20), 
    io_qty NUMBER,
    io_price NUMBER,
    io_total NUMBER
);

-- 생성된 TABLE에 데이터 추가
INSERT INTO tbl_iolist(io_date, io_buyer, io_qty, io_price)
VALUES ('2021-01-01', '홍길동', 10, 1000);

-- 데이터 전체 조회
SELECT io_date, io_buyer, io_pname, io_qty, io_price, io_total
FROM tbl_iolist;

-- 위에서 생성한 tbl_iolist는 데이터를 추가하는데 아무런 '제약조건'을 설정하지 않았다.
-- 그랬더니 INSERT를 수행했을때 실수로 상품명을 입력하지 않았는데도 데이터가 INSERT 되어버렸다.
-- 나중에 확인을 해 보니 상품이 없어서 데이터 활용 가치가 매우 떨어지는 현상이 발생했다.
-- 이런 상황은 INSERT(추가, 삽입) 이상 현상이 발생했다.
-- 무결성이 훼손되었다 라고 표현한다.

-- 기존의 Table 을 제거하고 무결성을 유지하기 위한 제약조건을 설정하여 Table을 다시 만들자
DROP TABLE tbl_iolist;


-- '제약조건'을 설정하기
CREATE TABLE tbl_iolist(
    io_date VARCHAR2(10), -- 2021-04-21
    io_buyer NVARCHAR2(20), -- varchar == 가변형 문자열
    io_pname NVARCHAR2(20) NOT NULL, 
    io_qty NUMBER,
    io_price NUMBER,
    io_total NUMBER
);

-- 다시 데이터 INSERT 테스트(상품이름 데이터를 입력하지 않은 상태)
INSERT INTO tbl_iolist(io_date, io_buyer, io_qty, io_price)
VALUES ('2021-01-01', '홍길동', 10, 1000);
-- 명령 수행에서 오류 발생
-- io_pname 칼럼에 null을 insert 할 수 없다.
-- io_pname 에 데이터가 setter 되지 않았다.

INSERT INTO tbl_iolist( io_pname ) VALUES('새우깡');

-- 조건없이 모든 데이터를 조회(출력)
SELECT * FROM tbl_iolist;

-- 원하는 칼럼을 배열하고 조건없이 모든데이터를 조회
-- Projection 지정
SELECT io_pname, io_iobuyer FROM tbl_iolist;

-- 데이터를 INSERT하는데 필수적으로 setting 되어야 할 칼럼에 필수 제약조건을 설정
DROP TABLE tbl_iolist;
CREATE TABLE tbl_iolist(
    io_date VARCHAR2(10) NOT NULL, -- 2021-04-21
    io_buyer NVARCHAR2(20) NOT NULL, -- varchar == 가변형 문자열
    io_pname NVARCHAR2(20) NOT NULL, 
    io_qty NUMBER NOT NULL,
    io_price NUMBER NOT NULL,
    io_total NUMBER
);

INSERT INTO tbl_iolist(io_date, io_buyer, io_pname, io_qty, io_price)
VALUES('2021-04-21', '홍길동', '새우깡', 30, 1000);
-- SELECT 명령문의 AS(Alias) 원래 table의 칼럼명을 변경하여 표현하고 싶을때
-- AS 생략가능
-- 1. tbl.iolist로 부터 데이터를 가져오고
-- 2. project으로 설정된 칼럼들 데이터만 추출하여
-- 3. 리스트를 출력한다.
SELECT io_date AS 거래일자,
        io_buyer AS 고객명, 
        io_pname AS 상품명, 
        io_qty AS 수량, 
        io_price AS 단가, 
        io_qty * io_price AS 합계
FROM tbl_iolist; --  == iolistDB.iouser.tbl_iolist

INSERT INTO tbl_iolist(io_date, io_buyer, io_pname, io_qty, io_price)
VALUES('2021-04-21', '성춘향', '신라면', 10, 1500);

INSERT INTO tbl_iolist(io_date, io_buyer, io_pname, io_qty, io_price)
VALUES('2021-04-21', '이몽룡', '어묵탕', 20, 2500);

INSERT INTO tbl_iolist(io_date, io_buyer, io_pname, io_qty, io_price)
VALUES('2021-04-21', '임꺽정', '빗자루', 50, 4000);

SELECT * FROM tbl_iolist;

-- 1. tbl_iolist로 부터 데이터를 가져오기
-- 2. 가져온 데이터 중에서 io_buyer 칼럼에 저장된 값이 '홍길동'인 데이터만 간추려서
-- 3. 보여달라
SELECT * 
FROM tbl_iolist
WHERE io_buyer = '홍길동';

SELECT io_buyer, io_pname
FROM tbl_iolist
WHERE io_buyer = '홍길동';

-- tbl.iolist에 저장되어 있는 데이터 리스트중에서 == iolso.buyer 칼럼의 값이
-- '홍길동' 인 데이터만 간추려서 보여주고 나머지 칼럼은 숨김으로 보여달라는 말
-- 보여지는 칼럼에 별명을 붙여보자
SELECT io_buyer AS 고객이름, io_pname AS 구매상품
FROM  tbl_iolist
WHERE io_buyer = '홍길동';