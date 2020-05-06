create table contacts (
    contact_name varchar2(100) not null,
    contact_tel varchar2(50) not null,
    contact_email varchar2(256),
    contact_create_date date default sysdate
);

insert into contacts (contact_name, contact_tel, contact_email)
values ('ȫ�浿', '010-1234-5678', 'hong@gmail.com');

insert into contacts (contact_name, contact_tel, contact_email)
values ('������', '010-6789-3453', 'kim@naver.com');

commit;

-- HR ����ڿ��� CONTACTS�� ���� ��ü���� �ο��ϱ�
GRANT SELECT
ON CONTACTS
to HR;

-- HR ����ڿ��� CONTACTS�� ���� ��ü���� �ο��ϱ�
GRANT UPDATE (CONTACT_TEL, CONTACT_EMAIL)
ON CONTACTS
to HR;

select *
from role_sys_privs;







/* Create Tables */

CREATE TABLE SCHOOL_COURSES
(
	course_no number(4,0) NOT NULL,
	SUBJECT_NO number(4,0) NOT NULL,
	PROF_NO number(4,0) NOT NULL,
	course_name varchar2(200) NOT NULL,
	course_quota number(3,0) DEFAULT 30,
	course_reg_cnt number(3,0) DEFAULT 0,
	course_cancel_cnt number(3,0) DEFAULT 0,
	course_closed char(1) DEFAULT 'N',
	course_create_date date DEFAULT SYSDATE,
	PRIMARY KEY (course_no)
);


CREATE TABLE SCHOOL_COURSE_REGISTRATIONS
(
	STUD_NO number(4,0) NOT NULL,
	course_no number(4,0) NOT NULL,
	REG_NO number(5,0) NOT NULL,
	REG_CANCELED char(1) DEFAULT 'N',
	REG_COMPLETED char(1) DEFAULT 'N',
	REG_SCORE number(2,1),
	REG_CREATE_DATE date DEFAULT SYSDATE,
	PRIMARY KEY (REG_NO),
	CONSTRAINT COURSE_REG_UK UNIQUE (STUD_NO, course_no)
);


CREATE TABLE SCHOOL_DEPT
(
	DEPT_NO number(4,0) NOT NULL,
	DEPT_NAME varchar2(100) NOT NULL,
	PRIMARY KEY (DEPT_NO)
);


CREATE TABLE SCHOOL_PROFESSORS
(
	PROF_NO number(4,0) NOT NULL,
	DEPT_NO number(4,0) NOT NULL,
	PROF_NAME varchar2(100) NOT NULL,
	PROF_POSITION varchar2(50),
	PROF_CREATE_DATE date DEFAULT SYSDATE,
	PRIMARY KEY (PROF_NO)
);


CREATE TABLE SCHOOL_STUDENTS
(
	STUD_NO number(4,0) NOT NULL,
	DEPT_NO number(4,0) NOT NULL,
	STUD_NAME varchar2(100) NOT NULL,
	STUD_GRADE number(1) NOT NULL,
	STUD_CREATE_DATE date DEFAULT SYSDATE,
	PRIMARY KEY (STUD_NO)
);


CREATE TABLE SCHOOL_SUBJECTS
(
	SUBJECT_NO number(4,0) NOT NULL,
	DEPT_NO number(4,0) NOT NULL,
	SUBJECT_NAME varchar2(200) NOT NULL,
	SUBJECT_CREATE_DATE date DEFAULT SYSDATE,
	PRIMARY KEY (SUBJECT_NO)
);



/* Create Foreign Keys */

ALTER TABLE SCHOOL_COURSE_REGISTRATIONS
	ADD FOREIGN KEY (course_no)
	REFERENCES SCHOOL_COURSES (course_no)
;


ALTER TABLE SCHOOL_PROFESSORS
	ADD FOREIGN KEY (DEPT_NO)
	REFERENCES SCHOOL_DEPT (DEPT_NO)
;


ALTER TABLE SCHOOL_STUDENTS
	ADD FOREIGN KEY (DEPT_NO)
	REFERENCES SCHOOL_DEPT (DEPT_NO)
;


ALTER TABLE SCHOOL_SUBJECTS
	ADD FOREIGN KEY (DEPT_NO)
	REFERENCES SCHOOL_DEPT (DEPT_NO)
;


ALTER TABLE SCHOOL_COURSES
	ADD FOREIGN KEY (PROF_NO)
	REFERENCES SCHOOL_PROFESSORS (PROF_NO)
;


ALTER TABLE SCHOOL_COURSE_REGISTRATIONS
	ADD FOREIGN KEY (STUD_NO)
	REFERENCES SCHOOL_STUDENTS (STUD_NO)
;


ALTER TABLE SCHOOL_COURSES
	ADD FOREIGN KEY (SUBJECT_NO)
	REFERENCES SCHOOL_SUBJECTS (SUBJECT_NO)
;



CREATE SEQUENCE SCHOOL_DEPT_SEQ START WITH 10 INCREMENT BY 10 NOCACHE;
CREATE SEQUENCE SCHOOL_PROF_SEQ START WITH 1000 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SCHOOL_STUDENT_SEQ START WITH 5000 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SCHOOL_SUBJECT_SEQ START WITH 100 INCREMENT BY 10 NOCACHE;
CREATE SEQUENCE SCHOOL_COURSE_SEQ START WITH 100 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SCHOOL_COURSE_REG_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;

CREATE OR REPLACE VIEW SCHOOL_COURSES_VIEW
AS
    SELECT a.course_no,         -- ������ȣ
           a.course_name,       -- ������
           a.course_quota,      -- ���� ����
           a.course_reg_cnt,    -- ���� ��û �ο�
           a.course_closed,     -- ��������
           b.subject_no,        -- �а���ȣ
           b.subject_name,      -- �а���
           c.prof_no,           -- ��米����ȣ
           c.prof_name,         -- ��米���̸�
           D.DEPT_NO,           -- �����а���ȣ
           D.DEPT_NAME,         -- �����а���
           a.course_create_date -- �����
    FROM school_courses A, school_subjects B, school_professors C, school_dept D
    WHERE a.subject_no = b.subject_no
    AND A.PROF_NO = C.PROF_NO
    AND b.dept_no = d.dept_no;

-- �������� ������ ����
SELECT *
FROM school_courses_view
WHERE COURSE_NO = ?;

-- �а����� ������ ���� ����
SELECT *
FROM school_courses_view
WHERE DEPT_NAME = ?;

-- ������ ������ ���� ����
SELECT *
FROM school_courses_view
WHERE PROF_NAME = ?;

-- �������� ���� ���� ����
SELECT *
FROM school_courses_view
WHERE course_closed = 'N';