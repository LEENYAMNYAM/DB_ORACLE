--DML(조작어:data manipulation language):데이터를 추가,수정,삭제==>데이터조작어(insert, update, delete)
--DDL(data definition language):객체를 생성, 변경, 삭제하는 데이터정의어(create,alter,drop)
--DCL

--p291 11장 트랜잭션
--트랜잭션:  더 이상 분할 할 수 없는 최소 수행단위
--한번에 수행하여 작업을 완료하거나 모두 수행하지 않거나(작업취소)
--ALL or Nothing(commit / rollback)
--TCL

--트랙잭션(ACID)
--A : 원자성(Atomicity)
--C : 일관성(constistency)     -- 일관적으로 DB 상태 유지
--I : 격리성(Isolation)        -- 트랜잭션 수행 시 다른 트랜잭션의 작업이 끼어들지 못하도록 보장하는 것
--D : 영속성(Durability)       -- 성공적으로 수행된 트랜잭션은 영원히 반영 되는 것

-- p298 읽기일관성
-- 격리수준
    -- Oracle : Read Commited
    -- mySQL : Repeatable Commited
select * from test;
insert into test(no, name) values(3,'홍길동');

update test
set name = '홍길동22'
where no = 3;
commit;

--p327 <13장 객체종류>
-- 데이터 사전(data dictionary) : 데이터베이스를 구성하고 운영하는 데 필요한 
--                               모든 특수한 테이블로 데이터베이스가 생성되는 시점에 자동 생성
    -- USER_ : 현재 데이터베이스에 접속한 사용자가 소유한 객체 정보
    -- ALL_ : 사용가능한 모든 객체 정보
    -- DBA_ : 데이터베이스 관리를 위한 정보(SYS, SYSTEM 사용자만 열함 가능) 
    -- V$_  : 데이터베이스 성능 관련
    
-- 인덱스
-- 뷰(view) : 가상의 테이블(편의성, 보안상)
    
    
select * from dictionary;

-- 현재 접속한 계정(scott)이 가지고 있는 모든 테이블 조회
select table_name from user_tables;

-- scott 계정이 가지고 있는 모든 객체 정보 조회
select owner, table_name from all_tables;

--관리자 권한이므로(dba_) scott으로는 접근 불가
-- select * from dba_tables;

--p334 인덱스
    --생성
    create index idx_emp_sal
    on emp(sal);
    --삭제
    drop index idx_emp_sal;

--p338 뷰(view)
    create view vw_emp20
    as (select empno, ename, job, deptno
    from emp
    where deptno>20);
    
    select * from vw_emp20;
    select * from user_views;
    
    create or replace view vw_emp20   -- 없으면 만들고 있으면 대체하라(create ore replace)
    as (select empno, ename, job, deptno
        from emp
        where deptno>20);

-- emp 테이블 전체 내용을 v_emp1 뷰 생성
    create or replace view v_emp1
    as (select * from emp);
    select * from v_emp1;
    select * from user_views;
    
    -- v_emp1 (3000, '홍길동', sysdate) 추가
    insert into v_emp1(empno, ename, hiredate)
    values(3000, '홍길동', sysdate);
    select * from v_emp1;
    select * from emp;      --v_emp1에 추가하면 emp에도 추가됨
    commit;
    
    -- emp 테이블 3000번 삭제
    delete from emp where empno=3000;
    commit;
    select * from emp;
    select * from v_emp1;   -- emp에서 삭제해도 v_emp1도 삭제됨
    
    -- v_emp1 에서 3000번 삭제
    delete from v_emp1 where empno=3000;
    commit;
    
    -- 뷰 v-emp1 삭제
    drop view v_emp1;
    
-- 때문에 읽기만 가능한 v_emp1 뷰 생성하며 보안성을 강화함.
create or replace view v_emp1
as (select * from emp)
with read only;          --읽기만 가능한 view 생성
    
    -- v_emp1에는 (3000, '홍길동', sysdate) 추가가 불가능하다(읽기전용이기 때문)
