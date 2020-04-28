-- 셀프조인 (자체조인)
-- 101번 사원의 이름, 직종, 자신의 상사 이름을 조회하기
select EMP.first_name 직원명
    , EMP.job_id "직원의 직종"
    , MGR.first_name "상사의 이름"
from employees EMP, employees MGR
where emp.employee_id = 101
and emp.manager_id = mgr.employee_id;

-- 60번 부서에 근무중인 직원의 아이디, 이름, 사원의 직종, 상사의 이름, 상사의 직종, 
-- 부서아이디, 부서명, 부서관리자 아이디, 부서관리자 이름을 조회하기
select 직원.employee_id 직원아이디
    , 직원.first_name 직원이름
    , 직원.job_id "직원의 직종"
    , 상사.first_name "상사의 이름"
    , 상사.job_id "상사의 직종"
    , 직원.department_id "소속부서 아이디"
    , 부서.department_name "소속부서 이름"
    , 부서.manager_id "관리자 아이디"
    , 부서관리자.first_name "부서의 관리자 이름"
from employees 직원, employees 상사, employees 부서관리자, departments 부서
where 직원.department_id = 60
and 직원.manager_id = 상사.employee_id
and 직원.department_id = 부서.department_id
and 부서.manager_id = 부서관리자.employee_id;

-- 포괄조인
-- 부서아이디, 부서명, 부서관리자아이디, 부서관리자 이름 조회하기
select a.department_id, a.department_name, a.manager_id, b.first_name
from departments A, employees B
where a.manager_id = b.employee_id(+)
order by department_id;

-- 모든 직원의 이름, 급여, 직종아이디, 소속부서명을 조회하기
select *
from employees A, departments B
where a.department_id = b.department_id(+)
order by a.employee_id;


-- 다중행 함수 사용하기
-- employees의 모든 행의 개수 조회하기
select count(*)
from employees;

-- 50번 부서에서 일하는 직원의 수를 조회하기
select count(*)
from employees
where department_id = 50;

-- 커미션을 받는 직원의 수를 조회하기
select count(commission_pct)    -- 컬럼을 지정하면 해당 컬럼의 값이 null이 아닌 것만 카운트한다.
from employees;

select count(*)
from employees
where commission_pct is not null;

-- 직원들 중에서 최고급여, 최저급여를 받는 직원의 급여를 조회하기
select max(salary), min(salary)
from employees;

-- 최고급여를 받는 사람의 이름과 최고급여를 조회하기
select first_name, max(salary) -- 오류 : 그룹함수와 그룹함수가 아닌 표현식을 같이 사용할 수 없다.
from employees;

select first_name, salary
from employees
where salary = (select max(salary)
                from employees);
                
-- 조회된 행의 개수를 구하기
-- count(*) : 조회된 모든 행의 개수를 반환한다.
-- count(컬럼명) : 해당 칼럼의 값이 null이 아닌 행의 개수를 반환한다.
-- count(distinct 컬럼명) : 해당 컬럼의 값에 대해 중복된 값은 1번만 카운트해서 행의 개수를 반환한다.
select count(*)
from employees;         -- 107

select count(job_id)
from employees;         -- 107

select count(distinct job_id)
from employees;         -- 19

select count(distinct to_char(hire_date, 'yyyy'))
from employees;         -- 8

-- 조회된 행의 특정 컬럼에 대한 합계를 구하기
-- sum(컬럼명) : 해당 컬럼의 값 중에서 null을 제외한 값들의 합계를 반환한다.
select sum(salary)          -- 전체 사원들의 급여 출력
from employees;

select sum(commission_pct)  -- 전체 사원들의 커미션에 대한 합계, 커미션 값이 null인 것은 계산에 포함되지 않음
from employees;

-- 조회된 행의 특정 컬럼에 대한 평균을 구하기
-- avg(컬럼명) : 해당 컬럼의 값 중에서 null을 제외한 값을 가진 행들에 대한 평균값을 반환한다.
select trunc(avg(salary))   -- 전체 직원들의 급여 평균
from employees;

select trunc(avg(commission_pct),2)
from employees;

-- 조회된 행의 특정 컬럼에 대한 최대값, 최소값 구하기
-- min(컬럼명) : 해당 컬럼의 값 중에서 null을 제외한 가장 작은 값을 반환한다.
-- max(컬럼명) : 해당 컬럼의 값 중에서 null을 제외한 가장 큰 값을 반환한다.
select min(salary), max(salary)
from employees;

select min(commission_pct), max(commission_pct)
from employees;

