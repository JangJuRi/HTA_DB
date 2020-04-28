-- �������� (��ü����)
-- 101�� ����� �̸�, ����, �ڽ��� ��� �̸��� ��ȸ�ϱ�
select EMP.first_name ������
    , EMP.job_id "������ ����"
    , MGR.first_name "����� �̸�"
from employees EMP, employees MGR
where emp.employee_id = 101
and emp.manager_id = mgr.employee_id;

-- 60�� �μ��� �ٹ����� ������ ���̵�, �̸�, ����� ����, ����� �̸�, ����� ����, 
-- �μ����̵�, �μ���, �μ������� ���̵�, �μ������� �̸��� ��ȸ�ϱ�
select ����.employee_id �������̵�
    , ����.first_name �����̸�
    , ����.job_id "������ ����"
    , ���.first_name "����� �̸�"
    , ���.job_id "����� ����"
    , ����.department_id "�ҼӺμ� ���̵�"
    , �μ�.department_name "�ҼӺμ� �̸�"
    , �μ�.manager_id "������ ���̵�"
    , �μ�������.first_name "�μ��� ������ �̸�"
from employees ����, employees ���, employees �μ�������, departments �μ�
where ����.department_id = 60
and ����.manager_id = ���.employee_id
and ����.department_id = �μ�.department_id
and �μ�.manager_id = �μ�������.employee_id;

-- ��������
-- �μ����̵�, �μ���, �μ������ھ��̵�, �μ������� �̸� ��ȸ�ϱ�
select a.department_id, a.department_name, a.manager_id, b.first_name
from departments A, employees B
where a.manager_id = b.employee_id(+)
order by department_id;

-- ��� ������ �̸�, �޿�, �������̵�, �ҼӺμ����� ��ȸ�ϱ�
select *
from employees A, departments B
where a.department_id = b.department_id(+)
order by a.employee_id;


-- ������ �Լ� ����ϱ�
-- employees�� ��� ���� ���� ��ȸ�ϱ�
select count(*)
from employees;

-- 50�� �μ����� ���ϴ� ������ ���� ��ȸ�ϱ�
select count(*)
from employees
where department_id = 50;

-- Ŀ�̼��� �޴� ������ ���� ��ȸ�ϱ�
select count(commission_pct)    -- �÷��� �����ϸ� �ش� �÷��� ���� null�� �ƴ� �͸� ī��Ʈ�Ѵ�.
from employees;

select count(*)
from employees
where commission_pct is not null;

-- ������ �߿��� �ְ�޿�, �����޿��� �޴� ������ �޿��� ��ȸ�ϱ�
select max(salary), min(salary)
from employees;

-- �ְ�޿��� �޴� ����� �̸��� �ְ�޿��� ��ȸ�ϱ�
select first_name, max(salary) -- ���� : �׷��Լ��� �׷��Լ��� �ƴ� ǥ������ ���� ����� �� ����.
from employees;

select first_name, salary
from employees
where salary = (select max(salary)
                from employees);
                
-- ��ȸ�� ���� ������ ���ϱ�
-- count(*) : ��ȸ�� ��� ���� ������ ��ȯ�Ѵ�.
-- count(�÷���) : �ش� Į���� ���� null�� �ƴ� ���� ������ ��ȯ�Ѵ�.
-- count(distinct �÷���) : �ش� �÷��� ���� ���� �ߺ��� ���� 1���� ī��Ʈ�ؼ� ���� ������ ��ȯ�Ѵ�.
select count(*)
from employees;         -- 107

select count(job_id)
from employees;         -- 107

select count(distinct job_id)
from employees;         -- 19

select count(distinct to_char(hire_date, 'yyyy'))
from employees;         -- 8

-- ��ȸ�� ���� Ư�� �÷��� ���� �հ踦 ���ϱ�
-- sum(�÷���) : �ش� �÷��� �� �߿��� null�� ������ ������ �հ踦 ��ȯ�Ѵ�.
select sum(salary)          -- ��ü ������� �޿� ���
from employees;

select sum(commission_pct)  -- ��ü ������� Ŀ�̼ǿ� ���� �հ�, Ŀ�̼� ���� null�� ���� ��꿡 ���Ե��� ����
from employees;

-- ��ȸ�� ���� Ư�� �÷��� ���� ����� ���ϱ�
-- avg(�÷���) : �ش� �÷��� �� �߿��� null�� ������ ���� ���� ��鿡 ���� ��հ��� ��ȯ�Ѵ�.
select trunc(avg(salary))   -- ��ü �������� �޿� ���
from employees;

select trunc(avg(commission_pct),2)
from employees;

-- ��ȸ�� ���� Ư�� �÷��� ���� �ִ밪, �ּҰ� ���ϱ�
-- min(�÷���) : �ش� �÷��� �� �߿��� null�� ������ ���� ���� ���� ��ȯ�Ѵ�.
-- max(�÷���) : �ش� �÷��� �� �߿��� null�� ������ ���� ū ���� ��ȯ�Ѵ�.
select min(salary), max(salary)
from employees;

