-- ex21_view.sql

/*
	View, 뷰
	- 데이터베이스 객체 중 하나(테이블, 제약사항, 뷰, 시퀀스)
	- 가상 테이블, 뷰 테이블 등..
	- 테이블처럼 사용한다. (***)
	- 쿼리의 양을 줄인다.
	
	- 정의: 쿼리(SQL)을 저장하는 객체
	- 목적: 권한 통제
	
	create [or replace] view 뷰이름
	as
	select 문;
	
*/

CREATE OR REPLACE VIEW vwInsa
AS
SELECT * FROM tblinsa;


SELECT * FROM vwInsa; -- tblInsa 테이블의 복사본 > 실명 뷰
SELECT * FROM (SELECT * FROM TBLINSA); > 익명 뷰


-- '영업부' 직원
CREATE OR REPLACE VIEW 영업부
AS
SELECT 
	num, name, city, BASICPAY, SUBSTR(ssn,8) AS ssn
FROM TBLINSA 
	WHERE BUSEO = '영업부';
	
SELECT * FROM 영업부;


-- 비디오 대여점 사장 > 날마다 > 업무
CREATE OR REPLACE VIEW vwCheck
as
SELECT
	m.name AS 회원,
	v.name AS 비디오,
	r.RENTDATE AS 언제,
	r.retdate AS 반납,
	r.RENTDATE + g.PERIOD AS 반납예정일,
	round(sysdate - (r.RENTDATE + g.PERIOD)) AS 연체일,
	round((sysdate - (r.RENTDATE + g.PERIOD))) * g.PRICE * 0.1 AS 연체료
FROM tblrent r
	INNER JOIN TBLVIDEO v
		ON r.VIDEO = v.SEQ
			INNER JOIN TBLMEMBER m
				ON m.seq = r.MEMBER
					INNER JOIN TBLGENRE g
						ON g.SEQ = v.GENRE;
			
			
SELECT * FROM TBLGENRE;
			
SELECT * FROM VWCHECK;




-- tblInsa > 서울 직원 > view

CREATE OR REPLACE VIEW vwSeoul
AS
SELECT * FROM tblinsa WHERE city = '서울'; --뷰를 만드는 시점 > 20명

SELECT * FROM vwseoul; --20명

UPDATE TBLINSA SET city = '제주' WHERE num IN (1001, 1005, 1008);

SELECT * FROM tblInsa WHERE city = '서울'; --17명

SELECT * FROM vwSeoul; -- 17명


-- 신입 사원 > 업무 > 연락처 확인 > 문자 발송 > hr(java1234)
SELECT * FROM tblinsa; 	--신입 계정 > tblInsa 접근 권한(X)
SELECT * FROM VWTEL;  	--신입 계정 > vwTest 접근 읽기 권한(O)

CREATE OR REPLACE VIEW vwTel
AS
SELECT name, buseo, jikwi, tel FROM TBLINSA;


-- 뷰 사용 주의점!!
-- 1. SELECT > 실행O > 뷰는 읽기 전용으로 사용한다 == 읽기 전용 테이블
-- 2. INSERT > 실행O > 절대 사용 금지
-- 3. UPDATE > 실행O > 절대 사용 금지
-- 4. DELETE > 실행O > 절대 사용 금지

CREATE OR REPLACE VIEW vwTodo -- 단순 뷰 > 뷰의 SELECT가 1개의 테이블로 구성
AS
SELECT * FROM tblTodo;

SELECT * FROM vwtodo;
INSERT INTO vwtodo VALUES ((SELECT max(seq) + 1 FROM tbltodo) , '할일', sysdate, NULL);
UPDATE vwTOdo SET title = '할일 완료' WHERE seq = 24;
DELETE vwtodo WHERE seq = 25;


