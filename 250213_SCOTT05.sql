--DML(���۾�:data manipulation language):�����͸� �߰�,����,����==>���������۾�(insert, update, delete)
--DDL(data definition language):��ü�� ����, ����, �����ϴ� ���������Ǿ�(create,alter,drop)
--DCL

--p291 11�� Ʈ�����
--Ʈ�����:  �� �̻� ���� �� �� ���� �ּ� �������
--�ѹ��� �����Ͽ� �۾��� �Ϸ��ϰų� ��� �������� �ʰų�(�۾����)
--ALL or Nothing(commit / rollback)
--TCL

--Ʈ�����(ACID)
--A : ���ڼ�(Atomicity)
--C : �ϰ���(constistency)     -- �ϰ������� DB ���� ����
--I : �ݸ���(Isolation)        -- Ʈ����� ���� �� �ٸ� Ʈ������� �۾��� ������� ���ϵ��� �����ϴ� ��
--D : ���Ӽ�(Durability)       -- ���������� ����� Ʈ������� ������ �ݿ� �Ǵ� ��

-- p298 �б��ϰ���
-- �ݸ�����
    -- Oracle : Read Commited
    -- mySQL : Repeatable Commited
select * from test;
insert into test(no, name) values(3,'ȫ�浿');

update test
set name = 'ȫ�浿22'
where no = 3;
commit;

--p327 <13�� ��ü����>
-- ������ ����(data dictionary) : �����ͺ��̽��� �����ϰ� ��ϴ� �� �ʿ��� 
--                               ��� Ư���� ���̺�� �����ͺ��̽��� �����Ǵ� ������ �ڵ� ����
    -- USER_ : ���� �����ͺ��̽��� ������ ����ڰ� ������ ��ü ����
    -- ALL_ : ��밡���� ��� ��ü ����
    -- DBA_ : �����ͺ��̽� ������ ���� ����(SYS, SYSTEM ����ڸ� ���� ����) 
    -- V$_  : �����ͺ��̽� ���� ����
    
-- �ε���
-- ��(view) : ������ ���̺�(���Ǽ�, ���Ȼ�)
    
    
select * from dictionary;

-- ���� ������ ����(scott)�� ������ �ִ� ��� ���̺� ��ȸ
select table_name from user_tables;

-- scott ������ ������ �ִ� ��� ��ü ���� ��ȸ
select owner, table_name from all_tables;

--������ �����̹Ƿ�(dba_) scott���δ� ���� �Ұ�
-- select * from dba_tables;

--p334 �ε���
    --����
    create index idx_emp_sal
    on emp(sal);
    --����
    drop index idx_emp_sal;

--p338 ��(view)
    create view vw_emp20
    as (select empno, ename, job, deptno
    from emp
    where deptno>20);
    
    select * from vw_emp20;
    select * from user_views;
    
    create or replace view vw_emp20   -- ������ ����� ������ ��ü�϶�(create ore replace)
    as (select empno, ename, job, deptno
        from emp
        where deptno>20);

-- emp ���̺� ��ü ������ v_emp1 �� ����
    create or replace view v_emp1
    as (select * from emp);
    select * from v_emp1;
    select * from user_views;
    
    -- v_emp1 (3000, 'ȫ�浿', sysdate) �߰�
    insert into v_emp1(empno, ename, hiredate)
    values(3000, 'ȫ�浿', sysdate);
    select * from v_emp1;
    select * from emp;      --v_emp1�� �߰��ϸ� emp���� �߰���
    commit;
    
    -- emp ���̺� 3000�� ����
    delete from emp where empno=3000;
    commit;
    select * from emp;
    select * from v_emp1;   -- emp���� �����ص� v_emp1�� ������
    
    -- v_emp1 ���� 3000�� ����
    delete from v_emp1 where empno=3000;
    commit;
    
    -- �� v-emp1 ����
    drop view v_emp1;
    
-- ������ �б⸸ ������ v_emp1 �� �����ϸ� ���ȼ��� ��ȭ��.
create or replace view v_emp1
as (select * from emp)
with read only;          --�б⸸ ������ view ����
    
    -- v_emp1���� (3000, 'ȫ�浿', sysdate) �߰��� �Ұ����ϴ�(�б������̱� ����)
--    insert into v_emp1(empno, ename, hiredate)
--    values(3000, 'ȫ�浿', sysdate);
    