-- group by와 그룹함수를 사용해서 데이터 집계하기
-- 직종별 직원수를 조회하기
select job_id, count(*)
from employees
group by job_id;

-- 입사년도별 사원수
select to_char(hire_date, 'yyyy'), count(*)
from employees
group by to_char(hire_date, 'yyyy')
order by 1;


--1. 모든 직원들의 모든 업무아이디를 조회하기
select DISTINCT job_id
from employees;

--2. 급여를 12,000달러 이상 받는 직원의 이름과 급여를 조회하기
select first_name, salary
from employees
where salary >= 12000;

--3. 직원번호가 176번 직원과 같은 부서에서 근무하는 직원의 아이디와 이름 직종아이디를 조회하기
select a.employee_id, a.first_name, a.job_id
from employees A, employees B
where b.employee_id = 176
and a.department_id = b.department_id;

--4. 급여를 12,000달러 이상 15,000달러 이하 받는 직원들의 직원 아이디와 이름과 급여를 조회하기
select employee_id, first_name, salary
from employees
where salary >= 12000 and salary <= 15000;

--5. 2005년 1월 1일부터 2005년 6월 30일 사이에 입사한 직원의 아이디, 이름, 업무아이디, 입사일을 조회하기
select employee_id, first_name, job_id, hire_date
from employees
where hire_date >= to_date('20050101', 'yyyymmdd')
and hire_date <= to_date('20050630', 'yyyymmdd');

--6. 급여가 5,000달러와 12,000달러 사이이고, 부서번호가 20 또는 50인 직원의 이름과 급여를 조회하기
select first_name, salary
from employees
where salary >= 5000 and salary <= 12000
and department_id in(20, 50);

--7. 관리자가 없는 직원의 이름과 업무아이디를 조회하기
select first_name, job_id
from employees
where manager_id is null;

--8. 커미션을 받는 모든 직원의 이름과 급여, 커미션을 급여 및 커미션의 내림차순으로 정렬해서 조회하기
select first_name, salary, commission_pct
from employees
where commission_pct is not null
order by salary desc, commission_pct desc;

--9. 이름의 2번째 글자가 e인 모든 직원의 이름을 조회하기
select first_name
from employees
where instr(first_name,'e') = 2;

--10. 업무아이디가 ST_CLERK 또는 SA_REP이고 급여를 2,500달러, 3,500달러, 7,000달러 받는 모든 직원의 이름과 업무아이디, 급여를 조회하기
select first_name, job_id, salary
from employees
where job_id in ('ST_CLERK', 'SA_REP')
and salary in (2500, 3500, 7000);

--11. 모든 직원의 이름과 입사일, 근무 개월 수를 계산하여 조회하기, 근무개월 수는 정수로 반올림하고, 근무개월수를 기준으로 오름차순으로 정렬하기
select first_name, hire_date, trunc(MONTHS_BETWEEN(sysdate, hire_date)) 근무개월수
from employees
order by TRUNC(MONTHS_BETWEEN(sysdate, hire_date));

--12. 직원의 이름과 커미션을 조회하기, 커미션을 받지 않는 직원은 '없음'으로 표시하기
select first_name, nvl(to_char(commission_pct),'없음')
from employees;

--13. 모든 직원의 이름, 부서번호, 부서이름을 조회하기
select a.first_name, a.department_id, b.department_name
from employees A, departments B
where a.department_id = b.department_id(+);

--14. 80번부서에 소속된 직원의 이름과 업무아이디, 업무제목, 부서이름을 조회하기
select a.first_name, a.job_id, b.job_title, c.department_name
from employees A, jobs B, departments C
where a.department_id = 80
and a.job_id = b.job_id
and a.department_id = c.department_id;

--15. 커미션을 받는 모든 직원의 이름과 업무아이디, 업무제목, 부서이름, 부서소재지 도시명을 조회하기
select a.first_name, a.job_id, b.job_title, c.department_name, d.city
from employees A, jobs B, departments C, locations D
where a.commission_pct is not null
and a.job_id = b.job_id
and a.department_id = c.department_id
and c.location_id = d.location_id;

--16. 유럽에 소재지를 두고 있는 모든 부서아이디와 부서이름을 조회하기
select a.department_id, a.department_name
from departments A, locations B, countries C , regions D
where d.region_name = 'Europe'
and a.location_id = b.location_id
and b.country_id = c.country_id
and c.region_id = d.region_id;

