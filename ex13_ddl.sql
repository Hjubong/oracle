-- ex13_ddl.sql

/*
	ex01 ~ ex12: DML 기본(기초)

	DDL
	- 데이터 정의어
	- 데이터베이스 객체를 생성/수정/삭제한다.
	- 데이터베이스 객체 > 테이블, 뷰, 인덱스, 프로시저, 트리거, 제약사항, 시노닙 등..
	- create, alter, drop
	
	테이블 생성하기 > 스키마 정의하기 > 속성(컬럼) 정의하기 > 컬럼의 이름, 자료형, 제약을 정의
	
	create table 테이블명
	(
		컬럼 정의,
		컬럼 정의,
		컬럼 정의,
		컬럼명 자료형(길이),
		컬럼명 자료형(길이) NULL 제약 사항
	);
	
	
	제약 사항, Constraint
	- 해당 컬럼에 들어갈 데이터(값)에 대한 조건
		1. 조건을 만족하면 > 대입
		2. 조건을 불만족하면 > 에러 발생
	- 유효성 검사 도구
	- 데이터 무결성을 보장하기 위한 도구(***)
	
	1. NOT NULL
		- 해당 컬럼이 반드시 값을 가져야 한다.
		- 해당 컬럼에 값이 없으면 에러 발생
		- 필수값
	
	2. PRIMARY KEY, PK
		- 기본키
		- 테이블의 행을 구분하기 위한 제약 사항
		- 행을 식별하는 수많은 키(후보키)들 중 대표로 선정된 키
		- 모든 테이블은 반드시 1개의 기본키가 존재해야 한다(**************)
		- 중복값을 가질 수 없다. > unique
		- 값을 반드시 가진다. > not null
	
	3. FOREIGN KEY, FK
		- 다음에
	
	4. UNIQUE
		- 유일하다 > 레코드간의 중복값을 가질 수 없다
		- null을 가질 수 있다 > 식별자가 될 수 없다
		ex) 초등학교 교실
			- 학생(번호(PK), 이름(NOT NULL), 직책(UQ))
				1,홍길동,반장
				2,아무개,null
				3,하하하,부반장
				4,테스트,null
				
		PK = UNIQUE + NOT NULL = UQ + NN
		
	5. CHECK
		- 사용자 정의형
		- where절의 조건 > 컬럼의 제약 사항으로 적용
		
	6. DEFAULT
		- 기본값 설정
		- insert / update 작업 시 > 컬럼에 값을 안넣으면 null 대신 미리 설정한 값을 대입
*/

--메모 테이블
CREATE TABLE tblMemo
(
	-- 컬럼명 자료형(길이) NULL 제약 사항
	seq number(3) NULL,			--메모번호
	name varchar2(30) NULL,		--작성자
	memo varchar2(1000) NULL,	--메모
	regdate DATE NULL			--작성날짜
);

SELECT * FROM TBLMEMO;

INSERT INTO TBLMEMO (seq, name, memo, regdate) VALUES (1, '홍길동', '메모입니다.', sysdate);
INSERT INTO TBLMEMO (seq, name, memo, regdate) VALUES (2, '아무개', null , sysdate);
INSERT INTO TBLMEMO (seq, name, memo, regdate) VALUES (3, null, null , null);
INSERT INTO TBLMEMO (seq, name, memo, regdate) VALUES (null, null, null , null);




--메모 테이블
DROP TABLE TBLMEMO;

CREATE TABLE tblMemo
(
	seq number(3) NOT NULL,			--메모번호(NN = not null)
	name varchar2(30) NULL,			--작성자
	memo varchar2(1000) NOT NULL,	--메모(NN)
	regdate DATE NULL				--작성날짜
);

SELECT * FROM TBLMEMO;

INSERT INTO TBLMEMO (seq, name, memo, regdate) VALUES (1, '홍길동', '메모입니다.', sysdate);

-- ORA-01400: cannot insert NULL into ("HR"."TBLMEMO"."MEMO")
INSERT INTO TBLMEMO (seq, name, memo, regdate) VALUES (2, '아무개', null , sysdate);
INSERT INTO TBLMEMO (seq, name, regdate) VALUES (2, '아무개', sysdate); -- 생략된 컬럼에는 null이 들어간다.
INSERT INTO TBLMEMO (seq, name, memo, regdate) VALUES (2, '아무개', '' , sysdate); --빈문자('')도 null로 취급한다





--메모 테이블
DROP TABLE TBLMEMO;

CREATE TABLE tblMemo
(
	seq number(3) PRIMARY key,			--메모번호(pk)
	name varchar2(30) NULL,			--작성자
	memo varchar2(1000) NOT NULL,	--메모(NN)
	regdate DATE NULL				--작성날짜
);

SELECT * FROM TBLMEMO;

-- ORA-00001: unique constraint (HR.SYS_C007085) violated
INSERT INTO TBLMEMO (seq, name, memo, regdate) VALUES (1, '홍길동', '메모입니다.', sysdate); --기본키 중복 입력시 오류
-- ORA-01400: cannot insert NULL into ("HR"."TBLMEMO"."SEQ")
INSERT INTO TBLMEMO (seq, name, memo, regdate) VALUES (null, '홍길동', '메모입니다.', sysdate); --기본키는 반드시 값을 가져야함





--테이블내에 PK가 반드시 존재해야할까?
DROP TABLE TBLMEMO;

