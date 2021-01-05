-- 그룹함수 AVG, MAX, MIN, SUM, COUNT
select avg(salary), sum(salary), min(salary), max(salary), count(*) from employees;
select count(*) from employees;
select count(first_name) from employees; --first_name이 null이 아닌 개수
select count(commission_pct) from employees; --commission_pct이 null이 아닌 개수

-- 그룹 함수는 일반컬럼과 동시에 사용이 불가능하다
--select department_id, sum(salary) from employees;
-- 그룹 절에 묶인 컬럼만 조회가 가능합니다.
-- select department_id , job_id from employees group by department_id;

-- group by 절을 이용한 그룹핑 (group by절은 where절 다음에 들어갑니다.)
select department_id from employees group by department_id;
select department_id, sum(salary), avg(salary), count(*) from employees group by department_id;

-- 2개 이상의 그룹화 
select * from employees;
select department_id, job_idfrom employees group by department_id, job_id; --부서별 job_id명
select job_id, department_id from employees group by job_id, department_id; --job_id별 부서명

--아래 두 구문은 결과가 다릅니다.
select department_id, sum(salary) from empliyees group by department_id;
select department_id, sum(salary) from employees where salary>=5000 group by department_id;

--group by 절의 조건 having
select department_id, sum(salary) from employees group by department_id having sum(salary) >= 100000;

-- 20명 이상인 job id가 
select job_id, count(*)
from employees
group by job_id
having count(*) >= 20;
