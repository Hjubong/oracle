-- ex09_numerical_function.sql

/*
	숫자 함수(= 수학 함수)
	- Math.xxxx()
	
	round()
	- 반올림 함수
	- number round(컬럼명): 정수 반환
	- number round(컬럼명, 소수 이하 자릿수): 실수 반환
	
*/


SELECT * FROM dual; --시스템 테이블 > 1행 1열 테이블(***)

-- 현재 시간 필요
SELECT SYSDATE FROM TBLINSA WHERE num = 1001;

SELECT SYSDATE FROM dual;

SELECT 1+1 FROM TBLCOMEDIAN;

SELECT 1+1 FROM dual;


SELECT
	3.5678,
	ROUND(3.5678),
	ROUND(3.5678, 1),
	ROUND(3.5678, 2),
	ROUND(3.5678, 0)
FROM dual;

-- 평균 급여
SELECT AVG(BASICPAY) FROM TBLINSA;


/*
	floor(), truc()
	- 절삭 함수
	- 무조건 내림 함수
	- number floor(컬럼명): 무조건 정수 반환
	- number trunc(컬럼명): 정수 반환
	- number trunc(컬럼명, 소수이하 자릿수): 실수 반환
	
*/

SELECT
	3.5678,
	floor(3.5678),
	trunc(3.5678),
	trunc(3.5678, 1),
	trunc(3.5678, 2),
	trunc(3.5678, 0)
FROM dual;


/*
	ceil()
	- 무조건 올림 함수
	- 천장
	- number ceil(컬럼명)
*/

SELECT
	3.14,
	ceil(3.14)
FROM dual;

-- round(), floor(), ceil()


/*
	mod()
	- 나머지 함수
	- number mod(피제수, 제수)
*/


SELECT
	10 / 3,
	mod(10, 3) AS 나머지, 	-- 정수 % 정수
	floor(10 / 3) AS 몫		-- 정수 / 정수
FROM dual;


SELECT
	ABS(10), ABS(-10),
	POWER(2,2), POWER(2,3), POWER(2,4),
	SQRT(4), SQRT(9), SQRT(16)
FROM dual;