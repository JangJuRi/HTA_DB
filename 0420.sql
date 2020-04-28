-- �����ϱ�
-- �޿��� 3000�޷� �޴� ����� ���̵�, �̸�, �������̵�, �ҼӺμ����̵�, �ҼӺμ����� ��ȸ�ϱ�
select employee_id, first_name, job_id, employees.department_id, department_name
from employees, departments
where employees.department_id = departments.department_id and salary = 3000;

-- �޿��� 15000�޷� �̻� ���� ������
-- �������̵�, �̸�, �޿�, �������̵�, ��������, ���������޿�, �����ְ�޿��� ��ȸ�ϱ�
select A.employee_id, A.first_name, A.salary, B.job_id, B.job_title, B.min_salary, B.max_salary
from employees A,jobs B
where salary >= 15000
and A.job_id = B.job_id;

-- �μ������ڰ� ������ �μ���
-- �μ����̵�, �μ���, ���ø�, �����ȣ, �ּ� ��ȸ�ϱ�
select A.department_id, A.department_name, B.city, B.postal_code, B.street_address
from departments A, locations B
where a.manager_id is not null
and A.location_id = B.location_id
order by a.department_id asc;

-- �����ڰ� ������ �μ���
-- �μ����̵�, �μ���, �����ھ��̵�, ������ �̸��� ��ȸ�ϱ�
select A.department_id, a.department_name, a.manager_id, B.first_name
from departments A, employees B
where a.manager_id is not null
and a.manager_id = b.employee_id;

-- 3�� �̻��� ���̺� �����ϱ�
-- �޿��� 12000�̻� ���� �����
-- ������̵�, �̸�, �޿�, �������̵�, ��������, �ҼӺμ����̵�, �ҼӺμ����� ��ȸ�ϱ�
select a.employee_id, a.first_name, a.salary, a.job_id, b.job_title, a.department_id, c.department_name
from employees A, jobs B, departments C
where a.job_id = b.job_id
and a.department_id = c.department_id
and a.salary >= 12000;

-- �μ� �����ڰ� ������ �μ���
-- �μ����̵�, �μ���, �������� �������̵�, ������, ��ġ ���̵�, ���ø�, �ּ� ��ȸ�ϱ�
select a.department_id, a.department_name, a.manager_id, b.first_name, c.location_id, c.city, c.street_address
from departments A, employees B, locations C
where a.manager_id is not null
and a.manager_id = b.employee_id
and a.location_id = c.location_id;

-- �μ� �����ڰ� ������ �μ���
-- �μ����̵�, �μ���, ��ġ ���̵�, ���ø�, �ּ�, �������̵�, ������ ��ȸ�ϱ�
select a.department_id, a.department_name, b.location_id, b.city, b.street_address, c.country_id, c.country_name
from departments A, locations B, countries C
where a.manager_id is not null
and a.location_id = b.location_id
and b.country_id = c.country_id;

-- Seattle�� ������ �μ����� �ٹ��ϴ� ������ ���̵�, �̸�, ���� ���̵�, �ҼӺμ� ���̵�, �ҼӺμ����� ��ȸ�ϱ�
select a.employee_id, a.first_name, a.job_id, b.department_id, b.department_name
from employees A, departments B, locations C
-- where c.location_id = '1700'
where c.city = 'Seattle'
and a.department_id = b.department_id
and b.location_id = c.location_id;

-- ���� ���� �̷¿���
-- �������̵�, �����̸�, ����������, ����������, �������̵�, ��������, �ҼӺμ����̵�, �μ��� ��ȸ�ϱ�
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


-- �� ����
-- 50�� �μ��� �Ҽӵ� ������ �޿� ����� ��ȸ�ϱ�
-- �������̵�, �̸�, �޿�, �޿� ���
select a.employee_id, a.first_name, b.lowest_sal, a.salary, b.highest_sal, b.gra
from employees A, job_grades B
where a.department_id = 50
and a.salary >= b.lowest_sal and a.salary <= b.highest_sal
order by a.employee_id;