--    insert into v_emp1(empno, ename, hiredate)
--    values(3000, '홍길동', sysdate);
    
-- p344
    -- 부서별 최대급여를 받는 사원의 부서번호, 부서명, 급여
    -- dept, emp 테이블 이용    
    select d.deptno, d.dname, e.sal
        from emp e, dept d
        where e.deptno = d.deptno
        and e.sal in(select max(sal)
                        from emp
                        group by deptno);
    -- 인라인뷰(SQL문에서 일회성으로 만들어 사용하는 뷰) ===> 서브쿼리 or with 활용
    select d.deptno, d.dname, e.sal
    from (select deptno, max(sal) sal
          from emp
          group by deptno) e, dept d
    where e.deptno = d.deptno;
    
    select d.deptno, d.dname, e.sal
    from (select deptno, max(sal) sal
         from emp
         group by deptno) e join dept d
         on e.deptno = d.deptno;

-- p346 rownum(의사컬럼: pseudo cloumn) : 행번호 뽑기
    select * from emp where rownum <=3;
    
    select rownum, e.*
    from emp e
    where rownum<=3;
    
    -- ename 으로 내림차순하여 위에서 3개만 출력
    select rownum, e.*
    from ( select * from emp order by ename desc ) e
    where rownum <= 3;
    
    select *
    from ( select * from emp order by ename desc )
    where rownum <= 3;
    
    -- ename으로 내림차순하여 위에서 3에서 5사이 출력
    select *
    from(select rownum rn, e.*
         from (select * 
               from emp 
               order by ename desc) e
               )
    where rn>=3 and rn<=5;
    
    select *
    from(select rownum rn, e.*
         from (select * 
               from emp 
               order by ename desc) e
         where rownum <=5)
    where rn>=3;        -- 이게 더 빠름(외부쿼리 테이블수가 줄어들기때문)
    
-- ename 내림차순 하여 위에서 3개 출력
select rownum, e.*
from (select * from emp order by enmae) e
where rownum <=3;
    
-- with 사용(p259)
-- p347
with e as (select * from emp order by ename)
select rownum, e.*
from e
where rownum <=3;

------------------------------------------------------------------
--p348 시퀀스(sequence)
--시퀀스(sequence) 생성
create sequence dept_seq
increment by 10
start with 10
maxvalue 90
minvalue 0
nocycle
nocache;

select * from user_sequences;
-- 테이블 생성 : dept_sequence  ==> dept 구조만
create table dept_sequence
as select * from dept
where 1<>1;
select * from dept_sequence;
    -- 'DATABASE', 'SEOUL' 값 추가
    insert into dept_sequence(dname, loc) values('DATABASE', 'SEOUL');
    select * from dept_sequence;
    
    insert into dept_sequence(deptno, dname, loc)
    values(dept_seq.nextval, 'DATABASE1', 'SEOUL1');
    insert into dept_sequence(deptno, dname, loc)
    values(dept_seq.nextval, 'DATABASE2', 'SEOUL2');
    insert into dept_sequence(deptno, dname, loc)
    values(dept_seq.nextval, 'DATABASE3', 'SEOUL3');    
    
    select dept_seq.nextval from dual;
    insert into dept_sequence(deptno, dname, loc)
    values(dept_seq.nextval, 'DATABASE4', 'SEOUL4'); 
    select * from dept_sequence;
    select dept_seq.currval from dual;
    delete from dept_sequence where dname = 'DATABASE';
    commit;
    select * from dept_sequence;
    insert into dept_sequence(deptno, dname, loc)
    values(dept_seq.nextval, 'DATABASE5', 'SEOUL5');
    -- 시퀀스 삭제
    drop sequence dept_seq;
    -- 테이블 삭제
    drop table dept_sequence;

