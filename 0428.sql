-- å�� ���� ����� ������ ��� ���̺�
create table sample_book_reviews (
    review_no number(7, 0)          CONSTRAINT review_no_pk PRIMARY KEY,
    review_content varchar2(2000)   CONSTRAINT review_content_nn NOT NULL,
    review_point number(1,0)        CONSTRAINT review_point_ck CHECK (review_point >= 0 and review_point <= 5),
    review_registered_date date     default sysdate,
    book_no number(7, 0)            CONSTRAINT review_bookno_fk REFERENCES sample_books (book_no),
    user_id varchar2(50)            CONSTRAINT review_userid_fk REFERENCES sample_book_users (user_id),
    CONSTRAINT reviews_uk UNIQUE (book_no, user_id)
);

create SEQUENCE sample_review_seq NOCACHE;

insert into sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
values
(sample_review_seq.nextval, '���� ���� �����̾����ϴ�.', 5, 10023, 'hong');

insert into sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
values
(sample_review_seq.nextval, '���� ���� �����̾����ϴ�.', 5, 10019, 'abcde');

insert into sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
values
(sample_review_seq.nextval, '�� �о����ϴ�.', 5, 10024, 'abcde');

insert into sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
values
(sample_review_seq.nextval, '�� �о����ϴ�.', 2, 10024, 'hong');

create table sample_book_likes (
    book_no number(7, 0) not null,
    user_id varchar2(50) not null,
    CONSTRAINT likes_bookno_fk FOREIGN KEY (book_no) REFERENCES sample_books(book_no),
    CONSTRAINT likes_userid_fk FOREIGN KEY (user_id) REFERENCES sample_book_users(user_id),
    CONSTRAINT likes_uk UNIQUE (book_no, user_id)
);

-- ���� ���̺� �����_1
create or replace view emp_salary_grade_view
		as select A.employee_id, A.first_name, A.salary, b.gra
		from employees A, job_grades B
		where A.salary >= B.lowest_sal and A.salary <= B.highest_sal
        and B.gra = 'A';

-- ���� ���̺� ����ϱ�_1
select *
from emp_salary_grade_view
where gra = 'A';

-- ���� ���̺� �����_2
create or replace view emp_salary_view
		as select employee_id, first_name, salary, salary*4*12 + salary*nvl(commission_pct,0)*4*12 annual_salary
		from employees;

-- ���� ���̺� ����ϱ�_2    
select *
from emp_salary_view;

-- �ζ��κ� ����ϱ�
select employee_id, fullname, salary
from (select 
        employee_id                         id
        , first_name || ' ' || last_name    name   
        , salary
        , department_id                     deptid
      from employees)
where deptid = 60;  -- �ζ��κ信 ���ǵ� ��Ī���� ����ؾ���

-- ��ü �����߿��� �ڽ��� �Ҽӵ� �μ��� ��ձ޿����� �޿��� ���Թ޴� �����
-- ���̵�, �̸�, �޿�, �μ����̵�, �μ��� ��ձ޿��� ��ȸ�ϱ�
select a.employee_id, a.first_name, a.salary, b.deptid, b.avg_salary
from employees A, (select department_id deptid, trunc(avg(salary)) avg_salary
      from employees
      where department_id is not null
      group by department_id)B 
where A.department_id = B.deptid
and a.salary < b.avg_salary
order by a.employee_id asc;
      
-- �μ����̵�, �μ���, �μ��� �����, ���ø��� ����ϱ�
select A.department_id, A.department_name, B.city, C.cnt
from departments A, locations B, (select department_id, count(*) cnt
                                  from employees
                                  group by department_id) C
where A.location_id = B.location_id
and A.department_id = C.department_id
order by A.department_id asc;