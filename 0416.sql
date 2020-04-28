-- ���̺��� ��� ���� ��ȸ�ϱ�
-- ������� ���� ��ȸ�ϱ�
select *
from employees;

-- �μ����� ���� ��ȸ�ϱ�
select *
from departments;

-- ���̺��� ���� �����ؼ� ��ȸ�ϱ�
-- ������̵�, �����, �������̵�, �޿� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees;

-- �������̵�, ������ �ּұ޿�, �ִ�޿� ��ȸ�ϱ�
select job_id, min_salary, max_salary
from jobs;

-- �������̵�, ���ø�, �ּ� ��ȸ�ϱ�
select location_id, city, street_address
from locations;

-- ������̵�, �����, �Ի��� ��ȸ�ϱ�
select employee_id, first_name, hire_date
from employees;


-- �����ڸ� �̿��ϱ�
-- ������̵�, ����, �޿�, ������ ��ȸ�ϱ�
select employee_id, job_id, salary, salary*12 as ����
from employees;

-- ������̵�, ����, �޿�, �ñ��� ��ȸ�ϱ�, �ñ��� �޿�/(5*8)
select employee_id, job_id, salary, salary/(5*8) as �ñ�
from employees;

-- ���� �����ؼ� ��ȸ�ϱ�
-- 60�� �μ����� �ٹ��ϴ� ����� ���̵�, �̸�, ����, �μ����̵� ��ȸ�ϱ�
select employee_id, first_name, job_id, department_id
from employees
where department_id = 60;

-- �޿��� 5000�޷� ���Ϸ� �޴� ������̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees
where salary <= 5000;

-- 100�� �������� �����ϴ� ������ ���̵�, �̸� ��ȸ�ϱ�
select employee_id, first_name
from employees
where manager_id = 100;

-- 100�� ����� �μ�����ڷ� ������ �μ��� ���̵�, �μ����� ��ȸ�ϱ�
select department_id, department_name
from departments
where manager_id = 100;

-- ���� �ִ� �޿��� 15000�޷� �̻�Ǵ� ������ ���̵�, ��������, �ִ�޿� ��ȸ�ϱ�
select job_id, job_title, max_salary
from jobs
where max_salary >= 15000;

-- �ñ��� 100�޷� �̻� �޴� ������ ���̵�, �̸�, �������̵�, �޿�, �ñ��� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary, salary/(5*8) as �ñ�
from employees
where salary/(5*8) >= 100;

-- �̸��� Neena�� ����� �������̵�, �̸�, �̸���, ��ȭ��ȣ�� ��ȸ�ϱ�
select employee_id, first_name, last_name, email, phone_number
from employees
where first_name = 'Neena';

-- null�� ���� null�� �ƴ� ��츦 �����ؼ� ��ȸ�ϱ�
-- Ŀ�̼��� null�� ������ �������̵�, �̸�, �ҼӺμ� ���̵� ��ȸ�ϱ�
select employee_id, first_name, department_id
from employees
where commission_pct is null;

-- Ŀ�̼��� null�� �ƴ� ������ �������̵�, �̸�, �������̵�, �ҼӺμ� ���̵� ��ȸ�ϱ�
select employee_id, first_name, job_id, department_id
from employees
where commission_pct is not null;

-- �ҼӺμ��� �������� ���� ������ ���̵�, �̸�, �Ի��� ��ȸ�ϱ�
select employee_id, first_name, hire_date
from employees
where department_id is null;

-- �μ�����ڰ� �������� ���� �μ��� ���̵�, �μ����� ��ȸ�ϱ�
select department_id, department_name
from departments
where manager_id is null;

-- �μ�����ڰ� ������ �μ��� �μ����̵�, �μ���, ����� �������̵� ��ȸ�ϱ�
select department_id, department_name, manager_id
from departments
where manager_id is not null;

-- BETWEEN A AND B ����ϱ�
-- �޿��� 2000�̻� 3000���Ϸ� �޴� ����� ���̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees
where salary between 2000 AND 3000;

