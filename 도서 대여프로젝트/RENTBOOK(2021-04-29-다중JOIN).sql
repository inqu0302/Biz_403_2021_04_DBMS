-- RENTBOOK 접속

DELETE FROM tbl_books;
commit;

CREATE TABLE tbl_books(
    bk_isbn	CHAR(13)		PRIMARY KEY,
    bk_title	nVARCHAR2(125)	NOT NULL,
    bk_ccode	CHAR(5)	NOT NULL,
    bk_acode	CHAR(5)	NOT NULL,
    bk_date	CHAR(10),
    bk_pages	NUMBER	,	
    bk_price	NUMBER	
);

CREATE TABLE tbl_company(
    cp_code	CHAR(5)		PRIMARY KEY,
    cp_title	nVARCHAR2(125)	NOT NULL,
    cp_ceo	nVARCHAR2(20),
    cp_tel	VARCHAR(20),	
    cp_addr	nVARCHAR2(125),
    cp_genre	nVARCHAR2(30)
);

CREATE TABLE tbl_author(
    au_code	CHAR(5)		PRIMARY KEY,
    au_name	nVARCHAR2(50)	NOT NULL,
    au_tel	VARCHAR(20),
    au_addr	nVARCHAR2(125),
    au_genre	nVARCHAR2(30)
);

-- 3개의 table을 JOIN 하여 VIEW만들기
CREATE VIEW view_도서정보 AS
(
SELECT bk_isbn, bk_title AS 도서명,
C.cp_title AS 출판사명, C.cp_ceo AS 출판사대표,
A.au_name AS 저자명, A.au_tel 저자연락처,
B.bk_date AS 출판일, B.bk_price AS 가격
FROM tbl_books B
    LEFT JOIN tbl_company C
        ON b.bk_ccode = c.cp_code
    LEFT JOIN tbl_author A
        ON b.bk_acode = A.au_code
);
SELECT * FROM tbl_books;


/*
고정문자열 type칼럼 주의사항
CHAR() Type 의 문자열 칼럼은 실제 저장되는 데이터 type에 따라 주의를 해야한다.

만약 데이터가 숫자값으로만 되어 있는 경우
00001, 00002 와 같이 입력할 경우 0을 삭제 해버리는 경우가 있다.

엑셀에서 import하는 실제데이터가 날짜 타입일 경우 SQL의 날짜형 데이터로
변환한후 다시 문자열로 변환하여 저장

칼럼을 PK로 설정하지 않는 경우는 가급적 CHAR로 설정하지 말고 VARCHAR2로
설정하는 것이 좋다

고정문자열 칼럼으로 조회할때 아래와 같은 문제이 조회할때 데이터가 조회되지
않는 경우가 발생할수 있다.
WHERE 코드 = '00001'
*/

SELECT * FROM view_도서정보;

-- 조건부여해서 찾기
-- PK칼럼으로 데이터 조회
SELECT * FROM view_도서정보
WHERE ISBN = '9791188850501';

-- 도서명이 엘리트 문자열로 시작되는 모든(LIST) EPDLXJ
SELECT * FROM view_도서정보
WHERE 도서명 LIKE '엘리트%';

-- 출판사명에 " 넥 " 이라는 문자열이 포함된 모든 데이터
SELECT * FROM view_도서정보
WHERE 출판사명 LIKE '%넥%';

-- 출판일이 2018년도인 모든 데이터
SELECT * FROM view_도서정보
WHERE 출판일 >= '2018-01-01' AND 출판일 <= '2018-12-31';

SELECT * FROM view_도서정보
WHERE 출판일 BETWEEN '2018-01-01' AND '2018-12-31';

-- SUBSTR() 함수를 사용한 무낮열 자르기
-- SUBSTR(문자열데이터, 시작위치, 개수)
-- 다른 DB에서는 LEFT(문자열, 글자수) 함수를 사용
--              RIGHT(문자열, 글자수) 오른쪽에서 글자수 만큼
SELECT * FROM view_도서정보
WHERE SUBSTR(출판일,7,4) = '2018';

--출판일 칼럼의 데이터를 앞에서 4글자만 잘라서 보여주는 것
SELECT SUBSTR(출판일,0,4) FROM view_도서정보;

-- 1 OR 1 = 1;
DELETE FORM tbl_books WHERE bk_isbn = 1 OR 1 = 1 ;

