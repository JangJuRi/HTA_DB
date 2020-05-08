-- 전화번호 조회하기, 실행 성공
select *
from scott.contacts;

-- 전화번호 변경하기, 실행 성공
update scott.contacts
set
    contact_tel = '010-1122-3344'
where
    contact_name = '홍길동';
 
-- 이름 변경하기, 객체권한 부족으로 실행 오류   
update scott.contacts   
set
    contact_name = '강감찬'
where
    contact_name = '김유신';
    

-- SCOTT.CONTACTS에 대한 테이블의 동의어를 생성하기
create SYNONYM contacts for scott.contacts;

select *
from contacts;

-- 사용자의 모든 테이블 정보 조회
select *
from user_tables;

-- 사용자의 모든 뷰 정보 조회
select *
from user_views;

-- 사용자의 모든 시퀀스 정보 조회
select *
from user_sequences;

-- 모든 사용자 정보 조회
select *
from user_users;



-- 집합 연산자 사용하기
-- 모든 사원의 현재 및 이전에 근무했던 직종을 조회하기
-- 사원별로 한번씩만 표시하기
SELECT EMPLOYEE_ID, JOB_ID  -- 현재 근무중인 직종 조회
FROM EMPLOYEES
UNION
SELECT EMPLOYEE_ID, JOB_ID  -- 이전에 근무했던 직종 조회
FROM JOB_HISTORY;

-- 모든 사원의 현재 부서아이디와 이전 소속부서 아이디를 조회하기
SELECT EMPLOYEE_ID, DEPARTMENT_ID
FROM employees
UNION ALL
SELECT EMPLOYEE_ID, DEPARTMENT_ID
FROM JOB_HISTORY;

-- 현재 종사하는 직종과 같은 직종에서 종사하고 있는 사원의 아이디와 직종아이디 조회하기
SELECT EMPLOYEE_ID, JOB_ID
FROM employees
INTERSECT
SELECT employee_id, JOB_ID
FROM JOB_HISTORY;

SELECT a.employee_id, a.job_id
FROM employees A, JOB_HISTORY B
WHERE a.employee_id = b.employee_id
AND A.JOB_ID = B.JOB_ID;

-- 직종이 변경된 적이 없는 사원의 아이디를 조회하기
SELECT EMPLOYEE_ID
FROM EMPLOYEES
MINUS
SELECT EMPLOYEE_ID
FROM JOB_HISTORY;
       
-- 직종이 변경된 적이 없는 사원의 아이디, 이름을 조회하기
SELECT a.employee_id, b.first_name
FROM ( SELECT EMPLOYEE_ID
       FROM EMPLOYEES
       MINUS
       SELECT EMPLOYEE_ID
       FROM JOB_HISTORY) A, employees B
WHERE a.employee_id = b.employee_id
ORDER BY 1;

-- 직종이 변경된 적이 없는 사원의 아이디, 이름, 현재직종, 소속부서명을 조회하기
SELECT a.EMPLOYEE_ID, B.FIRST_NAME, B.JOB_ID, C.DEPARTMENT_NAME
FROM ( SELECT EMPLOYEE_ID
       FROM employees
       MINUS
       SELECT EMPLOYEE_ID
       FROM JOB_HISTORY) A, employees B, departments C
WHERE A.EMPLOYEE_ID = B.EMPLOYEE_ID
AND b.department_id = c.department_id;

-- 모든 사원의 현재 및 이전에 근무했던 직종을 조회하기
-- 사원아이디, 직종, 급여를 조회하기
SELECT EMPLOYEE_ID, JOB_ID, SALARY
FROM EMPLOYEES
UNION
SELECT EMPLOYEE_ID, JOB_ID, 0
FROM JOB_HISTORY;



-- 사원테이블에서 급여가 5000이상 12000이하인 사원의 아이디, 이름, 급여를 조회하기
SELECT employee_id, first_name, salary
FROM EMPLOYEES
WHERE salary >= 5000 AND salary <= 12000;

-- 사원들이 소속된 부서의 부서명을 중복없이 조회하기
SELECT DISTINCT b.department_name
FROM EMPLOYEES A, DEPARTMENTS B
WHERE a.department_id = b.department_id;

-- 2007년에 입사한 사원의 아이디, 이름, 입사일을 조회하기
SELECT employee_id, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE to_char(hire_date, 'yyyy') = '2007';

