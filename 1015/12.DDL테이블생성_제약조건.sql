-----���̺� ����-----
create table dept2(
    dept_no number(2, 0), -- 2�ڸ� ����, �Ǽ��� �������� �ʴ´�.
    dept_name varchar2(14), --byte��� ���� ���ڿ�
    loca varchar2(13),
    dept_date date,
    deot_bonus number(10)
);

select * from dept2;
insert into dept2 values(99, '����', '����', sysdate, 2000000000 ); --�ڸ��� Ȯ��

----���̺� ���� alter table---
alter table dept2
add dept_count number(3); --�߰�
desc dept2;

alter table dept2
modify dept_count number(10); --����
desc dept2;

alter table dept2
rename column dept_count to emp_count; --�÷��� ����
desc dept2;

alter table dept2
drop column emp_count; --����
desc dept2;

--���̺� ����
drop table dept2;
--drop table dept2 cascade constraints �������Ǹ�; --�ش����̺� FK���������� ����ִ��� ����.

--���̺����� ���λ���
--truncate table dept2;

--���̺� ������ ��������
/*
������ �������� (PK, FK, not null, check, unique)
1. PK - ���̺� ���� �ĺ� �÷� (not null���� unique����)
2. UNIQUE - ������ ���� �����ϴ� �÷�(�ߺ��������� ����)
3. not null - null�� ������� ����
4. FK - �����ϴ� ���̺��� PK�� �����ϴ� �÷�
5. CHECK - ���ǵ� ���ĸ� �������� ���
*/

desc locations;

create table dept2(
    dept_no number(2) PRIMARY KEY,
    dept_name varchar2(14) not null unique,
    loca number(4) REFERENCES locations(location_id),
    dept_date date default sysdate, --�ƹ��͵� �������� ������ �⺻���� ���ݽð�
    dept_bonus number(10),
    dept_gender char(1) check(dept_gender in ('F', 'M') )
);
desc dept2;
drop table dept2;
--���̺� ���� ��������(��� ���� ������ �Ŀ� �Ʒ��ʿ� �������� �߰�)
create table dept2(
    dept_no number(2),
    dept_name varchar2(14) not null,
    loca number(4),
    dept_date date default sysdate,
    dept_bonus number(10),
    dept_gender char(1),
    constraints dept_no_pk primary key (dept_no ), --�������� ���������̸� ������������ �����÷�
    constraints dept_name_uk unique (dept_name),
    constraints dept_gender_ck check (dept_gender in ('F', 'M')),
    constraints dept_loca_fk foreign key (loca) references locations(location_id)    
);
















