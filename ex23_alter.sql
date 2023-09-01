-- ex23_alter.sql

/*
	DDL > 객체 조작
	- 객체 생성: CREATE
	- 객체 수정: ALTER
	- 객체 삭제: DROP

	DML > 데이터 조작
	- 데이터 생성: INSERT
	- 데이터 수정: UPDATE
	- 데이터 삭제: DELETE
	
	
	테이블 수정하기
	- 테이블 정의 수정 > 스키마 수정 > 컬럼 수정 > 컬럼명 or 자료형(길이) or 제약사항 등
	- 되도록 테이블 수정하는 상황을 발생시켜선 안된다! > 설계를 반드시 완벽~
	
	테이블 수정해야 하는 상황 발생!!
	1. 테이블 삭제(DROP) > 테이블 DDL(CREATE) 수정 > 수정된 DDL로 새롭게 테이블 생성
		a. 기존 테이블에 데이터가 없었을 경우 > 아무 문제 없음
		b. 기존 테이블에 데이터가 있었을 경우 > 미리 데이터 백업 > 테이블 삭제 > 수정된 테이블 다시 생성 > 데이터 복구
		- 개발 중에 사용 가능
		- 공부할 때 사용 가능
		- 서비스 운영 중에는 거의 불가능한 방법
	
	2. alter 명령어 사용 > 기존 테이블의 구조 변경
		a. 기존 테이블에 데이터가 없었을 경우 > 아무 문제 없음
		b. 기존 테이블에 데이터가 있었을 경우 > 경우에 따라 비용 차이
			- 개발 중에 사용 가능
			- 공부할 때 사용 가능
			- 서비스 운영 중에는 경우에 따라 가능
		
*/

DROP TABLE tblEdit;

CREATE TABLE tblEdit(
	seq NUMBER PRIMARY KEY,
	DATA varchar(20) NOT null
);

INSERT INTO tblEdit VALUES (1, '마우스');
INSERT INTO tblEdit VALUES (2, '키보드');
INSERT INTO tblEdit VALUES (3, '모니터');

SELECT * FROM tblEdit;


-- Case 1. 새로운 컬럼을 추가하기
ALTER TABLE tbledit
	add(price number);

-- ORA-01758: table must be empty to add mandatory (NOT NULL) column	
ALTER TABLE tbledit
	add(qty NUMBER NOT null);
	
DELETE FROM TBLEDIT;

INSERT INTO tblEdit VALUES (1, '마우스', 1001, 1);
INSERT INTO tblEdit VALUES (2, '키보드', 2000, 1);
INSERT INTO tblEdit VALUES (3, '모니터', 3000, 2);

ALTER TABLE tbledit
	add(color varchar2(30) DEFAULT 'white' NOT NULL);
	
SELECT * FROM TBLEDIT;


-- Case 2. 컬럼 삭제하기
ALTER TABLE tbledit
	DROP COLUMN color;
	
ALTER TABLE tbledit
	DROP COLUMN qty;
	
ALTER TABLE tbledit
	DROP COLUMN seq; -- PK삭제 > 절대 금지!!!