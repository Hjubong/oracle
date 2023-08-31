-- ex10_string_function.sql

/*
	문자열 함수
	
	대소문자 변환
	- upper(), lower(), initcap()
	- varchar2 upper(컬럼)
	- varchar2 lower(컬럼)
	- varchar2 initcap(컬럼)
*/


SELECT 
	first_name,
	UPPER(FIRST_NAME),
	LOWER(FIRST_NAME)
FROM EMPLOYEES;


SELECT
	'abc',
	INITCAP('abc'), -- 첫문자를 대문자로
	INITCAP('aBC') 
FROM dual;


-- 이름(first_name)에 'an' 포함된 직원 > 대소문자 구분없이
SELECT
	FIRST_NAME
FROM EMPLOYEES
	WHERE FIRST_NAME LIKE '%an%' OR FIRST_NAME LIKE '%AN%' 
		OR FIRST_NAME LIKE '%An%' OR FIRST_NAME LIKE '%aN%'; --Anna

		
SELECT
	FIRST_NAME
FROM EMPLOYEES
	WHERE lower(FIRST_NAME) LIKE '%an%';
	

/*
	문자열 추출 함수
	- subtr() > substring()
	- varchar2 substr(컬럼, 시작위치, 가져올 문자 개수)
	- varchar2 substr(컬럼, 시작위치)
*/


SELECT
	ADDRESS,
	SUBSTR(ADDRESS, 3, 5),
	SUBSTR(ADDRESS, 3)
FROM TBLADDRESSBOOK


SELECT
	name,
	SSN,
	SUBSTR(ssn,1, 2) AS 생년,
	SUBSTR(ssn,3, 2) AS 생월,
	SUBSTR(ssn,5, 2) AS 생일,
	SUBSTR(ssn,8, 1) AS 성별
FROM TBLINSA;


-- tblInsa > 김, 이, 박, 최, 정 > 각각 몇명?

SELECT COUNT(*) FROM TBLINSA WHERE SUBSTR(name, 1, 1) = '김';

SELECT
	count(CASE
		WHEN substr(name, 1, 1) = '김' THEN 1
	END) AS 김,
	count(CASE
		WHEN substr(name, 1, 1) = '이' THEN 1
	END) AS 이,
	count(CASE
		WHEN substr(name, 1, 1) = '박' THEN 1
	END) AS 박,
	count(CASE
		WHEN substr(name, 1, 1) = '최' THEN 1
	END) AS 최,
	count(CASE
		WHEN substr(name, 1, 1) = '정' THEN 1
	END) AS 정,
	count(CASE
		WHEN substr(name,1,1) NOT IN ('김', '이','박','최','정') THEN 1
	END) AS 나머지
FROM TBLINSA;


/*
	문자열 길이
	-length()
	- number length(컬럼)
*/

-- 컬럼 리스트에서 사용
SELECT name, LENGTH(name) FROM TBLCOUNTRY;

-- 조건절에서 사용
SELECT name, LENGTH(name) FROM TBLCOUNTRY WHERE LENGTH(name) > 3;

SELECT name, LENGTH(name) AS leng FROM TBLCOUNTRY WHERE leng > 3; --FROM WHERE SELECT 순으로 실행되기때문에 as로 부르면 X
SELECT name, LENGTH(name) AS leng FROM TBLCOUNTRY ORDER BY leng asc; --FROM SELECT order by 순으로 실행되기때문에 as로 부르면 O

-- 정렬에서 사용
SELECT name, LENGTH(name) FROM TBLCOUNTRY ORDER BY LENGTH(name) DESC;


/*
	문자열 검색(indexOf)
	- instr()
	- 검색어의 위치 반환
	- number instr(컬럼, 검색어)
	- number instr(컬럼, 검색어, 시작위치)
	- number instr(컬럼, 검색어, 시작위치, -1) //lastIndexOf
	- 못찾으면 0을 반환
*/

SELECT
	'안녕하세요. 홍길동님.',
	INSTR('안녕하세요. 홍길동님.', '홍길동') AS r1,
	INSTR('안녕하세요. 홍길동님.', '아무개') AS r2,
	INSTR('안녕하세요. 홍길동님. 홍길동님', '홍길동') AS r3,
	INSTR('안녕하세요. 홍길동님. 홍길동님', '홍길동', 11) AS r4
FROM dual;


/*
	패딩
	- lpad(), rpad()
	- left padding, right padding
	- varchar2 lpad(컬럼, 개수, 문자)
	- varchar2 rpad(컬럼, 개수, 문자)
	
*/

SELECT
	lpad('a', 5), --%5s
	lpad('a', 5, 'b'),
	lpad('aa', 5, 'b'),
	lpad('aaa', 5, 'b'),
	lpad('aaaa', 5, 'b'),
	lpad('1', 3, '0'),
	rpad('1', 3, '0')
FROM dual;


/*
	공백 제거
	-trim(), ltrim(), rtrim()
	- varchar2 trim(컬럼)
	- varchar2 ltrim(컬럼)
	- varchar2 rtrim(컬럼)
*/

SELECT
	'     하나     둘     셋     ',
	trim('     하나     둘     셋     '),
	ltrim('     하나     둘     셋     '),
	rtrim('     하나     둘     셋     ')
FROM dual;


/*
	문자열 치환
	- replace()
	- varchar2 replace(컬럼, 찾을 문자열, 바꿀 문자열)
	
*/

SELECT
	replace('홍길동', '홍', '김'),
	replace('홍길동', '이', '김'),
	replace('홍길동', '홍', '김')
FROM dual;

SELECT
	NAME,
	regexp_REPLACE(name, '김.{2}', '김OO')
	tel,
	regexp_replace(tel, '(\d{3})-(\d{4})-\d{4}', '\1-\2-XXXX')
FROM TBLINSA;


/*
	문자열 치환
	- decode()
	- replace()와 유사
	- varchar2 decode(컬럼, 찾을 문자열, 바꿀 문자열,[찾을 문자열, 바꿀 문자열] x N)

*/


-- tblComedian. 성별 > 남자, 여자
SELECT
 	GENDER,
 	CASE
 		WHEN gender = 'm' THEN '남자'
 		WHEN gender = 'f' THEN '여자'
 	END AS g1,
 	REPLACE(replace(gender, 'm', '남자'), 'f', '여자') AS g2,
 	DECODE(gender, 'm', '남자'
 	) AS g3
FROM TBLCOMEDIAN;


-- tblComedian. 남자수? 여자수?
SELECT
	count(CASE
		WHEN GENDER = 'm' THEN 1
	END) AS m1,
	count(CASE
		WHEN GENDER = 'f' THEN 1
	END) AS f1,
	count(DECODE(gender, 'm', 1)) AS m2,
	count(DECODE(gender, 'f', 1)) AS f2
FROM TBLCOMEDIAN;

