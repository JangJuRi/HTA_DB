-- ��ȭ��ȣ ��ȸ�ϱ�, ���� ����
select *
from scott.contacts;

-- ��ȭ��ȣ �����ϱ�, ���� ����
update scott.contacts
set
    contact_tel = '010-1122-3344'
where
    contact_name = 'ȫ�浿';
 
-- �̸� �����ϱ�, ��ü���� �������� ���� ����   
update scott.contacts   
set
    contact_name = '������'
where
    contact_name = '������';
    

-- SCOTT.CONTACTS�� ���� ���̺��� ���Ǿ �����ϱ�
create SYNONYM contacts for scott.contacts;

select *
from contacts;

-- ������� ��� ���̺� ���� ��ȸ
select *
from user_tables;

-- ������� ��� �� ���� ��ȸ
select *
from user_views;

-- ������� ��� ������ ���� ��ȸ
select *
from user_sequences;

-- ��� ����� ���� ��ȸ
select *
from user_users;



-- ���� ������ ����ϱ�
-- ��� ����� ���� �� ������ �ٹ��ߴ� ������ ��ȸ�ϱ�
-- ������� �ѹ����� ǥ���ϱ�
SELECT EMPLOYEE_ID, JOB_ID  -- ���� �ٹ����� ���� ��ȸ
FROM EMPLOYEES
UNION
SELECT EMPLOYEE_ID, JOB_ID  -- ������ �ٹ��ߴ� ���� ��ȸ
FROM JOB_HISTORY;

-- ��� ����� ���� �μ����̵�� ���� �ҼӺμ� ���̵� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, DEPARTMENT_ID
FROM employees
UNION ALL
SELECT EMPLOYEE_ID, DEPARTMENT_ID
FROM JOB_HISTORY;

-- ���� �����ϴ� ������ ���� �������� �����ϰ� �ִ� ����� ���̵�� �������̵� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, JOB_ID
FROM employees
INTERSECT
SELECT employee_id, JOB_ID
FROM JOB_HISTORY;

SELECT a.employee_id, a.job_id
FROM employees A, JOB_HISTORY B
WHERE a.employee_id = b.employee_id
AND A.JOB_ID = B.JOB_ID;

-- ������ ����� ���� ���� ����� ���̵� ��ȸ�ϱ�
SELECT EMPLOYEE_ID
FROM EMPLOYEES
MINUS
SELECT EMPLOYEE_ID
FROM JOB_HISTORY;
       
-- ������ ����� ���� ���� ����� ���̵�, �̸��� ��ȸ�ϱ�
SELECT a.employee_id, b.first_name
FROM ( SELECT EMPLOYEE_ID
       FROM EMPLOYEES
       MINUS
       SELECT EMPLOYEE_ID
       FROM JOB_HISTORY) A, employees B
WHERE a.employee_id = b.employee_id
ORDER BY 1;

-- ������ ����� ���� ���� ����� ���̵�, �̸�, ��������, �ҼӺμ����� ��ȸ�ϱ�
SELECT a.EMPLOYEE_ID, B.FIRST_NAME, B.JOB_ID, C.DEPARTMENT_NAME
FROM ( SELECT EMPLOYEE_ID
       FROM employees
       MINUS
       SELECT EMPLOYEE_ID
       FROM JOB_HISTORY) A, employees B, departments C
WHERE A.EMPLOYEE_ID = B.EMPLOYEE_ID
AND b.department_id = c.department_id;

-- ��� ����� ���� �� ������ �ٹ��ߴ� ������ ��ȸ�ϱ�
-- ������̵�, ����, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, JOB_ID, SALARY
FROM EMPLOYEES
UNION
SELECT EMPLOYEE_ID, JOB_ID, 0
FROM JOB_HISTORY;



-- ������̺��� �޿��� 5000�̻� 12000������ ����� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT employee_id, first_name, salary
FROM EMPLOYEES
WHERE salary >= 5000 AND salary <= 12000;

-- ������� �Ҽӵ� �μ��� �μ����� �ߺ����� ��ȸ�ϱ�
SELECT DISTINCT b.department_name
FROM EMPLOYEES A, DEPARTMENTS B
WHERE a.department_id = b.department_id;

-- 2007�⿡ �Ի��� ����� ���̵�, �̸�, �Ի����� ��ȸ�ϱ�
SELECT employee_id, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE to_char(hire_date, 'yyyy') = '2007';