-- IN(��1, ��2, ��3, ... ) ����ϱ�
-- 10�� �μ��� 20�� �μ��� �Ҽӵ� ����� ���̵�, �̸�, �ҼӺμ� ���̵� ��ȸ�ϱ�
SELECT employee_id, first_name, department_id
from employees
where department_id in(10,20);

-- 50, 60, 70, 80�� �μ��� �Ҽӵ��� ���� ����� ���̵�, �̸�, �ҼӺμ� ���̵� ��ȸ�ϱ�
SELECT employee_id, first_name, department_id
from employees
where department_id not in (50,60,70,80);

-- �������̵� JP, US�� ������ ��ġ���̵�, �ּ�, �������̵� ��ȸ�ϱ�
select location_id, street_address, country_id
from locations
where country_id in ('JP', 'US');

-- ������ �������̵� AD_PRES�̰ų� AD_VP�� ������ ���̵�, �̸�, ������ ��ȸ�ϱ�
select employee_id, first_name, job_id
from employees
where job_id in ('AD_PRES', 'AD_VP');

-- 50�� Ȥ�� 60�� �μ��� �ٹ��� ���� �ִ� ����� ���̵�, �ٹ�������, �ٹ��������� ��ȸ�ϱ�
select employee_id, start_date, end_date
from job_history
where department_id in (50,60);

-- 101���̳� 102�� ������ ���� ������ ����� ���̵�, �̸�, �Ŵ������̵� ��ȸ�ϱ�
select employee_id, first_name, manager_id
from employees
where manager_id in (101,102);

-- �������̵� **_MAN�� ������ ���̵�, �̸�, �������̵�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees
where job_id like '%MAN';

-- �̸��� 'A'�� �����ϴ� ������ �̸��� ���� ��ȸ�ϱ�
select first_name
from employees
where first_name like 'A%';

-- �̸��� 'A'�� �����ϰ� �̸��� 4������ ������ �̸��� ���� ��ȸ�ϱ�
select first_name
from employees
where first_name like 'A___';

-- �̸��� 'e'�� ���Ե� ������ �̸��� ���� ��ȸ�ϱ�
select first_name
from employees
where first_name like '%e%';

-- �� �����ڸ� ����ؼ� 2�� �̻��� ������ �����ϴ� ���� ��ȸ�ϱ�
-- 80�� �μ����� ���ϴ� ���� �� �޿��� 3000�޷� �̸��� ����� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
from employees
where department_id = 80 
and salary < 3000;

-- 50�� �μ����� ���ϴ� ���� �� ������ �Ŵ����� ������ �������̵�, �̸�, �������̵�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees
where department_id = 50
and job_id like '%MAN';

-- 50�� �μ����� ���ϰ�, �޿��� 2500�� ���Ϸ� �ް�, �ڽ��� �Ŵ����� ���̵� 121���� ������ ���̵�, �̸�, �Ի���, �޿�, �������̵� ��ȸ�ϱ�
select employee_id, first_name, hire_date, salary, job_id
from employees
where department_id = 50 
and salary <= 2500 
and manager_id = 121;

-- 50�̳� 60�� �μ��� �Ҽӵ� ���� �߿��� �̸��� 'A'�� �����ϴ� ������ ���̵�, �̸�, �μ����̵� ��ȸ�ϱ�
select employee_id, first_name, department_id
from employees
where department_id in (50, 60)
-- where (department_id = 50 or department_id = 60)
and first_name like 'A%';

-- Ŀ�̼��� �޴� ���� �߿��� �޿��� 10000�޷� �̻� �޴� ������ ���̵�, �̸�, ����, �Ի���, �޿�, ������ ��ȸ�ϱ�
-- ���� = �޿�*4*12 + �޿�*Ŀ�̼�*4*12
select 
    employee_id
    , first_name
    , job_id
    , hire_date
    , salary
    , salary*4*12 + salary*commission_pct*4*12 as ����
from employees
where commission_pct is not null 
and salary >= 10000;

