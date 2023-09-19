-- ex32_index.sql

/*
	인덱스, Index
	- 검색을 빠른 속도로 하기 위해 사용하는 도구
	- SQL 명령 처리 속도를 빠르게 하기 위해서, 특정 컬럼에 대해 생성되는 도구
	- 책 > 목차 / 인덱스(찾아보기)
	
	데이터베이스
	- 테이블내의 레코드 순서가 사용자 원하는 정렬 상태가 아니다 > DBMS가 자체적 정렬 보관
	- 어떤 데이터 검색 > 처음 ~ 끝까지 차례대로 검색 > table full scan
	- 특정 컬럼 선택 > 별도의 테이블에 복사 > 미리 정렬 >> 인덱스
	- 원본 테이블 <- 참조 -> 인덱스
	
	인덱스의 장단점
	- 처리 속도를 향상 시킨다
	- 무분별한 인덱스 사용은 DB 성능을 저하시킨다
	
	자동으로 인덱스가 걸리는 컬럼
	1. Primary key
	2. Unique
	- ** 테이블에서 PK 컬럼을 검색하는 속도 >>> 테이블에서 PK아닌 컬럼을 검색하는 속도

*/

CREATE TABLE tblIndex
AS
SELECT * FROM tbladdressbook; --2,000


SELECT count(*) FROM tblindex; --2,000

INSERT INTO tblindex SELECT * FROM tblIndex;


SELECT * FROM tbladdressbook; --seq(PK)
SELECT * FROM tblIndex; --제약사항(X), 없음(PK)

-- SQL 실행
-- 1. Ctrl + Enter 	> 결과 > 테이블
-- 2. F5			> 결과 > 텍스트

-- 인덱스없이 검색 > 경과시간: 00:00:03.422
SELECT count(*) FROM tblindex WHERE name = '최민기';

-- 인덱스 생성
CREATE INDEX idxName
	ON tblIndex(name);
	
-- 인덱스 검색 > 경과 시간: 00:00:00.078
SELECT count(*) FROM tblIndex WHERE name = '최민기';


/*
	인덱스 종류
	1. 고유 인덱스
	2. 비고유 인덱스
	3. 단일 인덱스
	4. 복합 인덱스
	5. 함수 기반 인덱스
*/

-- 고유 인덱스
-- : 색인의 값이 중복이 불가능하다
-- : PK, UNIQUE
CREATE UNIQUE INDEX idxName2 ON tblIndex(name); -- 동명이인(X)
CREATE UNIQUE INDEX idxContinent ON tblcountry(continent);

-- 비고유 인덱스
-- : 색인의 값이 중복이 가능하다
-- : 일반 컬럼
CREATE INDEX idxHometown ON tblIndex(hometown);

-- 단일 인덱스
-- : 컬럼 1개를 대상으로 만드는 인덱스
CREATE INDEX idxHometown ON tblIndex(hometown);
DROP INDEX idxHometown;

SELECT count(*) FROM tblindex WHERE hometown = '서울'; -- 경과시간: 00:00:00.094

SELECT count(*) FROM tblindex WHERE hometown = '서울' AND job = '학생';

SELECT * FROM tbladdressbook;