-- 1. 단순 출력문으로 3 x 1 = 3 문자열을 출력하세요 

declare
    num1 number;
    num2 number;
begin
    num1  := 3;
    num2 := 1;
    DBMS_OUTPUT.PUT_LINE('3 x 1 ='||' '||num1*num2);
end;
--2. 사원테이블에서 201번의 사원의 이름과 이메일 주소를 출력
--   익명 블록을 생성
declare
    v_emp_name employees.last_name%type;
    v_email employees.email%type;
begin
    select last_name, email
    into v_emp_name, v_email
    from employees
    where employee_id = 201;
    
    DBMS_OUTPUT.put_line(v_emp_name||'-'||v_email);
end;
--3. 사원테이블에서 사원번호가 가장 큰 사원을 찾은 후에
-- 이 번호 +1 번으로 아래 사원을  emps테이블에 추가하세요
-- 이름 -steven, 이메일-stevenjobs, 입사일 -오늘날짜, job_id - ceo
create table emps as (select * from employees where 1=2);

select * from emps;

declare
    v_emp_id employees.employee_id%type;
begin
    select max(employee_id)
    into v_emp_id
    from employees;
    
    insert into emps(employee_id,last_name, email, hire_date, job_id)
    values(v_emp_id+1,'steven', 'stevenjobs', sysdate, 'ceo');
    
    
end;





select *
    from employees s;
    