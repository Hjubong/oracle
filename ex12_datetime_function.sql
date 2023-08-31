-- ex12_datetime_function.sql

/*
	날짜 시간 함수
	
	sysdate
	- 현재 시스템의 시각을 반환
	- Calendar.getInstance()
	- date sysdate
	
*/

SELECT SYSDATE() FROM dual;


/*
	날짜 연산
	1. 시각 - 시각 = 시간
	2. 시각 + 시간 = 시각
	3. 시각 - 시각 = 시각
	
*/

-- 1. 시각 - 시각 = 시간(일)
SELECT
	name,
	IBSADATE,
	round(sysdate - IBSADATE) AS 근무일수,
	round((SYSDATE - IBSADATE) / 365) AS 근무년수, -- 사용금지
	round((SYSDATE - IBSADATE) * 24) AS 근무시수,
	round((SYSDATE - IBSADATE) * 24 * 60) AS 근무분수,
	round((SYSDATE - IBSADATE) * 24 * 60 * 60) AS 근무초수
FROM TBLINSA;

-- 오라클 > 식별자 최대 길이 > 30바이트(UTF-8)
-- ORA-00972: identifier is too long
SELECT
	TITLE,
	ADDDATE,
	COMPLETEDATE,
	round((COMPLETEDATE - ADDDATE) * 24) AS 실행하기까지걸린시간
FROM TBLTODO
	WHERE COMPLETEDATE IS NOT null
 	ORDER BY round((COMPLETEDATE - ADDDATE) * 24) desc;


-- 2. 시각 + 시간(일) = 시각
-- 3. 시각 - 시각(일) = 시각
SELECT
	sysdate,
	sysdate + 100 AS "100일뒤",
	sysdate - 100 AS "100일전",
	sysdate + (3/ 24) AS "3시간 후",
	sysdate - (5/ 24) AS "5시간 전",
	sysdate + (30 / 60 / 24) AS "30분 뒤"
FROM dual;


/*
	시각 - 시각 = 시간(일) > 일 > 시 > 분 > 초 환산 가능
						  > 일 > 월 > 년 환산 불가능
						  
	시각 + 시간(일) = 시각 > 일, 시 ,분, 초 가능
						  > 월, 년 불가능
*/

SELECT sysdate + 3 * 30 FROM dual;


/*
	month_between()
	- number months_between(date, date)
	- 시각 - 시각 = 시간(월)

 */

SELECT
	name,
	round(sysdate - IBSADATE) AS "근무일수",
	round((sysdate - IBSADATE) / 30) AS "근무월수",
	round(months_between(sysdate, IBSADATE)) AS "근무월수",
	round(months_between(sysdate, IBSADATE)/12) AS "근무년수"
FROM TBLINSA;


/*
	add_months()
	- date add_months(date, 시간)
	- 시각 + 시간(일) = 시각
*/

SELECT
	SYSDATE,
	ADD_MONTHS(SYSDATE, 3),
	ADD_MONTHS(SYSDATE, -2),
	ADD_MONTHS(SYSDATE, 5*12)
FROM dual;


/*
	시각 - 시각
	1. 일, 시, 분, 초 > 연산자(-)
	2. 월, 년 > months_between()
	
	시각 +- 시간
	1. 일, 시, 분, 초 > 연산자(+,-)
	2. 월, 년 > add_months()
	
*/


SELECT 
	sysdate,
	LAST_DAY(SYSDATE) --해당 날짜 포함된 마지막 날짜 반환(해당월이 며칠까지?)
FROM dual;