-- ������ ����/�ְ�޿��� ��� ��ȸ�ϱ�
-- �������̵�, ��������, ���������޿�, �޿����
select a.job_id, a.job_title, a.min_salary, b.gra min_salary_gra, a.max_salary, c.gra max_salary_gra
from jobs A, job_grades B, job_grades C
where a.min_salary >= b.lowest_sal and a.min_salary <= b.highest_sal
and a.max_salary >= c.lowest_sal and a.max_salary <= c.highest_sal
order by a.job_id;


-- 1.  �ý����� ���� ��¥�� �ð� ��ȸ�ϱ� (dual ���)
select sysdate
from dual;

-- 2.  �޿��� 5000�޷� �̻�ް�, 2005�⿡ �Ի��� ������ ���̵�, �̸�, �޿�, �Ի����� ��ȸ�ϱ�
select employee_id, first_name, salary, hire_date
from employees
where salary >= 5000
and to_char(hire_date, 'yyyy') = '2005';

-- 3.  �̸��� e�� E�� ���Ե� ���� �߿��� �޿��� 10000�޷� �̻� �޴� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
from employees
where (first_name like '%e%' or first_name like '%E%')
and salary >= 10000;

-- 4.  �Ի�⵵�� ������� 4���� �Ի��� �������� ���̵�, �̸�, �Ի����� ��ȸ�ϱ�
select employee_id, first_name, hire_date
from employees
where to_char(hire_date, 'mm') = '04';

-- 5.  2006�� ��ݱ�(1/1 ~ 6/30)�� �Ի��� �������� ���̵�, �̸�, �Ի��� ��ȸ�ϱ�
select employee_id, first_name, hire_date
from employees
where hire_date >= to_date('20060101', 'yyyymmdd')
and hire_date <= to_date('20060630', 'yyyymmdd');

-- 6.  50�� �μ��� �Ҽӵ� �������� �޿��� 13%�λ��Ű���� �Ѵ�.
--     �������̵�, �̸�, ���� �޿�, �λ�� �޿��� ��ȸ�ϱ�
--     �λ�� �޿��� �Ҽ��� ���ϴ� ������.
select employee_id, first_name, salary, trunc(salary + salary*0.13 )�λ�޿�
from employees
where department_id = 50;

-- 7.  50�� �μ��� �Ҽӵ� �������� �޿��� ��ȸ�Ϸ��� �Ѵ�.
--     ���� ���̵�, �̸�, �޿� �׸���, �޿� 1000�޷��� *�� �ϳ��� ǥ���϶�.
--     120 Matthew 8000 ********
--     122 Shanta  6500 ******
select employee_id, first_name, salary, rpad('*',trunc(salary/1000),'*')
from employees
where department_id = 50;

-- 8.  �����ڰ� �����Ǿ� ���� �ʴ� �μ��� 
--     �μ����̵�, �μ���, ��ġ���̵�, ���ø�, �ּҸ� ��ȸ�ϱ�
select a.department_id, a.department_name, b.location_id, b.street_address
from departments A, locations B
where a.manager_id is null
and a.location_id = b.location_id;

-- 9.  90�� �μ��� �Ҽӵ� ������ �������̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees
where department_id = 90;

-- 9-2. 'Executive' �μ��� �Ҽӵ� ������ �������̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
select a.employee_id, a.first_name, a.job_id, a.salary
from employees A, departments B
where b.department_name = 'Executive'
and a.department_id = b.department_id;

-- 10. 100�� ������ �μ������ڷ� ������ �μ��� �Ҽӵ� ������ �������̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees A, departments B
where b.manager_id = 100
and a.department_id = b.department_id;

-- 11. 10, 20, 30�� �μ��� �Ҽӵ� �������� �������̵�, �̸�, �޿�, �޿������ ��ȸ�ϱ�
select employee_id, first_name, salary, gra
from employees A, job_grades B
where a.salary >= b.lowest_sal and a.salary <= b.highest_sal
and a.department_id in (10, 20, 30);

