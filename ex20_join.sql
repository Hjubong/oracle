-- ex20_join.sql

/*
	관계형 데이터베이스 시스템이 지양하는 것들
	- 테이블 다시 수정해야 고쳐지는 것들 > 구조적인 문제!!
	
	1. 테이블에 기본키가 없는 상태 > 데이터 조작 곤란
	2. null이 많은 상태의 테이블 > 공간 낭비
	3. 데이터가 중복되는 상태 > 공간 낭비 + 데이터 조작 곤란
	4. 하나의 속성값이 원자값이 아닌 상태 > 더 이상 쪼개지지 않는 값을 넣어야 한다

*/

CREATE TABLE tblTest
(
	name varchar2(30) NOT NULL,
	age number(3) NOT NULL,
	nick varchar2(30) NOT null
);


-- 홍길동, 20, 강아지
-- 아무개, 22, 바보
-- 테스트, 20, 반장
-- 홍길동, 20 ,강아지 > 발생(X), 조작(?)

-- 홍길동 별명 수정
UPDATE tblTest SET nick = '고양이' WHERE name = '강아지'; --식별 불가능

-- 홍길동 탈퇴
DELETE FROM tblTest WHERE name = '홍길동'; --식별 불가능




--2. null이 많은 상태의 테이블 > 공간낭비
CREATE TABLE tblTest
(
	name varchar2(30) PRIMARY KEY,
	age number(3) NOT NULL,
	nick varchar2(30) NOT NULL,
	hobby1 varchar2(100) NULL,
	hobby2 varchar2(100) NULL,
	hobby3 varchar2(100) NULL,
	..
	hobby8 varchar2(100) NULL,
);

-- 홍길동, 20, 강아지, null, null, null, null, null, null, null, null
-- 아무개, 22, 고양이, 게임, null, null, null, null, null, null, null
-- 이순신, 24, 거북이, 수영, 활쏘기, null, null, null, null, null, null
-- 테스트, 25, 닭, 수영, 독서, 낮잠, 여행, 맛집, 공부, 코딩, 영화




-- 직원 정보
-- 직원(번호(PK), 직원명, 급여, 거주지, 담당프로젝트)
create TABLE tblStaff(
	seq NUMBER PRIMARY KEY, 			--직원번호(PK)
	name varchar2(30) NOT NULL,			--직원명
	salary NUMBER NOT NULL, 			--급여
	address varchar2(300) NOT NULL, 	--거주지
	project varchar2(300)				--담당프로젝트
);

SELECT * FROM TBLSTAFF

INSERT INTO TBLSTAFF (seq, name, salary, address, project)
	VALUES (1, '홍길동', 300, '서울시', '홍콩 수출');

INSERT INTO TBLSTAFF (seq, name, salary, address, project)
	VALUES (2, '아무개', 250, '인천시', 'TV 광고');

INSERT INTO TBLSTAFF (seq, name, salary, address, project)
	VALUES (3, '하하하', 350, '의정부시', '매출 분석');


-- '홍길동'에게 담당 프로젝트가 1건 추가 > '고객 관리'
-- '홍콩 수출, 고객 관리'
UPDATE tblstaff SET project = project + ',고객 관리' WHERE seq =1; --절대 금지

INSERT INTO TBLSTAFF (seq, name, salary, address, project)
	VALUES (4, '홍길동', 300, '서울시', '고객 관리');
	
INSERT INTO TBLSTAFF (seq, name, salary, address, project)
	VALUES (5, '호호호', 250, '서울시', '게시판 관리, 회원 응대');

INSERT INTO TBLSTAFF (seq, name, salary, address, project)
	VALUES (6, '후후후', 250, '서울시', '불량 회원 응대');
	
-- 'TV 광고' > 담당자!! > 확인?
SELECT * FROM tblstaff WHERE project = 'TV 광고';

-- '회원 응대' > 담당자!! > 확인?
SELECT * FROM tblstaff WHERE project like '%회원 응대%';

-- '회원 응대' > '멤버 조치' 수정
UPDATE tblstaff SET project = '멤버 조치' WHERE project like '%,회원 응대%'



-- 해결 > 테이블 재구성
DROP TABLE TBLSTAFF

-- 직원 정보
-- 직원(번호(PK), 직원명, 급여, 거주지)
create TABLE tblStaff(
	seq NUMBER PRIMARY KEY, 			--직원번호(PK)
	name varchar2(30) NOT NULL,			--직원명
	salary NUMBER NOT NULL, 			--급여
	address varchar2(300) NOT NULL 	--거주지
);

-- 프로젝트 정보
CREATE TABLE tblproject(
	seq NUMBER PRIMARY KEY, 		--
	project varchar2(100) NOT NULL, --프로젝트명
	staff_seq NUMBER NOT NULL		--담당 직원 번호
);