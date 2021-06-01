-- testUser 접속

CREATE TABLE tbl_books(
    bk_isbn CHAR(13) PRIMARY KEY,
    bk_comp CHAR(5) NOT NULL,
    bk_title nVARCHAR2(50) NOT NULL,
    bk_author CHAR(5) NOT NULL,
    bk_date CHAR(10),
    bk_pages NUMBER,
    bk_price NUMBER
);

CREATE TABLE tbl_company(
  cp_code CHAR(5) PRIMARY KEY,
  cp_name nVARCHAR2(125) NOT NULL,
  cp_ceo nVARCHAR2(30) NOT NULL,
  cp_tel VARCHAR(20) NOT NULL,
  cp_addr nVARCHAR2(125)
);

CREATE TABLE tbl_author(
    au_code CHAR(5) PRIMARY KEY,
    au_name nVARCHAR2(125) NOT NULL,
    au_tel VARCHAR(20),
    au_addr nVARCHAR2(125)
);

-- import 된 데이터 확인
SELECT COUNT(*) FROM tbl_books;
SELECT COUNT(*) FROM tbl_company;
SELECT COUNT(*) FROM tbl_author;

-- tbl_books 테이블에서 각 출판사별로 몇권의 도서를 출판했는지 조회
SELECT COUNT (*) FROM tbl_books
GROUP BY bk_comp;

SELECT bk_comp, COUNT(*) FROM tbl_books
GROUP BY bk_comp;

SELECT bk_comp AS 코드, cp_name AS 출판사명, COUNT(*) AS 권수
FROM tbl_books B
    LEFT JOIN tbl_company C
        ON B.bk_comp = C.cp_code
GROUP BY bk_comp, cp_name
ORDER BY bk_comp;

-- tbl_books 테이블에서 
-- 1.도서가격이 2만원 이상인 도서들의 리스트
SELECT * FROM tbl_books
WHERE bk_price >= 20000;

-- 2.도서가격이 2만원 이상인 도서들의 전체 합계금액
SELECT sum(bk_price) FROM tbl_books
WHERE bk_price >= 20000;

-- tbl_books, tbl_company, tbl_author 3개의 table을 JOIN 하여 
-- ISBN, 도서명, 출판사명, 출판사대표, 저자, 저자연락처 로 출력되도록 작성
SELECT B.bk_isbn AS ISBN, 
        B.bk_title AS 도서명, 
        C.cp_name AS 출판사명,
        C.cp_ceo AS 출판사대표,
        A.au_name AS 저자,
        A.au_tel AS 저자연락처
FROM tbl_books B
    LEFT JOIN tbl_company C
        ON B.bk_comp = C.cp_code
        LEFT JOIN tbl_author A
            ON B.bk_author = A.au_code;

-- tbl_books, tbl_company, tbl_author 3개의 table을 JOIN 하여 
-- ISBN, 도서명, 출판사명, 출판사대표, 저자, 저자연락처 출판일로 출력되도록 작성
-- 출판일 2018년 데이터만
SELECT B.bk_isbn AS ISBN, 
        B.bk_title AS 도서명, 
        C.cp_name AS 출판사명,
        C.cp_ceo AS 출판사대표,
        A.au_name AS 저자,
        A.au_tel AS 저자연락처,
        B.bk_date AS 출판일
FROM tbl_books B
    LEFT JOIN tbl_company C
        ON B.bk_comp = C.cp_code
        LEFT JOIN tbl_author A
            ON B.bk_author = A.au_code
-- WHERE B.bk_date LIKE '2018%' ;
-- WHERE B.bk_date BETWEEN '2018-01-01' AND '2018-12-31';
WHERE SUBSTR(B.bk_date, 0, 4) = '2018' ;
/*
    SUBSTR(문자열 칼럼, 시작위치, 개수)
    MySQL : LEFT (문자열 칼럼, 개수)
*/