-- p344
    -- �μ��� �ִ�޿��� �޴� ����� �μ���ȣ, �μ���, �޿�
    -- dept, emp ���̺� �̿�    
    select d.deptno, d.dname, e.sal
        from emp e, dept d
        where e.deptno = d.deptno
        and e.sal in(select max(sal)
                        from emp
                        group by deptno);
    -- �ζ��κ�(SQL������ ��ȸ������ ����� ����ϴ� ��) ===> �������� or with Ȱ��
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

-- p346 rownum(�ǻ��÷�: pseudo cloumn) : ���ȣ �̱�
    select * from emp where rownum <=3;
    
    select rownum, e.*
    from emp e
    where rownum<=3;
    
    -- ename ���� ���������Ͽ� ������ 3���� ���
    select rownum, e.*
    from ( select * from emp order by ename desc ) e
    where rownum <= 3;
    
    select *
    from ( select * from emp order by ename desc )
    where rownum <= 3;
    
    -- ename���� ���������Ͽ� ������ 3���� 5���� ���
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
    where rn>=3;        -- �̰� �� ����(�ܺ����� ���̺���� �پ��⶧��)
    
-- ename �������� �Ͽ� ������ 3�� ���
select rownum, e.*
from (select * from emp order by enmae) e
where rownum <=3;
    
-- with ���(p259)
-- p347
with e as (select * from emp order by ename)
select rownum, e.*
from e
where rownum <=3;

------------------------------------------------------------------
--p348 ������(sequence)
--������(sequence) ����
create sequence dept_seq
increment by 10
start with 10
maxvalue 90
minvalue 0
nocycle
nocache;

select * from user_sequences;
-- ���̺� ���� : dept_sequence  ==> dept ������
create table dept_sequence
as select * from dept
where 1<>1;
select * from dept_sequence;
    -- 'DATABASE', 'SEOUL' �� �߰�
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
    -- ������ ����
    drop sequence dept_seq;
    -- ���̺� ����
    drop table dept_sequence;

-- �����غ���
    -- ������ ���� : emp_seq
    -- 1�� ���� / 1�� ���� / ĳ������, ����Ŭ ���� / �ּҰ� 1
    create sequence emp_seq
    increment by 1
    start with 1
    minvalue 1
    nocycle
    nocache;
    -- ���̺� ���� : emp_tmp(num, name, phone, address)
    --                 ����(3), ���ڿ�(20), ���ڿ�(20), ���ڿ�(70)
    create table emp_tmp(
        num number(3),
        name varchar2(20),
        phone varchar2(20),
        address varchar2(70)
    );  
    -- num : emp_seq �������� ���
    -- name : ȫ�浿 / phone : 010-1111-2222 / address : �λ� �߰�
    insert into emp_tmp values(emp_seq.nextval, 'ȫ�浿', '010-1111-2222', '�λ�');
    -- num : emp_seq �������� ���
    -- name : �̼��� / phone : 010-2222-3333 / address : �λ� �߰�
    insert into emp_tmp values(emp_seq.nextval, '�̼���', '010-2222-3333', '�λ�');
    -- num : emp_seq �������� ���
    -- name : ������ / phone : 010-4444-5555 / address : ���� �߰�
    insert into emp_tmp values(emp_seq.nextval, '������', '010-4444-5555', '����');
    
    commit;

    select * from emp_tmp;   
    
-- ������ ����
    alter sequence emp_seq
    increment by 20
    cycle;
    select emp_seq.nextval from dual;
    select emp_seq.nextval from dual;
-- ������ ����
drop sequence emp_seq;
-- ���̺� ����
drop table emp_tmp;

commit;
------------------p357 13�� �������� ----------------------------------------
-- ���� ���� ����
------------------p360 14�� �������� ----------------------------------------
    -- not null : null�� �Է� ����
    -- unique : �ߺ��� �Է� ����
    -- primary key (�⺻Ű) : not null + unique
    -- foreign key (�ܷ�Ű) : �ٸ����̺� �ִ� �࿡ �ִ� ���� null���� �߰� ����(���� ���� �߰��Ұ�)
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

-- �����߻�
-- login_pwd �� not null�̶� �Է¾��ϸ� �ȵ�.
--insert into table_notnull(login_id, tel)
--values('cc', '010-2222-4444');

create table table_notnull2(
    login_id varchar2(20) constraint tbl_nn2_loginID not null,
    login_pwd varchar2(20) constraint tbl_nn2_loginpwd not null,
    tel varchar2(20)
);

