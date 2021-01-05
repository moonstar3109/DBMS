/*
프로시저 생성
create or replace procedure 프로시저이름(
    입력 파라미터
)
*/

create or replace procedure new_job_proc(
    p_job_id in jobs.job_id%type,
    p_job_title in jobs.job_title%type,
    p_min_salary in jobs.min_salary%type,
    p_max_salary in jobs.max_salary%type
)
is 
--변수의 선언 영역
begin
    insert into jobs (job_id,job_title,min_salary,max_salary)
    values(  p_job_id,p_job_title, p_min_salary,p_max_salary);
    
    commit; --커밋

end;

--프로시저 실행
execute new_job_proc('JOBS1','test...',1000,5000);
execute new_job_proc('JOBS2','test2...',2000,10000);

--프로시저 수정은 동일한 이름으로 수정

create or replace procedure new_job_proc(
    p_job_id in jobs.job_id%type,
    p_job_title in jobs.job_title%type,
    p_job_min_salary in jobs.min_salary%type := 0, --기본값 지정
    p_job_max_salary in jobs.max_salary%type := 100 -- 기본값 100지정
) is
    v_count number := 0;
begin
    select count(*)
    into v_count
    from jobs
    where job_id = p_job_id;  --매개변수 p_job_id 기반으로 조회해서 카운트
    
    --없다면 insert
    if v_count = 0 then
        insert into jobs(job_id, job_title, min_salary, max_salary)
        values ( p_job_id,p_job_title,p_job_min_salary,p_job_max_salary );
    else --있다면 update
        update jobs set job_title = p_job_title ,
                        min_salary = p_job_min_salary,
                        max_salary = p_job_max_salary 
        where job_id = p_job_id;
    
    end if;
    commit;
end;

--실행문
execute new_job_proc('JOBS2','test2...',2000,10000);
--프로시저에 기본매개값이 선언되어 있다면, 생략이 가능합니다.
execute new_job_proc('JOBS3','test3...');
select * from jobs;

--OUT 매개변수
--OUT 변수를 사용하는 프로시저는 익명블록에서 실행을 합니다.
create or replace procedure new_job_proc02(
    p_job_id in jobs.job_id%type,
    p_job_title in jobs.job_title%type,
    p_min_salary in jobs.min_salary%type := 0,
    p_max_salary in jobs.max_salary%type := 100,
    p_result out varchar2 --출력을 위한 변수
) is
    v_count number := 0;
    v_result varchar2(100) := '값이 없어서 insert처리 되었습니다';
begin
    --동일한 아이디가 있는지 체크
    select count(*)
    into v_count
    from jobs
    where job_id = p_job_id;
    --없다면 파라미터 값 insert
    if v_count = 0 then
        insert into jobs 
        values(p_job_id, p_job_title, p_min_salary, p_max_salary);
    else --필요한 결과 추출
        select p_job_id || '의 최대연봉: ' || max_salary || ', 최소연봉:' || min_salary 
        into v_result
        from jobs
        where job_id = p_job_id;
    end if;
    p_result := v_result; -- out변수에 결과 할당
end;

--OUT프로시저의 실행
declare
    str varchar2(100); --문자열 크기 지정(반드시)
begin
    --out변수를 프로시저에 전달해서, 할당된 결과값을 받아서 처리.
    new_job_proc02('SM_JOB1','sample job1',2000,6000,str);
    DBMS_OUTPUT.put_line(str);
    new_job_proc02('CEO','sample ceo',10000,90000,str);
    DBMS_OUTPUT.put_line(str);
end;


-- in out 처리형태
create or replace procedure testProc(
    p_var1/*(in)*/ varchar2,
    p_var2 out varchar2,
    p_var3 in out varchar2
)is
begin
    -- in, out이 없다면 단순히 사용만 가능
    DBMS_OUTPUT.put_line(p_var1);
    -- out변수는 프로시저가 끝나기 전까지 값의 할당이 안됨.
    DBMS_OUTPUT.put_line(p_var2);
    -- in, out은 둘다 사용이 가능.
    DBMS_OUTPUT.put_line(p_var3);
  --  p_var1 := '결과1'; --할당불가
    p_var2 := '결과2';
    p_var3 := '결과3';
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

--return구문

/*
1. employees에서 
job_id만 in변수로 입력받아서, 해당 아이디가 있는지 확인하고, 
없다면, 단순히 프로시저 안에서 출력만 해줍니다.
2. job_id가 있다면, 동일한 job_id를 가진 급여의 합계를 출력해주세요.
*/
set serveroutput on;
create or replace procedure new_emp_proc(
    a_job_id  in employees.job_id%type
) is
    p_count number := 0;
    p_salary number := 0;
begin
     
    
    --동일한 아이디가 있는지 체크
    select count(*), sum(salary)
    into p_count,p_salary
    from employees
    where job_id like '%'|| a_job_id ||'%'; 
    
    if p_count = 0 then
        DBMS_OUTPUT.put_line( a_job_id ||'는 없습니다');
        return; --프로시저 종료
    else
       DBMS_OUTPUT.put_line( a_job_id ||'가 포함된 급여의 합'||p_salary);
     end if;
end;

execute new_emp_proc('123');

--예외처리 구문 EXCEPTION when other then

declare 
    v_num number := 0;
begin
    v_num := 10 /0 ;
    
    EXCEPTION when others then
     DBMS_OUTPUT.PUT_LINE('0으로 나눌 수 없습니다');
end;