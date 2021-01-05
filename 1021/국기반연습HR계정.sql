/*
절차형 SQL문
오라클 제공되는 프로그래밍 같은 기능입니다.
쿼리문을 순서대로 어떤 동작을 일괄처리하기 위해서 사용됩니다.

절차형SQL은 필요한 코드부분만 선택 해서 F5 컴파일 시킵니다.
*/

--오라클 접속시 출력구문을 사용할수 있게 변경
set SERVEROUTPUT ON; --블럭 잡아서 F5누르기

declare --변수를 선언하는 부분
    v_num number; --숫자같은 경우는 크기가 지정되지 않아도 됩니다.    
begin
    v_num := 100;
    DBMS_OUTPUT.put_line(v_num);
end;

/*
연산자
일반sql문에서 사용하는 모든 연산자가 사용가능합니다.
특별한 연산자 ** 제곱
*/

declare
    a number := (1+2) ** 2;  --3의제곱
begin
    DBMS_OUTPUT.PUT_LINE('a는'||a);
end;


/*
--DML문
DDL이 사용이 불가능.
일반적인 SQL문의 select구문을 사용하는데, 
select절 아래에는 into절을 이용해서 변수를 할당.
*/

declare
    v_emp_name varchar2(50); --문자열은 길이제약을 반드시 해야합니다.
    v_dep_name varchar2(50);
begin

    select last_name, department_name --이름과, 부서이름
    into v_emp_name, v_dep_name --into 절에서는 변수에 할당
    from employees e
    left join departments d
    on e.department_id = d.department_id
    where employee_id = 100;
    
    DBMS_OUTPUT.put_line('이름:'||v_emp_name||'부서이름:'||v_dep_name);

end;

/*
TYPE키워드
--해당 테이블의 같은 타입의 컬럼을 변수타입으로 선언하려면
--테이블명.컬러명%type
*/

declare
     v_emp_name employees.last_name%type;
     v_dep_name departments.department_name%type;
begin
    select last_name, department_name
    into  v_emp_name, v_dep_name
    from employees e 
    left join departments d
    on e.department_id = d.department_id
    where employee_id = 100;
    
    insert into emp_test values(v_emp_name, v_dep_name);
    
end;
 
create table emp_test(emp_name varchar2(50), dep_name varchar2(50));













