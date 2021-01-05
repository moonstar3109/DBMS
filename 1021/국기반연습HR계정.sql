/*
������ SQL��
����Ŭ �����Ǵ� ���α׷��� ���� ����Դϴ�.
�������� ������� � ������ �ϰ�ó���ϱ� ���ؼ� ���˴ϴ�.

������SQL�� �ʿ��� �ڵ�κи� ���� �ؼ� F5 ������ ��ŵ�ϴ�.
*/

--����Ŭ ���ӽ� ��±����� ����Ҽ� �ְ� ����
set SERVEROUTPUT ON; --�� ��Ƽ� F5������

declare --������ �����ϴ� �κ�
    v_num number; --���ڰ��� ���� ũ�Ⱑ �������� �ʾƵ� �˴ϴ�.    
begin
    v_num := 100;
    DBMS_OUTPUT.put_line(v_num);
end;

/*
������
�Ϲ�sql������ ����ϴ� ��� �����ڰ� ��밡���մϴ�.
Ư���� ������ ** ����
*/

declare
    a number := (1+2) ** 2;  --3������
begin
    DBMS_OUTPUT.PUT_LINE('a��'||a);
end;


/*
--DML��
DDL�� ����� �Ұ���.
�Ϲ����� SQL���� select������ ����ϴµ�, 
select�� �Ʒ����� into���� �̿��ؼ� ������ �Ҵ�.
*/

declare
    v_emp_name varchar2(50); --���ڿ��� ���������� �ݵ�� �ؾ��մϴ�.
    v_dep_name varchar2(50);
begin

    select last_name, department_name --�̸���, �μ��̸�
    into v_emp_name, v_dep_name --into �������� ������ �Ҵ�
    from employees e
    left join departments d
    on e.department_id = d.department_id
    where employee_id = 100;
    
    DBMS_OUTPUT.put_line('�̸�:'||v_emp_name||'�μ��̸�:'||v_dep_name);

end;

/*
TYPEŰ����
--�ش� ���̺��� ���� Ÿ���� �÷��� ����Ÿ������ �����Ϸ���
--���̺��.�÷���%type
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













