--����Ŭ �ּ��Դϴ�
--������ ctrl + enter

select + from employees;

select employee_id, first_name, last_name from employees;
select email, phone_number, hire_date from employees;


--�÷��� ��ȸ�ϴ� ��ġ���� * / + - ������ �����մϴ�
select first_name, last_name,salary + salary*0.1 from employees;

--null�� Ȯ��
select department_id, commission_pct from employees;

--�ٸ��(�÷����� ��Ī�� �ٿ��� ��ȸ�մϴ�)
select first_name as �̸�, last_name as ��, salary as �޿�, salary+ salary*0.1 as �޿�110���� from employees;

--|| ������
-- ����Ŭ �C����ǥ�� ���ڸ� ǥ���ϱ� ������, ���ڿ��ȿ� ' �� ǥ���ϰ� �ͤ��ٸ� escape �ؾ� �ϴµ� '' �ι����� �˴ϴ�.
select first_name ||' ' || last_name  ||'''s salary is $' || salary from employees;

-- distinct (�ߺ� �� ����) Ű����
select department_id from employees;
select distinct department_id from employees;

--ROWID, ROWNUM (�ο���� ������ ����� ���� ���ȣ�Դϴ�)   *rownum ���� �߿�
select rowid, rownum, employee_id from employees;