/*
���ν����� -salesProc
sales���̺��� ������ �Ǹų����̴�.
day_of_sales���̺��� �Ǹų��� ������ ���� ������ �Ѹ����� ����ϴ� ���̺��̴�.
����)day_of_sales�� ���������� �̹� �����ϸ� ������Ʈ ó��

*/

set SERVEROUTPUT on;
--���⳻��
create table sales(
    sbo number(5),
    name varchar2(30),
    total number(10),
    price number(10),
    regdate date default sysdate
    );
    
    
--��������
create table day_of_sales(
    regdate date,
    final_total number(10)
);
insert into sales values(5 ,'�ƾ�',1,1000,sysdate-1);

create or replace procedure salesProc(
    p_regdate sales.regdate%type

) is
    v_check number := 0;
    v_final_total number := 0; --�������⳻��
begin 
    select sum(total*price) as v_final_total
    into v_final_total
    from sales
    where to_char(regdate,'YY/MM/DD') = to_char(p_regdate,'YY/MM/DD');
    
    --����Ȯ��
    select count(*)
    into v_check
    from day_of_sales
    where to_char(regdate,'YY/MM/DD') = to_char(p_regdate,'YY/MM/DD');
    
    --day_of_sales�� ���� ����
    if v_check = 0 then
     insert into day_of_sales (regdate,final_total)
     values (p_regdate,v_final_total);
     else
     update day_of_sales set final_total = v_final_total
     where to_char(regdate,'YY/MM/DD') = to_char(p_regdate,'YY/MM/DD');
     
     end if;
    
    commit;
    DBMS_OUTPUT.PUT_LINE('���� �����հ�: '||v_final_total);
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