-- ex04_operator.sql

/*
    연산자, Operator
    
    1. 산술 연산자
    - +, -, *, /
    - % (없음) > 함수로 제공(mod())
    
    2. 문자열 연산자(concat)
    - +(X) > ||(O)
    
    3. 비교 연산자
    - >, >=, <, <=
    - =(==), <>(!=)
	- 논리값 반환 > SQL에는 boolean이 없다 > 명시적으로 표현 불가능 > 조건이 필요한 상황에서 내부적으로 사용

	4. 논리 연산자
	- and(&&), or(||), not(!)
	- 논리값 반환
	- 컬럼 리스트에서 사용 불가
	- 조건절에서 사용
	
	5. 대입 연산자
	- =
	- 컬럼 = 값
	- update 문
	
	6. 3항 연산자
	- 없음
	- 제어문 없음
	
	7. 증감 연산자
	- 없음
	
	8. SQL 연산자
	- 자바 연산자 > instanceof, typeof 등..
	- in, between, like, is 등..(OO절, OO구..)

*/

select 
    population,
    area,
    population + area,
    population - area,
    population * area,
    population / area
from tblcountry;


--ORA-01722: invalid number
SELECT name, couple, name + couple FROM tblmen;
SELECT name, couple, name || couple FROM tblmen;

SELECT height, weight, height > weight FROM tblmen ;

SELECT height, weight FROM tblmen WHERE height > weight;


SELECT name, age FROM tblmen; -- 이전 나이(한국식)

-- 컬럼의 별칭(Alias)
-- : 되도록 가공된 컬럼에 적용
-- : 함수 결과에 적용
-- : *** 컬럼명이 식별자로 적합하지 않을 때 사용 > 적합한 식별자로 수정
-- : 식별자로 사용 불가능 상황 > 억지로 적용할 때
SELECT 
	name AS 이름,
	age,
	age - 1 AS 나이,
	length(name) AS 길이,
	couple AS "여자 친구" -- 띄어쓰기하면 오류남 but ""을 사용하면 가능
	name AS "SELECT" -- 명령어도 ""사용하면 가능
FROM tblmen; -- 컬럼명(***)


-- 테이블 별칭(Alias)
-- : 편하게 하기 위해 + 가독성 향상
SELECT * FROM tblmen t;

SELECT hr.tblmen.name, hr.tblmen.age, hr.tblmen.height, hr.tblmen.weight, hr.tblmen.couple FROM hr.tblMen;

SELECT tblmen.name, hr.tblmen.age, hr.tblmen.height, hr.tblmen.weight, hr.tblmen.couple FROM tblMen;

-- 각 절의 실행 순서
-- 1. from 절
-- 2. select 절 


SELECT m.name, m.age, m.height, m.weight, m.couple FROM tblMen m;
