-- 여기는 SCUSER 접속
INSERT INTO tbl_score(sc_num, sc_kor, sc_eng, sc_math)
VALUES('S0100',98,78,68);

SELECT * FROM tbl_score
WHERE sc_num = 'S0100';

-- SQL Developer에서
-- 데이터를 INSERT(추가), UPDATE(변경), DELETE(삭제) 명령을 수행하면 
-- Oracle Server 와 SQL Developer 사이에서 중간에 임시로 데이터가 보관된다.
-- 이 상태는 아직 Oracle Server의 저장소에 확정이 안된 상태
-- 확정이 안된 상태에서 ROLLBACK 명령을 수행하면 모든 CUD(INSERT, UPDATE, DELETE)가 취소된다.
-- CUD를 수행하여 데이터에 변화가 발생하면 명령을 완료한 후에 
-- 반드시 확정을 지어야 한다. 이때 사용하는 명령이 COMMIT이다
-- COMMIT 이 실행 되어야만 저장소에 데이터가 확정된다.

ROLLBACK;

DELETE FROM tbl_score; -- tbl_score의 모든데이터를 삭제
SELECT *
FROM tbl_score; -- 리스트에 데이터가 없음

ROLLBACK; -- 방금전 작업(DELETE) 을 취소

SELECT * 
FROM tbl_score; -- 삭제전 데이터를 복원

UPDATE tbl_score 
SET sc_kor = 100;

-- 데이터의 무결성, 일관성을 유지하고 갱신이상, 삭제이상을 방지하는 유일한 방법
-- DELETE와 UPDATE명령은 무조건 WHERE가 따라가자!!
-- 특별하게 필요한 경우가 아니면 WHERE에 포함하는 조건은 PK칼럼을 기준으로 하자
DELETE FORM tbl_score
WHERE sc_num = 'SC0001';

UPDATE tbl_score SET sc_kor = 100
WHERE sc_num = 'S0001';

-- DELETE와 UPDATE를 수행한 후 실수를 발견했을때 즉시 ROLLBACK을 수행하면
-- 명령을 취소할 수 있다. 하지만 PRODUCTION(실무) 환경에서는 DBMS 의 명령을 
-- 수행하는 사용자가 혼자가 아니므로 ROLLBACK 명령도 매우 신중하게 사용해야 한다.

SELECT * FROM view_score;

-- VIEW 생성시 설정한 AS 값들이 칼럼이름으로 사용된다.
SELECT * FROM view_score
WHERE 총점 < 200;

-- 총점이 200 미만인 학생들 데이터를 조회하여 총점순으로 오름차순 정렬하여 보여줘라
SELECT * FROM view_score
WHERE 총점 < 200
ORDER BY 총점;

-- 총점이 200 미만인 학생들 리스트를 먼저 영어 점수 순으로 오름차순 정렬하고
-- 영어 점수에 동점자가 있으면 수학점수 순으로 오름차순 정렬하라
-- 영어점수, 수학점수 동점자가 있으면 국어점수 순으로 오름차순...
SELECT 학번, 영어, 수학, 국어 FROM view_score
WHERE 총점 < 200
ORDER BY 영어, 수학, 국어;

-- 총점이 150보다 크고 200보다 작은 점수만 보여줘라
SELECT * FROM view_score
WHERE 총점 > 150 AND 총점 < 200;

-- 총점이 150 이상이고 200 이하인 점수만 보여줘라
SELECT * FROM view_score
WHERE 총점 >= 150 AND 총점 <= 200;

-- 조건값이 포함된 범위를 조회(검색)할때
SELECT * FROM view_score
WHERE 총점 BETWEEN 150 AND 200;

-- 총점이 150이상 200이하인 데이터중에 국어점수가 70 이상인 데이터
SELECT * FROM view_score
WHERE 총점 BETWEEN 150 AND 200 AND 국어>= 70;

-- 전체 데이터의 총점을 구하여 보여라
-- Project 항목에 사용하는 함수
-- 총점 칼럼에 저장된 모든 데이터의 합을 구하는 함수 
SELECT SUM(총점)
FROM view_score;

-- 전체학생의 총점 평균
SELECT AVG(총점)
FROM view_score;

-- 전체학생중 총점이 제일 큰 점수
SELECT MAX(총점)
FROM view_score;

-- 총점은 MAX() 함수로 감싸져 있고 학번은 단독으로 사용되었다.
-- 이러한 데이터를 출력하려면 함수로 감싸지 않은 칼럼들을 GROUP BY 에
-- 나열해 주어야 한다.
SELECT 학번, MAX(총점)
FROM view_score
GROUP BY 학번;

-- GROUP BY
-- 같은 값을 갖는 데이터들 끼리 묶어서 한번만 출력
SELECT 총점
FROM view_score
GROUP BY 총점;

-- SQL 통계함수
-- SUM(), AVG(), MAX(), MIN(), COUNT()
-- 총점(총합), 평균, 최대값, 최소값, 개수를 계산

-- 전체 데이터의 개수
SELECT COUNT(*) FROM view_score;

-- 같은 총점끼리 묶고 총점이 같은 데이터가 몇개씩 있는가
-- 총점이 같은 학생이 몇명씩 인가
SELECT 총점, COUNT(*)
FROM view_score
GROUP BY 총점; -- 개수를 새는데 부여하는 조건
COMMIT;