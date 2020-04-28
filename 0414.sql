-- ������̵�, �̸�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
FROM employees;

-- �μ����̵�, �μ����� ��ȸ�ϱ�
select department_id, department_name
from departments;

-- �� ���̵�, �� Ÿ��Ʋ�� ��ȸ�ϱ�
select job_id, job_title
from jobs;

-- �����̸� ��ȸ�ϱ�
select country_name
from countries;

-- ������̵�, �̸�, �޿�, ������ ��ȸ�ϱ�
select employee_id as ID, first_name as NAME, salary as SAL, salary*12 as ANN_SAL
from employees;

-- ������̵�, �̸�, �޿�, 10%�λ�� �޿��� ��ȸ�ϱ�
select employee_id ID, first_name NAME, salary SAL, salary + (salary*0.1) "INCREMENT SALARY"
from employees;

-- NULL ���� �ִ� �÷� ��ȸ�ϱ�
-- �μ����̵�, �μ���, �μ������ ���̵� ��ȸ�ϱ�
select department_id, department_name, manager_id
from departments;

-- ������̵�, �̸�, �޿�, Ŀ�̼�, Ŀ�̼��� ���Ե� �޿� ��ȸ�ϱ�
-- Ŀ�̼��� ���Ե� �޿��� �޿� + �޿�*Ŀ�̼�
-- * ����Ŀ� null�� ���ԵǾ������� ����� null
select employee_id, first_name, salary, commission_pct, salary + salary*commission_pct
from employees;

-- �ߺ������ ��ȸ�ϱ�
-- ������� �����ϰ� �ִ� �������̵� ���� ��ȸ�ϱ�
select DISTINCT job_id
from employees;

-- 60�� �μ��� �ٹ��ϴ� ����� ���̵�, �̸�, ����, �޿�, �μ����̵� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary, department_id
from employees
WHERE department_id = 60;

-- �޿��� 15000�޷� �̻� �޴� ����� ���̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees
where salary >= 15000;