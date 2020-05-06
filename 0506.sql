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
WHERE a.department_id IS NOT NULL;

-- 2007년에 입사한 사원의 아이디, 이름, 입사일을 조회하기
SELECT employee_id, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE to_char(hire_date, 'yyyy') = '2007';

-- 급여가 5000이상 12000이하이고, 20번과 50번 부서에 소속된 사원의 아이디, 이름, 급여, 소속부서명을 조회하기
SELECT a.employee_id, a.first_name, A.SALARY, B.DEPARTMENT_NAME
FROM EMPLOYEES A, DEPARTMENTS B
WHERE a.salary >= 5000 AND A.SALARY <= 12000
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
SELECT a.employee_id, a.first_name
FROM EMPLOYEES A, EMPLOYEES B
WHERE B.FIRST_NAME = 'Steven' AND B.LAST_NAME = 'King'
AND a.department_id = b.department_id;

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
FROM EMPLOYEES


-- Ismael과 같은 해에 입사했고, 같은 부서에 근무하는 사원의 아이디, 이름, 입사일을 조회하기

-- Renske에게 보고받는 사원의 아이디, 이름, 급여, 급여등급을 조회하기

-- 사원테이블의 급여를 기준으로 급여등급을 조회했을 때, 급여등급별 사원수를 조회하기

-- 입사자가 가장 적은 년도와 그 해에 입사한 사원수를 조회하기

-- 관리자별 사원수를 조회했을 때 관리하는 사원수가 10명을 넘는 관리자의 아이디와 사원수를 조회하기

-- EUROPE 지역에서 근무중인 사원의 아이디, 이름, 소속부서명, 소재지 도시명, 나라이름을 조회하기

-- 전체 사원의 사원아이디, 이름, 급여, 소속부서아이디, 소속부서명, 상사의 이름을 조회하기

-- 50번 부서에 근무중인 사원들의 급여를 500달러 인상시키기

-- 사원의 아이디, 이름, 급여, 보너스를 조회하기
-- 보너스는 20000달러 이상은 급여의 10%, 10000달러 이상은 급여의 15%, 그 외는 급여의 20%를 지급한다.

-- 소속부서에서 입사일이 늦지만, 더 많은 급여를 받는 사원의 이름, 입사일, 소속부서명, 급여를 조회하기

-- 부서별 평균급여를 조회했을 때 부서별 평균급여가 10000달러 이하인 부서의 아이디, 부서명, 평균급여를 조회하기
-- (평균급여는 소숫점 1자리까지만 표시)

-- 사원들 중에서 자신 종사하고 있는 직종의 최대급여와 동일한 급여를 받는 사원의 아이디, 이름, 급여를 조회하기

-- 분석함수를 사용해서 사원들을 급여순으로 정렬하고, 순번을 부여했을 때 6~10번째 속하는 순번, 사원의 아이디, 이름, 급여, 급여등급을 조회하기