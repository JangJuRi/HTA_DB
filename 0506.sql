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
WHERE a.department_id IS NOT NULL;

-- 2007�⿡ �Ի��� ����� ���̵�, �̸�, �Ի����� ��ȸ�ϱ�
SELECT employee_id, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE to_char(hire_date, 'yyyy') = '2007';

-- �޿��� 5000�̻� 12000�����̰�, 20���� 50�� �μ��� �Ҽӵ� ����� ���̵�, �̸�, �޿�, �ҼӺμ����� ��ȸ�ϱ�
SELECT a.employee_id, a.first_name, A.SALARY, B.DEPARTMENT_NAME
FROM EMPLOYEES A, DEPARTMENTS B
WHERE a.salary >= 5000 AND A.SALARY <= 12000
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
SELECT a.employee_id, a.first_name
FROM EMPLOYEES A, EMPLOYEES B
WHERE B.FIRST_NAME = 'Steven' AND B.LAST_NAME = 'King'
AND a.department_id = b.department_id;

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
FROM EMPLOYEES


-- Ismael�� ���� �ؿ� �Ի��߰�, ���� �μ��� �ٹ��ϴ� ����� ���̵�, �̸�, �Ի����� ��ȸ�ϱ�

-- Renske���� ����޴� ����� ���̵�, �̸�, �޿�, �޿������ ��ȸ�ϱ�

-- ������̺��� �޿��� �������� �޿������ ��ȸ���� ��, �޿���޺� ������� ��ȸ�ϱ�

-- �Ի��ڰ� ���� ���� �⵵�� �� �ؿ� �Ի��� ������� ��ȸ�ϱ�

-- �����ں� ������� ��ȸ���� �� �����ϴ� ������� 10���� �Ѵ� �������� ���̵�� ������� ��ȸ�ϱ�

-- EUROPE �������� �ٹ����� ����� ���̵�, �̸�, �ҼӺμ���, ������ ���ø�, �����̸��� ��ȸ�ϱ�

-- ��ü ����� ������̵�, �̸�, �޿�, �ҼӺμ����̵�, �ҼӺμ���, ����� �̸��� ��ȸ�ϱ�

-- 50�� �μ��� �ٹ����� ������� �޿��� 500�޷� �λ��Ű��

-- ����� ���̵�, �̸�, �޿�, ���ʽ��� ��ȸ�ϱ�
-- ���ʽ��� 20000�޷� �̻��� �޿��� 10%, 10000�޷� �̻��� �޿��� 15%, �� �ܴ� �޿��� 20%�� �����Ѵ�.

-- �ҼӺμ����� �Ի����� ������, �� ���� �޿��� �޴� ����� �̸�, �Ի���, �ҼӺμ���, �޿��� ��ȸ�ϱ�

-- �μ��� ��ձ޿��� ��ȸ���� �� �μ��� ��ձ޿��� 10000�޷� ������ �μ��� ���̵�, �μ���, ��ձ޿��� ��ȸ�ϱ�
-- (��ձ޿��� �Ҽ��� 1�ڸ������� ǥ��)

-- ����� �߿��� �ڽ� �����ϰ� �ִ� ������ �ִ�޿��� ������ �޿��� �޴� ����� ���̵�, �̸�, �޿��� ��ȸ�ϱ�

-- �м��Լ��� ����ؼ� ������� �޿������� �����ϰ�, ������ �ο����� �� 6~10��° ���ϴ� ����, ����� ���̵�, �̸�, �޿�, �޿������ ��ȸ�ϱ