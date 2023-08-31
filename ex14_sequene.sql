-- ex14_sequene.sql

/*
	시퀀스, Sequence
	- 데이터베이스 객체 중 하나
	- 오라클 전용 객체(다른 DBMS 제품에는 없음)
	- 일련 번호를 생성하는 객체(***)
	- (주로) 식별자(일련번호)를 만드는데 사용한다 > PK 값으로 사용한다
	
	시퀀스 객체 생성하기
	- create sequence 시퀀스명;
	
	시퀀스 객체 삭제하기
	- drop sequence 시퀀스명;
	
	시퀀스 객체 사용하기(함수)
	- 시퀀스객체.nextVal (***)
	- 시퀀스객체.currVal 

*/

CREATE SEQUENCE seqNum;

SELECT seqNum.nextVal FROM dual; --일련 번호 생성

SELECT * FROM TBLMEMO;

DELETE FROM TBLMEMO;

CREATE SEQUENCE seqmemo;

INSERT INTO TBLMEMO (seq, name, memo, regdate) VALUES (seqMemo.nextVal, '홍길동', '메모입니다.', sysdate);

-- 쇼핑몰 > 상품 번호 > ABC100
SELECT 'A' || seqNum.nextVal FROM dual;


-- nextVal 호출하면 나오게 될 숫자를 반환 > 확인용 
-- Queue, Stack > pop() / peek()
--ORA-08002: sequence SEQNUM.CURRVAL is not yet defined in this session 프로그램 종료 후 다시 실행했을때 발생하는 오류
-- currVal는 최소 1번 이상의 nextVal를 호출해야 사용이 가능하다.
SELECT seqNum.currVal FROM dual;



/*
	시퀀스 객체 생성하기
	
	create sequence 시퀀스명;
	
	create sequence 시퀀스명 
			increment by n 	--증감치
			start with n	--시작값(Seed)
			maxvalue n		--최댓값
			minvalue n		--최솟값
			cycle
			cache n;


*/

DROP SEQUENCE seqTest;

CREATE SEQUENCE seqTest
				--increment BY -1;
				--START WITH 10;
				--MAXVALUE 10
				--CYCLE 
				cache 20;

SELECT seqTest.nextVal FROM dual;


SELECT * FROM tblinsa;