CREATE VIEW view_도서정보 AS (
    SELECT B.bk_isbn AS ISBN, 
            B.bk_title AS 도서명, 
            C.cp_name AS 출판사명,
            C.cp_ceo AS 출판사대표,
            A.au_name AS 저자,
            A.au_tel AS 저자연락처,
            B.bk_date AS 출판일
    FROM tbl_books B
        LEFT JOIN tbl_company C
            ON B.bk_comp = C.cp_code
            LEFT JOIN tbl_author A
                ON B.bk_author = A.au_code
);

SELECT * FROM view_도서정보;

/*
자주 사용할 것 같은 SELECT SQL 은 VIEW로 등록하면 언제든지 사용이 가능하다

하지만 자주사용하지 않을 경우 저장공간을 차지하기 대문에 한개의 SQL(SELECT)문을
한개의 table처럼 FROM을 이용하여 사용가능하다
*/
SELECT * FROM(
    SELECT B.bk_isbn AS ISBN, 
            B.bk_title AS 도서명, 
            C.cp_name AS 출판사명,
            C.cp_ceo AS 출판사대표,
            A.au_name AS 저자,
            A.au_tel AS 저자연락처,
            B.bk_date AS 출판일
    FROM tbl_books B
        LEFT JOIN tbl_company C
            ON B.bk_comp = C.cp_code
            LEFT JOIN tbl_author A
                ON B.bk_author = A.au_code
    WHERE SUBSTR(B.bk_date, 0, 4) = '2018'
);

-- tbl_books와 tbl_company, tbl_books와 tbl_author FK 설정
-- bk_comp 와 cp_code        bk_author 와 au_code
ALTER TABLE tbl_books ADD(  -- 누구한테
CONSTRAINT FK_comp          -- FK이름
FOREIGN KEY (bk_comp)       -- 누구의 칼럼
REFERENCES tbl_company (cp_code));-- 참조대상

ALTER TABLE tbl_books ADD(
CONSTRAINT FK_author
FOREIGN KEY (bk_author)
REFERENCES tbl_author (au_code));

/*
 PK
 개체 무결성을 보장하기 위한 조건
 어떠한 데이터를 수정, 삭제할 때 수정하거나 삭제해서는 안되는 데이터는 유지하면서
 반드시 선택한 데이터만 수정, 삭제가 된다.
 수정이상, 삭제이상을 방지하는 방법
 
 중복된 데이터는 절대 추가될 수 없다. : 삽입이상
 
 FK
 두개 이상의 table 을 연결하여 view(조회)를 할때 데이터가 NULL값으로 보이는것을 방지
 
 Child(tbl_books) : bk_comp     Parent(tbl_comp):cp_code
    있을수 있고, 추가가능               있다
    있을수 없음, 추가불가               없다
        있다                          삭제 불가
        있다                         반드시 있다
*/

-- 리처드 쇼튼의 연락처가 010-6676-6428에서 010-9898-6428로 변경되었다
-- 리처드 쇼튼의 연락처를 변경해보기
SELECT * FROM tbl_author
WHERE au_name LIKE '%쇼튼%';

SELECT * FROM tbl_author
WHERE au_code = 'A0006';

UPDATE tbl_author
SET au_tel = '010-9898-6428'
WHERE au_code = 'A0006';

-- 정보를 수정, 삭제하는 절차
-- 내가 수정, 삭제하고자 하는 데이터가 어떤 상태인지 조회
SELECT * FROM tbl_author
WHERE au_name LIKE '%쇼튼%';

-- 수정하고자 하는 리처드 쇼튼의 PK값 확인
UPDATE tbl_author
SET au_tel = '010-9898-6428'
WHERE au_code = 'A0006';

-- 수정, 삭제하고자 할때는 먼저 대상 데이터의 PK를 확인하고 PK를 WHERE절에
-- 포함시켜 UPDATE, DELETE 를 수행하자

-- 실무에서 UPDATE, DELETE를 2개이상 동시에 적용하는 것은 매우 위험
-- 꼭 필요한 경우가 아니면 UPDATE, DELETE는 PK를 기준으로 한개씩만 수행
