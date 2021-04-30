-- userbookr 접속

SELECT COUNT(*) FROM tbl_books;
SELECT COUNT(*) FROM tbl_company;
SELECT COUNT(*) FROM tbl_author;

DROP VIEW view_도서정보;

-- 3개의 테이블 JOIN
CREATE VIEW view_도서정보 AS
(
SELECT b.bk_isbn AS ISBN,
        b.bk_title AS 도서명,
        c.cp_title AS 출판사명,
        c.cp_ceo AS 출판사대표,
        a.au_name AS 저자명,
        a.au_tel AS 저자연락처,
        b.bk_date AS 출판일,
        b.bk_price AS 가격,
        b.bk_page AS 페이지
FROM tbl_books B
    LEFT JOIN tbl_company C
        ON b.bk_ccode = c.cp_code
    LEFT JOIN tbl_author A
        ON b.bk_acode = a.au_code
);
        
-- 단독 table 로 생성된 view는 ISERT, UPDATE, DELETE를 실행할 수 있지만
-- TABLE JOIN 한 결과로 생성된 VIEW는 읽기전용임
--      INSERT, UPDATE, DELETE를 실행할수 없다.

SELECT * FROM "VIEW_도서정보";