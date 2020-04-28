-- 조인하기
-- 급여를 3000달러 받는 사원의 아이디, 이름, 직종아이디, 소속부서아이디, 소속부서명을 조회하기
select employee_id, first_name, job_id, employees.department_id, department_name
from employees, departments
where employees.department_id = departments.department_id and salary = 3000;

-- 급여를 15000달러 이상 받은 직원의
-- 직원아이디, 이름, 급여, 직종아이디, 직종제목, 직종최저급여, 직종최고급여를 조회하기
select A.employee_id, A.first_name, A.salary, B.job_id, B.job_title, B.min_salary, B.max_salary
from employees A,jobs B
where salary >= 15000
and A.job_id = B.job_id;

-- 부서관리자가 지정된 부서의
-- 부서아이디, 부서명, 도시명, 우편번호, 주소 조회하기
select A.department_id, A.department_name, B.city, B.postal_code, B.street_address
from departments A, locations B
where a.manager_id is not null
and A.location_id = B.location_id
order by a.department_id asc;

-- 관리자가 지정된 부서의
-- 부서아이디, 부서명, 관리자아이디, 관리자 이름을 조회하기
select A.department_id, a.department_name, a.manager_id, B.first_name
from departments A, employees B
where a.manager_id is not null
and a.manager_id = b.employee_id;

-- 3개 이상의 테이블 조인하기
-- 급여를 12000이상 받은 사원의
-- 사원아이디, 이름, 급여, 직종아이디, 직종제목, 소속부서아이디, 소속부서명을 조회하기
select a.employee_id, a.first_name, a.salary, a.job_id, b.job_title, a.department_id, c.department_name
from employees A, jobs B, departments C
where a.job_id = b.job_id
and a.department_id = c.department_id
and a.salary >= 12000;

-- 부서 관리자가 지정된 부서의
-- 부서아이디, 부서명, 관리자의 직원아이디, 직원명, 위치 아이디, 도시명, 주소 조회하기
select a.department_id, a.department_name, a.manager_id, b.first_name, c.location_id, c.city, c.street_address
from departments A, employees B, locations C
where a.manager_id is not null
and a.manager_id = b.employee_id
and a.location_id = c.location_id;

-- 부서 관리자가 지정된 부서의
-- 부서아이디, 부서명, 위치 아이디, 도시명, 주소, 국가아이디, 국가명 조회하기
select a.department_id, a.department_name, b.location_id, b.city, b.street_address, c.country_id, c.country_name
from departments A, locations B, countries C
where a.manager_id is not null
and a.location_id = b.location_id
and b.country_id = c.country_id;

-- Seattle에 소재한 부서에서 근무하는 직원의 아이디, 이름, 직종 아이디, 소속부서 아이디, 소속부서명을 조회하기
select a.employee_id, a.first_name, a.job_id, b.department_id, b.department_name
from employees A, departments B, locations C
-- where c.location_id = '1700'
where c.city = 'Seattle'
and a.department_id = b.department_id
and b.location_id = c.location_id;

-- 직종 변경 이력에서
-- 직원아이디, 직원이름, 업무시작일, 업무종료일, 직종아이디, 직종제목, 소속부서아이디, 부서명 조회하기
select a.employee_id
    , a.first_name
    , b.start_date
    , b.end_date
    , b.job_id
    , c.job_title
    , b.department_id
    , d.department_name
from employees A, job_history B, jobs C, departments D
where b.employee_id = a.employee_id
and b.job_id = c.job_id
and b.department_id = d.department_id
order by b.employee_id asc, b.start_date;


-- 비등가 조인
-- 50번 부서에 소속된 직원의 급여 등급을 조회하기
-- 직원아이디, 이름, 급여, 급여 등급
select a.employee_id, a.first_name, b.lowest_sal, a.salary, b.highest_sal, b.gra
from employees A, job_grades B
where a.department_id = 50
and a.salary >= b.lowest_sal and a.salary <= b.highest_sal
order by a.employee_id;

