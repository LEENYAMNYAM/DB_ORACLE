-- 예)호텔 ==> 리뷰
--1)HOTEL(hotel_id, name, grade, address)
--hotel_id 기본키 ==> 시퀀스 :hotel_seq

--2)review(num, titel, content, regdate)
--num : 기본키 ==> 시퀀스 : review_seq
--regdate date 형 ==> 오늘날짜를 기본값

--3)hotel 은 여러개의 review 를 가질 수 있다
 -- ==> 외래키부여

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
-- 부서는 여러명의 사원을 가진다

alter table employees
add constraint employees_fk foreign key(department_id)
references departments(department_id);

-- 제약조건 확인
select * from user_constraints;
select constraint_name, constraint_type, table_name
from user_constraints;

-- 호텔, 리뷰 테이블 삭제
drop table review;
drop table hotel;

select constraint_name, constraint
