-- �޿��� 5000�̻� 12000�����̰�, 20���� 50�� �μ��� �Ҽӵ� ����� ���̵�, �̸�, �޿�, �ҼӺμ����� ��ȸ�ϱ�
SELECT a.employee_id, a.first_name, A.SALARY, B.DEPARTMENT_NAME
FROM EMPLOYEES A, DEPARTMENTS B
WHERE a.salary >= 5000 AND A.SALARY <= 12000
and a.department_id = b.department_id
AND a.department_id IN(20, 50);

-- 100�� �������� �����ϴ� ����� ���̵�, �̸�, �޿�, �޿������ ��ȸ�ϱ�
SELECT a.employee_id, a.first_name, A.SALARY, B.GRA
FROM EMPLOYEES A, EMP_SALARY_GRADE_VIEW B
WHERE a.employee_id = b.employee_id
AND a.manager_id = 100;

-- 80�� �μ��� �ҼӵǾ��ְ�, 80�� �μ��� ��ձ޿����� ���� �޿��� �޴� ����� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT A.employee_id, A.FIRST_NAME, A.SALARY
FROM EMPLOYEES A, (SELECT TRUNC(AVG(SALARY))AVG_SALARY
                   FROM EMPLOYEES
                   WHERE DEPARTMENT_ID = 80
                   GROUP BY DEPARTMENT_ID) B
WHERE A.DEPARTMENT_ID = 80
AND a.salary < b.avg_salary;


-- 50�� �μ��� �Ҽӵ� ��� �߿��� �ش� ������ �ּұ޿����� 2�� �̻��� �޿��� �޴� ����� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT a.employee_id, a.first_name, A.SALARY
FROM EMPLOYEES A, (SELECT a.employee_id, B.MIN_SALARY
                   FROM EMPLOYEES A, JOBS B
                   WHERE A.JOB_ID = B.JOB_ID
                   AND a.department_id = 50) B
WHERE a.department_id = 50
AND a.employee_id = b.employee_id
AND a.salary >= b.min_salary*2;

-- ����� �߿��� �ڽ��� ��纸�� ���� �Ի��� ����� ���̵�, �̸�, �Ի���, ����� �Ի����� ��ȸ�ϱ�
SELECT a.employee_id, a.first_name, A.HIRE_DATE ���, B.HIRE_DATE ���
FROM EMPLOYEES A, EMPLOYEES B
WHERE a.manager_id = b.employee_id
AND a.hire_date < b.hire_date;

-- STEVEN KING�� ���� �μ����� �ٹ��ϴ� ����� ���̵�� �̸��� ��ȸ�ϱ�
SELECT employee_id, first_name
FROM EMPLOYEES
WHERE department_id in(select department_id
                       from employees
                       where first_name = 'Steven' and last_name = 'King');

-- �����ں� ������� ��ȸ�ϱ�, ������ ���̵�, ������� ����Ѵ�. ������ ���̵������ �������� ����
SELECT manager_id, COUNT(*)
FROM EMPLOYEES
GROUP BY manager_id
ORDER BY manager_id ASC;

-- Ŀ�̼��� �޴� ����� ���̵�, �̸�, �޿�, Ŀ�̼��� ��ȸ�ϱ�
SELECT employee_id, FIRST_NAME, SALARY, commission_pct
FROM EMPLOYEES
WHERE commission_pct IS NOT NULL;

-- �޿��� ���� ���� �޴� ��� 3���� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT employee_id, FIRST_NAME, SALARY
FROM (SELECT employee_id, first_name, salary
      from employees
      order by salary desc)
where rownum <=3;

-- Ismael�� ���� �ؿ� �Ի��߰�, ���� �μ��� �ٹ��ϴ� ����� ���̵�, �̸�, �Ի����� ��ȸ�ϱ�
select employee_id, first_name, hire_date
from employees
where hire_date >= (select to_date(to_char(hire_date, 'yyyy')||'0101','yyyymmdd')
                    from employees
                    where first_name = 'Ismael')
and hire_date <= (select to_date(to_char(hire_date, 'yyyy')|| '1231', 'yyyymmdd') + 1
                  from employees
                  where first_name = 'Ismael');

-- Renske���� ����޴� ����� ���̵�, �̸�, �޿�, �޿������ ��ȸ�ϱ�
select a.employee_id, a.first_name, a.salary, b.gra
from employees A, job_grades B
where a.salary >= b.lowest_sal and a.salary <= b.highest_sal
and a.employee_id = (select manager_id
                     from employees
                     where first_name = 'Renske');

