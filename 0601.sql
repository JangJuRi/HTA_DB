select a.employee_id, a.first_name, a.last_name, a.email, a.phone_number,
       a.hire_date, a.job_id, a.salary, a.commission_pct,
       c.employee_id manager_id, c.first_name manager_first_name, c.last_name manager_last_name,
       b.department_id, b.department_name
from (select employee_id, first_name, last_name, email, phone_number,
             hire_date, job_id, salary, commission_pct, manager_id, department_id,
             row_number() over(order by employee_id asc) rownumber
      from employees) A, departments B, employees C
where a.rownumber >= 1 and a.rownumber <= 20
and a.department_id = b.department_id(+)
and a.manager_id = c.employee_id(+);


create table sample_files (
    file_no number(5) PRIMARY KEY,
    file_title varchar2(500) not null,
    file_name varchar2(300) not null,
    file_create_date date DEFAULT sysdate
);

create SEQUENCE sample_file_seq nocache;