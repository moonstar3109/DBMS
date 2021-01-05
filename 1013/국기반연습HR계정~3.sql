/*
서브쿼리
-사용법은 () 안에 명시함, 서브쿼리의 리턴행이 1줄 이하여야 합니다.
-서브쿼리절을 먼저 해석하면 됩니다.
*/

select salary from employees where first_name = 'Nancy'; --낸시의 급여

--단일행 서브쿼리 - 서브쿼리절의 결과가 한 행이 나오는 것.

--직원들 중에 낸시보다 급여가 많은 사람 
select * 
from employees
where salary > (select salary from employees where first_name = 'Nancy' );

--employee_id가 103인 사람의 job_id와 동일한 사람을 찾아라.
select job_id from employees where employee_id = 103;

select *
from employees
where job_id = (select job_id from employees where employee_id = 103);

--서브쿼리의 리턴 행이 여러개라면 일반 비교연산으로는 구분할 수 없습니다.
select*
from employees
where job_id = (select job_id from employees where job_id = 'IT_PROG');