-- 직종별 최저/최고급여의 등급 조회하기
-- 직종아이디, 직종제목, 직종최저급여, 급여등급
select a.job_id, a.job_title, a.min_salary, b.gra min_salary_gra, a.max_salary, c.gra max_salary_gra
from jobs A, job_grades B, job_grades C
where a.min_salary >= b.lowest_sal and a.min_salary <= b.highest_sal
and a.max_salary >= c.lowest_sal and a.max_salary <= c.highest_sal
order by a.job_id;


-- 1.  시스템의 현재 날짜와 시간 조회하기 (dual 사용)
select sysdate
from dual;

-- 2.  급여를 5000달러 이상받고, 2005년에 입사한 직원의 아이디, 이름, 급여, 입사일을 조회하기
select employee_id, first_name, salary, hire_date
from employees
where salary >= 5000
and to_char(hire_date, 'yyyy') = '2005';

-- 3.  이름에 e나 E가 포함된 직원 중에서 급여를 10000달러 이상 받는 직원의 아이디, 이름, 급여를 조회하기
select employee_id, first_name, salary
from employees
where (first_name like '%e%' or first_name like '%E%')
and salary >= 10000;

-- 4.  입사년도와 상관없이 4월에 입사한 직원들의 아이디, 이름, 입사일을 조회하기
select employee_id, first_name, hire_date
from employees
where to_char(hire_date, 'mm') = '04';

-- 5.  2006년 상반기(1/1 ~ 6/30)에 입사한 직원들의 아이디, 이름, 입사일 조회하기
select employee_id, first_name, hire_date
from employees
where hire_date >= to_date('20060101', 'yyyymmdd')
and hire_date <= to_date('20060630', 'yyyymmdd');

-- 6.  50번 부서에 소속된 직원들의 급여를 13%인상시키려고 한다.
--     직원아이디, 이름, 현재 급여, 인상된 급여를 조회하기
--     인상된 급여는 소숫점 이하는 버린다.
select employee_id, first_name, salary, trunc(salary + salary*0.13 )인상급여
from employees
where department_id = 50;

-- 7.  50번 부서에 소속된 직원들의 급여를 조회하려고 한다.
--     직원 아이디, 이름, 급여 그리고, 급여 1000달러당 *를 하나씩 표시하라.
--     120 Matthew 8000 ********
--     122 Shanta  6500 ******
select employee_id, first_name, salary, rpad('*',trunc(salary/1000),'*')
from employees
where department_id = 50;

-- 8.  관리자가 지정되어 있지 않는 부서의 
--     부서아이디, 부서명, 위치아이디, 도시명, 주소를 조회하기
select a.department_id, a.department_name, b.location_id, b.street_address
from departments A, locations B
where a.manager_id is null
and a.location_id = b.location_id;

-- 9.  90번 부서에 소속된 직원의 직원아이디, 이름, 직종, 급여를 조회하기
select employee_id, first_name, job_id, salary
from employees
where department_id = 90;

-- 9-2. 'Executive' 부서에 소속된 직원의 직원아이디, 이름, 직종, 급여를 조회하기
select a.employee_id, a.first_name, a.job_id, a.salary
from employees A, departments B
where b.department_name = 'Executive'
and a.department_id = b.department_id;

-- 10. 100번 직원이 부서관리자로 지정된 부서에 소속된 직원의 직원아이디, 이름, 직종, 급여를 조회하기
select employee_id, first_name, job_id, salary
from employees A, departments B
where b.manager_id = 100
and a.department_id = b.department_id;

-- 11. 10, 20, 30번 부서에 소속된 직원들의 직원아이디, 이름, 급여, 급여등급을 조회하기
select employee_id, first_name, salary, gra
from employees A, job_grades B
where a.salary >= b.lowest_sal and a.salary <= b.highest_sal
and a.department_id in (10, 20, 30);

