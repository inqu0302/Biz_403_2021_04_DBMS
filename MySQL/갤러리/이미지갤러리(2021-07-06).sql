use mylibs;

CREATE TABLE tbl_gallery (
g_seq	BIGINT	AUTO_INCREMENT	PRIMARY KEY,
g_writer	VARCHAR(20)	NOT NULL,	
g_date	VARCHAR(10)	NOT NULL,	
g_time	VARCHAR(10)	NOT NULL,	
g_subject	VARCHAR(50)	NOT NULL,	
g_content	VARCHAR(1000)	NOT NULL,	
g_image	VARCHAR(125)		
);

SHOW TABLES ;

drop table tbl_files;
drop table tbl_gallery;

show tables;

DESC tbl_gallery;

-- 다수의 데이터를 입력시키는 효율적 방법
INSERT INTO tbl_files
(file_gseq, file_origin, file_update)
value
(1, 'title', 'uuid-title'),
(1, 'title', 'uuid-title'),
(1, 'title', 'uuid-title');

-- INSERT 수행할때
-- AUTO_INCREMENT로 성정된 칼럼에 0 또는 null, '' 등의 값을 설정하면
-- AUTO_INCREMENT가 실행된다
INSERT INTO tbl_gallery
(g_seq, g_sriter, g_date, g_time, g_subject, g_content)
value(0, 'callor', '2021', '00:00', "제목", "내용");

select * from tbl_gallery;
select * from tbl_files;

-- EQ JOIN
-- 카티션 곱
-- 두개의 table을 JOIN하여 table 1 개수 * table 2 개수 만큼 list 출력
SELECT * FROM tbl_gallery G, tbl_files F
	WHERE G.g_seq = F.file_gseq
    AND G.g_seq = 1;

/*
view 갤러리의 SQL 코드
EQ JOIN으로 연결된 코드
tbl_gallery에는 데이터가 있는데 tbl_files에는 연결되는 데이터가 하나 없는 경우
tbl_gallery 자체가 출력되지 않는 문제가 있다.
*/
CREATE VIEW view_갤러리 AS
SELECT 
	G.g_seq AS g_seq , 
    G.g_writer AS g_writer, 
    G.g_date AS g_date, 
    G.g_time AS g_time,
    G.g_subject AS g_subject, 
    G.g_content AS g_content, 
    G.g_image AS g_image,
	F.file_seq AS f_seq, 
    F.file_original AS f_original, 
    F.file_upname AS f_upname
 FROM tbl_gallery G, tbl_files F
	WHERE G.g_seq = F.file_gseq;
    
SELECT * FROM view_갤러리;
    
DESC view_갤러리;

SHOW TABLES;

DESC tbl_member;

/*
1:N 관계의 table일 경우
보통은 FK로 설정하여 데이터를 유지한다.
1:0 ~ 1:N	: child table에 연관된 데이터가 하나도 없는 경우가 있다 
1:1 ~ 1:N	: child table에 연관된 데이터가 최소 한개는 있는 경우

1:1 ~ 1:N 인경우는 EQ JOIN을 수행해도 실제로는 Parent table에 있는 데이터는 무조건 출력이 된다
1:0 ~ 1:N 인 경우 child table에 데이터가 하나도 없는 경우 EQ JOIN을 수행하면 출력되는 데이터가
			한개도 없는 상황이 발생한다.
            
JOIN을 수행할때 FK가 설정에 상관없이 LEFT(OUTTER) JOIN을 수행하는 것이 좋다.
*/
SELECT 
	G.g_seq AS g_seq , 
    G.g_writer AS g_writer, 
    G.g_date AS g_date, 
    G.g_time AS g_time,
    G.g_subject AS g_subject, 
    G.g_content AS g_content, 
    G.g_image AS g_image,
	F.file_seq AS f_seq, 
    F.file_original AS f_original, 
    F.file_upname AS f_upname
FROM tbl_gallery G
		LEFT JOIN tbl_files F
			ON G.g_seq = F.file_gseq
	WHERE G.g_seq = 8;
        
DELETE FROM tbl_files
WHERE file_seq = 12;