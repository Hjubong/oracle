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
DROP TABLE TBLSTAFF;
DROP TABLE TBLPROJECT;

-- 직원 정보
-- 직원(번호(PK), 직원명, 급여, 거주지)
create TABLE tblStaff(	
	seq NUMBER PRIMARY KEY, 			--직원번호(PK)
	name varchar2(30) NOT NULL,			--직원명
	salary NUMBER NOT NULL, 			--급여
	address varchar2(300) NOT NULL 	--거주지
); -- 부모 테이블

-- 프로젝트 정보
CREATE TABLE tblproject(
	seq NUMBER PRIMARY KEY, 							--프로젝트 번호(PK)
	project varchar2(100) NOT NULL, 					--프로젝트명
	staff_seq NUMBER NOT NULL REFERENCES tblStaff(seq) --담당 직원 번호(FK)
); --자식 테이블

INSERT INTO tblstaff (seq, name, salary, address) VALUES (1, '홍길동', 300, '서울시');
INSERT INTO tblstaff (seq, name, salary, address) VALUES (2, '아무개', 250, '인천시');
INSERT INTO tblstaff (seq, name, salary, address) VALUES (3, '하하하', 250, '부산시');

INSERT INTO tblProject (seq, project, staff_seq) VALUES (1, '홍콩 수출', 1); --홍길동
INSERT INTO tblProject (seq, project, staff_seq) VALUES (2, 'TV 광고', 2);	--아무개
INSERT INTO tblProject (seq, project, staff_seq) VALUES (3, '매출 분석', 3);	--하하하
INSERT INTO tblProject (seq, project, staff_seq) VALUES (4, '노조 협상', 1);	--홍길동
INSERT INTO tblProject (seq, project, staff_seq) VALUES (5, '대리점 분양', 2);--아무개

SELECT * FROM TBLSTAFF;
SELECT * FROM TBLproject;

-- 'TV 광고' > 담당자!! > 확인?
SELECT staff_seq FROM TBLPROJECT WHERE project = 'TV 광고';
SELECT * FROM tblstaff 
	WHERE seq = (SELECT staff_seq FROM TBLPROJECT WHERE project = 'TV 광고');
	
-- A. 신입 사원 입사 > 신규 프로젝트 담당
-- A.1 신입 사원 추가(O)
INSERT INTO tblstaff (seq, name, salary, address) VALUES (4, '호호호', 250, '성남시');

-- A.2 신규 프로젝트 추가(O)
INSERT INTO tblProject (seq, project, staff_seq) VALUES (6, '자재 매입', 4);

-- A.3 신규 프로젝트 추가 > 에러(X) > 논리 오류!!
INSERT INTO tblProject (seq, project, staff_seq) VALUES (7, '고객 유치', 5);

SELECT * FROM tblstaff 
	WHERE seq = (SELECT staff_seq FROM TBLPROJECT WHERE project = '고객 유치');


-- B. '홍길동' 퇴사
-- B.1 '홍길동' 삭제
DELETE FROM tblstaff WHERE seq = 1;
	
-- B.2 '홍길동' 삭제 > 인수 인계(위임)
UPDATE TBLPROJECT SET staff_seq = 2 WHERE staff_seq = 1;

-- B.3 '홍길동' 삭제
DELETE FROM tblstaff WHERE seq = 1;


-- *** 자식 테이블보다 부모 테이블이 먼저 발생한다.(테이블 생성, 레코드 생성)
-- 고객 테이블
create table tblCustomer (
    seq number primary key,         --고객번호(PK)
    name varchar2(30) not null,     --고객명
    tel varchar2(15) not null,      --연락처
    address varchar2(100) not null  --주소
);

-- 판매내역 테이블
create table tblSales (
    seq number primary key,                             --판매번호(PK)
    item varchar2(50) not null,                         --제품명
    qty number not null,                                --판매수량
    regdate date default sysdate not null,              --판매날짜
    cseq number not null references tblCustomer(seq)    --판매한 고객번호(FK)
);




-- [비디오 대여점]

-- 장르 테이블
create table tblGenre (
    seq number primary key,         --장르 번호(PK)
    name varchar2(30) not null,     --장르명
    price number not null,          --대여가격
    period number not null          --대여기간(일)
);

-- 비디오 테이블
create table tblVideo (
    seq number primary key,                         --비디오 번호(PK)
    name varchar2(100) not null,                    --비디오 제목
    qty number not null,                            --보유 수량
    company varchar2(50) null,                      --제작사
    director varchar2(50) null,                     --감독
    major varchar2(50) null,                        --주연배우
    genre number not null references tblGenre(seq)  --장르 번호(FK)
);

