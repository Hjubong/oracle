-- ex18_groupby.sql

/*
	[WITH <Sub Query>]
    SELECT column_list
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING search_condition]
    [ORDER BY order_expresstion [ASC|DESC]]
	
	select 컬럼리스트		4. 컬럼 지정 (보고 싶은 컬럼만 가져오기) > Projection
	from 테이블				1. 테이블 지정
	where 조건;				2. 조건 지정 (보고 싶은 행만 가져오기) >  Selection
	group by 기준			3. (레코드끼리) 그룹을 나눈다.
	order by 정렬기준;		5. 순서대로
	

*/

-- tblInsa. 부서별 평균 급여?
SELECT * FROM TBLINSA;

SELECT round(AVG(BASICPAY)) FROM TBLINSA; --155만원, 전체 60명

SELECT DISTINCT buseo FROM TBLINSA; -- 7개

SELECT round(AVG(BASICPAY)) FROM TBLINSA WHERE BUSEO = '총무부';
SELECT round(AVG(BASICPAY)) FROM TBLINSA WHERE BUSEO = '개발부';
SELECT round(AVG(BASICPAY)) FROM TBLINSA WHERE BUSEO = '영업부';
SELECT round(AVG(BASICPAY)) FROM TBLINSA WHERE BUSEO = '기획부';
SELECT round(AVG(BASICPAY)) FROM TBLINSA WHERE BUSEO = '인사부';
SELECT round(AVG(BASICPAY)) FROM TBLINSA WHERE BUSEO = '자재부';
SELECT round(AVG(BASICPAY)) FROM TBLINSA WHERE BUSEO = '홍보부';

-- *** group by 목적 > 그룹별 통계값을 구학히 위해서!! > 집계 함수 사용
SELECT 
	count(*) AS "부서별 인원수",
	round(AVG(BASICPAY)) AS "부서별 평균급여",
	sum(BASICPAY) AS "부서별 지급액",
	max(BASICPAY) AS "부서내의 최고 급여",
	min(BASICPAY) AS "부서내의 최저 급여",
	BUSEO
FROM TBLINSA
	GROUP BY BUSEO;
	

SELECT
	COUNT(DECODE(GENDER, 'm', 1)) AS "남자수",
	COUNT(DECODE(GENDER, 'f', 1)) AS "여자수",
FROM TBLCOMEDIAN;


SELECT
	COUNT(*), GENDER
FROM TBLCOMEDIAN
 	GROUP BY GENDER;
 	
 
SELECT
	JIKWI,
	count(*)
FROM TBLINSA
	GROUP BY JIKWI;
	

SELECT
	GENDER,
	max(HEIGHT),
	MIN(HEIGHT),
	MAX(WEIGHT),
	MIN(WEIGHT),
	AVG(WEIGHT),
	AVG(HEIGHT)
FROM TBLCOMEDIAN
	GROUP BY GENDER;
	
-- ORA-00979: not a GROUP BY expression
-- group by 사용시 > select 컬럼리스트 > 일반 컬럼 명시 불가능 > 집계 함수 + 그룹컬럼
SELECT
	count(*), name
FROM TBLINSA
	GROUP BY BUSEO;
	

-- 다중 그룹
SELECT
	buseo,
	JIKWI,
	count(*)
FROM TBLINSA
	GROUP BY buseo, JIKWI
		ORDER BY buseo, JIKWI;
		
	
-- 급여별 그룹
-- 100만원 이하
-- 100만원 ~ 200만원
-- 200만원 이상
SELECT
	BASICPAY,
	count(*)
FROM TBLINSA
	GROUP BY BASICPAY;
	

SELECT
	BASICPAY,
	floor(BASICPAY / 1000000)
FROM TBLINSA
	

SELECT
	(floor(BASICPAY / 1000000) + 1) * 100 || '만원 이하' AS money,
	count(*)
FROM TBLINSA 
	GROUP BY floor(BASICPAY / 1000000);
	

-- tblinsa. 남자/여자 직원수?
SELECT
	substr(SSN, 8, 1),
	count(*)
FROM TBLINSA
	GROUP BY substr(SSN, 8, 1);
	


SELECT
	count(CASE
		WHEN COMPLETEDATE IS NOT NULL THEN 1
	END),
	count(CASE
		WHEN COMPLETEDATE IS NULL THEN 1
	END)
FROM TBLTODO



SELECT
	CASE
		WHEN COMPLETEDATE IS NOT NULL THEN '미완료'
		ELSE '완료'
	END,
	COUNT(*)
FROM TBLTODO
	GROUP BY CASE
		WHEN COMPLETEDATE IS NOT NULL THEN '미완료'
		ELSE '완료'
	END;
	


/*
	[WITH <Sub Query>]
    SELECT column_list
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING search_condition]
    [ORDER BY order_expresstion [ASC|DESC]]
	
	select 컬럼리스트			5. 컬럼 지정 
	from 테이블				1. 테이블 지정
	where 조건;				2. 조건 지정 (레코드에 대한 조건 - 개인 조건 > 컬럼) 
	group by 기준			3. (레코드끼리) 그룹을 나눈다.
	having 조건				4. 조건 지정(그룹에 대한 조건 - 그룹 조건 > 집계 함수)
	order by 정렬기준;		6. 순서대로

*/


