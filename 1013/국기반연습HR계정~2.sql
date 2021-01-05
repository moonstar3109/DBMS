/*
조인연습하기
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

-- select구문에 필요한 컬럼 지정
-- 양쪽 테이블에 동일한 이름으로 존재하는 컬럼을 적으면 열의 정의가 모호하다는 에러를 출력합니다.
-- 이런 경우 테이블이름.컬럼 으로 지칭해서 정상적 조회가 가능합니다.
select id,
       title,
       content,
       regdate,
       name,
       job,
       auth.user_id
from info inner join auth on info.user_id = auth.user_id;

--테이블에 별칭을 이용해서 join을 할 수 있습니다.
select title,
       content,
       regdate,
       name,
       job,
       i.user_id
from info i inner join auth a on i.user_id = a.user_id
where name = '홍길동';


--아우터 조인 left outer, right outer, full outer
select * from info i left outer join auth a on i.user_id = a.user_id;
select * from info i right outer join auth a on i.user_id = a.user_id;
select * from info i full outer join auth a on i.user_id = a.user_id; --양쪽행을 기준으로 모두 붙어서 출력
select * from info i cross join auth a; --잘못된 형태의 조인의 결과 (cartition product)

--조인이 3개 테이블도 가능 합니다. 키 값만 찾아서 구문을 연결해서 쓰면 됩니다.
select * from employees;
select * from departments;
select * from locations;

select *
from employees e
left outer join departments d
on e.department_id = d.department_id
left outer join locations l
on d.location_id = l.location_id;

--테이블 auth와 info에서 엘리어스 a, i를 이용해서 left join - job컬럼이 DBA인 사람의 ID, TITLE, CONTENT, JOB만 출력
--right join으로 달라지는 결과만 확인.

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

--self join (하나의 테이블에 연결된 키값으로 조인)
select *
from employees e1
left outer join employees e2
on e1.manager_id = e2.employee_id
order by e1.employee_id;

-------------------------------------문제---------------------------------------
/*문제 1.
-EMPLOYEES 테이블과, DEPARTMENTS 테이블은 DEPARTMENT_ID로 연결되어 있습니다.
-EMPLOYEES, DEPARTMENTS 테이블을 엘리어스를 이용해서
각각 INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER 조인 하세요. (달라지는 행의 개수 확인)*/

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
문제 2.
-EMPLOYEES, DEPARTMENTS 테이블을 INNER JOIN하세요
조건)employee_id가 200인 사람의 이름, department_id를 출력하세요
조건)이름 컬럼은 first_name과 last_name을 합쳐서 출력합니다
*/

select first_name || ' ' || last_name  as 이름,
      e.department_id
from employees e
inner join departments d
on e.department_id = d.department_id and employee_id = 200;


/*문제 3.
-EMPLOYEES, JOBS테이블을 INNER JOIN하세요
조건) 모든 사원의 이름과 직무아이디, 직무 타이틀을 출력하고, 이름 기준으로 오름차순 정렬
HINT) 어떤 컬럼으로 서로 연결되 있는지 확인*/

select concat(first_name,last_name) as name,
       e.job_id,
       job_title
from employees e
join jobs j 
on e.job_id = j.job_id 
order by name;


/*
문제 4.
JOBS테이블과 JOB_HISTORY테이블을 LEFT_OUTER JOIN 하세요.
*/
select * from job_history;

select *
from jobs j1
left outer join job_history j2
on j1.job_id = j2.job_id;

/*
문제 5.
Steven King의 부서명을 출력하세요.
*/
select * from DEPARTMENTS;

select first_name || ' ' || last_name as name,
        d.department_name
from employees e
join departments d
on e.department_id = d.department_id ;
where e.first_name = 'Steven' and e.last_name = 'King';



/*
문제 6.
EMPLOYEES 테이블과 DEPARTMENTS 테이블을 Cartesian Product(Cross join)처리하세요
*/

select *
from employees e
cross join departments d;


/*
문제 7.
EMPLOYEES 테이블과 DEPARTMENTS 테이블의 부서번호를 조인하고 SA_MAN 사원만의 사원번호, 이름,
급여, 부서명, 근무지를 출력하세요. (Alias를 사용)
*/
select * from departments;
select * from employees;

select e.employee_id as 사원번호,
       first_name|| ' '||last_name as 이름,
       e.salary as 급여,
       d.department_name as 부서명,
       d.location_id as 근무지
from employees e
left outer join departments d
on e.department_id = d.department_id
and job_id = 'SA_MAN';


/*
문제 8.
employees, jobs 테이블을 조인 지정하고 job_title이 'Stock Manager', 'Stock Clerk'인 직원 정보만
출력하세요
*/
select * from employees;
select * from jobs;

select *
from employees e
left outer join jobs j 
on e.job_id = j.job_id
where j.job_title in ('Stock Manager' ,'Stock Clerk');

/*
문제 9.
-- departments 테이블에서 직원이 없는 부서를 찾아 출력하세요. LEFT OUTER JOIN 사용
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
문제 10.
join을 이용해서 사원의 이름과 그 사원의 매니저 이름을 출력하세요
힌트) EMPLOYEES 테이블과 EMPLOYEES 테이블을 조인하세요.
*/

select * from employees;

select e1.first_name || ' ' || e1.last_name as 사원,
        e1.manager_id,
        e2.first_name || ' ' ||e2.last_name as 매니저
        from employees e1
        left outer join employees e2
        on e1.manager_id = e2.employee_id;
        
/*
문제 11.
EMPLOYEES 테이블에서 left join하여 관리자(매니저)와, 매니저의 이름, 매니저의 급여 까지 출력하세요
매니저 아이디가 없는 사람은 배제하고 급여는 역순으로 출력하세요
*/    
 
select * from employees;

select e1.first_name, -- 본인
       e1.manager_id as 관리자번호,
       e2.first_name || ' ' || e2.last_name as 매니저,
       e2.salary as 급여
       from employees e1
       left outer join employees e2
       on e1.manager_id = e2.employee_id
       where e1.manager_id is not null
       order by e2.salary desc;
      
        
        