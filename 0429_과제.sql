create table school_department (
    department_no number(5, 0) primary key,
    department_name varchar2(200) not null
);
create sequence school_department_seq start with 10000 nocache;

create table school_professor (
    professor_no   number(5, 0) primary key,
    professor_name varchar2(200) not null,
    professor_rank varchar2(200),
    department_no  number(5, 0) REFERENCES school_department (department_no),
    professor_registered_date date default sysdate
);
create sequence school_professor_seq start with 20000 nocache;

create table school_student (
    student_no     number(5, 0)  primary key,
    student_name   varchar2(200) not null,
    student_grade  number(1,0)   not null,
    department_no  number(5, 0)  REFERENCES school_department (department_no),
    student_registered_date date default sysdate
);
create sequence school_student_seq start with 30000 nocache;

create table school_subject (
    subject_no     number(5,0)   primary key,
    subject_name   varchar2(200) not null,
    department_no  number(5, 0)  REFERENCES school_department (department_no) not null,
    subject_registered_date date default sysdate
);
create sequence school_subject_seq start with 40000 nocache;

create table school_course (
    course_no      number(5, 0)   primary key,
    course_name    varchar2(200) not null,
    department_no  number(5, 0) REFERENCES school_department (department_no),
    subject_no     number(5, 0)  REFERENCES school_subject (subject_no),
    professor_no   number(5, 0) REFERENCES school_professor (professor_no),
    course_size    number(4, 0) default 0 not null,
    course_closed  char(1)      default 'N',
    course_registered_date date default sysdate
);
create sequence school_course_seq start with 50000 nocache;

create table school_enrolment (
    enrolment_no       number(5, 0)  primary key,
    course_no          number(5, 0)  REFERENCES school_course (course_no),
    student_no         number(5, 0)  REFERENCES school_student (student_no),
    enrolment_canceled char(1)       default 'N',
    enrolment_score    number(3, 0),
    enrolment_registered_date date default sysdate
);
create sequence school_enrolment_seq start with 60000 nocache;

commit;

insert into school_department
values (school_department_seq.nextval, '건축학과');

insert into school_professor
values (school_professor_seq.nextval, '컴공교수2', '부교수', 10001, sysdate);

insert into school_student
values (school_student_seq.nextval, '건축학생1', 1, 10001, sysdate);

insert into school_subject
values (school_subject_seq.nextval, '건축환경설계', 10001, sysdate);

insert into school_course
values (school_course_seq.nextval, '건축설계A', 10001, 40003, 20002, 0, 'N', sysdate);