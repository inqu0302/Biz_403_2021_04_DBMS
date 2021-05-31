-- 하나마트

-- DATABASE 생성
CREATE DATABASE nhDB;

-- 사용할 DATABASE 에 연결하기
USE nhDB;

DROP TABLE tbl_iolist;

-- 테이블 생성
 CREATE TABLE tbl_iolist(
	io_seq	BIGINT	AUTO_INCREMENT	PRIMARY KEY,
	io_date	VARCHAR(10)	NOT NULL,
	io_time	VARCHAR(10)	NOT NULL,
	io_pname	VARCHAR(50)	NOT NULL,
	io_dname	VARCHAR(50)	NOT NULL,	
	io_dceo	VARCHAR(20)	NOT NULL,
	io_inout	VARCHAR(5)	NOT NULL,
	io_qty	INT	NOT NULL,
	io_price	INT	NOT NULL,
	io_total	INT
);

DESC tbl_iolist;

-- 매입과 매출의 합계
-- 수량 * 단가를 곱하여 계산
SELECT(io_qty * io_price) 합계
FROM tbl_iolist;

-- 통계함수와 GROUP BY 를 이용
SELECT (io_qty * io_price) 합계
FROM tbl_iolist
GROUP BY io_inout;

SELECT io_inout, sum(io_qty * io_price) 합계
FROM tbl_iolist
GROUP BY io_inout;

SELECT CASE WHEN io_inout = '1' THEN ' 매입'
			WHEN io_inout = '2' THEN '매출'
            END,
            SUM(io_qty * io_price) AS'합계'
FROM tbl_iolist
GROUP BY io_inout;

-- if( 조건, true, false) : MySQL 전용함수
SELECT IF(io_inout = '1','매입','매출') AS 구분,
SUM(io_qty * io_price) AS 합계
FROM tbl_iolist
GROUP BY io_inout;

-- 매입합계와 매출합계를 PIVOT 형식으로 조회
SELECT 
SUM(IF(io_inout = '1', io_qty* io_price,0)) AS 매입,
SUM(IF(io_inout = '2', io_qty* io_price,0)) AS 매출
FROM tbl_iolist;


SELECT io_date AS 일자,
SUM(IF(io_inout = '1', io_qty* io_price,0)) AS 매입,
SUM(IF(io_inout = '2', io_qty* io_price,0)) AS 매출
FROM tbl_iolist
group by io_date
ORDER BY io_DATE;

-- 각 거래처별로 매입 매출 합계
SELECT io_dname AS 거래처,
SUM(IF(io_inout = '1', io_qty * io_price, 0)) AS 매입,
SUM(IF(io_inout = '2', io_qty * io_price, 0)) AS 매출
FROM tbl_iolist
GROUP BY io_dname
ORDER BY io_dname;

SELECT io_dname AS 거래처,
SUM(CASE WHEN io_inout = '1'THEN io_qty * io_price ELSE 0 END) AS 매입,
SUM(CASE WHEN io_inout = '2'THEN io_qty * io_price ELSE 0 END) AS 매출
FROM tbl_iolist
GROUP BY io_dname
ORDER BY io_dname;

-- 2020년 4월의 매입매출 전체 리스트 조회
SELECT * FROM tbl_iolist
WHERE io_date between '2020-04-01' and '2020-04-30';

-- LEFT, MID, RIGHT
-- 문자열 칼럼의 데이터 일부만 추출할때
-- LEFT ( 칼럼, 개수 ) : 왼쪽부터 문자열 추출
-- MID ( 칼럼, 위치, 개수 ) : 중간 문자열 추출
-- RIGTH ( 칼럼, 개수 ) : 오른쪽 부터 문자열 추출
SELECT * FROM tbl_iolist
WHERE LEFT(io_date, 7) = '2020-04';

SELECT LEFT('대한민국', 2);
SELECT LEFT('Republic of Korea', 2);
-- MySQL 은 언어와 관계없이 글자수로 인식
SELECT LEFT('대한민국', 2), LEFT('Korea', 2);
SELECT MID('대한민국', 2, 2), MID('Korea', 2, 2);
SELECT RIGHT ('대한민국', 2), RIGHT ('Korea', 2);

-- 2020년 4월의 거래처별로 매입매출 합계
SELECT io_dname AS 거래처,
SUM(IF(io_inout = '1', io_qty * io_price, 0)) AS 매입,
SUM(IF(io_inout = '2', io_qty * io_price, 0)) AS 매출
FROM tbl_iolist
WHERE io_date between '2020-04-01' and '2020-04-30'
GROUP BY io_dname
ORDER BY io_dname;

SELECT io_dname AS 거래처,
	SUM(CASE WHEN io_inout = '1' THEN io_qty * io_price ELSE 0 END) AS 매입,
	SUM(CASE WHEN io_inout = '2' THEN io_qty * io_price ELSE 0 END) AS 매출
FROM tbl_iolist
WHERE io_date between '2020-04-01' and '2020-04-30'
GROUP BY io_dname
ORDER BY io_dname;

