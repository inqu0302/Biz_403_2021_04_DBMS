-- 현재 존재하는 DataBase를 보여달라
SHOW databases;

-- 지금부터 MYSQL DataBase를 사용하겠다.
-- 사용자와 연관없이 기본적으로 사용할 DataBase를 선언하여 지정하여 사용할 준비
USE MYSQL;

-- 현재 접속한 DataBase(mysql)에 있는 모든 table을 보여달라
SHOW tables;

-- myDB 라는 Database(데이터저장소) 생성
CREATE database myDB;

-- 생성된 저장소 확인
SHOW DATABASES;

-- MySQL 에서는 사용할 DB를 open하기
-- USE 명령을 사용하여 DB Open
USE MYDB;

-- 현재DB(MYDB)에 있는 모든 Table을 보여달라
SHOW TABLES;

-- MySQL에서는 일련번호와 관련된 칼럼에 AUTO_INCREMENT 옵션을 설정하면 INSERT 할때 값을 지정하지 않아도 자동으로 ID, SEQ 값을 생성하여 
-- 칼럼에 추가하여 준다.
CREATE TABLE tbl_test(
	id BIGINT PRIMARY KEY auto_increment,
    name VARCHAR(50) NOT NULL,
    tel VARCHAR(20),
    addr VARCHAR(125)
);

SHOW TABLES;
DESC tbl_test;

INSERT INTO tbl_test(name, tel, addr)
VALUES('홍길동', '010-111-1111', '서울시');
SELECT * FROM tbl_test;

-- MySQL은 Linux 철학을 유지 하고있기 때문에 명령이 정상으로 수행되면 아무런 메시지도 보이지 않는다.
CREATE TABLE tbl_books(
	bk_isbn	char(13)		PRIMARY KEY,
    bk_comp	VARCHAR(15)	NOT NULL,
	bk_title VARCHAR(125)	NOT NULL,
	bk_author VARCHAR(50)	NOT NULL,	
	bk_trans VARCHAR(20),
	bk_date	VARCHAR(10),
	bk_page	int	,
	bk_price int		

);
DROP TABLE tbl_books;

SHOW TABLES;
DESC tbl_books;
SELECT * FROM tbl_books;

SELECT COUNT(*)
FROM tbl_books;

-- 도서 가격이 20000원 이상인 데이터
SELECT * 
FROM tbl_books
WHERE bk_price >= 20000;

-- 도서 가격이 10000원 이상 20000원 이하인 데이터
SELECT * 
FROM tbl_books
WHERE bk_price BETWEEN 10000 AND 20000;

SELECT * 
FROM tbl_books
WHERE bk_price >= 10000 AND bk_price <= 20000;

-- 도서명에 '왕' 문자열이 있는 데이터 
SELECT *
FROM tbl_books
WHERE bk_title LIKE '%왕%';

-- Java 등 코딩에서 중간 문자열 검색하는 방법
-- oracle : '%' || '왕' || '%'
-- MySQL : CONCAT('%', '왕', '%')
SELECT *
FROM tbl_books
WHERE bk_title LIKE CONCAT('%', '왕', '%'); 

-- 날짜 칼럼의 앞에 4글자만 보여라
SELECT LEFT(bk_date,4)
FROM tbl_books;

-- 발행일이 2018년인 도서들
SELECT * 
FROM tbl_books
WHERE LEFT(bk_date,4) = '2018';

SELECT * 
FROM tbl_books
ORDER BY bk_date;

-- 도서명을 역순으로 정렬하여
SELECT * 
FROM tbl_books
ORDER BY bk_title DESC;

-- 처음 3개의 데이터만 보여라
SELECT * 
FROM tbl_books
LIMIT 3;

-- 4번째 데이터 부터 2개
-- 게시판 등 코딩에서 pagination 을 구현할때 사용하는 방법
SELECT *
FROM tbl_books
LIMIT 3, 2;

CREATE DATABASE BookRent;
USE BookRent;

CREATE TABLE tbl_books(
	bk_isbn		CHAR(13)		PRIMARY KEY,
	bk_title	VARCHAR(125)	NOT NULL,	
	bk_ccode	CHAR(5)	NOT NULL,
	bk_acode	CHAR(5)	NOT NULL,	
	bk_date		VARCHAR(10),
	bk_price	INT,
	bk_pages	INT		
);

CREATE TABLE tbl_company(
	cp_code	CHAR(5)		PRIMARY KEY,
	cp_title	VARCHAR(125)	NOT NULL,
	cp_ceo	VARCHAR(20)	,
	cp_tel	VARCHAR(20)	,	
	cp_addr	VARCHAR(125),		
	cp_genre	VARCHAR(30)		
);

CREATE TABLE tbl_author(
	au_code	CHAR(5)		PRIMARY KEY,
	au_name	VARCHAR(50)	NOT NULL,
	au_tel	VARCHAR(20)	,
	au_addr	VARCHAR(125),		
	au_genre	VARCHAR(30)		
);

CREATE TABLE tbl_buyer(
	bu_code	CHAR(5)		PRIMARY KEY,
	bu_name	VARCHAR(50)	NOT NULL,
	bu_birth	INT	NOT NULL,
	bu_tel	VARCHAR(20)	,
	bu_addr	VARCHAR(125)		
);

CREATE TABLE tbl_book_rent(
	br_seq	BIGINT	PRIMARY KEY AUTO_INCREMENT,
	br_sdate	VARCHAR(10)	NOT NULL,
	br_isbn		CHAR(13)	NOT NULL,
	br_bcode	CHAR(5)	NOT NULL,	
	br_edate	VARCHAR(10)	,
	br_price	INT		
);