-- ***
-- 고객 테이블
create table tblMember (
    seq number primary key,         --고객번호(PK)
    name varchar2(30) not null,     --고객명
    grade number(1) not null,       --고객등급(1,2,3)
    byear number(4) not null,       --생년
    tel varchar2(15) not null,      --연락처
    address varchar2(300) null,     --주소
    money number not null           --예치금
);

-- 대여 테이블
create table tblRent (
    seq number primary key,                             --대여번호(PK)
    member number not null references tblMember(seq),   --회원번호(FK)
    video number not null references tblVideo(seq),     --비디오번호(FK)
    rentdate date default sysdate not null,             --대여시각
    retdate date null,                                  --반납시각
    remark varchar2(500) null                           --비고
);



SELECT * FROM TBLGENRE;
SELECT * FROM TBLvideo;
SELECT * FROM TBLmember;
SELECT * FROM TBLrent;


/*
	조인, Join
	- (서로 관계를 맺은) 2개 이상의 테이블을 1개의 결과셋으로 만드는 기술
	
	조인의 종류
	1. 단순 조인, CREOSS JOIN
	2. 내부 조인, INNER JOIN ***
	3. 외부 조인, OUTER JOIN ***
	4. 셀프 조인, SELF JOIN
	5. 전체 외부 조인, FULL OUTER JOIN

*/

/*
	1. 단순 조인, CROSS JOIN, 카티션곱(데카르트곱)
	- A 테이블 X B 테이블
	- 쓸모없다 > 가치있는 행과 가치없는 행이 뒤섞여 있어서
	- 더미 데이터(유효성 무관)
*/

SELECT * FROM TBLCUSTOMER; 	--3개

SELECT * FROM TBLSALES;		--9개

SELECT * FROM TBLCUSTOMER CROSS JOIN TBLSALES;	--ANSI-SQL(추천)
SELECT * FROM TBLCUSTOMER, TBLSALES; --Oracle


/*
	2. 내부 조인, INNER JOIN
	- 단순 조인에서 유효한 레코드만 추출한 조인
	
	select 컬럼리스트 from 테이블 A cross join 테이블 B;
	
	select 
		컬럼리스트 
	from 테이블 A 
		inner join 테이블 B 
			on 테이블A.PK = 테이블B.FK;
	
*/

-- 직원 테이블, 프로젝트 테이블
SELECT 
	* 
FROM TBLSTAFF
	CROSS JOIN TBLPROJECT;
	
SELECT 
	tblstaff.seq,
	tblstaff.name,
	tblproject.seq,
	tblproject.project
FROM TBLSTAFF
	INNER JOIN TBLPROJECT
		ON tblstaff.SEQ =tblproject.STAFF_SEQ
			ORDER BY tblproject.SEQ;
			
	
-- 조인 > 테이블 별칭 자주 사용
SELECT 	--2.
	s.seq,
	s.name,
	p.seq,
	p.project
FROM TBLSTAFF s
	INNER JOIN TBLPROJECT P
		ON s.SEQ =p.STAFF_SEQ 	--1.
			ORDER BY p.SEQ; --3.
			
			
-- 고객 테이블, 판매 테이블
SELECT
	c.name AS 고객명,
	s.item AS 제품명,
	s.qty AS 개수
FROM TBLCUSTOMER c
	INNER JOIN TBLSALES S
		ON c.SEQ = s.CSEQ;
		

	
SELECT * FROM TBLMEN;
SELECT * FROM TBLWOMEN;

SELECT
	*
FROM TBLMEN m
	INNER JOIN TBLWOMEN W
		ON m.NAME = w.COUPLE;
		
	
SELECT
	*
FROM TBLSTAFF st
	INNER JOIN TBLSALES sa
		ON st.seq = sa.CSEQ;
		
	
-- 고객명 + 판매물품명 > 가져오시오
-- 1. 조인
SELECT
	c.NAME AS 고객명,
	s.ITEM AS 물품명
FROM TBLCUSTOMER c
	INNER JOIN TBLSALES S
		ON c.seq = s.CSEQ;

-- 2. 서브 쿼리 > 상관 서브 쿼리
-- 메인쿼리 > 자식 테이블
-- 상관 서브 쿼리 > 부모 테이블
SELECT
	ITEM AS 물품명,
	(SELECT name FROM TBLCUSTOMER WHERE seq = tblsales.cseq) AS 고객명
FROM TBLSALES;




