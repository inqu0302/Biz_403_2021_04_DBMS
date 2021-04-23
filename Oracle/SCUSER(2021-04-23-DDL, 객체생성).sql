-- scuser 접속
-- 학생의 점수를 저장할 Table 생성하기
-- 학번, 국어, 영어 수학 항목을 저장

CREATE TABLE tbl_score(
        st_num CHAR(5) , -- 학번
        st_kor NUMBER, -- 국어
        st_eng NUMBER, -- 영어
        st_math NUMBER); --수학
        
INSERT INTO tbl_score(st_num, st_kor, st_eng, st_math)
VALUES ('00100',80,78,90);
INSERT INTO tbl_score(st_num, st_kor, st_eng, st_math)
VALUES ('00180',48,98,90);
INSERT INTO tbl_score(st_num, st_kor, st_eng, st_math)
VALUES ('00050',68,18,73);
INSERT INTO tbl_score(st_num, st_kor, st_eng, st_math)
VALUES ('00015',64,97,68);
INSERT INTO tbl_score(st_num, st_kor, st_eng, st_math)
VALUES ('08975',80,90,100);


SELECT
    *
FROM tbl_score ;

DROP TABLE tbl_score;

-- 학번은 중복될수 없고 null값이 저장될수 없다.
-- 점수에는 null값이 저장될수 없다.
CREATE TABLE tbl_score(
        st_num CHAR(5) PRIMARY KEY, -- 학번
        st_kor NUMBER NOT NULL, -- 국어
        st_eng NUMBER NOT NULL, -- 영어
        st_math NUMBER NOT NULL); --수학
        
INSERT INTO tbl_score(st_num, st_kor, st_eng, st_math)
VALUES ('00100',80,78,90);
INSERT INTO tbl_score(st_num, st_kor, st_eng, st_math)
VALUES ('00180',48,98,90);
INSERT INTO tbl_score(st_num, st_kor, st_eng, st_math)
VALUES ('00050',68,18,73);
INSERT INTO tbl_score(st_num, st_kor, st_eng, st_math)
VALUES ('00015',64,97,68);
INSERT INTO tbl_score(st_num, st_kor, st_eng, st_math)
VALUES ('08975',80,90,100);
INSERT INTO tbl_score(st_num, st_kor, st_eng, st_math)
VALUES ('00197',97,87,10);

SELECT * 
FROM tbl_score;

DROP TABLE tbl_score;

-- 고정문자열 : CHAR(최대크기)
-- 가변문자열 : VARCHR2(최대크기)
-- 한글가변문자열 : nVARCHAR2(최대크기)
-- 숫자 : NUMBER(자릿수, 소수)
CREATE TABLE tbl_score(
    sc_num CHAR(5),
    sc_kor NUMBER,
    sc_eng NUMBER,
    sc_math NUMBER
);

-- CREATE 로 작성한 칼럼의 순서대로 모든 데이터를 포함하여 INSERT 수행하기
-- 항상 CREATE 로 작성한 캄럼의 순서를 기억해야 하고 모든 칼럼에 데이터를
-- 포함해야 한다. 순서가 바뀌면 전혀 엉뚱한 데이터가 INSERT 될 수 있다.
INSERT INTO tbl_score
VALUES('00001', '98', '87', '84');

-- INSERT를 수행할때 데이터칼럼을 나열하면 순서를 몰라도 상관없고,
-- 필요한 칼럼만 데이터를 포함하여 수행할 수 있다.
INSERT INTO tbl_score(sc_kor, sc_eng, sc_math, sc_num)
VALUES(09,87,98,'00050');

SELECT * FROM tbl_score;

