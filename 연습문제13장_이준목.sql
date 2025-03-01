-- 13�� �������� p357
    drop table empidx;
--1������
    --  1-1��
    create table empidx
    as select * from emp;
    
    select * from empidx;
    --  1-2��
    create index IDX_EMPIDX_EMPNO on empidx(empno);
    
    -- 1-3��
    select * from User_indexes
    where index_name = 'IDX_EMPIDX_EMPNO';

--2������
    create or replace view EMPIDX_OVER15K
    as (select empno, ename, job, deptno, sal, nvl2(comm, 'O', 'X') comm
        from empidx
        where sal >1500)
    with read only;
        
    select * from EMPIDX_OVER15K;
    
--3������
    -- 3-1��
    create table DEPTSEQ
    as select * from dept;
    
    -- 3-2��
    create sequence dept_seq
    increment by 1
    start with 1
    maxvalue 99
    minvalue 1
    cycle
    nocache;
    
    alter sequence dept_seq
    nocycle;
    
    -- 3-3�� 
    select * from deptseq;
    insert into deptseq values(dept_seq.nextval, 'DATABASE', 'SEOUL');
    insert into deptseq values(dept_seq.nextval, 'WEB', 'BUSAN');    
    insert into deptseq values(dept_seq.nextval, 'MOBILE', 'ILSAN');    
    COMMIT;
   
    -- ������ ����
    drop sequence dept_seq;
    -- ���̺� ����
    drop table deptseq;
    drop table empidx;
    -- �����
    drop view empidx_over15k;
    -- �ε��� ����
    drop index idx_empidx_empno;