-- 12. 직원들의 직종정보를 참고했을 때 자신이 종사하고 있는 직종의 최저급여를 받고 있는
--     직원의 아이디, 이름, 급여, 직종아이디, 직종최저급여를 조회하기
select a.employee_id, a.first_name, a.salary, b.job_id, b.min_salary
from employees A, jobs B
where a.job_id = b.job_id
and a.salary = b.min_salary;

-- 13. 커미션을 받는 직원들의 직원아이디, 이름, 커미션, 급여, 직종아이디, 직종제목, 급여, 소속부서 아이디, 부서명을 조회하기
select a.employee_id, a.first_name, a.commission_pct, b.job_id, b.job_title, c.department_id, c.department_name
from employees A, jobs B, departments C
where a.commission_pct is not null
and a.job_id = b.job_id
and a.department_id = c.department_id;

-- 14. 'Canada'에서 근무하고 있는 직원의 아이디, 이름, 소속부서 아이디, 소속부서명, 위치 아이디, 도시명, 주소를 조회하기
select a.employee_id, a.first_name, b.department_id, b.department_name, c.location_id, c.city, c.street_address
from employees A, departments B, locations C, countries D
where a.department_id = b.department_id
and b.location_id = c.location_id
and c.country_id = d.country_id
and d.country_name = 'Canada';

-- 15. 모든 직원의 직원아이디, 이름, 직종아이디, 직종제목, 급여, 급여등급, 소속부서 아이디, 소속부서명, 도시명을 조회하기
select a.employee_id, a.first_name, b.job_id, b.job_title, a.salary, c.gra, d.department_id, d.department_name, e.city
from employees A, jobs B, job_grades C, departments D, locations E 
where a.job_id = b.job_id
and a.salary >= c.lowest_sal and a.salary <= c.highest_sal
and a.department_id = d.department_id
and d.location_id = e.location_id;

-- 16. 급여를 5000달러 이하로 받는 직원들의 아이디, 이름, 직종, 소속부서 아이디, 소속부서명, 소속부서 관리자 직원아이디, 
--     소속부서 관리자 직원이름을 조회하기
select a.employee_id, a.first_name, a.job_id, b.department_id, b.department_name, b.manager_id, c.first_name
from employees A, departments B, employees C
where a.salary <= 5000
and a.department_id = b.department_id
and b.manager_id = c.employee_id;

-- 17. 'Asia'지역에 소재지를 두고 있는 부서의 아이디, 부서명, 부서관리자 이름을 조회하기
select a.department_id, a.department_name, b.first_name
from departments A, employees B, locations C, Countries D, regions E
where a.department_id = b.department_id
and a.location_id = c.location_id
and c.country_id = d.country_id
and d.region_id = e.region_id
and e.region_name = 'Asia';

-- 18. 101번 직원이 근무했던 부서에서 근무중이 직원의 아이디, 이름, 부서아이디, 부서명을 조회하기
select distinct a.employee_id, a.first_name, b.department_id, b.department_name
from employees A, departments B, job_history C
where c.employee_id = 101
and c.department_id = a.department_id
and b.department_id = c.department_id;

-- 19. 직원중에서 자신이 종사하고 있는 직종의 최고급여 50%이상을 급여로 받고 있는 
--     직원의 아이디, 이름, 급여, 직종아이디, 직종 최고급여를 조회하기
select a.employee_id, a.first_name, a.salary, a.job_id, b.max_salary
from employees A, jobs B
where a.job_id = b.job_id
and a.salary >= b.max_salary*0.5;

-- 20. 미국(US)에 위치하고 있는 부서의 아이디, 이름, 위치번호, 도시명, 주소를 조회하기 
select a.department_id, a.department_name, b.location_id, b.city, b.street_address
from departments A, locations B
where b.country_id = 'US'
and a.location_id = b.location_id;