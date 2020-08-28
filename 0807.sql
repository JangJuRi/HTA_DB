create table spring_user_roles (
    user_id varchar2(20) references spring_users(user_id),
    has_role varchar2(20) check (has_role in('USER', 'ADMIN'))
);

create table spring_url_roles (
    req_url varchar2(100) not null,
    req_role varchar2(20) check (req_role in('USER', 'ADMIN'))
);