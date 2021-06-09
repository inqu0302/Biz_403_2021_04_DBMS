CREATE database mybook;

USE mybook;

CREATE TABLE tbl_books(
bk_isbn		CHAR(13) 	PRIMARY KEY,
bk_title	VARCHAR(125) NOT NULL,
bk_ccode	CHAR(5) 	NOT NULL,
bk_acode	CHAR(5) 	NOT NULL,
bk_date		VARCHAR(10),
bk_price	INT,
bk_pages	INT
);

CREATE TABLE tbl_company(
cp_code		CHAR(5) 	PRIMARY KEY,
cp_title	VARCHAR(125)NOT NULL,
cp_ceo		VARCHAR(20),
cp_tel		VARCHAR(20),
cp_addr		VARCHAR(125),
cp_genre	VARCHAR(10)
);

CREATE TABLE tbl_author(
au_code		CHAR(5) 	PRIMARY KEY,
au_name		VARCHAR(50) NOT NULL,
au_tel		VARCHAR(20),
au_addr		VARCHAR(125),
au_genre	VARCHAR(30)
);

CREATE TABLE tbl_buyer(
bu_code		CHAR(5) 	PRIMARY KEY,
bu_name		VARCHAR(50) NOT NULL,
bu_birth	INT 		NOT NULL,
bu_tel		VARCHAR(20),
bu_addr		VARCHAR(125)
);

CREATE TABLE tbl_book_rent(
br_seq		BIGINT		PRIMARY KEY,
br_sdate	VARCHAR(10)	NOT NULL,	
br_isbn		CHAR(13)	NOT NULL,
br_bcode	CHAR(5)		NOT NULL,
br_edate	VARCHAR(10),
br_price	INT		
);

SELECT * FROM tbl_company;
