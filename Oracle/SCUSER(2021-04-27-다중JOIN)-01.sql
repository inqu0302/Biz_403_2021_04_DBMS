--SCUSER접속


CREATE TABLE tbl_dept(
            dp_code	char(3)	PRIMARY KEY,
            dp_name	NVARCHAR2(20) NOT NULL,	
            dp_prof	NVARCHAR2(20) NOT NULL
);

INSERT INTO tbl_dept (dp_code, dp_name, dp_prof)
VALUES('001', '컴퓨터공학', '토발즈');
INSERT INTO tbl_dept (dp_code, dp_name, dp_prof)
VALUES('002', '전자공학', '이철기');
INSERT INTO tbl_dept (dp_code, dp_name, dp_prof)
VALUES('003', '법학', '킹스필드');
INSERT INTO tbl_dept (dp_code, dp_name, dp_prof)
VALUES('004', '관광학', '이한우');
INSERT INTO tbl_dept (dp_code, dp_name, dp_prof)
VALUES('005', '국어국문', '백석기');
INSERT INTO tbl_dept (dp_code, dp_name, dp_prof)
VALUES('006', '영어영문', '권오순');
INSERT INTO tbl_dept (dp_code, dp_name, dp_prof)
VALUES('007', '무역학', '심하군');
INSERT INTO tbl_dept (dp_code, dp_name, dp_prof)
VALUES('008', '미술학', '필리스');
INSERT INTO tbl_dept (dp_code, dp_name, dp_prof)
VALUES('009', '고전음악학', '파파로티');
INSERT INTO tbl_dept (dp_code, dp_name, dp_prof)
VALUES('010', '정보통신공학', '최양록');

-- 지금 수행한 INSERT 명령으로 추가된 데이터를 실제 STORAGE에 반영하라
COMMIT;

DELETE FROM tbl_dept;
COMMIT;

-- 여러개의 데이터를 동시에 INSERT하기
-- 다른 테이블로 부터 데이터를 복사할때 사용하는 방식
INSERT ALL
INTO tbl_dept (dp_code, dp_name, dp_prof) VALUES('001', '컴퓨터공학', '토발즈')
INTO tbl_dept (dp_code, dp_name, dp_prof) VALUES('002', '전자공학', '이철기')
INTO tbl_dept (dp_code, dp_name, dp_prof) VALUES('003', '법학', '킹스필드')
INTO tbl_dept (dp_code, dp_name, dp_prof) VALUES('004', '관광학', '이한우')
INTO tbl_dept (dp_code, dp_name, dp_prof) VALUES('005', '국어국문', '백석기')
INTO tbl_dept (dp_code, dp_name, dp_prof) VALUES('006', '영어영문', '권오순')
INTO tbl_dept (dp_code, dp_name, dp_prof) VALUES('007', '무역학', '심하군')
INTO tbl_dept (dp_code, dp_name, dp_prof) VALUES('008', '미술학', '필리스')
INTO tbl_dept (dp_code, dp_name, dp_prof) VALUES('009', '고전음악학', '파파로티')
INTO tbl_dept (dp_code, dp_name, dp_prof) VALUES('010', '정보통신공학', '최양록')
SELECT * FROM DUAL;
COMMIT;

SELECT * FROM tbl_dept;

DROP TABLE tbl_student;

CREATE TABLE tbl_student(
        st_num CHAR(5) PRIMARY KEY,
        st_name	NVARCHAR2(20) NOT NULL,
        st_dcode CHAR(3) NOT NULL,
        st_grade CHAR(1) NOT NULL,	
        st_tel	VARCHAR(20) NOT NULL,	
        st_addr	NVARCHAR2(125)		
);

SELECT * FROM tbl_student;
SELECT COUNT(*) FROM tbl_student;

-- 학생테이블과, 학과테이블을 학색의 st_dcode칼럼과, 학과의 dp_code칼럼을
-- 연관지어 JOIN을 수행
-- 학생테이블의 모든데이터를 나열하고 학과 테이블에서 일치하는 데이터를
-- 가져와서 연동하여 보여주어라
CREATE VIEW VIEW_학생정보 AS
(   SELECT st.st_num 학번, 
        st.st_name 학생이름,
        st.st_dcode 학과코드,
        dp.dp_name 학과명,
        dp.dp_prof 담당교수,
        st.st_grade 학년,
        st.st_tel 전화번호,
        st.st_addr 주소
    FROM tbl_student ST
        LEFT JOIN tbl_dept DP
            ON st.st_dcode = dp.dp_code
);

SELECT * FROM VIEW_학생정보
ORDER BY 학번;

-- 학생정보 테이블에서 학과별로 몇명의 학생이 재학중인지
-- 학과코드 = 학과명은 항상 같은 값이 되므로 학과코드, 학과명으로 
-- GROUP BY 를 하면 학과별로 묶음이 이루어진다.
-- 학과별로 묶음을 만들고 묶은 학과에 포함된 레코드가 몇개인가
-- 세어보면, 학과별 학생 인원수가 조회된다.
SELECT 학과코드, 학과명, COUNT(*) 인원수
FROM VIEW_학생정보
GROUP BY 학과코드, 학과명;

SELECT * FROM tbl_score;

CREATE VIEW VIEW_성적일람표 AS
 (   SELECT sc.sc_num 학번, st.st_name 이름, st.st_dcode 학과코드, dp.dp_name 학과명, st.st_tel 전화번호,
            SC.SC_KOR 국어, SC.SC_ENG 영어, SC.SC_MATH 수학,
            (sc.sc_kor + sc.sc_eng + sc.sc_math) 총점,
            ROUND((sc.sc_kor + SC.SC_ENG + SC.SC_MATH)/3,0) 평균
        FROM tbl_score SC
        LEFT JOIN tbl_student ST
            ON sc.sc_num = st.st_num
        LEFT JOIN tbl_dept DP
            ON st.st_dcode = dp.dp_code
);           


SELECT * FROM VIEW_성적일람표
ORDER BY 학번;

-- 생성된 view_성적일람표를 사용하여 
-- 1. 총점이 200점 이상인 학생은 몇명?
SELECT COUNT(*) FROM VIEW_성적일람표
WHERE 총점 >= 200;

-- 2. 평균이 75점 이상인 학생들의 평균점수는?
SELECT ROUND(AVG(평균),0)
FROM VIEW_성적일람표
WHERE 평균 >=75;

-- 3. 각 학과별로 총점과 평균 점수는?
-- 학과코드와 학과명을 그룹으로 설정하고 각 그룹의 총점과 평균을 계산
SELECT 학과코드, 학과명, SUM(총점), ROUND(AVG(평균),0), MAX(평균) 최고점, MIN(평균) 최저점
FROM VIEW_성적일람표
GROUP BY 학과코드, 학과명
ORDER BY 학과코드;