-- �������� Ȯ��
    select * from user_constraints;
    select * from user_constraints
    where table_name = 'TABLE_NOTNULL';  -- ���̺���� �빮�ڷ�
      
    select owner, constraint_name
    from user_constraints
    where table_name = 'TABLE_NOTNULL';
      
    select * from table_notnull2;  
      
    insert into table_notnull2 values('aa', '1111', '010-1111-2222');
    insert into table_notnull2 values('aa', '1111', '010-1111-2222');    
    commit;
    select * from table_notnull2;  

-- �������� ����  ==> tel �� not null
    alter table table_notnull2
    modify(tel constraint tbl_nn2_tel not null);
    
    -- ������ tel�� notnull�̹Ƿ�
    --insert into table_notnull2(logi_id, login_pwd)
    --values('cc', '3333');
    
    delete from table_notnull2;
    insert into table_notnull2 values('aa', '1111', '010-1111-2222');

-- �������� ���� ==> login_id unique ���Ǻο�
    alter table table_notnull2
    modify(login_id constraint tbl_nn2_unique_loginID UNIQUE);
    
    insert into table_notnull2 values('cc', '3333', '010-1111-3333');
    -- unique �� �ߺ����� �����ϱ� ������ ����
    --insert into table_notnull2 values('aa', '1111', '010-1111-2222');
    select * from table_notnull2;

-- �������� ����  table_notnull2 ���̺��� tel�� ������ �������� ����
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
values('aa', '1111', '010-1111-2222');  -- �ߺ� ����
insert into table_unique(login_id, login_pwd, tel)
values(null, '1111', '010-1111-2222');  -- �Է¼��� 
commit;
select * from table_unique;

-- ���̺� ����
drop table table_notnull;
drop table table_notnull2;
drop table table_unique;

---------------------------
--primary key : not null + unique �Ӽ��� ������ �⺻Ű 
create table table_pk(
    login_id varchar2(20) primary key,
    login_pwd varchar2(20) not null,
    tel varchar2(20)
);
insert into table_pk(login_id, login_pwd, tel)
values('aa', '1111', '010-1111-2222'); -- ���Ἲ ����
insert into table_pk(login_id, login_pwd, tel)
values(null, '1111', '010-1111-2222'); -- not null����

-- ��������
-- 1) ������ �� ���̺����
-- board(num, title, writer, content, regdate)
    -- number                           date(�⺻�� : sysdate)
    -- num : �⺻Ű <- ������ �̿�
-- ������ ���� : board_seq : 1/1/1/nocycle, nocache
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

-- 2) ������ �߰�
-- (���� : board1, �ۼ��� : ȫ�浿, ���� : 1�� �Խñ�)
-- (���� : board2, �ۼ��� : �̼���, ���� : 2�� �Խñ�)
insert into board(num, title, writer, content)
values(board_seq.nextval, 'board1', 'ȫ�浿', '1�� �Խñ�');
insert into board(num, title, writer, content)
values(board_seq.nextval, 'board2', '�̼���', '2�� �Խñ�');

select * from board;
commit;

--���� �߻�
insert into board(num, title, writer, content)
values(2, 'board3', '������', '3�� �Խñ�');
insert into board(num, title, writer, content)
values(board_seq.nextval, 'board5', '�̼���5', '5�� �Խñ�');
insert into board(num, title, writer, content)
values(board_seq.nextval, 'board6', '�̼���6', '6�� �Խñ�');
insert into board(num, title, writer, content)
values(board_seq.nextval, 'board7', '�̼���7', '7�� �Խñ�');
commit;

--board ���̺��� num ������������ �ؼ� ������ 5�� ���
select rownum, e.*
from (select * from board order by num desc) e
where rownum<=5;

-- board ���̺��� num ������������ �ؼ� ������ 3~5�� ���
select *
from (select rownum rn, b.*
      from (select * 
            from board 
            order by num desc) b
      where rownum<=5)
where rn>=3;

drop sequence board_seq;
drop table board;

----------����-----------------------
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

