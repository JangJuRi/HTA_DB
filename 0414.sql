-- 사원아이디, 이름, 급여를 조회하기
select employee_id, first_name, salary
FROM employees;

-- 부서아이디, 부서명을 조회하기
select department_id, department_name
from departments;

-- 잡 아이디, 잡 타이틀을 조회하기
select job_id, job_title
from jobs;

-- 나라이름 조회하기
select country_name
from countries;

-- 사원아이디, 이름, 급여, 연봉을 조회하기
select employee_id as ID, first_name as NAME, salary as SAL, salary*12 as ANN_SAL
from employees;

-- 사원아이디, 이름, 급여, 10%인상된 급여를 조회하기
select employee_id ID, first_name NAME, salary SAL, salary + (salary*0.1) "INCREMENT SALARY"
from employees;

-- NULL 값이 있는 컬럼 조회하기
-- 부서아이디, 부서명, 부서담당자 아이디 조회하기
select department_id, department_name, manager_id
from departments;

-- 사원아이디, 이름, 급여, 커미션, 커미션이 포함된 급여 조회하기
-- 커미션이 포함된 급여는 급여 + 급여*커미션
-- * 산술식에 null이 포함되어있으면 결과는 null
select employee_id, first_name, salary, commission_pct, salary + salary*commission_pct
from employees;

-- 중복행없이 조회하기
-- 사원들이 종사하고 있는 직종아이디를 전부 조회하기
select DISTINCT job_id
from employees;

-- 60번 부서에 근무하는 사원의 아이디, 이름, 직종, 급여, 부서아이디를 조회하기
select employee_id, first_name, job_id, salary, department_id
from employees
WHERE department_id = 60;

-- 급여를 15000달러 이상 받는 사원의 아이디, 이름, 직종, 급여를 조회하기
select employee_id, first_name, job_id, salary
from employees
where salary >= 15000;