-- �����ϱ�
-- 60�� �μ��� �Ҽӵ� ������� ���̵�, �̸�, �޿�, �Ի����� ��ȸ�ϱ�
-- �̸������� �������� �����ϱ�
select employee_id, first_name, salary, hire_date
from employees
where department_id = 60
order by first_name;

-- 60�� �μ��� �Ҽӵ� ������� ���̵�, �̸�, �޿�, �Ի����� ��ȸ�ϱ�
-- �̸������� �������� �����ϱ�
select employee_id, first_name, salary, hire_date
from employees
where department_id = 60
order by first_name desc;

-- 60�� �μ��� �Ҽӵ� ������� ���̵�, �̸�, �޿�, ����, �Ի����� ��ȸ�ϱ�
-- ���������� �������� �����ϱ�
select employee_id, first_name, salary, salary*4*12 ����, hire_date
from employees
where department_id = 60
order by salary*4*12 asc;   -- ������� ����ؼ� �����ϱ�

-- 60�� �μ��� �Ҽӵ� ������� ���̵�, �̸�, �޿�, ����, �Ի����� ��ȸ�ϱ�
-- ���������� �������� �����ϱ�
select employee_id, first_name, salary, salary*4*12 ����, hire_date
from employees
where department_id = 60
order by 4 asc;             -- �÷��� ������ ����ؼ� �����ϱ�

-- 60�� �μ��� �Ҽӵ� ������� ���̵�, �̸�, �޿�, ����, �Ի����� ��ȸ�ϱ�
-- ���������� �������� �����ϱ�
select employee_id, first_name, salary, salary*4*12 ����, hire_date
from employees
where department_id = 60
order by ���� asc;             -- �÷��� ��Ī�� ����ؼ� �����ϱ�

-- 50�� �μ��� �Ҽӵ� ���� �߿��� ������ 200000�޷� �̻��� �������� ���̵�, �̸�, �޿�, ����, �Ի����� ��ȸ�ϱ�
-- ���������� �������� �����ϱ�
select employee_id, first_name, salary, salary*4*12 ����, hire_date
from employees
-- where department_id = 50 and ���� >= 200000  --> ���� : SELECT������ ������ ��Ī�� WHERE������ ����� �� ����.
where department_id = 50 and salary*4*12 >= 200000
order by ����;

-- 50�� �μ����� �ٹ��ϴ� �������� �̸�, �޿��� ��ȸ�ϱ�
-- �޿������� �������� �����ϰ�, ���� �޿��� �����ϸ� �̸������� �������� �����ϱ�
select first_name, salary
from employees
where department_id = 50
order by salary desc, first_name asc;

-- ������ �Լ� �� �����Լ� ����ϱ�
-- ����� ���̵�, �̸��� ��ȸ�ϱ�(�̸��� �빮�ڷ� ǥ��)
select employee_id
    , UPPER(first_name)
    , LOWER(first_name)
    , LENGTH(first_name)
    , CONCAT(first_name, last_name)
    , LPAD(first_name, 10, '#')
    , RPAD(first_name, 10, '@')
from employees;


-------------------------------------------------------------------------------------

-- �μ����̺��� ��� �μ� ������ ��ȸ�ϱ�
select department_id
    , department_name
    , manager_id
    , location_id
from departments;

-- �μ����̺��� ��ġ���̵� 1700���� �ƴ� �μ� ���� ��ȸ�ϱ�
select department_id
    , department_name
    , manager_id
    , location_id
from departments
where location_id != 1700;

-- 100����� �����ϴ� �μ����� ��ȸ�ϱ�
select department_id
    , department_name
    , manager_id
    , location_id
from departments
where manager_id = 100;

-- �μ����� 'IT'�� �μ��� ���� ��ȸ�ϱ�
select department_id
    , department_name
    , manager_id
    , location_id
from departments
where department_name = 'IT';

-- ��ġ���̵� 1700���� ������ �ּ�, �����ȣ, ���ø�, �����ڵ带 ��ȸ�ϱ�
select location_id, postal_code, country_id, city, country_id
from locations
where location_id = 1700;