-- 12. �������� ���������� �������� �� �ڽ��� �����ϰ� �ִ� ������ �����޿��� �ް� �ִ�
--     ������ ���̵�, �̸�, �޿�, �������̵�, ���������޿��� ��ȸ�ϱ�
select a.employee_id, a.first_name, a.salary, b.job_id, b.min_salary
from employees A, jobs B
where a.job_id = b.job_id
and a.salary = b.min_salary;

-- 13. Ŀ�̼��� �޴� �������� �������̵�, �̸�, Ŀ�̼�, �޿�, �������̵�, ��������, �޿�, �ҼӺμ� ���̵�, �μ����� ��ȸ�ϱ�
select a.employee_id, a.first_name, a.commission_pct, b.job_id, b.job_title, c.department_id, c.department_name
from employees A, jobs B, departments C
where a.commission_pct is not null
and a.job_id = b.job_id
and a.department_id = c.department_id;

-- 14. 'Canada'���� �ٹ��ϰ� �ִ� ������ ���̵�, �̸�, �ҼӺμ� ���̵�, �ҼӺμ���, ��ġ ���̵�, ���ø�, �ּҸ� ��ȸ�ϱ�
select a.employee_id, a.first_name, b.department_id, b.department_name, c.location_id, c.city, c.street_address
from employees A, departments B, locations C, countries D
where a.department_id = b.department_id
and b.location_id = c.location_id
and c.country_id = d.country_id
and d.country_name = 'Canada';

-- 15. ��� ������ �������̵�, �̸�, �������̵�, ��������, �޿�, �޿����, �ҼӺμ� ���̵�, �ҼӺμ���, ���ø��� ��ȸ�ϱ�
select a.employee_id, a.first_name, b.job_id, b.job_title, a.salary, c.gra, d.department_id, d.department_name, e.city
from employees A, jobs B, job_grades C, departments D, locations E 
where a.job_id = b.job_id
and a.salary >= c.lowest_sal and a.salary <= c.highest_sal
and a.department_id = d.department_id
and d.location_id = e.location_id;

-- 16. �޿��� 5000�޷� ���Ϸ� �޴� �������� ���̵�, �̸�, ����, �ҼӺμ� ���̵�, �ҼӺμ���, �ҼӺμ� ������ �������̵�, 
--     �ҼӺμ� ������ �����̸��� ��ȸ�ϱ�
select a.employee_id, a.first_name, a.job_id, b.department_id, b.department_name, b.manager_id, c.first_name
from employees A, departments B, employees C
where a.salary <= 5000
and a.department_id = b.department_id
and b.manager_id = c.employee_id;

-- 17. 'Asia'������ �������� �ΰ� �ִ� �μ��� ���̵�, �μ���, �μ������� �̸��� ��ȸ�ϱ�
select a.department_id, a.department_name, b.first_name
from departments A, employees B, locations C, Countries D, regions E
where a.department_id = b.department_id
and a.location_id = c.location_id
and c.country_id = d.country_id
and d.region_id = e.region_id
and e.region_name = 'Asia';

-- 18. 101�� ������ �ٹ��ߴ� �μ����� �ٹ����� ������ ���̵�, �̸�, �μ����̵�, �μ����� ��ȸ�ϱ�
select distinct a.employee_id, a.first_name, b.department_id, b.department_name
from employees A, departments B, job_history C
where c.employee_id = 101
and c.department_id = a.department_id
and b.department_id = c.department_id;

-- 19. �����߿��� �ڽ��� �����ϰ� �ִ� ������ �ְ�޿� 50%�̻��� �޿��� �ް� �ִ� 
--     ������ ���̵�, �̸�, �޿�, �������̵�, ���� �ְ�޿��� ��ȸ�ϱ�
select a.employee_id, a.first_name, a.salary, a.job_id, b.max_salary
from employees A, jobs B
where a.job_id = b.job_id
and a.salary >= b.max_salary*0.5;

-- 20. �̱�(US)�� ��ġ�ϰ� �ִ� �μ��� ���̵�, �̸�, ��ġ��ȣ, ���ø�, �ּҸ� ��ȸ�ϱ� 
select a.department_id, a.department_name, b.location_id, b.city, b.street_address
from departments A, locations B
where b.country_id = 'US'
and a.location_id = b.location_id;