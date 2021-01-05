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

--부서 아이디가 50이상인 컬럼을 그룹화 시키고, 그룸평균중 5000이상만 조회
select department_id,count(*), trunc(avg(salary))
from employees
where department_id >= 50
group by department_id 
having trunc(avg(salary)) >= 5000;


--------------------------------연습 문제----------------------------------
--문제 1.
--사원 테이블에서 JOB_ID별 사원 수를 구하세요.
--사원 테이블에서 JOB_ID별 월급의 평균을 구하세요. 월급의 평균 순으로 내림차순 정렬하세요
select job_id, count(*), trunc(avg(salary))
from employees
group by job_id
order by trunc(avg(salary)) desc;


--문제 2.
--사원 테이블에서 입사 년도 별 사원 수를 구하세요.
select to_char(hire_date, 'YY'), count(*)
from employees
group by hire_date
order by to_char(hire_date, 'YY');

--문제 3.
--급여가 1000 이상인 사원들의 부서별 평균 급여를 출력하세요. 단 부서 평균 급여가 2000이상인 부서만 출력
select department_id, trunc(avg(salary))
from employees
where salary >= 1000
group by department_id
having trunc(avg(salary)) >= 2000;

--문제 4.
--사원 테이블에서 commission_pct(커미션) 컬럼이 null이 아닌 사람들의
--department_id(부서별) salary(월급)의 평균, 합계, count를 구합니다.
--조건 1) 월급의 평균은 커미션을 적용시킨 월급입니다.
--조건 2) 평균은 소수 2째 자리에서 절삭 하세요.

select department_id, count(*),trunc(avg(salary+(salary*commission_pct)),2), sum(salary)
from employees
where commission_pct 
group by department_id;