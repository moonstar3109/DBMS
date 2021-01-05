/*
���ο����ϱ�
CREATE TABLE INFO 
(
  ID NUMBER NOT NULL 
, TITLE VARCHAR2(50) 
, CONTENT VARCHAR2(100) 
, REGDATE DATE DEFAULT sysdate 
, USER_ID VARCHAR2(50) 
, CONSTRAINT INFO_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);
*/

/*
CREATE TABLE AUTH 
(
  USER_ID VARCHAR2(50) NOT NULL 
, COLUMN1 VARCHAR2(50) 
, JOB VARCHAR2(50) 
, CONSTRAINT AUTH_PK PRIMARY KEY 
  (
    USER_ID 
  )
  ENABLE 
);
*/

select * from info;
select * from auth;

--inner join
select * 
from info inner join auth on info.user_id = auth.user_id;

-- select������ �ʿ��� �÷� ����
-- ���� ���̺� ������ �̸����� �����ϴ� �÷��� ������ ���� ���ǰ� ��ȣ�ϴٴ� ������ ����մϴ�.
-- �̷� ��� ���̺��̸�.�÷� ���� ��Ī�ؼ� ������ ��ȸ�� �����մϴ�.
select id,
       title,
       content,
       regdate,
       name,
       job,
       auth.user_id
from info inner join auth on info.user_id = auth.user_id;

--���̺� ��Ī�� �̿��ؼ� join�� �� �� �ֽ��ϴ�.
select title,
       content,
       regdate,
       name,
       job,
       i.user_id
from info i inner join auth a on i.user_id = a.user_id
where name = 'ȫ�浿';


--�ƿ��� ���� left outer, right outer, full outer
select * from info i left outer join auth a on i.user_id = a.user_id;
select * from info i right outer join auth a on i.user_id = a.user_id;
select * from info i full outer join auth a on i.user_id = a.user_id; --�������� �������� ��� �پ ���
select * from info i cross join auth a; --�߸��� ������ ������ ��� (cartition product)

--������ 3�� ���̺� ���� �մϴ�. Ű ���� ã�Ƽ� ������ �����ؼ� ���� �˴ϴ�.
select * from employees;
select * from departments;
select * from locations;

select *
from employees e
left outer join departments d
on e.department_id = d.department_id
left outer join locations l
on d.location_id = l.location_id;

--���̺� auth�� info���� ����� a, i�� �̿��ؼ� left join - job�÷��� DBA�� ����� ID, TITLE, CONTENT, JOB�� ���
--right join���� �޶����� ����� Ȯ��.

select id, title, content, job
from auth a
left outer join info i
on i.user_id = a.user_id
where job = 'DBA';


select id, title, content, job
from auth a
right outer join info i
on i.user_id = a.user_id
where job = 'DBA';

--self join (�ϳ��� ���̺� ����� Ű������ ����)
select *
from employees e1
left outer join employees e2
on e1.manager_id = e2.employee_id
order by e1.employee_id;

-------------------------------------����---------------------------------------
/*���� 1.
-EMPLOYEES ���̺��, DEPARTMENTS ���̺��� DEPARTMENT_ID�� ����Ǿ� �ֽ��ϴ�.
-EMPLOYEES, DEPARTMENTS ���̺��� ������� �̿��ؼ�
���� INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER ���� �ϼ���. (�޶����� ���� ���� Ȯ��)*/

select count(*) 
from employees e
inner join departments d
on e.department_id = d.department_id;

select count(*)
from employees e
left outer join departments d
on d.department_id = e.department_id;

select count(*)
from employees e
right outer join departments d
on d.department_id = e.department_id; 

select count(*)
from employees e
full outer join departments d
on d.department_id = e.department_id; 

/*
���� 2.
-EMPLOYEES, DEPARTMENTS ���̺��� INNER JOIN�ϼ���
����)employee_id�� 200�� ����� �̸�, department_id�� ����ϼ���
����)�̸� �÷��� first_name�� last_name�� ���ļ� ����մϴ�
*/

select first_name || ' ' || last_name  as �̸�,
      e.department_id
from employees e
inner join departments d
on e.department_id = d.department_id and employee_id = 200;


/*���� 3.
-EMPLOYEES, JOBS���̺��� INNER JOIN�ϼ���
����) ��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ�, �̸� �������� �������� ����
HINT) � �÷����� ���� ����� �ִ��� Ȯ��*/

select concat(first_name,last_name) as name,
       e.job_id,
       job_title
from employees e
join jobs j 
on e.job_id = j.job_id 
order by name;


/*
���� 4.
JOBS���̺�� JOB_HISTORY���̺��� LEFT_OUTER JOIN �ϼ���.
*/
select * from job_history;

select *
from jobs j1
left outer join job_history j2
on j1.job_id = j2.job_id;

/*
���� 5.
Steven King�� �μ����� ����ϼ���.
*/
select * from DEPARTMENTS;

select first_name || ' ' || last_name as name,
        d.department_name
from employees e
join departments d
on e.department_id = d.department_id ;
where e.first_name = 'Steven' and e.last_name = 'King';



/*
���� 6.
EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian Product(Cross join)ó���ϼ���
*/

select *
from employees e
cross join departments d;


/*
���� 7.
EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ� SA_MAN ������� �����ȣ, �̸�,
�޿�, �μ���, �ٹ����� ����ϼ���. (Alias�� ���)
*/
select * from departments;
select * from employees;

select e.employee_id as �����ȣ,
       first_name|| ' '||last_name as �̸�,
       e.salary as �޿�,
       d.department_name as �μ���,
       d.location_id as �ٹ���
from employees e
left outer join departments d
on e.department_id = d.department_id
and job_id = 'SA_MAN';


/*
���� 8.
employees, jobs ���̺��� ���� �����ϰ� job_title�� 'Stock Manager', 'Stock Clerk'�� ���� ������
����ϼ���
*/
select * from employees;
select * from jobs;

select *
from employees e
left outer join jobs j 
on e.job_id = j.job_id
where j.job_title in ('Stock Manager' ,'Stock Clerk');

/*
���� 9.
-- departments ���̺��� ������ ���� �μ��� ã�� ����ϼ���. LEFT OUTER JOIN ���
*/
select * from departments;
select * from employees;
    
select d.department_id,
       d.department_name
from departments d
left outer join employees e
on e.department_id = d.department_id
where e.employee_id is null;

/*
���� 10.
join�� �̿��ؼ� ����� �̸��� �� ����� �Ŵ��� �̸��� ����ϼ���
��Ʈ) EMPLOYEES ���̺�� EMPLOYEES ���̺��� �����ϼ���.
*/

select * from employees;

select e1.first_name || ' ' || e1.last_name as ���,
        e1.manager_id,
        e2.first_name || ' ' ||e2.last_name as �Ŵ���
        from employees e1
        left outer join employees e2
        on e1.manager_id = e2.employee_id;
        
/*
���� 11.
EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)��, �Ŵ����� �̸�, �Ŵ����� �޿� ���� ����ϼ���
�Ŵ��� ���̵� ���� ����� �����ϰ� �޿��� �������� ����ϼ���
*/    
 
select * from employees;

select e1.first_name, -- ����
       e1.manager_id as �����ڹ�ȣ,
       e2.first_name || ' ' || e2.last_name as �Ŵ���,
       e2.salary as �޿�
       from employees e1
       left outer join employees e2
       on e1.manager_id = e2.employee_id
       where e1.manager_id is not null
       order by e2.salary desc;
      
        
        