CREATE DATABASE db_school;

use db_school;

DROP TABLE tbl_student;

CREATE TABLE tbl_student(
	st_num	CHAR(8)		PRIMARY KEY,
	st_name	VARCHAR(20)	NOT NULL,
	st_dept	VARCHAR(20)	NOT NULL,	
	st_grade	INT	NOT NULL,
	st_tel	VARCHAR(15)	NOT NULL,
	st_addr	VARCHAR(125)
);

INSERT INTO tbl_student(st_num, st_name, st_dept, st_grade, st_tel)
VALUES('2021001', '홍길동', '컴퓨터공학', '3', '010-1111-2222');

commit;

drop table tbl_score;

CREATE TABLE tbl_score(
	sc_seq	BIGINT	AUTO_INCREMENT PRIMARY KEY,
	sc_stnum	CHAR(8)	NOT NULL,
	sc_sbcode	CHAR(4)	NOT NULL,
	sc_score	INT	NOT NULL	
);

INSERT INTO tbl_score ( sc_stnum, sc_sbcode, sc_score )
VALUES('2021003', 'S001', 100);

INSERT INTO tbl_score ( sc_stnum, sc_sbcode, sc_score )
VALUES('2021003', 'S002', 95);

INSERT INTO tbl_score ( sc_stnum, sc_sbcode, sc_score )
VALUES('2021003', 'S003', 90);

SELECT * FROM tbl_score;

DROP TABLE tbl_subject;

CREATE TABLE tbl_subject(
	sb_code	CHAR(4)		PRIMARY KEY,
	sb_name	VARCHAR(20)	NOT NULL,
	sb_prof	VARCHAR(20)	
);

INSERT INTO tbl_subject(sb_code, sb_name)
VALUES('S001','국어');
INSERT INTO tbl_subject(sb_code, sb_name)
VALUES('S002','영어');
INSERT INTO tbl_subject(sb_code, sb_name)
VALUES('S003','수학');
INSERT INTO tbl_subject(sb_code, sb_name)
VALUES('S004','음악');
INSERT INTO tbl_subject(sb_code, sb_name)
VALUES('S005','과학');

delete from tbl_subject WHERE sb_code = "과목코드";
delete from tbl_subject WHERE sb_code = "";

SELECT * FROM  tbl_subject;

/*
tbl_subject, tbl_score 를 가지고 각 학생의 성적리스트 출력해보기
과목 리스트를 출력하고, 각 과목의 성적이 입력된 학생 리스트 확인하기
학번을 조건으로 하여 한 학생의 성적입력 여부를 확인하기

학생의 점수가 입ㄺ된 과목과 입력되지 않은 과목을 확인
*/
-- subquery
SELECT SB.sb_code, SB.sb_name, SB.sb_prof, 
		SC.sc_stnum, SC.sc_score
FROM tbl_subject SB
	LEFT JOIN (SELECT * FROM tbl_score WHERE sc_stnum = '20210001' ) SC
		ON Sc.sc_sbcode = SB.sb_code;

/*
과목리스트를 전체 보여주고, 학생의 성적 table을 JOIN하여 학생의 점수가 있으면
점수를 보여주고 없으면 NULL로 보여주는 JOIN SQL문

이 JOIN 명령문에 특정한 학번을 조건으로 부여하여 한 학생의 성적 여부를 조회하는 SQL문 만들기

순수한 JOIN을 사용하여 한 학생의 성적을 조회하는데 학생의 성적이 tbl_score table에 있으면
점수를 보여주고 없으면 NULL 로 표현하기 위하여 WHERE절에서 학번을 조건으로 부여하지 않고
JOIN문의 ON에서 학번을 조건으로 지정
*/
SELECT SB.sb_code, SB.sb_name, SB.sb_prof, 
		SC.sc_stnum, SC.sc_score
FROM tbl_subject SB
	LEFT JOIN tbl_score SC
		ON Sc.sc_sbcode = SB.sb_code
        AND SC.sc_stnum = '20210001' LIMIT 5;
