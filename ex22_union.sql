-- ex22_union.sql

/*
	관계 대수 연산
	1. 셀렉션 > select where
	2. 프로젝션 > select column
	3. 조인
	4. 합집합(union), 차집합(minus), 교집합(intersect)

	유니온, union
	- 스키마가 동일한 결과셋끼리 가능
*/

SELECT * FROM tblmen
union
SELECT * FROM TBLWOMEN;


SELECT name,ADDRESS, SALARY FROM TBLSTAFF
union
SELECT name,city, basicpay FROM tblinsa;


-- 어떤 회사 > 부서별 게시판 
SELECT * FROM 영업부게시판;
SELECT * FROM 총무부게시판;
SELECT * FROM 개발부게시판;

-- 회장님 > 모든 부서의 게시판글 > 한번에 열람
SELECT * FROM 영업부게시판
union
SELECT * FROM 총무부게시판
union
SELECT * FROM 개발부게시판;	


-- 야구선수 > 공격수, 수비수
SELECT * FROM 공격수;
SELECT * FROM 수비수;

SELECT * FROM 공격수
union
SELECT * FROM 수비수;

-- SNS > 하나의 테이블 + 다량의 데이터 > 기간별 테이블 분할

SELECT * FROM 게시판2020;
SELECT * FROM 게시판2021;
SELECT * FROM 게시판2022;
SELECT * FROM 게시판2023;

SELECT * FROM 게시판2020
union
SELECT * FROM 게시판2021
union
SELECT * FROM 게시판2022
union
SELECT * FROM 게시판2023;


--
CREATE TABLE tblAAA(
	name varchar2(30) NOT null
);

CREATE TABLE tblBBB(
	name varchar2(30) NOT null
);

INSERT INTO tblAAA VALUES ('강아지');
INSERT INTO tblAAA VALUES ('고양이');
INSERT INTO tblAAA VALUES ('토끼');
INSERT INTO tblAAA VALUES ('거북이');
INSERT INTO tblAAA VALUES ('병아리');

INSERT INTO tblBBB VALUES ('강아지');
INSERT INTO tblBBB VALUES ('고양이');
INSERT INTO tblBBB VALUES ('호랑이');
INSERT INTO tblBBB VALUES ('사자');
INSERT INTO tblBBB VALUES ('코끼리');


SELECT * FROM TBLAAA;
SELECT * FROM TBLBBB;


-- union > 수학의 집합 > 중복 제거
SELECT * FROM TBLAAA
UNION
SELECT * FROM TBLBBB;

-- union all > 수학의 집합 > 중복값 허용
SELECT * FROM TBLAAA
UNION ALL
SELECT * FROM TBLBBB;

-- intersect > 교집합
SELECT * FROM TBLAAA
INTERSECT
SELECT * FROM TBLbbb;

-- minus > 차집합(A - B)
SELECT * FROM TBLAAA
minus
SELECT * FROM TBLbbb;

SELECT * FROM TBLbbb
minus
SELECT * FROM TBLAAA;