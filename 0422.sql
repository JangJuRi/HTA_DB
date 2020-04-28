-- ������ �׷��� ����
-- group by���� ����ϸ� ���̺��� ������ ���� �׷����� �����
-- �׷� �� �����͸� ������ �� �ִ�.

-- �ҼӺμ��� �������� ��ȸ�ϱ�
-- ��, �ҼӺμ��� �������� ���� ������ �����Ѵ�.
select department_id, count(*)
from employees
where department_id is not null
group by department_id;

-- �����ں� �ڽ��� �����ϴ� ���� ���� ��ȸ�ϱ�
-- ��, �����ڰ� �������� ���� ������ �����Ѵ�.
-- �����ھ��̵�, ���� ���� ��ȸ�Ѵ�.
select manager_id, count(*)
from employees
where manager_id is not null
group by manager_id;

-- �μ��� �������� ��ȸ�ϱ�
-- ��, �μ��� �������� ���� ������ �����Ѵ�.
-- �μ��̸�, ���� ���� ��ȸ�Ѵ�.
select b.department_name, count(*)
from employees A, departments B
where a.department_id is not null
and a.department_id = b.department_id
group by b.department_name;

-- ���ú�, �μ��� �������� ��ȸ�ϱ�
-- ���ø�, �μ��� �������� ��ȸ�Ѵ�.
select c.city, b.department_name, count(*)
from employees A, departments B, locations C
where a.department_id = b.department_id
and b.location_id = c.location_id
group by c.city, b.department_name
order by 1, 2;

-- having ���� ����ؼ� �׷��� �����ϱ�
-- �޿��� ������� ��ȸ���� ��, �������� 10�� �̻��� �޿��� ������ ������ ��ȸ�ϱ�
select trunc(salary, -3) salary, count(*)
from employees
group by trunc(salary, -3)
having count(*) >= 10
order by salary;

-- �μ��� ��ձ޿� ��ȸ�ϱ�
-- �μ���� �μ��� ��ձ޿��� ��ȸ�Ѵ�.
-- ��� �޿��� �Ҽ������ϴ� ������.
-- ��� �޿��� 5000�޷� �̸��� �μ��� ��ȸ�ϱ�
select a.department_name, trunc(avg(b.salary)) avg_salary
from departments A, employees B
where a.department_id = b.department_id
group by a.department_name
having avg(salary) < 5000
order by a.department_name;

-- �׷��Լ��� ��ø
-- �μ����� �������� ��ȸ���� �� ���� ���� ������� ����ΰ�?
select max(count(*))
from employees
group by department_id;

-- �޿� ��޺� ������� �޿� ��޺� ��ձ޿��� ��ȸ�ϱ�
-- �޿���ް� �����, ��ձ޿��� ǥ���Ѵ�.
select a.gra, count(*), trunc(avg(salary))
from job_grades A, employees B
where b.salary >= a.lowest_sal and b.salary <= a.highest_sal
group by a.gra
order by a.gra;

-- ��������
-- �̸��� Neena�� ����� ���� �ؿ� �Ի��� ������� �̸�, �Ի����� ��ȸ�ϱ�
select first_name, hire_date
from employees
where to_char(hire_date, 'yyyy') = (select to_char(hire_date, 'yyyy')
                                    from employees
                                    where first_name = 'Neena');

                                    
-- Stephen�� ���� ������ ���� �ϴ� �������� ���̵�� �̸�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
from employees
where job_id = (select job_id
                from employees
                where first_name = 'Stephen');
                
-- Mozhe�� ���� ������ ���� �ϰ�,
-- Mozhe�� �޿����� �޿��� ���� �޴� ������ ���̵�� �̸�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
from employees
where job_id = (select job_id
                from employees
                where first_name = 'Mozhe')
and salary > (select salary
               from employees
               where first_name = 'Mozhe');
               
-- ��ü ������ ��ձ޿����� ���� �޿��� �޴� �������� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
from employees
where salary < (select avg(salary)
                from employees);
                
-- ���� ���� �޿��� �޴� �������� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
from employees
where salary = (select min(salary)
                from employees);
                
-- �μ��� ������� ��ȸ���� �� ������� ���� ���� �μ��� ���̵�� ������� ��ȸ�ϱ�
select department_id, count(*)
from employees
group by department_id
having count(*) = (select max(count(*))
                   from employees
                   group by department_id);

-- with���� ����ؼ� �ߺ� ����Ǵ� �����۾��� �� ���� ����ǰ� �� �� �ִ�.
-- ������ ���༺���� ����Ų��.
with deptcnt
as (select department_id, count(*) cnt
    from employees
    group by department_id)
select department_id, cnt
from deptcnt
where cnt = (select max(cnt)
             from deptcnt);
             
-- ������ ��������
-- 50�� �μ��� �ٹ��ߴ����� �ִ� ����� ���̵�, �̸�, ����, �ҼӺμ����̵� ��ȸ�ϱ�
select employee_id, first_name, job_id, department_id
from employees
where employee_id in (select employee_id
                     from job_history
                     where department_id = 50);
                     
-- Seattle�� ��ġ�ϰ� �ִ� �μ��� ������ �������̵�, �̸��� ��ȸ�ϱ�
select employee_id, first_name
from employees
where employee_id in (select manager_id
                      from departments
                      where location_id = (select location_id
                                           from locations
                                           where city = 'Seattle'));
                                           
select a.employee_id, a.first_name
from employees A, departments B, locations C
where a.employee_id = b.manager_id
and b.location_id = c.location_id
and c.city = 'Seattle';