-- �ּұ޿��� 2000�̻� 5000������ ������ �������̵�, ��������, �ּұ޿�, �ִ�޿� ��ȸ�ϱ�
select job_id, job_title, min_salary, max_salary
from jobs
where min_salary >= 2000 and min_salary <= 5000;

-- �ִ�޿��� 20000���� �ʰ��ϴ� ������ ���̵�, ��������, �ּұ޿�, �ִ�޿� ��ȸ�ϱ�
select job_id, job_title, min_salary, max_salary
from jobs
where max_salary > 20000;

-- 100�������� �����ϴ� ����� ���̵�, �̸�, �μ����̵��� ��ȸ�ϱ�
select employee_id, first_name, department_id
from employees
where manager_id = 100;

-- 80�� �μ����� �ٹ��ϰ� �޿��� 8000�� �̻� �޴� ����� ���̵�, �̸�, �޿�, Ŀ�̼�����Ʈ ��ȸ�ϱ�
select employee_id, first_name, salary, commission_pct
from employees
where department_id = 80 and salary >= 8000;

-- ������ SA_REP�̰�, Ŀ�̼�����Ʈ�� 0.25�̻��� ����� ���̵�, �̸�, �޿�, Ŀ�̼�����Ʈ�� ��ȸ�ϱ�
select employee_id, first_name, salary, commission_pct
from employees
where job_id = 'SA_REP' and commission_pct >= 0.25;

-- 80�� �μ��� �ٹ��ϰ�, �޿��� 10000�� �̻��� ����� ���̵�, �̸�, �޿�, ������ ��ȸ�ϱ�
--  ���� = (�޿� + �޿�*Ŀ�̼�)*12��
--  ������ ��Ī�� annual_salary��.
select employee_id, first_name, salary, (salary + salary*commission_pct)*12 as annual_salary
from employees
where department_id = 80 and salary >= 10000;

-- 80�� �μ��� �ٹ��ϰ�, 147�� �������� �����ϴ� ��� �߿��� Ŀ�̼��� 0.1�� ����� 
--  ������̵�, �̸�, ����, �޿�, Ŀ�̼�����Ʈ�� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary, commission_pct
from employees
where department_id = 80 and manager_id = 147 and commission_pct = 0.1;

-- ������� �����ϴ� ������ �ߺ����� ��ȸ�ϱ�
select distinct job_id
from employees;

-- ������� �Ҽӵ� �μ����̵� ��� ��ȸ�ϱ�
select department_id
from employees
where department_id is not null;

-- �޿��� 12000�� �Ѵ� ����� �̸��� �޿��� ��ȸ�ϱ�
select first_name, salary
from employees
where salary > 12000;

-- �޿��� 5000�̻� 12000������ ����� �̸��� �޿��� ��ȸ�ϱ�
select first_name, salary
from employees
where salary >= 5000 and salary <= 12000;

-- 20�� 50�� �μ��� �Ҽӵ� ����� �̸��� �μ���ȣ�� ��ȸ�ϰ�, �̸��� ���ĺ������� �����ؼ�  ��ȸ�ϱ�
select first_name, department_id
from employees
where department_id in (20, 50)
order by first_name;

-- �޿��� 5000�̻� 12000���ϰ�, 20���� 50�� �μ��� �Ҽӵ� ����� �̸��� �޿�, �μ���ȣ�� ��ȸ�ϱ�
select first_name, salary, department_id
from employees
where salary >= 5000 and salary <= 12000 and department_id in (20, 50);

-- �����ڰ� ���� ����� �̸��� ����, �޿��� ��ȸ�ϱ�
select first_name, job_id, salary
from employees
where manager_id is null;

-- ������ 'SA_MAN'�̰ų� 'ST_MAN'�� �����߿��� �޿��� 8000�̻� �޴� ����� ���̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees
where job_id in ('SA_MAN', 'ST_MAN') and salary >= 8000;