-- 연습해보기
    -- 시퀀스 생성 : emp_seq
    -- 1로 시작 / 1씩 증가 / 캐쉬없음, 사이클 없음 / 최소값 1
    create sequence emp_seq
    increment by 1
    start with 1
    minvalue 1
    nocycle
    nocache;
    -- 테이블 생성 : emp_tmp(num, name, phone, address)
    --                 숫자(3), 문자열(20), 문자열(20), 문자열(70)
    create table emp_tmp(
        num number(3),
        name varchar2(20),
        phone varchar2(20),
        address varchar2(70)
    );  
    -- num : emp_seq 시퀀스로 사용
    -- name : 홍길동 / phone : 010-1111-2222 / address : 부산 추가
    insert into emp_tmp values(emp_seq.nextval, '홍길동', '010-1111-2222', '부산');
    -- num : emp_seq 시퀀스로 사용
    -- name : 이순신 / phone : 010-2222-3333 / address : 부산 추가
    insert into emp_tmp values(emp_seq.nextval, '이순신', '010-2222-3333', '부산');
    -- num : emp_seq 시퀀스로 사용
    -- name : 강감찬 / phone : 010-4444-5555 / address : 서울 추가
    insert into emp_tmp values(emp_seq.nextval, '강감찬', '010-4444-5555', '서울');
    
    commit;

    select * from emp_tmp;   
    
-- 시퀀스 변경
    alter sequence emp_seq
    increment by 20
    cycle;
    select emp_seq.nextval from dual;
    select emp_seq.nextval from dual;
-- 시퀀스 삭제
drop sequence emp_seq;
-- 테이블 삭제
drop table emp_tmp;

commit;
------------------p357 13장 연습문제 ----------------------------------------
-- 따로 파일 만듦
------------------p360 14장 제약조건 ----------------------------------------
    -- not null : null값 입력 금지
    -- unique : 중복값 입력 금지
    -- primary key (기본키) : not null + unique
    -- foreign key (외래키) : 
    -- check : 
--p362
--not null
create table table_notnull(
    login_id varchar2(20) not null,
    login_pwd varchar2(20) not null,
    tel varchar2(20)
);
insert into table_notnull(login_id, login_pwd, tel)
values('aa', '1111', '010-1111-2222');

insert into table_notnull(login_id, login_pwd, tel)
values('bb', '2222', '010-1111-3333');

insert into table_notnull(login_id, login_pwd)
values('cc', '3333');

commit;

select * from table_notnull;

-- 오류발생
-- login_pwd 가 not null이라서 입력안하면 안됨.
--insert into table_notnull(login_id, tel)
--values('cc', '010-2222-4444');

create table table_notnull2(
    login_id varchar2(20) constraint tbl_nn2_loginID not null,
    login_pwd varchar2(20) constraint tbl_nn2_loginpwd not null,
    tel varchar2(20)
);

-- 제약조건 확인
    select * from user_constraints;
    select * from user_constraints
    where table_name = 'TABLE_NOTNULL';  -- 테이블명은 대문자로
      
    select owner, constraint_name
    from user_constraints
    where table_name = 'TABLE_NOTNULL';
      
    select * from table_notnull2;  
      
    insert into table_notnull2 values('aa', '1111', '010-1111-2222');
    insert into table_notnull2 values('aa', '1111', '010-1111-2222');    
    commit;
    select * from table_notnull2;  

-- 제약조건 변경  ==> tel 을 not null
    alter table table_notnull2
    modify(tel constraint tbl_nn2_tel not null);
    
    -- 에러남 tel이 notnull이므로
    --insert into table_notnull2(logi_id, login_pwd)
    --values('cc', '3333');
    
    delete from table_notnull2;
    insert into table_notnull2 values('aa', '1111', '010-1111-2222');

-- 제약조건 변경 ==> login_id unique 조건부여
    alter table table_notnull2
    modify(login_id constraint tbl_nn2_unique_loginID UNIQUE);
    
    insert into table_notnull2 values('cc', '3333', '010-1111-3333');
    -- unique 는 중복값을 허용안하기 때문에 에러
    --insert into table_notnull2 values('aa', '1111', '010-1111-2222');
    select * from table_notnull2;

