-- 여기는 SCUSER 접속

CREATE TABLE tbl_student(
        st_num CHAR(5),
        st_name NVARCHAR2(20),
        st_dept NVARCHAR2(10), 
        st_grade VARCHAR(5), -- 숫자값을 입력, 숫자값을 문자형으로 인식
        st_tel VARCHAR(20),
        st_addr NVARCHAR2(125)
        );

-- 테이블 삭제        
DROP TABLE tbl_student;


-- 생성한 Table에 데이터 추가
-- DML(데이터 조작어) 명령을 사용하여 데이터 추가(create)
-- create : 테이블에 존재하지 않는 데이터를 새로 추가한다는 개념
INSERT INTO tbl_student(st_num, st_name, st_dept, st_grade)
VALUES('00001', '홍길동', '국어국문', '3');

-- 데이터를 추가한 후에는 잘 추가되었는지 확인
-- tbl_student table 에 저장되어있는 모든 데이터를 무조건 보여달라
SELECT * FROM tbl_student;

INSERT INTO tbl_student(st_num, st_dept, st_grade)
VALUES('00001', '컴퓨터공학', '2');

SELECT * FROM tbl_student;

-- 위에서 생성한 tbl_student 테이블에는 데이터를 추가할때
-- 이름 데이터가 없어도 데이터가 정삭적으로 추가가 가능하다.
-- 같은 학번의 데이터가 이미 추가되있어도 중복으로 추가가 가능하다.
-- 이런식으로 데이터가 계속 추가된다면 전체 데이터의 신뢰성에 문제가 생긴다.
-- DBMS에서는 table(Entity)를 설계할때 이러한 오류를 방지하기 위하여
-- Table을 생성할때 "제약조건'을 설정하여 데이터가 INSERT 되지 못하도록
-- 하는 기능이 있다.
-- 작성된 Table을 삭제하고 다시 "제약조건"을 설정하여 생성

DROP TABLE tbl_student;

-- 1. 학생의 이름은 데이터가 반드시 있어야 한다.
--      st_name(학생 이름) 칼럼은 NOT NULLL 이어야 한다.
-- 2. 학번은 절대 중복될수 없다.
--      tbl_student 테이블의 모든 데이터의 학번은 유일해야 한다.
CREATE TABLE tbl_student(
        st_num CHAR(5) UNIQUE NOT NULL, -- ( , ) 위치 확인
        st_name NVARCHAR2(20) NOT NULL,
        st_dept NVARCHAR2(10), 
        st_grade VARCHAR(5), -- 숫자값을 입력, 숫자값을 문자형으로 인식
        st_tel VARCHAR(20),
        st_addr NVARCHAR2(125)
        );
        
-- 이름 데이터가 없으므로 INSERT 불가
INSERT INTO tbl_student (st_num, st_dept)
VALUES('00001','컴퓨터공학');

-- 학생 이름 데이터를 같이 포함하여 INSERT수행
INSERT INTO tbl_student (st_num, st_dept, st_name)
VALUES('00001','컴퓨터공학', '홍길동');

-- 칼럼과 데이터의 개수가 맞지않아서 ISERT불가
INSERT INTO tbl_student (st_num, st_dept, st_name)
VALUES('사회과학', '이몽룡');

-- 학번 칼럼이 없으므로 INSERT 불가        
INSERT INTO tbl_student (st_dept, st_name)
VALUES('사회과학', '이몽룡');

-- st_num 칼럼이 UNIQUE인데 이미 존재하는 00001 학번이 있기때문에 데이터를
-- 추가하려고 하니 문제가 발생하여 INSERT 불가
-- Table의 제약조건을 설정할 때 UNIQUE는 매우 신중하게 선택해야 한다.
INSERT INTO tbl_student (st_num, st_dept, st_name)
VALUES('00001', '사회과학', '이몽룡');
        
INSERT INTO tbl_student (st_num, st_dept, st_name)
VALUES('00100', '사회과학', '이몽룡');

INSERT INTO tbl_student (st_num, st_dept, st_name)
VALUES('00002', '법학과', '성춘향');

SELECT * FROM tbl_student;

-- 기본키 칼럼(PRIMARY KEY)
-- 데이터를 조회(SELECT)할때 st_num 칼럼을 기준으로 조회를 하면 
-- 반드시 원하는 데이터1개만 보여지게 하는 조건 칼럼
-- 제약조건이 반드시 UNIQUE 하면서 NOT NULL 이어야 한다.
-- 기본키는 제약조건에 UNIQUE 와 NOT NULL을 같이 설정해야 하는데
-- DBMS에서는 기본키 제약조건을 설정하는 키워드가 별도로 있다.

DROP TABLE tbl_student;
-- PRIMARY KEY : UNIQUE + NOT NULL + 기타 조건 + INDEX 자동생성
-- 매우 강력한, 가장 우선순위가 높은 제약조건이다.
CREATE TABLE tbl_student(
        st_num CHAR(5) PRIMARY KEY, -- ( , ) 위치 확인
        st_name NVARCHAR2(20) NOT NULL,
        st_dept NVARCHAR2(10), 
        st_grade VARCHAR(5), -- 숫자값을 입력, 숫자값을 문자형으로 인식
        st_tel VARCHAR(20),
        st_addr NVARCHAR2(125)
        );        
        
-- TABLE 의 구조를 보여달라
DESCRIBE tbl_student;
DESC tbl_student;

INSERT INTO tbl_student (st_num, st_dept, st_name)
VALUES('00100', '사회과학', '이몽룡');

INSERT INTO tbl_student (st_num, st_dept, st_name)
VALUES('00002', '법학과', '성춘향');
        
INSERT INTO tbl_student (st_num, st_dept, st_name)
VALUES('00001', '컴퓨터공학', '홍길동');

SELECT * FROM tbl_student;

-- PK 로 설정된 칼럼에 조건을 부여하여 데이터 조회하기
-- 개체 무결성을 갖춘 테이블
SELECT * 
FROM tbl_student
WHERE st_num = '00001';

SELECT * FROM tbl_student;