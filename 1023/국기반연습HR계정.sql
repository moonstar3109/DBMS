/*
프로시저명 -salesProc
sales테이블은 오늘의 판매내역이다.
day_of_sales테이블은 판매내역 마감시 오늘 일자의 총매출을 기록하는 테이블이다.
조건)day_of_sales의 마감내역이 이미 존재하면 업데이트 처리

*/

set SERVEROUTPUT on;
--매출내역
create table sales(
    sbo number(5),
    name varchar2(30),
    total number(10),
    price number(10),
    regdate date default sysdate
    );
    
    
--마감내역
create table day_of_sales(
    regdate date,
    final_total number(10)
);
insert into sales values(5 ,'아아',1,1000,sysdate-1);

create or replace procedure salesProc(
    p_regdate sales.regdate%type

) is
    v_check number := 0;
    v_final_total number := 0; --최종매출내역
begin 
    select sum(total*price) as v_final_total
    into v_final_total
    from sales
    where to_char(regdate,'YY/MM/DD') = to_char(p_regdate,'YY/MM/DD');
    
    --존재확인
    select count(*)
    into v_check
    from day_of_sales
    where to_char(regdate,'YY/MM/DD') = to_char(p_regdate,'YY/MM/DD');
    
    --day_of_sales에 존재 안함
    if v_check = 0 then
     insert into day_of_sales (regdate,final_total)
     values (p_regdate,v_final_total);
     else
     update day_of_sales set final_total = v_final_total
     where to_char(regdate,'YY/MM/DD') = to_char(p_regdate,'YY/MM/DD');
     
     end if;
    
    commit;
    DBMS_OUTPUT.PUT_LINE('당일 매출합계: '||v_final_total);
end;
EXECUTE salesProc(sysdate);
EXECUTE salesProc(sysdate-1);
select * from day_of_sales;


select * 
from employees e
left outer join department d
where e.department_id = d.department_id; 

desc employees;

select * from employees where employee_id = 100;