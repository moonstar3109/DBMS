/*
���ν��� ����
create or replace procedure ���ν����̸�(
    �Է� �Ķ����
)
*/

create or replace procedure new_job_proc(
    p_job_id in jobs.job_id%type,
    p_job_title in jobs.job_title%type,
    p_min_salary in jobs.min_salary%type,
    p_max_salary in jobs.max_salary%type
)
is 
--������ ���� ����
begin
    insert into jobs (job_id,job_title,min_salary,max_salary)
    values(  p_job_id,p_job_title, p_min_salary,p_max_salary);
    
    commit; --Ŀ��

end;

--���ν��� ����
execute new_job_proc('JOBS1','test...',1000,5000);
execute new_job_proc('JOBS2','test2...',2000,10000);

--���ν��� ������ ������ �̸����� ����

create or replace procedure new_job_proc(
    p_job_id in jobs.job_id%type,
    p_job_title in jobs.job_title%type,
    p_job_min_salary in jobs.min_salary%type := 0, --�⺻�� ����
    p_job_max_salary in jobs.max_salary%type := 100 -- �⺻�� 100����
) is
    v_count number := 0;
begin
    select count(*)
    into v_count
    from jobs
    where job_id = p_job_id;  --�Ű����� p_job_id ������� ��ȸ�ؼ� ī��Ʈ
    
    --���ٸ� insert
    if v_count = 0 then
        insert into jobs(job_id, job_title, min_salary, max_salary)
        values ( p_job_id,p_job_title,p_job_min_salary,p_job_max_salary );
    else --�ִٸ� update
        update jobs set job_title = p_job_title ,
                        min_salary = p_job_min_salary,
                        max_salary = p_job_max_salary 
        where job_id = p_job_id;
    
    end if;
    commit;
end;

--���๮
execute new_job_proc('JOBS2','test2...',2000,10000);
--���ν����� �⺻�Ű����� ����Ǿ� �ִٸ�, ������ �����մϴ�.
execute new_job_proc('JOBS3','test3...');
select * from jobs;

--OUT �Ű�����
--OUT ������ ����ϴ� ���ν����� �͸��Ͽ��� ������ �մϴ�.
create or replace procedure new_job_proc02(
    p_job_id in jobs.job_id%type,
    p_job_title in jobs.job_title%type,
    p_min_salary in jobs.min_salary%type := 0,
    p_max_salary in jobs.max_salary%type := 100,
    p_result out varchar2 --����� ���� ����
) is
    v_count number := 0;
    v_result varchar2(100) := '���� ��� insertó�� �Ǿ����ϴ�';
begin
    --������ ���̵� �ִ��� üũ
    select count(*)
    into v_count
    from jobs
    where job_id = p_job_id;
    --���ٸ� �Ķ���� �� insert
    if v_count = 0 then
        insert into jobs 
        values(p_job_id, p_job_title, p_min_salary, p_max_salary);
    else --�ʿ��� ��� ����
        select p_job_id || '�� �ִ뿬��: ' || max_salary || ', �ּҿ���:' || min_salary 
        into v_result
        from jobs
        where job_id = p_job_id;
    end if;
    p_result := v_result; -- out������ ��� �Ҵ�
end;

--OUT���ν����� ����
declare
    str varchar2(100); --���ڿ� ũ�� ����(�ݵ��)
begin
    --out������ ���ν����� �����ؼ�, �Ҵ�� ������� �޾Ƽ� ó��.
    new_job_proc02('SM_JOB1','sample job1',2000,6000,str);
    DBMS_OUTPUT.put_line(str);
    new_job_proc02('CEO','sample ceo',10000,90000,str);
    DBMS_OUTPUT.put_line(str);
end;


-- in out ó������
create or replace procedure testProc(
    p_var1/*(in)*/ varchar2,
    p_var2 out varchar2,
    p_var3 in out varchar2
)is
begin
    -- in, out�� ���ٸ� �ܼ��� ��븸 ����
    DBMS_OUTPUT.put_line(p_var1);
    -- out������ ���ν����� ������ ������ ���� �Ҵ��� �ȵ�.
    DBMS_OUTPUT.put_line(p_var2);
    -- in, out�� �Ѵ� ����� ����.
    DBMS_OUTPUT.put_line(p_var3);
  --  p_var1 := '���1'; --�Ҵ�Ұ�
    p_var2 := '���2';
    p_var3 := '���3';
end;
 
    
declare

    var1 varchar2(50) := 'A';
    var2 varchar2(50) := 'B';
    var3 varchar2(50) := 'C';
begin
    testProc(var1,var2,var3);
     DBMS_OUTPUT.put_line(var2);
     DBMS_OUTPUT.put_line(var3);
end;

--return����

/*
1. employees���� 
job_id�� in������ �Է¹޾Ƽ�, �ش� ���̵� �ִ��� Ȯ���ϰ�, 
���ٸ�, �ܼ��� ���ν��� �ȿ��� ��¸� ���ݴϴ�.
2. job_id�� �ִٸ�, ������ job_id�� ���� �޿��� �հ踦 ������ּ���.
*/
set serveroutput on;
create or replace procedure new_emp_proc(
    a_job_id  in employees.job_id%type
) is
    p_count number := 0;
    p_salary number := 0;
begin
     
    
    --������ ���̵� �ִ��� üũ
    select count(*), sum(salary)
    into p_count,p_salary
    from employees
    where job_id like '%'|| a_job_id ||'%'; 
    
    if p_count = 0 then
        DBMS_OUTPUT.put_line( a_job_id ||'�� �����ϴ�');
        return; --���ν��� ����
    else
       DBMS_OUTPUT.put_line( a_job_id ||'�� ���Ե� �޿��� ��'||p_salary);
     end if;
end;

execute new_emp_proc('123');

--����ó�� ���� EXCEPTION when other then

declare 
    v_num number := 0;
begin
    v_num := 10 /0 ;
    
    EXCEPTION when others then
     DBMS_OUTPUT.PUT_LINE('0���� ���� �� �����ϴ�');
end;