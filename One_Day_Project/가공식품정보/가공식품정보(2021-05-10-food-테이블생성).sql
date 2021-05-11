-- food 접속

CREATE TABLE tbl_foods(
        fd_code	CHAR(7)		PRIMARY KEY,
        fd_name	nVARCHAR2(50)	NOT NULL,	
        fd_year	VARCHAR2(4)	NOT NULL,
        fd_ccode	CHAR(6)	NOT NULL,	
        fd_scode	CHAR(4)	NOT NULL,	
        fd_ssize	NUMBER	NOT NULL,	
        fd_gram	NUMBER	NOT NULL,
        fd_kcal	NUMBER	NOT NULL,	
        fd_protein	NUMBER	NOT NULL,
        fd_fat	NUMBER	NOT NULL,
        fd_carbohydrate	NUMBER	NOT NULL,
        fd_sugar	NUMBER	NOT NULL	
);

CREATE TABLE tbl_company(
        cp_code	CHAR(6)		PRIMARY KEY,
        cp_name	nVARCHAR2(100)	NOT NULL	

);

CREATE TABLE tbl_items(
        it_code	CHAR(4)		PRIMARY KEY,
        it_name	nVARCHAR2(20)	NOT NULL	

);

CREATE TABLE tbl_myfoods(
        mf_code	CHAR(7)		PRIMARY KEY,
        mf_date	nVARCHAR2(10)	NOT NULL,	
        mf_eat	NUMBER	NOT NULL
);

-- 외래키 설정하기
ALTER TABLE tbl_foods
ADD CONSTRAINT fk_ccode
FOREIGN KEY(fd_ccode)
REFERENCES tbl_company(cp_code);

ALTER TABLE tbl_foods
ADD CONSTRAINT fk_scode
FOREIGN KEY(fd_scode)
REFERENCES tbl_items(it_code);

CREATE VIEW view_식품정보 AS
(
    SELECT F.fd_code AS 식품코드,
            F.fd_name AS 식품명,
            F.fd_year AS 출시연도,
            C.cp_name AS 제조사이름,
            I.it_name AS 식품분류,
            F.fd_ssize AS 제공량,
            F.fd_gram AS 총내용량,
            F.fd_kcal AS 총에너지,
            F.fd_protein AS 단백질,
            F.fd_fat AS 지방,
            F.fd_carbohydrate AS 탄수화물,
            F.fd_sugar AS 당류
    FROM tbl_foods F
        LEFT JOIN tbl_company C
            ON F.fd_ccode = c.cp_code
        LEFT JOIN tbl_items I
            ON F.fd_scode = I.it_code
);

CREATE VIEW view_섭취정보 AS
(
    SELECT M.mf_date AS 날짜,
            F.fd_name AS 식품명,
            M.mf_eat AS 섭취량,
            F.fd_kcal *  M.mf_eat AS 총에너지,
            F.fd_protein *  M.mf_eat AS 단백질,
            F.fd_fat *  M.mf_eat AS 지방,
            F.fd_carbohydrate *  M.mf_eat AS 탄수화물,
            F.fd_sugar *  M.mf_eat AS 당류
    FROM tbl_myfoods M
        LEFT JOIN tbl_foods F
            ON m.mf_code = f.fd_code
);