-- ������̺��� �޿��� �������� �޿������ ��ȸ���� ��, �޿���޺� ������� ��ȸ�ϱ�
select y.gra, nvl(x.cnt,0)
from (select b.gra, count(*) cnt
from employees A, job_grades B
where a.salary >= b.lowest_sal and a.salary <= b.highest_sal
group by b.gra)X, job_grades Y
where x.gra(+) = y.gra
order by y.gra;

-- �Ի��ڰ� ���� ���� �⵵�� �� �ؿ� �Ի��� ������� ��ȸ�ϱ�
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
             
-- �����ں� ������� ��ȸ���� �� �����ϴ� ������� 10���� �Ѵ� �������� ���̵�� ������� ��ȸ�ϱ�
select manager_id, count(*)
from employees
where manager_id is not null
group by manager_id
having count(*) > 10;

-- EUROPE �������� �ٹ����� ����� ���̵�, �̸�, �ҼӺμ���, ������ ���ø�, �����̸��� ��ȸ�ϱ�
select e.employee_id, e.first_name, d.department_name, c.city, b.country_name
from regions A, countries B, locations C, departments D, employees E
where a.region_name = 'Europe'
and a.region_id = b.region_id
and b.country_id = c.country_id
and c.location_id = d.location_id
and d.department_id = e.department_id;

-- ��ü ����� ������̵�, �̸�, �޿�, �ҼӺμ����̵�, �ҼӺμ���, ����� �̸��� ��ȸ�ϱ�
select ���.employee_id, ���.first_name, ���.salary, ���.department_id, �μ�.department_name, ���.first_name
from employees ���, employees ���, departments �μ�
where ���.manager_id = ���.employee_id
and ���.department_id = �μ�.department_id;

-- 50�� �μ��� �ٹ����� ������� �޿��� 500�޷� �λ��Ű��
update employees
set
    salary = salary + 500
where department_id = 50;

-- ����� ���̵�, �̸�, �޿�, ���ʽ��� ��ȸ�ϱ�
-- ���ʽ��� 20000�޷� �̻��� �޿��� 10%, 10000�޷� �̻��� �޿��� 15%, �� �ܴ� �޿��� 20%�� �����Ѵ�.
select employee_id, first_name, salary,
    case
        when salary >= 20000 then trunc(salary*0.1)
        when salary >= 10000 then trunc(salary*0.15)
        else salary*0.2
    end bonus
from employees;

-- �ҼӺμ����� �Ի����� ������, �� ���� �޿��� �޴� ����� �̸�, �Ի���, �ҼӺμ���, �޿��� ��ȸ�ϱ�
select DISTINCT �Ĺ�.first_name, �Ĺ�.hire_date, �Ĺ�.department_id, �Ĺ�.salary
from employees �Ĺ�, employees ����
where �Ĺ�.department_id = ����.department_id
and �Ĺ�.salary > ����.salary
and �Ĺ�.hire_date > ����.hire_date
order by �Ĺ�.first_name;

-- �μ��� ��ձ޿��� ��ȸ���� �� �μ��� ��ձ޿��� 10000�޷� ������ �μ��� ���̵�, �μ���, ��ձ޿��� ��ȸ�ϱ�
-- (��ձ޿��� �Ҽ��� 1�ڸ������� ǥ��)
select a.department_id, b.department_name, trunc(avg(a.salary)) dept_avg_salary
from employees A, departments B
where A.department_id = B.department_id
group by A.department_id, B.department_name
having avg(a.salary) <= 10000
order by a.department_id;

-- ����� �߿��� �ڽ��� �����ϰ� �ִ� ������ �ִ�޿��� ������ �޿��� �޴� ����� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
select a.employee_id, a.first_name, a.salary, a.job_id, b.max_salary
from employees A, jobs B
where A.job_id = B.job_id
and a.salary = b.max_salary;

-- �м��Լ��� ����ؼ� ������� �޿������� �������� �����ϰ�, ������ �ο����� �� 6~10��° ���ϴ� ����, ����� ���̵�, �̸�, �޿�, �޿������ ��ȸ�ϱ�
select A.num, a.employee_id, a.first_name, a.salary, b.gra
from (select num, employee_id, first_name, salary
      from (select row_number() over(order by salary desc) num, 
                   employee_id, first_name, salary
            from employees)
      where num >= 6 and num <= 10) A, job_grades B
where A.salary >= B.lowest_sal and A.salary <= B.highest_sal;