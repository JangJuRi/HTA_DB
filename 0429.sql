-- TOP-N �м�

-- 50�� �μ��� �Ҽӵ� ��� �߿��� �޿��� ���� ���� �޴� ���� 3���� ��ȸ�ϱ�
select rownum, salary, first_name
from (select salary, first_name
      from employees
      where department_id = 50
      order by salary desc)
where rownum <= 3;

-- �μ��� ������� ������� �� ������� ���� ���� �μ� 3���� ��ȸ�ϱ�
select rownum ranking, department_id, cnt
from (select department_id, count(*) cnt
      from employees
      group by department_id
      order by cnt desc)
where rownum <= 3;

-- �μ��� ������� ������� �� ������� ���� ���� �μ� 3���� ��ȸ�ϱ�
-- ����, �μ����̵�, �μ���, ������� ��µǾ�� ��.
select b.ranking, a.department_id, a.department_name, b.cnt
from departments A, (select rownum ranking, department_id, cnt
                     from (select department_id, count(*) cnt
                           from employees
                           group by department_id
                           order by cnt desc)
                     where rownum <= 3) B
where A.department_id = B.department_id;

-- ������ ���� ��� å 3���� ��ȸ�ϱ�
-- ����, ����, ������ ��µǾ�� ��.
select rownum ranking, book_title, book_price
from (select book_title, book_price
      from sample_books
      order by book_price desc)
where rownum <= 3;

-- ������ ���� ��� å 3���� ��ȸ���� ��
-- �ֱ� 1���� �̳��� �� å�� �� ����ڸ� ��ȸ�ϱ�
-- ����ھ��̵�, ����ڸ�, å ����, ���Ű���, ���ż���, ���ų�¥�� ��µǾ�� ��
select c.user_id, c.user_name, b.book_title, a.order_price, a.order_amount, a.order_registered_date
from sample_book_orders A, (select rownum ranking, book_no, book_title, book_price
                            from (select book_no, book_title, book_price
                                  from sample_books
                                  order by book_price desc)
                            where rownum <= 3) B, sample_book_users C
where a.order_registered_date > sysdate - 7
and a.book_no = b.book_no
and a.user_id = c.user_id;

-- �����Ѿ��� ������� �� �����Ѿ��� ���� ���� �������
-- ���̵�, �̸�, �� ���űݾ��� ��ȸ�ϱ�
select A.user_id, A.user_name, B.total_price
from sample_book_users A, (select user_id, total_price
                           from (select user_id, sum(order_price*order_amount) total_price
                                 from sample_book_orders
                                 group by user_id
                                 order by total_price desc)
                           where rownum = 1) B
where A.user_id = B.user_id;
              
-- �м��Լ� ����ϱ�
-- �޿��� �������� �����ؼ� ���� �ο��ϱ�
select row_number() over(order by salary desc), salary, first_name
from employees;

-- �޿��� �������� �������� �����ؼ� ������ �ο����� �� �ְ� �޿��� �޴� 3����
-- ����, ���̵�, �̸�, �޿��� ��ȸ�ϱ�
select num, employee_id, first_name, salary
from (select row_number() over(order by salary desc)num, employee_id, first_name, salary
      from employees)
where num <= 3;

-- �޿��� �������� �������� �����ؼ� ������ �ο����� �� �޿� ������ 11~20���� �ش��ϴ� ������
-- ����, ���̵�, �̸�, �޿��� ��ȸ�ϱ�
select num, employee_id, first_name, salary
from (select row_number() over(order by salary desc)num, employee_id, first_name, salary
      from employees)
where num >= 11 and num <= 20;

-- �μ����� �޿��� �������� �������� �����ؼ� ������ �ο��ϱ�
select 
    row_number() over(partition by department_id order by salary desc) num,
    department_id, salary, first_name
from employees;

-- �μ����� �޿��� �������� �������� �����ؼ� ������ �ο����� ��
-- �ش� �μ����� ���� �޿��� ���� �޴� ������
-- �̸�, �޿�, �μ����̵� ��ȸ�ϱ�
select first_name, salary, department_id
from(select row_number() over(partition by department_id order by salary desc) num,
            first_name, salary, department_id
     from employees)
where num = 1;

-- row_number(), rank(), dense_rank() ���� ������ Ȯ���غ���
select row_number() over(order by salary desc) row_number,
       rank()       over(order by salary desc) rank,
       dense_rank() over(order by salary desc) dense_rank,
       salary
from employees;

-- row_number() over()�� Ȱ���ؼ� �����͸� Ư�� �÷� ���� �������� �������� ������ ��ȸ�ϱ�
select *
from (select row_number() over(order by employee_id asc) num, employee_id, first_name
      from employees)
where num >= 1 and num <= 10;

select *
from (select row_number() over(order by employee_id asc) num, employee_id, first_name
      from employees)
where num >= 11 and num <= 20;

select first_value(salary) over(partition by department_id order by salary desc),
       department_id, salary, first_name
from employees
order by department_id;

-- ���ο� �Ϸù�ȣ ��ȸ
select sample_order_seq.nextval from dual;
-- ���� �������� �Ϸù�ȣ ��ȸ
select sample_order_seq.currval from dual;

select employee_id, ROWID
from employees;

-- �ε��� ����
create index sample_user_name_idx
on sample_book_users (user_name);

create index sample_order_date_idx
on sample_book_orders (to_char(order_registered_date, 'yyyy-mm-dd'));

select *
from sample_book_users
where user_name = 'ȫ�浿';

select *
from sample_book_orders
where to_char(order_registered_date, 'yyyy-mm-dd') = '2020-04-28';