-- �ܷ�Ű : �ٸ����̺� �ִ� �࿡ �ִ� ���� null���� �߰� ����(���� ���� �߰��Ұ�)
    -- �μ� : dept_fk(�μ���ȣ, �μ���, ����)
    create table dept_fk(
        deptno number(5) constraint dept_fk_deptno_pk primary key,
        dname varchar2(20),
        loc varchar2(50)
    );
    --  ��� : emp_fk(�����ȣ, ����̸�, ��å, �μ���ȣ)
    create table emp_fk(
        empno number(2) constraint emp_fk_empno_pk primary key,
        ename varchar2(20),
        job varchar2(20),
        deptno number(5)
    );
    -- ������ �߰�
    insert into dept_fk values(10, '����', '�λ�');
    insert into dept_fk values(20, '����2', '�λ�2');
    insert into emp_fk values(1, 'ȫ�浿', '���', 10);
    commit;
    select * from dept_fk;
    select * from emp_fk;
    insert into emp_fk values(2, '�̼���', '���', 30);
    -- �ܷ�Ű�� �Ⱦ��� ������ ���� ���� �Էµ�.
 -------------------------------------------------------------------------------
     create table dept_fk1(
        deptno number(5) constraint dept_fk1_deptno_pk1 primary key,
        dname varchar2(20),
        loc varchar2(50)
    );
    create table emp_fk1(
        empno number(2) constraint emp_fk1_empno_pk1 primary key,
        ename varchar2(20),
        job varchar2(20),
        deptno number(5) constraint emp_fk1_deptno_pk1
        references dept_fk1(deptno)
    );
    
    -- ������ �߰�
    insert into dept_fk1 values(10, '����', '�λ�');
    insert into dept_fk1 values(20, '����2', '�λ�2');
    insert into emp_fk1 values(1, 'ȫ�浿', '���', 10);
    commit;
    select * from dept_fk1;
    select * from emp_fk1;
    -- ���Ἲ ��������(SCOTT.SYS_C008409)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�
    insert into emp_fk1 values(2, '�̼���', '���', 30);    
    -- dept_fk1�� 30�� �μ��� ��� ������ ����
    -- ��, null���� ������
    insert into emp_fk1 values(2, '�̼���', '���', null);     
    select * from emp_fk1;
    
    insert into emp_fk1 values(3, '������', '����', 10);     
    commit;
    select * from emp_fk1;
    -- 1�� ��� ����
    delete from emp_fk1 where empno=1;
    -- 20�� �μ� ����
    delete from dept_fk1 where deptno = 20;
    select * from emp_fk1;
    -- 10�� �μ� ����
    -- emp_fk1�� 10���μ��� �����Ͱ� �����ϱ� ������ �θ������� 10�� �μ� ������ �Ұ�����.
    delete from dept_fk1 where deptno = 10;
    
    -- 2�� ����� �μ���ȣ�� 30���� ����
    update emp_fk1
    set deptno = 30
    where empno =2;
    --�ܷ�Ű �������� ����
    alter table emp_fk1
    drop constraint emp_fk1_deptno_pk1;
    insert into emp_fk1 values(4, 'aaa', '����', 30);  -- ����(�ܷ�Ű �������� �����߱� ����
    --�ܷ�Ű ���������� �߰�
    alter table emp_fk1
    add constraint emp_fk1_deptno_pk1 foreign key(deptno)
    references dept_fk1(deptno)
    on delete cascade;  --�θ� �������� �ڽĵ鵵 �ڵ����� ���������� ����
    insert into emp_fk1 values(4, 'aaa', '����', 30);
    
    -- 10�� �μ� ����
    delete from dept_fk1 where deptno = 10;

    -- ������ �ܷ�Ű �������� �����ϱ�    
    -- ���̺� ��Ŭ�� - ���� - �������� - +Ű Ŭ�� - �� �ܷ�Ű �������� Ŭ��
    ALTER TABLE EMP_FK
        ADD CONSTRAINT EMP_FK_FK1 FOREIGN KEY
        (DEPTNO)
        REFERENCES DEPT_FK
        (DEPTNO)
    ON DELETE CASCADE ENABLE;
    
    -- ���̺� ����
    drop table dept_fk;
    drop table dept_fk1;
    drop table emp_fk;
    drop table emp_fk1;
    
    -------------------------------------
    -- check : row������ ���������� �ɾ���
    create table table_check(
        login_id varchar2(20) constraint tb_check_loginID primary key,
        login_pwd varchar2(20) constraint tb_check_loginPWD check (length(login_pwd) > 5),
        tel varchar2(20)
    );
    --������ �߰�
    -- üũ ��������(SCOTT.TB_CHECK_LOGINPWD)�� ����Ǿ����ϴ�
    insert into table_check(login_id, login_pwd, tel)
    values('aa', '1234', '010-1111-2222');
    
    -- ����
    insert into table_check(login_id, login_pwd, tel)
    values('aa', '123456', '010-1111-2222');
    commit;

-------------------------------------------------------------------------------
-- �����ϱ�
    -- Member(userid, uusername, tel)
    -- �⺻Ű userid �������� pk_member
    drop table comments;
    drop table Board;
    drop table Member;
    drop sequence comments_seq;
    drop sequence board_seq;
    
    create table Member(
        userid varchar2(20) constraint pk_member primary key,
        username varchar2(20),
        tel varchar2(20)
    );    
    
    -- Board(num, title, userid, content, regdate(���ó�¥ ����Ʈ��)
    -- �⺻Ű : num(�������� : board_seq) / �������� pk_board
    -- �ܷ�Ű : userid / �������� fk_board
    
    create table Board(
        num number(3) constraint pk_board primary key,
        title varchar2(30),
        userid varchar2(20) constraint fk_board references Member(userid),
        content varchar2(100),
        regdate date default sysdate
    );
    create sequence Board_seq
    increment by 1
    start with 1
    minvalue 1
    nocycle
    nocache;
    
    -- comments(cnum, msg, regdate(���ó�¥ ����Ʈ��)
    -- �⺻Ű : cnum(�������� : comments_seq / �������� pk_comments)
    -- �ܷ�Ű ����

    create table comments(
        cnum number(3) constraint pk_comments primary key,
        msg varchar2(30),
        regdate date default sysdate,
        userid varchar2(20) constraint fk_comments_member references Member(userid),   --member����
        bnum number(3) constraint fk_board_comments references Board(num)
    );
    create sequence comments_seq
    increment by 1
    start with 1
    minvalue 1
    nocycle
    nocache;
    
    -- member ������ �߰�
    insert into member values('a1', 'ȫ�浿', '010-1111-2222');
    commit;
    select * from member;
    
    -- board(num, title, content, regdate, userid) ������ �߰�
    insert into board values(board_seq.nextval, '����1', 'a1', '����1', sysdate);
    select * from board;
    
    -- comments(cnum msg regdate, userid, bnum) ������ �߰�
    insert into comments values(comments_seq.nextval, '�޼���1', sysdate, 'a1', 1);
    insert into comments values(comments_seq.nextval, '�޼���2', sysdate, 'a1', 1);
    insert into comments values(comments_seq.nextval, '�޼���3', sysdate, 'a1', 1);
    insert into comments values(comments_seq.nextval, '�޼���4', sysdate, 'a1', 1);
        
    select * from comments;
    
    -- 1�� �Խñ��� �� ����� �̸��� ���
    select username
    from board b , member m
    where b.userid = m.userid and b.num=1;
    
    select username
    from board b natural join member m
    where b.num=1;
    
    -- member ������ �߰�
    insert into member values('b1', '�̼���', '010-1111-3333');
    -- board ������ �߰�
    insert into board values(board_seq.nextval, '����2', 'b1', '����2', sysdate);
    -- comments ������ �߰�
    insert into comments values(comments_seq.nextval, '�޼���11', sysdate, 'b1', 2);
    insert into comments values(comments_seq.nextval, '�޼���22', sysdate, 'b1', 2);
    insert into comments values(comments_seq.nextval, '�޼���33', sysdate, 'b1', 2);
    insert into comments values(comments_seq.nextval, '�޼���44', sysdate, 'b1', 2);
    insert into comments values(comments_seq.nextval, '�޼���111', sysdate, 'b1', 1);
    commit;
    
    select * from member;
    select * from board;
    select * from comments;
    
    -- member �� ��� �� ���(userid, ��ۼ�)
    select  userid, count(*) ��ۼ�, bnum �Խñ۹�ȣ
    from comments
    group by userid, bnum;
    -- member �� ��� ���� �̸� ���(userid, ��ۼ�, username)
    select username, userid, �Խñ۹�ȣ, ��ۼ�
    from( select  userid, count(*) ��ۼ�, bnum �Խñ۹�ȣ
            from comments
            group by userid, bnum) natural join member;
    
-- member ���̺� a1 ����
    --���Ἲ ��������(SCOTT.FK_COMMENTS_MEMBER)�� ����Ǿ����ϴ�- �ڽ� ���ڵ尡 �߰ߵǾ����ϴ�
    delete from member where userid='a1';
    -- board ���̺��� �������� Ȯ��
    select * from user_constraints where table_name_'BOARD';
          
---------------------------------------------------------------------------------

-- scott student / professor / department
-- student �ܷ�Ű �ο� (student �� profno ==> professor �� profno)
    alter table student 
        modify(profno number(4) 
               constraint student_profno_fk 
               references professor(profno));
--  add constraint student_profno_fk references professor(profno);           
               
    
-- professor �ܷ�Ű �ο�(professor�� deptno ==> department �� deptno)
    alter table professor 
        modify(deptno number(3) 
               constraint professor_deptno_fk 
               references department(deptno));
         