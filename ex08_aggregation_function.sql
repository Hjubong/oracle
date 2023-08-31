-- ex08_aggregation_function.sql

/*
	함수, function
	1. 내장 함수(Built-in function)
	2. 사용자 정의 함수(User Function) > ANSI-SQL(X), PL/SQL(O)
	
	
	집계 함수, Aggregation Function(****************)
	- 아주 쉬움 > 뒤에 나오는 수업과 결합 > 꽤 어려움;;
	1. count()
	2. sum()
	3. avg()
	4. max()
	5. min()
	
	1. count()
	- 결과 테이블의 레코드 수를 반환한다
	- number count(컬럼명)
	- null 값은 카운트에서 제외된다.(***********)
*/


-- tblCountry. 총 나라 몇개국?
SELECT count(*) FROM TBLCOUNTRY;			--14(모든 레코드, 일부 컬럼의 null 무관)
SELECT count(name) FROM TBLCOUNTRY;			--14
SELECT count(POPULATION) FROM TBLCOUNTRY;	--13


-- 모든 직원수?
SELECT COUNT(*) FROM TBLINSA; --60

-- 연락처가 있는 직원 수?
SELECT COUNT(TEL) FROM TBLINSA; --57

-- 연락처가 없는 직원 수?
SELECT COUNT(*) - COUNT(tel) FROM TBLINSA; --3

SELECT COUNT(*) FROM TBLINSA WHERE tel IS NOT NULL; --57
SELECT COUNT(*) FROM TBLINSA WHERE tel IS NULL; --3


-- tblInsa. 어떤 부서들 있나요?
SELECT DISTINCT buseo FROM TBLINSA;

-- tblInsa. 부서가 총 몇개?
SELECT count(DISTINCT buseo) FROM TBLINSA;


-- tblComdian. 남자수? 여자수?
SELECT * FROM TBLCOMEDIAN;

SELECT count(*) FROM TBLCOMEDIAN WHERE GENDER ='m';
SELECT count(*) FROM TBLCOMEDIAN WHERE GENDER ='f';

-- 남자수 + 여자수 > 1개의 테이블로 가져오시오
SELECT 
 	count(CASE
 		WHEN GENDER = 'm' THEN 1
 	END) AS 남자인원수,
 	count(CASE
 		WHEN GENDER = 'f' THEN 1
 	END) AS 여자인원수
FROM TBLCOMEDIAN;


-- tblInsa. 기획부 몇명? 총무부 몇명? 개발부 몇명? 총인원? 나머지부서 몇명?
SELECT COUNT(*) FROM TBLINSA WHERE BUSEO ='기획부' --7
SELECT COUNT(*) FROM TBLINSA WHERE BUSEO ='총무부' --7
SELECT COUNT(*) FROM TBLINSA WHERE BUSEO ='개발부' --14

SELECT 
	count(CASE
		WHEN BUSEO = '기획부' THEN 'O'
	END) AS 기획부,
	count(CASE
		WHEN BUSEO = '총무부' THEN 'O'
	END) AS 총무부,
	count(CASE
		WHEN BUSEO = '개발부' THEN 'O'
	END) AS 개발부,
	count(*) AS 전체인원수,
	count(
		CASE
			WHEN BUSEO NOT IN ('기획부',' 총무부', '개발부')THEN 'O'
		END
	) AS 나머지
FROM TBLINSA;


/*
	2. sum()
	- 해당 컬럼의 합을 구한다
	- number sum(컬럼명)
	- 해당 컬럼 > 숫자형 
*/

SELECT * FROM TBLCOMEDIAN;
SELECT SUM(height), SUM(weight) FROM TBLCOMEDIAN;
SELECT SUM(first)FROM TBLCOMEDIAN;-- ORA-01722: invalid NUMBER

SELECT
	SUM(BASICPAY) AS "지출 급여 합",
	SUM(SUDANG) AS "지출 수당 합",
	SUM(BASICPAY) + SUM(SUDANG) AS "총 지출",
	SUM(BASICPAY + SUDANG) AS "총 지출"
FROM TBLINSA;

SELECT SUM(*) FROM TBLINSA;


/*
	3. avg()
	- 해당 컬럼의 평균값을 구한다
	- number avg(컬럼명)
	- 숫자형만 적용 가능
*/


--tblInsa. 평균 급여?
SELECT sum(basicpay) / 60 FROM TBLINSA;
SELECT sum(basicpay) / COUNT(*) FROM TBLINSA; -- 전체 행으로 나눔
SELECT AVG(basicpay) FROM TBLINSA;


--tblCountry, 평균 인구수?
SELECT AVG(POPULATION) FROM TBLCOUNTRY;
SELECT SUM(POPULATION) / COUNT(*) FROM TBLCOUNTRY;
SELECT SUM(POPULATION) / COUNT(POPULATION) FROM TBLCOUNTRY;
SELECT COUNT(POPULATION), COUNT(*) FROM TBLCOUNTRY;


-- 회사 > 성과급 지급 > 출처 > 1팀 공로~
-- 1. 균등 지급: 총지급액 / 모든 직원 수 = sum() / count(*)
-- 2. 차등 지급: 총지급액 / 1팀 직원 수 = sum() / count(1팀) = avg()

SELECT AVG(name) FROM TBLINSA;
SELECT AVG(IBSADATE) FROM TBLINSA;


/*
	4. max()
	- object max(컬럼명)
	- 최댓값 반환
	
	5. min()
	- object min(컬럼명)
	- 최솟값 반환
	
	- 숫자형, 문자형, 날짜형 모두 적용 가능
*/

SELECT MAX(SUDANG), MIN(SUDANG)FROM TBLINSA; 		--숫자형
SELECT MAX(NAME), MIN(NAME)FROM TBLINSA; 			--문자형
SELECT MAX(IBSADATE), MIN(IBSADATE)FROM TBLINSA; 	--날짜형

SELECT
	COUNT(*) AS 직원수,
	SUM(BASICPAY) AS 총급여합,
	AVG(BASICPAY) AS 평균급여,
	MAX(BASICPAY) AS 최고급여,
	MIN(BASICPAY) AS 최저급여
FROM TBLINSA;


-- 집계 함수 사용 주의점!!

-- 1. ORA-00937: not a single-group group function
-- 컬럼 리스트에서는 집계 함수와 일반 컬럼을 동시에 사용할 수 없다. 

SELECT COUNT(*) FROM TBLINSA; 	--직원수
SELECT NAME FROM TBLINSA; 		--직원명

-- 요구사항] 직원들 이름과 총 직원수를 동시에 가져오시오.
SELECT COUNT(*), NAME FROM TBLINSA; 

-- 2. ORA-00934: group function is not allowed here
-- where절에는 집계 함수를 사용할 수 없다.
-- 집계 함수(집합), 컬럼(개인)
-- where절 > 개개인(레코드)의 데이터를 접근해서 조건 검색 > 집합값 호출 불가능

-- 요구사항] 평균 급여보다 더 많이 받는 직원들?
SELECT AVG(basicpay) FROM TBLINSA;

SELECT * FROM TBLINSA WHERE BASICPAY >= 1556526;
SELECT * FROM TBLINSA WHERE BASICPAY >= AVG(BASICPAY);