-- 1. �ܼ� ��¹����� 3 x 1 = 3 ���ڿ��� ����ϼ��� 

declare
    num1 number;
    num2 number;
begin
    num1  := 3;
    num2 := 1;
    DBMS_OUTPUT.PUT_LINE('3 x 1 ='||' '||num1*num2);
end;
--2. ������̺��� 201���� ����� �̸��� �̸��� �ּҸ� ���
--   �͸� ����� ����
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
--3. ������̺��� �����ȣ�� ���� ū ����� ã�� �Ŀ�
-- �� ��ȣ +1 ������ �Ʒ� �����  emps���̺� �߰��ϼ���
-- �̸� -steven, �̸���-stevenjobs, �Ի��� -���ó�¥, job_id - ceo
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
    