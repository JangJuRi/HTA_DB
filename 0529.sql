create table sample_users (
    user_id varchar2(20) CONSTRAINT sample_user_id_pk PRIMARY KEY,
    user_name varchar2(100) not null,
    user_password varchar2(100) not null,
    user_email varchar2(256) not null,
    user_disabled char(1) DEFAULT 'N',
    user_create_date date DEFAULT sysdate
);

create table sample_boards (
    board_no number(7) CONSTRAINT sample_board_no_pk PRIMARY KEY,
    board_title varchar2(500) not null,
    board_writer varchar2(20) not null,
    board_content varchar2(4000) not null,
    board_hit number(7) DEFAULT 0,
    board_reply_cnt number(5) DEFAULT 0,
    board_del_yn char(1) DEFAULT 'N',
    board_create_date date DEFAULT sysdate,
    CONSTRAINT sample_board_writer_fk foreign key (board_writer) 
                                      references sample_users(user_id)
);

create table sample_replys(
    reply_no number(7) CONSTRAINT sample_reply_no_pk PRIMARY KEY,
    reply_writer varchar2(20) not null,
    reply_content varchar2(2000) not null,
    reply_del_yn char(1) DEFAULT 'N',
    reply_create_date date DEFAULT sysdate,
    CONSTRAINT sample_reply_writer_fk foreign key (reply_writer)
                                      references sample_users(user_id)
);

create SEQUENCE board_seq nocache;
create SEQUENCE reply_seq nocache;