-- 비디오 + 장르 > 조인
SELECT
	v.NAME,
	g.NAME,
	g.PRICE
FROM TBLGENRE g
	INNER JOIN TBLVIDEO v 
		ON g.seq = v.GENRE;
			
	
-- 비디오 + 장르 + 대여
SELECT
	v.NAME,
	g.NAME,
	g.PRICE,
	r.rentdate,
	r.retdate
FROM TBLGENRE g
	INNER JOIN TBLVIDEO v 
		ON g.seq = v.GENRE
			INNER JOIN tblrent r 
				ON v.seq = r.VIDEO;

			
			
-- 비디오 + 장르 + 대여 + 회원
SELECT
	m.NAME,
	v.name,
	g.PRICE,
	r.RENTDATE
FROM TBLGENRE g
	INNER JOIN TBLVIDEO v 
		ON g.seq = v.GENRE
			INNER JOIN tblrent r 
				ON v.seq = r.VIDEO	
					INNER JOIN tblmember m
						ON m.seq = r.MEMBER;
					
					
					
SELECT
	e.FIRST_NAME || ' ' || e.LAST_NAME AS "직원명",
	d.DEPARTMENT_NAME AS "부서명",
	l.city AS "도시명",
	c.COUNTRY_NAME AS "국가명",
	r.REGION_NAME AS "대륙명",
	j.JOB_TITLE AS "직업"
FROM EMPLOYEES e
		INNER JOIN DEPARTMENTS d
			ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
				INNER JOIN LOCATIONS l
					ON l.LOCATION_ID = d.LOCATION_ID
						INNER JOIN COUNTRIES c 
							ON c.COUNTRY_ID = l.COUNTRY_ID
								INNER JOIN REGIONS r 
									ON r.REGION_ID = c.REGION_ID
										INNER JOIN jobs j 
											ON j.JOB_ID = e.JOB_ID;
										
						
						
/*
 	3. 외부 조인, OUTER JOIN
 	- 내부 조인의 반댓말
 	- 내부 조인 결과 + 내부 조인에 포함되지 않았던 부모 테이블의 나머지 레코드를 합하는 조인
 	
 	select
 		컬럼리스트
 	from 테이블A
 		inner join 테이블B
 			on 테이블A.컬럼 = 테이블B.컬럼;
 			
 			
 	select
 		컬럼리스트
 	from 테이블A
 		(left|right) outer join 테이블B
 			on 테이블A.컬럼 = 테이블B.컬럼;
 */
										
										
SELECT * FROM TBLCUSTOMER; -- 3명 > 5명
SELECT * FROM TBLSALES; --9건
			
INSERT INTO TBLCUSTOMER VALUES (4, '호호호', '010-1234-1234', '서울시');
INSERT INTO TBLCUSTOMER VALUES (5, '이순신', '010-1234-1234', '서울시');

-- 내부 조인
-- 업무 > 물건을 한번이라도 구매한 이력이 있는 고객의 정보와 그 고객이 사간 구매내역을 가져오시오.
SELECT
	*
FROM TBLCUSTOMER c
	INNER JOIN TBLSALES s 
		ON c.seq = s.cseq; --9
		
--외부 조인		
SELECT
	*
FROM TBLCUSTOMER c
	LEFT OUTER JOIN TBLSALES s 
		ON c.seq = s.cseq; --11 
										

SELECT
	*
FROM TBLCUSTOMER c
	RIGHT OUTER JOIN TBLSALES s 
		ON c.seq = s.cseq; --9 
										


SELECT * FROM TBLSTAFF; --3명
SELECT * FROM TBLPROJECT; --6건

UPDATE TBLPROJECT SET staff_seq = 4 WHERE STAFF_SEQ = 3;


-- 프로젝트 1건 이상 담당하고 있는 직원을 가져오시오.
SELECT
	* 
FROM TBLSTAFF s 
	INNER JOIN TBLPROJECT p 
	 	ON s.seq = p.STAFF_SEQ;
	 
	 
-- 담당 프로젝트의 유무와 상관없이 모든 직원을 가져오시오.
SELECT
	* 
FROM TBLSTAFF s 
	LEFT OUTER JOIN TBLPROJECT p 
	 	ON s.seq = p.STAFF_SEQ;
	 
	 
-- 대여가 한번이라도 발생한 비디오와 대여기록
SELECT
	*
FROM TBLVIDEO v
	INNER JOIN TBLRENT r
		ON v.seq = r.VIDEO;
	
	
SELECT
	*