SELECT 
	COUNT(*)
FROM TBLINSA
	WHERE BASICPAY >= 1500000;


SELECT							--4. 각 그룹별 > 집계 함수
	buseo,
	ROUND(AVG(BASICPAY))		
FROM TBLINSA					--1. 60명의 데이터를 가져온다
	WHERE BASICPAY >= 1500000	--2. 60명을 대상으로 조건을 검사한다.
		GROUP BY BUSEO;			--3. 2번을 통과한 사람들(27명) 대상으로 그룹을 짓는다.
		

SELECT
	buseo,
	ROUND(AVG(BASICPAY))					
FROM TBLINSA								-- 1. 60명
	GROUP BY BUSEO							-- 2. 60명 > 그룹
		HAVING AVG(BASICPAY) >= 1500000;	-- 3. 집합에 대한 조건 > 집계 함수 조건
		
		
		
		
-- 부서의 인원수가 10명이 넘는 결과
SELECT
	BUSEO,
	COUNT(*)
FROM TBLINSA
	GROUP BY BUSEO
		HAVING count(*) >= 10;
	
	

-- 부서의 과장/부장(where) 인원수가 3명이 넘는(having) 결과	
SELECT
	BUSEO,
	COUNT(*)
FROM TBLINSA
	WHERE JIKWI IN ('과장', '부장')
		GROUP BY BUSEO
			HAVING COUNT(*) >= 3;
		
		

-- job_id 그룹 > 통계		
SELECT 
	JOB_ID,
	COUNT(*) AS 인원수,
	ROUND(AVG(SALARY)) AS 평균급여
FROM EMPLOYEES
	GROUP BY JOB_ID; 
	


--시도별 인원수?
SELECT * FROM TBLADDRESSBOOK;

-- substr(컬럼, 시작위치, 문자개수)
SELECT substr(address, 1, instr(address, ' ') -1) FROM TBLADDRESSBOOK;


SELECT
	SUBSTR(ADDRESS, 1, INSTR(ADDRESS, ' ') -1) AS 시도,
	COUNT(*) AS 인원수
FROM TBLADDRESSBOOK
	GROUP BY substr(ADDRESS, 1, INSTR(ADDRESS, ' ') -1)
		ORDER BY 인원수 DESC;
		
	
	
-- 부서별 / 직급별 인원수를 가져오시오.
/*
 	[부서명]		[총인원]		[부장]		[과장]		[대리]		[사원]
 	기획부		6			1			1			2			2
 
 */
	
SELECT
	BUSEO AS 부서명,
	COUNT(*) AS 총인원,
	COUNT(DECODE(JIKWI, '부장', 1)) AS 부장,
	COUNT(DECODE(JIKWI, '과장', 1)) AS 과장,
	COUNT(DECODE(JIKWI, '대리', 1)) AS 대리,
	COUNT(DECODE(JIKWI, '사원', 1)) AS 사원
FROM TBLINSA
	GROUP BY BUSEO 
	
	
	
SELECT
	BUSEO,
	JIKWI,
	COUNT(*)
FROM TBLINSA
	GROUP BY BUSEO, JIKWI
		ORDER BY BUSEO, JIKWI;
		
	
	
	
	
/*
	rollup()
	- group by의 집계 결과를 좀 더 자세하게 반환
	- 그룹별 중간 통계
	
*/
	

SELECT
	BUSEO,
	COUNT(*),
	SUM(BASICPAY),
	ROUND(AVG(BASICPAY)),
	MAX(BASICPAY),
	MIN(BASICPAY)
FROM TBLINSA
	GROUP BY ROLLUP(BUSEO);
	
	
	
	
	
SELECT
	BUSEO,
	JIKWI,
	COUNT(*),
	SUM(BASICPAY),
	ROUND(AVG(BASICPAY)),
	MAX(BASICPAY),
	MIN(BASICPAY)
FROM TBLINSA
	GROUP BY ROLLUP(BUSEO, JIKWI);	
	
	
		
/*
 	cube()
 	- group by의 집계 결과를 좀 더 자세하게 반환
 	- 그룹별 중간 통계
 
 */	


SELECT
	BUSEO,
	COUNT(*),
	SUM(BASICPAY),
	ROUND(AVG(BASICPAY)),
	MAX(BASICPAY),
	MIN(BASICPAY)
FROM TBLINSA
	GROUP BY cube(BUSEO);
	
	
	
	
	
SELECT
	BUSEO,
	JIKWI,
	COUNT(*),
	SUM(BASICPAY),
	ROUND(AVG(BASICPAY)),
	MAX(BASICPAY),
	MIN(BASICPAY)
FROM TBLINSA
	GROUP BY cube(BUSEO, JIKWI);	



-- rollup > 다중 그룹 컬럼 > 수직관계(전체인원 총계, 부서별 총계)
-- cube > 다중 그룹 컬럼 > 수평관계(전체인원 총계, 부서별 총계, 직위별 총계)
	
	
	