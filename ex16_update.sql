-- ex16_update.sql


/*
	UPDATE
	- DML
	- 원하는 행의 원하는 컬럼값을 수정하는 명렁어
	
	UPDATE 구문
	- update 테이블명 set 컬럼명 = 값 [, 컬럼명 = 값] X N [where 절]

*/

-- 트랜잭션 처리

COMMIT;
ROLLBACK;

SELECT * FROM TBLCOUNTRY;

-- 대한민국: 서울 > 세종
UPDATE TBLCOUNTRY SET CAPITAL = '세종'

UPDATE TBLCOUNTRY SET CAPITAL = '세종' WHERE NAME = '대한민국';

UPDATE TBLCOUNTRY SET 
			CAPITAL = '세종', 
			POPULATION = POPULATION + 100,
			CONTINENT = 'EU'
			WHERE NAME = '대한민국';
			
