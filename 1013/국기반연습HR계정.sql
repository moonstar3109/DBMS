-- �׷��Լ� AVG, MAX, MIN, SUM, COUNT
select avg(salary), sum(salary), min(salary), max(salary), count(*) from employees;
select count(*) from employees;
select count(first_name) from employees; --first_name�� null�� �ƴ� ����
select count(commission_pct) from employees; --commission_pct�� null�� �ƴ� ����

-- �׷� �Լ��� �Ϲ��÷��� ���ÿ� ����� �Ұ����ϴ�
--select department_id, sum(salary) from employees;
-- �׷� ���� ���� �÷��� ��ȸ�� �����մϴ�.
-- select department_id , job_id from employees group by department_id;

-- group by ���� �̿��� �׷��� (group by���� where�� ������ ���ϴ�.)
select department_id from employees group by department_id;
select department_id, sum(salary), avg(salary), count(*) from employees group by department_id;

-- 2�� �̻��� �׷�ȭ 
select * from employees;
select department_id, job_idfrom employees group by department_id, job_id; --�μ��� job_id��
select job_id, department_id from employees group by job_id, department_id; --job_id�� �μ���

--�Ʒ� �� ������ ����� �ٸ��ϴ�.
select department_id, sum(salary) from empliyees group by department_id;
select department_id, sum(salary) from employees where salary>=5000 group by department_id;

--group by ���� ���� having
select department_id, sum(salary) from employees group by department_id having sum(salary) >= 100000;

-- 20�� �̻��� job id�� 
select job_id, count(*)
from employees
group by job_id
having count(*) >= 20;

--�μ� ���̵� 50�̻��� �÷��� �׷�ȭ ��Ű��, �׷������ 5000�̻� ��ȸ
select department_id,count(*), trunc(avg(salary))
from employees
where department_id >= 50
group by department_id 
having trunc(avg(salary)) >= 5000;


--------------------------------���� ����----------------------------------
--���� 1.
--��� ���̺��� JOB_ID�� ��� ���� ���ϼ���.
--��� ���̺��� JOB_ID�� ������ ����� ���ϼ���. ������ ��� ������ �������� �����ϼ���
select job_id, count(*), trunc(avg(salary))
from employees
group by job_id
order by trunc(avg(salary)) desc;


--���� 2.
--��� ���̺��� �Ի� �⵵ �� ��� ���� ���ϼ���.
select to_char(hire_date, 'YY'), count(*)
from employees
group by hire_date
order by to_char(hire_date, 'YY');

--���� 3.
--�޿��� 1000 �̻��� ������� �μ��� ��� �޿��� ����ϼ���. �� �μ� ��� �޿��� 2000�̻��� �μ��� ���
select department_id, trunc(avg(salary))
from employees
where salary >= 1000
group by department_id
having trunc(avg(salary)) >= 2000;

--���� 4.
--��� ���̺��� commission_pct(Ŀ�̼�) �÷��� null�� �ƴ� �������
--department_id(�μ���) salary(����)�� ���, �հ�, count�� ���մϴ�.
--���� 1) ������ ����� Ŀ�̼��� �����Ų �����Դϴ�.
--���� 2) ����� �Ҽ� 2° �ڸ����� ���� �ϼ���.

select department_id, count(*),trunc(avg(salary+(salary*commission_pct)),2), sum(salary)
from employees
where commission_pct 
group by department_id;