-- 급여가 5000이상 12000이하이고, 20번과 50번 부서에 소속된 사원의 아이디, 이름, 급여, 소속부서명을 조회하기
SELECT a.employee_id, a.first_name, A.SALARY, B.DEPARTMENT_NAME
FROM EMPLOYEES A, DEPARTMENTS B
WHERE a.salary >= 5000 AND A.SALARY <= 12000
and a.department_id = b.department_id
AND a.department_id IN(20, 50);

-- 100번 직원에게 보고하는 사원의 아이디, 이름, 급여, 급여등급을 조회하기
SELECT a.employee_id, a.first_name, A.SALARY, B.GRA
FROM EMPLOYEES A, EMP_SALARY_GRADE_VIEW B
WHERE a.employee_id = b.employee_id
AND a.manager_id = 100;

-- 80번 부서에 소속되어있고, 80번 부서의 평균급여보다 적은 급여를 받는 사원의 아이디, 이름, 급여를 조회하기
SELECT A.employee_id, A.FIRST_NAME, A.SALARY
FROM EMPLOYEES A, (SELECT TRUNC(AVG(SALARY))AVG_SALARY
                   FROM EMPLOYEES
                   WHERE DEPARTMENT_ID = 80
                   GROUP BY DEPARTMENT_ID) B
WHERE A.DEPARTMENT_ID = 80
AND a.salary < b.avg_salary;


-- 50번 부서에 소속된 사원 중에서 해당 직종의 최소급여보다 2배 이상의 급여를 받는 사원의 아이디, 이름, 급여를 조회하기
SELECT a.employee_id, a.first_name, A.SALARY
FROM EMPLOYEES A, (SELECT a.employee_id, B.MIN_SALARY
                   FROM EMPLOYEES A, JOBS B
                   WHERE A.JOB_ID = B.JOB_ID
                   AND a.department_id = 50) B
WHERE a.department_id = 50
AND a.employee_id = b.employee_id
AND a.salary >= b.min_salary*2;

-- 사원들 중에서 자신의 상사보다 먼저 입사한 사원의 아이디, 이름, 입사일, 상사의 입사일을 조회하기
SELECT a.employee_id, a.first_name, A.HIRE_DATE 사원, B.HIRE_DATE 상사
FROM EMPLOYEES A, EMPLOYEES B
WHERE a.manager_id = b.employee_id
AND a.hire_date < b.hire_date;

-- STEVEN KING과 같은 부서에서 근무하는 사원의 아이디와 이름을 조회하기
SELECT employee_id, first_name
FROM EMPLOYEES
WHERE department_id in(select department_id
                       from employees
                       where first_name = 'Steven' and last_name = 'King');

-- 관리자별 사원수를 조회하기, 관리자 아이디, 사원수를 출력한다. 관리자 아이디순으로 오름차순 정렬
SELECT manager_id, COUNT(*)
FROM EMPLOYEES
GROUP BY manager_id
ORDER BY manager_id ASC;

-- 커미션을 받는 사원의 아이디, 이름, 급여, 커미션을 조회하기
SELECT employee_id, FIRST_NAME, SALARY, commission_pct
FROM EMPLOYEES
WHERE commission_pct IS NOT NULL;

-- 급여를 가장 많이 받는 사원 3명의 아이디, 이름, 급여를 조회하기
SELECT employee_id, FIRST_NAME, SALARY
FROM (SELECT employee_id, first_name, salary
      from employees
      order by salary desc)
where rownum <=3;

-- Ismael과 같은 해에 입사했고, 같은 부서에 근무하는 사원의 아이디, 이름, 입사일을 조회하기
select employee_id, first_name, hire_date
from employees
where hire_date >= (select to_date(to_char(hire_date, 'yyyy')||'0101','yyyymmdd')
                    from employees
                    where first_name = 'Ismael')
and hire_date <= (select to_date(to_char(hire_date, 'yyyy')|| '1231', 'yyyymmdd') + 1
                  from employees
                  where first_name = 'Ismael');

-- Renske에게 보고받는 사원의 아이디, 이름, 급여, 급여등급을 조회하기
select a.employee_id, a.first_name, a.salary, b.gra
from employees A, job_grades B
where a.salary >= b.lowest_sal and a.salary <= b.highest_sal
and a.employee_id = (select manager_id
                     from employees
                     where first_name = 'Renske');

