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

select * from tbl_student;

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
VALUES('20210002', 'S001', 80);

INSERT INTO tbl_score ( sc_stnum, sc_sbcode, sc_score )
VALUES('20210002', 'S002', 75);

INSERT INTO tbl_score ( sc_stnum, sc_sbcode, sc_score )
VALUES('20210002', 'S003', 90);

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

SELECT * FROM  tbl_subject;