FROM TBLVIDEO v
	LEFT OUTER JOIN TBLRENT r 
		ON v.seq = r.VIDEO;
	
-- 대여를 최소 1회 이상 회원과 대여 내역
SELECT
	*
FROM TBLMEMBER m
	INNER JOIN TBLRENT r 
		ON m.seq = r.MEMBER;
	
SELECT
	*
FROM TBLMEMBER m
	LEFT OUTER JOIN TBLRENT r 
		ON m.seq = r.MEMBER;
	
-- 대여를 한번도 하지 않은 고객 명단
SELECT
	*
FROM TBLMEMBER m
	LEFT OUTER JOIN TBLRENT r 
		ON m.seq = r.MEMBER
			WHERE r.seq IS NULL;
	
-- 대여 기록이 있는 회원의 이름
SELECT
	DISTINCT m.NAME
FROM TBLMEMBER m
	inner JOIN TBLRENT r 
		ON m.seq = r.MEMBER;
		
-- 대여 기록이 있는 회원의 이름 + 대여 횟수
SELECT
	m.NAME,
	COUNT(*)
FROM TBLMEMBER m
	inner JOIN TBLRENT r 
		ON m.seq = r.MEMBER
			GROUP BY m.name;
		
		
		
SELECT	
	m.NAME,
	COUNT(r.SEQ)
FROM TBLMEMBER m
	LEFT OUTER JOIN TBLRENT r 
		ON m.seq = r.MEMBER
			GROUP BY m.name
				ORDER BY COUNT(r.seq) DESC;
			
			
			
/*
 	4. 셀프 조인, SELF JOIN
 	- 1개의 테이블을 사용하는 조인
 	- 테이블이 자기 스스로와 관계를 맺는 경우
 	
 	- 다중 조인(2개) + 내부 조인
 	- 다중 조인(2개) + 외부 조인
 */
	
			
-- 직원 테이블
CREATE TABLE tblSelf (
	seq NUMBER PRIMARY KEY,						--직원번호(PK)
	name varchar2(30) NOT NULL,					--직원명
	DEPARTMENTS varchar2(30) NOT NULL,			--부서명
	super NUMBER NULL REFERENCES tblself(seq)	--상사번호(FK)			
);

INSERT INTO TBLSELF VALUES (1, '홍사장', '사장', null);
INSERT INTO TBLSELF VALUES (2, '김부장', '영업부', 1);
INSERT INTO TBLSELF VALUES (3, '박과장', '영업부', 2);
INSERT INTO TBLSELF VALUES (4, '최대리', '영업부', 3);
INSERT INTO TBLSELF VALUES (5, '정사원', '영업부', 4);
INSERT INTO TBLSELF VALUES (6, '이부장', '개발부', 1);
INSERT INTO TBLSELF VALUES (7, '하과장', '개발부', 6);
INSERT INTO TBLSELF VALUES (8, '신과장', '개발부', 6);
INSERT INTO TBLSELF VALUES (9, '황대리', '개발부', 7);
INSERT INTO TBLSELF VALUES (10, '허사원', '개발부', 9);
		
-- 직원 명단을 가져오시오. 단, 상사의 이름까지
-- 1. Join
-- 2. Sub Query
-- 3. 계층형 쿼리

SELECT 
	b.name AS 직원명,
	b.departments AS 부서명,
	a.name AS 상사명
FROM TBLSELF a				-- 역할: 부모테이블 > 상사
	INNER JOIN tblself b	-- 역할: 자식테이블 > 직원
		ON a.seq = b.super;
		
	
SELECT 
	b.name AS 직원명,
	b.departments AS 부서명,
	a.name AS 상사명
FROM TBLSELF a				
	RIGHT outer JOIN tblself b	
		ON a.seq = b.super;
		
	
SELECT
	name AS 직원명,
	departments AS 부서명,
	(SELECT name FROM TBLSELF WHERE seq = a.super) AS 상사명
FROM TBLSELF a;



/*
	5. 전체 외부 조인, FULL OUTER JOIN
	- 서로 참조하고 있는 관계에서 사용
*/

SELECT * FROM TBLMEN;	--부모, 자식
SELECT * FROM TBLWOMEN;	--자식, 부모


-- 커플인 남자, 여자 가져오시오.
SELECT
	m.name,
	w.name
FROM TBLMEN m
	INNER JOIN TBLWOMEN w
		ON m.NAME = w.COUPLE;
		
	
SELECT
	m.name,
	w.name
FROM TBLMEN m
	full OUTER JOIN TBLWOMEN w
		ON m.NAME = w.COUPLE;