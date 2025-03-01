-- ��)ȣ�� ==> ����
--1)HOTEL(hotel_id, name, grade, address)
--hotel_id �⺻Ű ==> ������ :hotel_seq

--2)review(num, titel, content, regdate)
--num : �⺻Ű ==> ������ : review_seq
--regdate date �� ==> ���ó�¥�� �⺻��

--3)hotel �� �������� review �� ���� �� �ִ�
 -- ==> �ܷ�Ű�ο�

create sequence HOTEL_seq
increment by 1
start with 1
minvalue 1
nocycle
nocache;

create table HOTEL(
    hotel_id number default hotel_seq.nextval 
                    constraint HOTEL_hotel_id_pk 
                    primary key,
    name varchar2(20),
    grade varchar2(10),
    address varchar2(70)
);

create sequence review_seq
increment by 1
start with 1
minvalue 1
nocycle
nocache;

create table review(
    hid number constraint hotel_review_fk 
                    references HOTEL(hotel_id),
    num number default review_seq.nextval
               constraint num_num_pk 
               primary key,
    title varchar2(20),
    content varchar2(70),
    regdate date default sysdate
);

--------------------------------------------------------
-- employees  / department
-- �μ��� �������� ����� ������

alter table employees
add constraint employees_fk foreign key(department_id)
references departments(department_id);

-- �������� Ȯ��
select * from user_constraints;
select constraint_name, constraint_type, table_name
from user_constraints;

-- ȣ��, ���� ���̺� ����
drop table review;
drop table hotel;

select constraint_name, constraint
























