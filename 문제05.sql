-- 문제05.sql


-- 정렬


-- employees
-- 1. 전체 이름(first_name + last_name)이 가장 긴 -> 짧은 사람 순으로 정렬해서 가져오기
--    > 컬럼 리스트 > fullname(first_name + last_name), length(fullname)
SELECT FIRST_NAME||LAST_NAME, length(FIRST_NAME||LAST_NAME) AS "length(fullname)"
FROM EMPLOYEES
	ORDER BY "length(fullname)" desc;

-- 2. 전체 이름(first_name + last_name)이 가장 긴 사람은 몇글자? 가장 짧은 사람은 몇글자? 평균 몇글자?
--    > 컬럼 리스트 > 숫자 3개 컬럼
SELECT MAX(length(FIRST_NAME||LAST_NAME)),
Min(length(FIRST_NAME||LAST_NAME)),
avg(length(FIRST_NAME||LAST_NAME))
FROM EMPLOYEES
	

-- 3. last_name이 4자인 사람들의 first_name을 가져오기
--    > 컬럼 리스트 > first_name, last_name
--    > 정렬(first_name, 오름차순)
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
	WHERE LENGTH(LAST_NAME) = 4
	ORDER BY FIRST_NAME asc;


-- decode

-- 4. tblInsa. 부장 몇명? 과장 몇명? 대리 몇명? 사원 몇명?
SELECT 
count(decode(JIKWI, '부장', 1)),
count(decode(JIKWI, '과장', 1)),
count(decode(JIKWI, '대리', 1)),
count(decode(JIKWI, '사원', 1))
FROM TBLINSA

-- 5. tblInsa. 간부(부장, 과장) 몇명? 사원(대리, 사원) 몇명?
SELECT 
count(decode(JIKWI, '부장', 1)) + count(decode(JIKWI, '과장', 1)),
count(decode(JIKWI, '대리', 1)) + count(decode(JIKWI, '사원', 1))
FROM TBLINSA


-- 6. tblInsa. 기획부, 영업부, 총무부, 개발부의 각각 평균 급여?
SELECT 
AVG(CASE
	WHEN BUSEO IN ('기획부') THEN BASICPAY
END),
avg(CASE
	WHEN BUSEO IN ('영업부') THEN BASICPAY
END),
avg(CASE
	WHEN BUSEO IN ('총무부') THEN BASICPAY
END),
avg(CASE
	WHEN BUSEO IN ('개발부') THEN BASICPAY
END)
FROM TBLINSA

-- 7. tblInsa. 남자 직원 가장 나이가 많은 사람이 몇년도 태생? 여자 직원 가장 나이가 어린 사람이 몇년도 태생?
SELECT
min(CASE
	WHEN ssn LIKE '%-1%' THEN to_number(substr (ssn,1,2))
END) AS 남자고참,
max(CASE
	WHEN ssn LIKE '%-2%' THEN to_number(substr (ssn,1,2))
END) AS 여자막내
FROM TBLINSA












