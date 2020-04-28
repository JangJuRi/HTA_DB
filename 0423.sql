-- 책 정보를 저장하는 테이블 생성하기
create table sample_books (
    book_no                 number(6,0) PRIMARY KEY,
    book_title              varchar2(500) not null,
    book_writer             varchar2(200) not null,
    book_genre              varchar2(200) not null,
    book_publisher          varchar2(200) not null,
    book_price              number(7,0) not null,
    book_discount_price     number(7,0) not null,
    book_registered_date    date
);

-- 일련번호를 발행하는 시퀀스 생성하기
create sequence sample_book_seq start with 10000;

-- 책 정보 등록하기
insert into sample_books
(book_no, book_title, book_writer, book_genre, book_publisher, book_price, book_discount_price, book_registered_date)
values
(sample_book_seq.nextval, '자바의 정석', '남궁성', 'IT', '도우출판사', '30000', '27000', sysdate);

-- 고객 정보를 저장하는 테이블 생성하기
create table sample_book_users (
    user_id varchar2(50) PRIMARY KEY,
    user_password varchar2(50) not null,
    user_name varchar2(100) not null,
    user_email varchar2(256) not null,
    user_point number(10, 0),
    user_registered_date date
);

create table sample_book_orders (
    order_no number(6, 0) PRIMARY KEY,                              -- 주문번호
    user_id varchar2(50) REFERENCES sample_book_users (user_id),    -- 주문자 아이디
    book_no number(6, 0) REFERENCES sample_books (book_no),         -- 주문도서 번호
    order_price number(7, 0),                                       -- 구매가격
    order_amount number(3, 0),                                      -- 구매수량
    order_registered_date date                                      -- 주문날짜
);

-- 주문번호 발생기 생성
create sequence sample_order_seq start with 500000;

-- 사용자 등록
insert into sample_book_users
(user_id, user_password, user_name, user_email, user_point, user_registered_date)
values
('hong', 'zxcv1234', '홍길동', 'hong@gmail.com', 1000, sysdate);

-- 주문 등록
insert into sample_book_orders
(order_no, user_id, book_no, order_price, order_amount, order_registered_date)
values
(sample_order_seq.nextval, 'hong', 10024, 32000, 2, sysdate);