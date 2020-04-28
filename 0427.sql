-- 트랜잭션 처리
insert into sample_book_users                               -- 트랜잭션 시작
(user_id, user_password, user_name, user_email)
values
('hong5678', 'zxcv1234', 'ㅎㅎㅎ', 'hong5678@gmail.com');

update sample_book_users
set user_point = 1000
where user_id = 'hong5678';

SAVEPOINT add_new_user;                                     -- 저장지점 지정

insert into sample_book_orders (order_no,user_id, book_no, order_price, order_amount)
values (sample_order_seq.nextval, 'hong5678', 10019, 27000, 3);

update sample_book_users
set user_point = user_point + trunc(22500*3*0.03)
where user_id = 'hong5678';

commit;                                                     -- 현재 트랜잭션의 변경내용을 저장, 현재 트랜잭션 종료, 새 트랜잭션 시작
-- DML1 작업
-- DML2 작업
-- DML3 작업
rollback;                                                   -- 새로 시작된 트랜잭션의 변경내용(DML1~3)을 버림, 트랜잭션 종료, 새 트랜잭션 시작

rollback to SAVEPOINT add_new_user;

select rowid, user_id, user_name
from copy_sample_book_users;


-- 북스토어 문의 게시판
-- 번호, 제목, 작성자아이디, 내용, 조회수, 작성일, 상태(답변완료여부), 질문 유형
create table sample_book_questions (
    question_no             number(7,0)     primary key,
    question_title          varchar2(500)   not null,
    user_id                 varchar2(50)    REFERENCES sample_book_users(user_id),
    question_content        varchar2(4000)  not null,
    question_view_count     number(7,0)     default 0,
    question_registered_date date           default sysdate,
    question_status         char(1)         default 'N',
    question_type           varchar2(200)   not null
);

-- 북스토어 답변 게시판
-- 번호, 내용, 작성일, 문의글 번호
create table sample_bookstore_answers (
    answer_no               number(7,0)     primary key,
    answer_content          varchar2(4000)  not null,
    answer_registered_date  date default    sysdate,
    question_no             number(7,0)     REFERENCES sample_book_questions(question_no)
);

-- 테이블 이름 변경하기
rename sample_bookstore_answers to sample_book_answers;

create sequence sample_question_seq start with 1000000 nocache;
create sequence sample_answer_seq start with 1000000 nocache;

commit;