--17. 직원의 이름과 소속부서명, 급여, 급여 등급을 조회하기
select a.first_name, b.department_name, a.salary, c.gra
from employees A, departments B, job_grades C
where a.department_id = b.department_id(+)
and a.salary >= c.lowest_sal
and a.salary <= c.highest_sal;

--18. 직원의 이름과 소속부서명, 소속부서의 관리자명을 조회하기, 소속부서가 없는 직원은 소속부서명 '없음, 관리자명 '없음'으로 표시하기
select emp.first_name, nvl(b.department_name,'없음'), nvl(mgr.first_name, '없음')
from employees EMP, departments B, employees MGR
where emp.department_id = b.department_id(+)
and b.manager_id = mgr.employee_id(+);

--19. 모든 사원의 이름, 직종아이디, 급여, 소속부서명을 조회하기
select a.first_name, a.job_id, a.salary, b.department_name
from employees A, departments B
where a.department_id = b.department_id(+);

--20. 모든 사원의 이름, 직종아이디, 직종제목, 급여, 최소급여, 최대급여를 조회하기
select a.first_name, a.job_id, b.job_title, a.salary, b.min_salary, b.max_salary
from employees A, jobs B
where a.job_id = b.job_id;

--21. 모든 사원의 이름, 직종아이디, 직종제목, 급여, 최소급여와 본인 급여의 차이를 조회하기
select a.first_name, a.job_id, b.job_title, a.salary, a.salary - b.min_salary
from employees A, jobs B
where a.job_id = b.job_id;

--22. 커미션을 받는 모든 사원의 아이디, 부서이름, 소속부서의 소재지(도시명)을 조회하기
select a.employee_id, b.department_name, c.city
from employees A, departments B, locations C
where a.commission_pct is not null
and a.department_id = b.department_id(+)
and b.location_id = c.location_id(+);

--23. 이름이 A나 a로 시작하는 모든 사원의 이름과 직종, 직종제목, 급여, 소속부서명을 조회하기
select a.first_name, a.job_id, b.job_title, a.salary, c.department_name
from employees A, jobs B, departments C
where (a.first_name like 'A%' or a.first_name like 'a%')
and a.job_id = b.job_id
and a.department_id = c.department_id;

--24. 30, 60, 90번 부서에 소속되어 있는 사원들 중에서 100에게 보고하는 사원들의 이름, 직종, 급여,
--    급여등급을 조회하기
select a.first_name, a.job_id, a.salary, b.gra
from employees A, job_grades B
where a.department_id in (30, 60, 90)
and a.manager_id = 100
and a.salary >= b.lowest_sal and a.salary <= b.highest_sal;

--25. 80번 부서에 소속된 사원들의 이름, 직종, 직종제목, 급여, 최소급여, 최대급여, 급여등급, 
--    소속부서명을 조회하기
select a.first_name, a.job_id, b.job_title, a.salary, b.min_salary, b.max_salary, C.gra
from employees A, jobs B, job_grades C, departments D
where a.department_id = 80
and a.job_id = b.job_id
and a.department_id = d.department_id
and a.salary >= c.lowest_sal and a.salary <= c.highest_sal;

--26. 사원들중에서 자신의 상사보다 먼저 입사한 사원들의 이름, 입사일, 상사의 이름, 상사의 입사일을
--    조회하기
select emp.first_name, emp.hire_date, mgr.first_name, mgr.hire_date
from employees EMP, employees MGR
where emp.manager_id = mgr.employee_id
and emp.hire_date < mgr.hire_date;

--27. 부서명이 IT인 부서에 근무하는 사원들의 이름과, 직종, 급여, 급여등급, 상사의 이름과 직종을
--    조회하기
select emp.first_name, emp.job_id, emp.salary, a.gra, mgr.first_name, mgr.job_id
from employees EMP, job_grades A, employees MGR, departments B
where b.department_name = 'IT'
and emp.department_id = b.department_id
and emp.manager_id = mgr.employee_id
and EMP.salary >= a.lowest_sal and EMP.salary <= a.highest_sal;

--28. 'ST_CLERK'로 근무하다가 다른 직종으로 변경한 사원의 아이디, 이름, 변경전 부서명,
--     현재 직종, 현재 근무 부서명을 조회하기
select a.employee_id, a.first_name, 변경전.department_name 변경전, a.job_id, 현재.department_name 현재
from employees A, job_history B, departments 변경전, departments 현재
where b.job_id = 'ST_CLERK'
and a.employee_id = b.employee_id
and a.department_id = 현재.department_id
and b.department_id = 변경전.department_id;