CREATE TABLE tblMemo
(
	seq number(3) NOT NULL,			--메모번호(NN)
	name varchar2(30) NULL,			--작성자
	memo varchar2(1000) NOT NULL,	--메모(NN)
	regdate DATE NULL				--작성날짜
);

SELECT * FROM TBLMEMO;

INSERT INTO TBLMEMO (seq, name, memo, regdate) VALUES (1, '홍길동', '메모입니다.', sysdate); -- 2번 등록했다고 가정
INSERT INTO TBLMEMO (seq, name, memo, regdate) VALUES (2, '아무개', '메모입니다.', sysdate);
INSERT INTO TBLMEMO (seq, name, memo, regdate) VALUES (3, '테스트', '메모입니다.', sysdate);

SELECT * FROM TBLMEMO WHERE name = '아무개';
SELECT * FROM TBLMEMO WHERE seq = 2; -- 검색 > 주로 PK 검색

--기본키가 없으면 같은 내용을 2번 등록했을때 내가 보고싶은 데이터만 검색하기 힘듦 
SELECT * FROM TBLMEMO WHERE name = '홍길동'; 
SELECT * FROM TBLMEMO WHERE seq = 1;

--삭제할때도 마찬가지로 지우고 싶은 데이터만 삭제할 수 없음
DELETE FROM TBLMEMO WHERE seq = 1;





--메모 테이블
DROP TABLE TBLMEMO;

CREATE TABLE tblMemo
(
	seq number(3) PRIMARY key,			--메모번호(PK)
	name varchar2(30) UNIQUE,			--작성자(UQ)
	memo varchar2(1000) NOT NULL,		--메모(NN)
	regdate DATE 						--작성날짜
);

SELECT * FROM TBLMEMO;

INSERT INTO TBLMEMO (seq, name, memo, regdate) VALUES (1, '홍길동', '메모입니다.', sysdate);
INSERT INTO TBLMEMO (seq, name, memo, regdate) VALUES (2, '홍길동', '메모입니다.', sysdate); --UQ 유일해야함
INSERT INTO TBLMEMO (seq, name, memo, regdate) VALUES (2, '아무개', '메모입니다.', sysdate);
INSERT INTO TBLMEMO (seq, name, memo, regdate) VALUES (3, 'NULL', '메모입니다.', sysdate);
INSERT INTO TBLMEMO (seq, name, memo, regdate) VALUES (4, 'NULL', '메모입니다.', sysdate);





--메모 테이블
DROP TABLE TBLMEMO;

CREATE TABLE tblMemo
(
	seq number(3) PRIMARY key,			--메모번호(PK)
	name varchar2(30),					--작성자(UQ)
	memo varchar2(1000),				--메모(NN)
	regdate DATE, 						--작성날짜
	priority NUMBER(1) CHECK (priority BETWEEN 1 AND 3),	--중요도(1(중요), 2(보통), 3(안중요))
	category varchar2(30) CHECK (category IN ('할일', '공부', '약속'))		--카테고리(할일, 공부, 약속)
);

SELECT * FROM TBLMEMO;

INSERT INTO TBLMEMO (seq, name, memo, regdate, priority, category) VALUES (1, '홍길동', '메모입니다.', sysdate, 1, '할일');
-- ORA-02290: check constraint (HR.SYS_C007091) violated
INSERT INTO TBLMEMO (seq, name, memo, regdate, priority, category) VALUES (2, '홍길동', '메모입니다.', sysdate, 5, '할일');
-- ORA-02290: check constraint (HR.SYS_C007092) violated
INSERT INTO TBLMEMO (seq, name, memo, regdate, priority, category) VALUES (3, '홍길동', '메모입니다.', sysdate, 1, '개인');





--메모 테이블
DROP TABLE TBLMEMO;

CREATE TABLE tblMemo
(
	seq number(3) PRIMARY key,			--메모번호(PK)
	name varchar2(30) DEFAULT '익명',	--작성자(UQ)
	memo varchar2(1000),				--메모(NN)
	regdate DATE DEFAULT sysdate		--작성날짜
);

SELECT * FROM TBLMEMO;

INSERT INTO TBLMEMO (seq, name, memo, regdate) VALUES (1, '홍길동', '메모입니다.', sysdate);
INSERT INTO TBLMEMO (seq, name, memo, regdate) VALUES (2, null, '메모입니다.', null); --동작(X) > NULL 추가
INSERT INTO TBLMEMO (seq, memo) VALUES (3, '메모입니다.'); --암시적
INSERT INTO TBLMEMO (seq, name, memo, regdate) VALUES (4, default, '메모입니다.', default); -- DEFAULT 상수




----------------------------------------------------------------------------------------------------------

/*
	제약 사항을 만드는 방법
	
	1. 컬럼 수준에서 만드는 방법
		- 위에서 수업한 방법
		- 컬럼을 선언할 때 제약 사항도 같이 선언하는 방법
	
	2. 테이블 수준에서 만드는 방법
	
	3. 외부에서 만드는 방법
	

*/

CREATE TABLE tblMemo
(
	seq number(3) ,			
	name varchar2(30) ,	
	memo varchar2(1000) DEFAULT '메모입니다',				
	
	-- 테이블 수준에서 제약 사항 정의 > 가독성
	CONSTRAINT tblmemo_seq_pk PRIMARY KEY(seq),
	CONSTRAINT tblmemo_name_uq UNIQUE(name),
	CONSTRAINT tblmemo_memo_uq CHECK(LENGTH(memo) >= 10),
);