select min(commission_pct), max(commission_pct)
from employees;

-- group by�� �׷��Լ��� ����ؼ� ������ �����ϱ�
-- ������ �������� ��ȸ�ϱ�
select job_id, count(*)
from employees
group by job_id;

-- �Ի�⵵�� �����
select to_char(hire_date, 'yyyy'), count(*)
from employees
group by to_char(hire_date, 'yyyy')
order by 1;


--1. ��� �������� ��� �������̵� ��ȸ�ϱ�
select DISTINCT job_id
from employees;

--2. �޿��� 12,000�޷� �̻� �޴� ������ �̸��� �޿��� ��ȸ�ϱ�
select first_name, salary
from employees
where salary >= 12000;

--3. ������ȣ�� 176�� ������ ���� �μ����� �ٹ��ϴ� ������ ���̵�� �̸� �������̵� ��ȸ�ϱ�
select a.employee_id, a.first_name, a.job_id
from employees A, employees B
where b.employee_id = 176
and a.department_id = b.department_id;

--4. �޿��� 12,000�޷� �̻� 15,000�޷� ���� �޴� �������� ���� ���̵�� �̸��� �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
from employees
where salary >= 12000 and salary <= 15000;

--5. 2005�� 1�� 1�Ϻ��� 2005�� 6�� 30�� ���̿� �Ի��� ������ ���̵�, �̸�, �������̵�, �Ի����� ��ȸ�ϱ�
select employee_id, first_name, job_id, hire_date
from employees
where hire_date >= to_date('20050101', 'yyyymmdd')
and hire_date <= to_date('20050630', 'yyyymmdd');

--6. �޿��� 5,000�޷��� 12,000�޷� �����̰�, �μ���ȣ�� 20 �Ǵ� 50�� ������ �̸��� �޿��� ��ȸ�ϱ�
select first_name, salary
from employees
where salary >= 5000 and salary <= 12000
and department_id in(20, 50);

--7. �����ڰ� ���� ������ �̸��� �������̵� ��ȸ�ϱ�
select first_name, job_id
from employees
where manager_id is null;

--8. Ŀ�̼��� �޴� ��� ������ �̸��� �޿�, Ŀ�̼��� �޿� �� Ŀ�̼��� ������������ �����ؼ� ��ȸ�ϱ�
select first_name, salary, commission_pct
from employees
where commission_pct is not null
order by salary desc, commission_pct desc;

--9. �̸��� 2��° ���ڰ� e�� ��� ������ �̸��� ��ȸ�ϱ�
select first_name
from employees
where instr(first_name,'e') = 2;

--10. �������̵� ST_CLERK �Ǵ� SA_REP�̰� �޿��� 2,500�޷�, 3,500�޷�, 7,000�޷� �޴� ��� ������ �̸��� �������̵�, �޿��� ��ȸ�ϱ�
select first_name, job_id, salary
from employees
where job_id in ('ST_CLERK', 'SA_REP')
and salary in (2500, 3500, 7000);

--11. ��� ������ �̸��� �Ի���, �ٹ� ���� ���� ����Ͽ� ��ȸ�ϱ�, �ٹ����� ���� ������ �ݿø��ϰ�, �ٹ��������� �������� ������������ �����ϱ�
select first_name, hire_date, trunc(MONTHS_BETWEEN(sysdate, hire_date)) �ٹ�������
from employees
order by TRUNC(MONTHS_BETWEEN(sysdate, hire_date));

--12. ������ �̸��� Ŀ�̼��� ��ȸ�ϱ�, Ŀ�̼��� ���� �ʴ� ������ '����'���� ǥ���ϱ�
select first_name, nvl(to_char(commission_pct),'����')
from employees;

--13. ��� ������ �̸�, �μ���ȣ, �μ��̸��� ��ȸ�ϱ�
select a.first_name, a.department_id, b.department_name
from employees A, departments B
where a.department_id = b.department_id(+);

--14. 80���μ��� �Ҽӵ� ������ �̸��� �������̵�, ��������, �μ��̸��� ��ȸ�ϱ�
select a.first_name, a.job_id, b.job_title, c.department_name
from employees A, jobs B, departments C
where a.department_id = 80
and a.job_id = b.job_id
and a.department_id = c.department_id;

--15. Ŀ�̼��� �޴� ��� ������ �̸��� �������̵�, ��������, �μ��̸�, �μ������� ���ø��� ��ȸ�ϱ�
select a.first_name, a.job_id, b.job_title, c.department_name, d.city
from employees A, jobs B, departments C, locations D
where a.commission_pct is not null
and a.job_id = b.job_id
and a.department_id = c.department_id
and c.location_id = d.location_id;

--16. ������ �������� �ΰ� �ִ� ��� �μ����̵�� �μ��̸��� ��ȸ�ϱ�
select a.department_id, a.department_name
from departments A, locations B, countries C , regions D
where d.region_name = 'Europe'
and a.location_id = b.location_id
and b.country_id = c.country_id
and c.region_id = d.region_id;

