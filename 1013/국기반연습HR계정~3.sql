/*
��������
-������ () �ȿ� �����, ���������� �������� 1�� ���Ͽ��� �մϴ�.
-������������ ���� �ؼ��ϸ� �˴ϴ�.
*/

select salary from employees where first_name = 'Nancy'; --������ �޿�

--������ �������� - ������������ ����� �� ���� ������ ��.

--������ �߿� ���ú��� �޿��� ���� ��� 
select * 
from employees
where salary > (select salary from employees where first_name = 'Nancy' );

--employee_id�� 103�� ����� job_id�� ������ ����� ã�ƶ�.
select job_id from employees where employee_id = 103;

select *
from employees
where job_id = (select job_id from employees where employee_id = 103);

--���������� ���� ���� ��������� �Ϲ� �񱳿������δ� ������ �� �����ϴ�.
select*
from employees
where job_id = (select job_id from employees where job_id = 'IT_PROG');