-- 제약조건 변경  table_notnull2 테이블에서 tel이 가지는 제약조건 삭제
alter table table_notnull2
drop constraint tbl_nn2_tel;
insert into table_notnull2(login_id, login_pwd) values('bb', '2222');

create table table_unique(
    login_id varchar2(20) constraint tbl_unique_loginID UNIQUE,
    login_pwd varchar2(20) not null,
    tel varchar2(20)
);

insert into table_unique(login_id, login_pwd, tel)
values('aa', '1111', '010-1111-2222');
insert into table_unique(login_id, login_pwd, tel)
values('aa', '1111', '010-1111-2222');  -- 중복 에러
insert into table_unique(login_id, login_pwd, tel)
values(null, '1111', '010-1111-2222');  -- 입력성공 
commit;
select * from table_unique;

-- 테이블 삭제
drop table table_notnull;
drop table table_notnull2;
drop table table_unique;

---------------------------
--primary key : not null + unique 속성을 가지는 기본키 
create table table_pk(
    login_id varchar2(20) primary key,
    login_pwd varchar2(20) not null,
    tel varchar2(20)
);
insert into table_pk(login_id, login_pwd, tel)
values('aa', '1111', '010-1111-2222'); -- 무결성 위배
insert into table_pk(login_id, login_pwd, tel)
values(null, '1111', '010-1111-2222'); -- not null위배

-- 연습문제
-- 1) 시퀀스 및 테이블생성
-- board(num, title, writer, content, regdate)
    -- number                           date(기본값 : sysdate)
    -- num : 기본키 <- 시퀀스 이용
-- 시퀀스 생성 : board_seq : 1/1/1/nocycle, nocache
create table board(
    num number primary key,
    title varchar2(50), 
    writer varchar2(20),
    content varchar2(70),
    regdate date default sysdate
);
create sequence board_seq
    increment by 1
    start with 1
    minvalue 1
    nocycle
    nocache;

-- 2) 데이터 추가
-- (제목 : board1, 작성자 : 홍길동, 내용 : 1번 게시글)
-- (제목 : board2, 작성자 : 이순신, 내용 : 2번 게시글)
insert into board(num, title, writer, content)
values(board_seq.nextval, 'board1', '홍길동', '1번 게시글');
insert into board(num, title, writer, content)
values(board_seq.nextval, 'board2', '이순신', '2번 게시글');

select * from board;
commit;

--오류 발생
insert into board(num, title, writer, content)
values(2, 'board3', '강감찬', '3번 게시글');
insert into board(num, title, writer, content)
values(board_seq.nextval, 'board5', '이순신5', '5번 게시글');
insert into board(num, title, writer, content)
values(board_seq.nextval, 'board6', '이순신6', '6번 게시글');
insert into board(num, title, writer, content)
values(board_seq.nextval, 'board7', '이순신7', '7번 게시글');
commit;

--board 테이블에서 num 내림차순으로 해서 위에서 5개 출력
select rownum, e.*
from (select * from board order by num desc) e
where rownum<=5;

-- board 테이블에서 num 내림차순으로 해서 위에서 3~5개 출력
select *
from (select rownum rn, b.*
      from (select * 
            from board 
            order by num desc) b
      where rownum<=5)
where rn>=3;

drop sequence board_seq;
drop table board;

----------정리-----------------------
create table table_name(
    col1 varchar2(20) constraint table_name_col1 primary key,
    col2 varchar2(20) not null,
    col3 varchar2(20)
);
create table table_name2(
    col1 varchar2(20),
    col2 varchar2(20) not null,
    col3 varchar2(20),
    primary key (col1)
);
create table table_name3(
    col1 varchar2(20),
    col2 varchar2(20) not null,
    col3 varchar2(20),
    constraint table_name3_pk primary key (col1)
);
create table table_name4(
    col1 varchar2(20),
    col2 varchar2(20) not null,
    col3 varchar2(20)
);
alter table table_name4
add constraint table_name4_pk primary key(col1);

drop table table_name4;
drop table table_name3;
drop table table_name2;
drop table table_name;