--17. ������ �̸��� �ҼӺμ���, �޿�, �޿� ����� ��ȸ�ϱ�
select a.first_name, b.department_name, a.salary, c.gra
from employees A, departments B, job_grades C
where a.department_id = b.department_id(+)
and a.salary >= c.lowest_sal
and a.salary <= c.highest_sal;

--18. ������ �̸��� �ҼӺμ���, �ҼӺμ��� �����ڸ��� ��ȸ�ϱ�, �ҼӺμ��� ���� ������ �ҼӺμ��� '����, �����ڸ� '����'���� ǥ���ϱ�
select emp.first_name, nvl(b.department_name,'����'), nvl(mgr.first_name, '����')
from employees EMP, departments B, employees MGR
where emp.department_id = b.department_id(+)
and b.manager_id = mgr.employee_id(+);

--19. ��� ����� �̸�, �������̵�, �޿�, �ҼӺμ����� ��ȸ�ϱ�
select a.first_name, a.job_id, a.salary, b.department_name
from employees A, departments B
where a.department_id = b.department_id(+);

--20. ��� ����� �̸�, �������̵�, ��������, �޿�, �ּұ޿�, �ִ�޿��� ��ȸ�ϱ�
select a.first_name, a.job_id, b.job_title, a.salary, b.min_salary, b.max_salary
from employees A, jobs B
where a.job_id = b.job_id;

--21. ��� ����� �̸�, �������̵�, ��������, �޿�, �ּұ޿��� ���� �޿��� ���̸� ��ȸ�ϱ�
select a.first_name, a.job_id, b.job_title, a.salary, a.salary - b.min_salary
from employees A, jobs B
where a.job_id = b.job_id;

--22. Ŀ�̼��� �޴� ��� ����� ���̵�, �μ��̸�, �ҼӺμ��� ������(���ø�)�� ��ȸ�ϱ�
select a.employee_id, b.department_name, c.city
from employees A, departments B, locations C
where a.commission_pct is not null
and a.department_id = b.department_id(+)
and b.location_id = c.location_id(+);

--23. �̸��� A�� a�� �����ϴ� ��� ����� �̸��� ����, ��������, �޿�, �ҼӺμ����� ��ȸ�ϱ�
select a.first_name, a.job_id, b.job_title, a.salary, c.department_name
from employees A, jobs B, departments C
where (a.first_name like 'A%' or a.first_name like 'a%')
and a.job_id = b.job_id
and a.department_id = c.department_id;

--24. 30, 60, 90�� �μ��� �ҼӵǾ� �ִ� ����� �߿��� 100���� �����ϴ� ������� �̸�, ����, �޿�,
--    �޿������ ��ȸ�ϱ�
select a.first_name, a.job_id, a.salary, b.gra
from employees A, job_grades B
where a.department_id in (30, 60, 90)
and a.manager_id = 100
and a.salary >= b.lowest_sal and a.salary <= b.highest_sal;

--25. 80�� �μ��� �Ҽӵ� ������� �̸�, ����, ��������, �޿�, �ּұ޿�, �ִ�޿�, �޿����, 
--    �ҼӺμ����� ��ȸ�ϱ�
select a.first_name, a.job_id, b.job_title, a.salary, b.min_salary, b.max_salary, C.gra
from employees A, jobs B, job_grades C, departments D
where a.department_id = 80
and a.job_id = b.job_id
and a.department_id = d.department_id
and a.salary >= c.lowest_sal and a.salary <= c.highest_sal;

--26. ������߿��� �ڽ��� ��纸�� ���� �Ի��� ������� �̸�, �Ի���, ����� �̸�, ����� �Ի�����
--    ��ȸ�ϱ�
select emp.first_name, emp.hire_date, mgr.first_name, mgr.hire_date
from employees EMP, employees MGR
where emp.manager_id = mgr.employee_id
and emp.hire_date < mgr.hire_date;

--27. �μ����� IT�� �μ��� �ٹ��ϴ� ������� �̸���, ����, �޿�, �޿����, ����� �̸��� ������
--    ��ȸ�ϱ�
select emp.first_name, emp.job_id, emp.salary, a.gra, mgr.first_name, mgr.job_id
from employees EMP, job_grades A, employees MGR, departments B
where b.department_name = 'IT'
and emp.department_id = b.department_id
and emp.manager_id = mgr.employee_id
and EMP.salary >= a.lowest_sal and EMP.salary <= a.highest_sal;

--28. 'ST_CLERK'�� �ٹ��ϴٰ� �ٸ� �������� ������ ����� ���̵�, �̸�, ������ �μ���,
--     ���� ����, ���� �ٹ� �μ����� ��ȸ�ϱ�
select a.employee_id, a.first_name, ������.department_name ������, a.job_id, ����.department_name ����
from employees A, job_history B, departments ������, departments ����
where b.job_id = 'ST_CLERK'
and a.employee_id = b.employee_id
and a.department_id = ����.department_id
and b.department_id = ������.department_id;