-- 사원테이블의 급여를 기준으로 급여등급을 조회했을 때, 급여등급별 사원수를 조회하기
select y.gra, nvl(x.cnt,0)
from (select b.gra, count(*) cnt
from employees A, job_grades B
where a.salary >= b.lowest_sal and a.salary <= b.highest_sal
group by b.gra)X, job_grades Y
where x.gra(+) = y.gra
order by y.gra;

-- 입사자가 가장 적은 년도와 그 해에 입사한 사원수를 조회하기
select to_char(hire_date, 'yyyy'), count(*)
from employees
group by to_char(hire_date, 'yyyy')
having count(*) = (select min(count(*))
                   from employees
                   group by to_char(hire_date, 'yyyy'));

with year_count
as (select to_char(hire_date, 'yyyy') year, count(*) cnt
    from employees
    group by to_char(hire_date, 'yyyy'))
select year, cnt
from year_count
where cnt = (select min(cnt)
             from year_count);
             
-- 관리자별 사원수를 조회했을 때 관리하는 사원수가 10명을 넘는 관리자의 아이디와 사원수를 조회하기
select manager_id, count(*)
from employees
where manager_id is not null
group by manager_id
having count(*) > 10;

-- EUROPE 지역에서 근무중인 사원의 아이디, 이름, 소속부서명, 소재지 도시명, 나라이름을 조회하기
select e.employee_id, e.first_name, d.department_name, c.city, b.country_name
from regions A, countries B, locations C, departments D, employees E
where a.region_name = 'Europe'
and a.region_id = b.region_id
and b.country_id = c.country_id
and c.location_id = d.location_id
and d.department_id = e.department_id;

-- 전체 사원의 사원아이디, 이름, 급여, 소속부서아이디, 소속부서명, 상사의 이름을 조회하기
select 사원.employee_id, 사원.first_name, 사원.salary, 사원.department_id, 부서.department_name, 상사.first_name
from employees 사원, employees 상사, departments 부서
where 사원.manager_id = 상사.employee_id
and 사원.department_id = 부서.department_id;

-- 50번 부서에 근무중인 사원들의 급여를 500달러 인상시키기
update employees
set
    salary = salary + 500
where department_id = 50;

-- 사원의 아이디, 이름, 급여, 보너스를 조회하기
-- 보너스는 20000달러 이상은 급여의 10%, 10000달러 이상은 급여의 15%, 그 외는 급여의 20%를 지급한다.
select employee_id, first_name, salary,
    case
        when salary >= 20000 then trunc(salary*0.1)
        when salary >= 10000 then trunc(salary*0.15)
        else salary*0.2
    end bonus
from employees;

-- 소속부서에서 입사일이 늦지만, 더 많은 급여를 받는 사원의 이름, 입사일, 소속부서명, 급여를 조회하기
select DISTINCT 후배.first_name, 후배.hire_date, 후배.department_id, 후배.salary
from employees 후배, employees 선배
where 후배.department_id = 선배.department_id
and 후배.salary > 선배.salary
and 후배.hire_date > 선배.hire_date
order by 후배.first_name;

-- 부서별 평균급여를 조회했을 때 부서별 평균급여가 10000달러 이하인 부서의 아이디, 부서명, 평균급여를 조회하기
-- (평균급여는 소숫점 1자리까지만 표시)
select a.department_id, b.department_name, trunc(avg(a.salary)) dept_avg_salary
from employees A, departments B
where A.department_id = B.department_id
group by A.department_id, B.department_name
having avg(a.salary) <= 10000
order by a.department_id;

-- 사원들 중에서 자신이 종사하고 있는 직종의 최대급여와 동일한 급여를 받는 사원의 아이디, 이름, 급여를 조회하기
select a.employee_id, a.first_name, a.salary, a.job_id, b.max_salary
from employees A, jobs B
where A.job_id = B.job_id
and a.salary = b.max_salary;

-- 분석함수를 사용해서 사원들을 급여순으로 내림차순 정렬하고, 순번을 부여했을 때 6~10번째 속하는 순번, 사원의 아이디, 이름, 급여, 급여등급을 조회하기
select A.num, a.employee_id, a.first_name, a.salary, b.gra
from (select num, employee_id, first_name, salary
      from (select row_number() over(order by salary desc) num, 
                   employee_id, first_name, salary
            from employees)
      where num >= 6 and num <= 10) A, job_grades B
where A.salary >= B.lowest_sal and A.salary <= B.highest_sal;