DROP TABLE tbl_score;
-- 위에서 생성한 tbl_score는 중복된 학번의 점수가 INSERT될수 있다.
-- 한 학생의 점수가 이중 삼중으로 INSERT되어 엉뚱한 결과가 
-- 나타날 수 있다.
-- 제약조건 부여
-- 1. 학번은 중복 될 수 없고 절대 NULL 이어서는 안된다.
--      NOT NULL UNIQUE : PK로 선언하는 것도 좋은 방법
-- 2. 점수가 없는 학생의 데이터는 이후에 연산을 수행할때 문제를 일으킬 수 
-- 있기 때문에 NULL값이 없도록 하자
CREATE TABLE tbl_socre(
    sc_num CHAR(5) PRIMARY KEY,
    sc_kor NUMBER NOT NULL,
    sc_eng NUMBER NOT NULL,
    sc_maht NUMBER NOT NULL
);

CREATE TABLE tbl_score(
    sc_num CHAR(5),
    sc_kor NUMBER NOT NULL,
    sc_eng NUMBER NOT NULL,
    sc_maht NUMBER NOT NULL,
    PRIMARY KEY (sc_num)
);

CREATE TABLE tbl_score(
    sc_num	CHAR(5)	PRIMARY KEY,
    sc_kor	NUMBER	NOT NULL,
    sc_eng	NUMBER	NOT NULL,
    sc_math	NUMBER	NOT NULL
);

SELECT * FROM tbl_score;

-- 국어점수가 90점 이상인 리스트
SELECT * FROM tbl_score
WHERE sc_kor >= 90;

-- 데이터를 보여줄때 머릿글(칼럼제목)을 바꾸어서 보이기
-- AS(Alias, 별명)
SELECT sc_num AS 학번, sc_kor AS 국어, sc_eng AS 영어,
    sc_math AS 수학, sc_kor + sc_eng + sc_math AS 총점
FROM tbl_score;

-- 총점이 250점 이상인 학생만
SELECT sc_num AS 학번, sc_kor AS 국어, sc_eng AS 영어,
    sc_math AS 수학, sc_kor + sc_eng + sc_math AS 총점
FROM tbl_score
WHERE (sc_kor + sc_eng + sc_math) >= 250;

-- 총점이 150 이상이고 250 이하인 학생만 보여주기
SELECT sc_num AS 학번, sc_kor AS 국어, sc_eng AS 영어,
    sc_math AS 수학, sc_kor + sc_eng + sc_math AS 총점
FROM tbl_score
WHERE (sc_kor + sc_eng + sc_math) <= 250 AND
    (sc_kor + sc_eng + sc_math) >= 150;

-- SELECT를 사용하여 데이터를 조회시 문법이 복잡해지고 길어지게 되었다.
-- 이때 SELECT된 명령문을 VIEW 객체로 생성을 해둔다
-- VIEW는 사용법이 TABLE과 같다.
-- 단, 기본은 SELECT만 된다.
CREATE VIEW view_score
AS
(    
    SELECT sc_num AS 학번, sc_kor AS 국어, sc_eng AS 영어,
        sc_math AS 수학, sc_kor + sc_eng + sc_math AS 총점
    FROM tbl_score
);

SELECT * 
FROM view_score
WHERE 총점 >= 150 AND 총점 <= 250 ;

-- 영어 선생님에게 전체 학생의 정보를 보여줘야 한다.
-- 다른과목의 점수는 감추고 싶을때
-- 보안적인 측변에서 사용자 별로 보여줄 항목, 보이지 않을 항목을
-- 선별하여 VIEW작성해 두면 불필요한 정보가 노출되는 것을 최고화 할 수 있다.
CREATE VIEW view_영어점수
AS(
    SELECT sc_num AS 학번, SC_ENG AS 영어
    FROM tbl_score
);

drop view view_1반학생;

CREATE VIEW view_1반학생
AS(
    SELECT sc_num AS 학번, sc_kor AS 국어, SC_ENG AS 영어
    FROM tbl_score
    WHERE sc_num >= 'S0010' AND sc_num <= 'S0020'
);

SELECT
    *
FROM view_1반학생;





