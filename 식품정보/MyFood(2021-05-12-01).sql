-- myfood 접속

CREATE TABLE tbl_foods(
    fd_code	CHAR(7)		PRIMARY KEY,
    fd_name	nVARCHAR2(50)	NOT NULL,	
    fd_year	NUMBER(4),		
    fd_ccode	CHAR(6)	NOT NULL,
    fd_icode	CHAR(4)	NOT NULL,	
    fd_once	NUMBER(10,2),
    fd_capa	NUMBER(10,2),		
    fd_cal	NUMBER(10,2),		
    fd_protein	NUMBER(10,2),
    fd_fat	NUMBER(10,2),	
    fd_carbo	NUMBER(10,2),		
    fd_sugar	NUMBER(10,2)		
);

CREATE TABLE tbl_company(
    cp_code	CHAR(6)		PRIMARY KEY,
    cp_name	nVARCHAR2(125)	NOT NULL,	
    cp_ceo	nVARCHAR2(50),
    cp_tel	VARCHAR2(20),		
    cp_arrd	nVARCHAR2(125),
    cp_item	nVARCHAR2(30)		
);

CREATE TABLE tbl_items(
    it_code	CHAR(4)		PRIMARY KEY,
    it_name	nVARCHAR2(30)	NOT NULL	
);

CREATE TABLE tbl_myfoods(
    mf_seq	NUMBER		PRIMARY KEY,
    mf_date	nVARCHAR2(10)	NOT NULL,	
    mf_fcode	CHAR(7)	NOT NULL,
    mf_amt	NUMBER	NOT NULL	
);

CREATE SEQUENCE seq_myfoods
START WITH 1 INCREMENT BY 1;

-- 임포트된 데이터 개수 확인
SELECT COUNT(*) FROM tbl_foods;
SELECT COUNT(*) FROM tbl_company;
SELECT COUNT(*) FROM tbl_items;

-- 식품정보와 제조사 정보를 JOIN하여
-- 데이터가 정상으로 임포트 되었는지 확인
-- 여기에서 데이터가 출력된다면 제조사 정보 테이블에 문제가 있는 것이다
SELECT *
FROM tbl_foods F
    LEFT JOIN tbl_company C
        ON F.fd_ccode = C.cp_code
    WHERE C.cp_code IS NULL;

-- 식품정보와 ITEM 정보를 JOIN
SELECT *
FROM tbl_foods F
    LEFT JOIN tbl_items I
        ON F.fd_icode = i.it_code
    WHERE I.it_code IS NULL;
    
-- 3개의 table간에 참조무결성 설정
-- 누가 부모이고, 누가 자손인지 파악을 해야한다.
-- 자손 : tbl_foods 부모 : tbl_company, tbl_items
-- FK 설정은 자손 table에 설정을 한다

ALTER TABLE tbl_foods
ADD CONSTRAINT fk_company
FOREIGN KEY(fd_ccode)
REFERENCES tbl_company(cp_code);
   
ALTER TABLE tbl_foods
ADD CONSTRAINT fk_item
FOREIGN KEY(fd_icode)
REFERENCES tbl_items(it_code);
   
   
