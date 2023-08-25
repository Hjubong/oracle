-- ex04_operator.sql

/*
    연산자, Operator
    
    1. 산술 연산자
    - +, -, *, /
    - % (없음) > 함수로 제공(mod())
    
    2. 
    



*/

select 
    population,
    area,
    population + area,
    population - area,
    population * area,
    population / area
from tblcountry;