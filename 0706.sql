create table sample_todo_users(
    user_id varchar2(20) primary key,
    user_name varchar2(100) not null,
    user_password varchar2(20) not null,
    user_email varchar2(256) not null,
    user_created_date date default sysdate
);


create table sample_todos (
    todo_no number(6) primary key,
    todo_title varchar2(200) not null,
    todo_content varchar2(2000) not null,
    todo_day date not null,
    todo_completed_day date,
    todo_status varchar2(100) default '처리예정',
    user_id varchar2(20) REFERENCES sample_todo_users (user_id),
    todo_create_date date default sysdate
);

drop table sample_todos;

create SEQUENCE sample_todo_seq;

insert into sample_todos(todo_no, todo_title, todo_content, todo_day, user_id)
values(sample_todo_seq.nextval, '일정' || sample_todo_seq.currval, '테스트 일정', sysdate + sample_todo_seq.currval, 'wkdwnfl119');

commit;

select todo_no, todo_title, todo_content, todo_day, todo_completed_day, todo_status, user_id, user_name, todo_create_date
from (select todo_no, todo_title, todo_content, todo_day, todo_completed_day, todo_status, a.user_id, user_name, todo_create_date
      from sample_todos a, sample_todo_users b
      where todo_day > sysdate
      and a.user_id = b.user_id
      order by todo_day asc)
where rownum <= 5;