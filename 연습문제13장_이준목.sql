-- 13장 연습문제 p357
    drop table empidx;
--1번문제
    --  1-1번
    create table empidx
    as select * from emp;
    
    select * from empidx;
    --  1-2번
    create index IDX_EMPIDX_EMPNO on empidx(empno);
    
    -- 1-3번
    select * from User_indexes
    where index_name = 'IDX_EMPIDX_EMPNO';

--2번문제
    create or replace view EMPIDX_OVER15K
    as (select empno, ename, job, deptno, sal, nvl2(comm, 'O', 'X') comm
        from empidx
        where sal >1500)
    with read only;
        
    select * from EMPIDX_OVER15K;
    
--3번문제
    -- 3-1번
    create table DEPTSEQ
    as select * from dept;
    
    -- 3-2번
    create sequence dept_seq
    increment by 1
    start with 1
    maxvalue 99
    minvalue 1
    cycle
    nocache;
    
    alter sequence dept_seq
    nocycle;
    
    -- 3-3번 
    select * from deptseq;
    insert into deptseq values(dept_seq.nextval, 'DATABASE', 'SEOUL');
    insert into deptseq values(dept_seq.nextval, 'WEB', 'BUSAN');    
    insert into deptseq values(dept_seq.nextval, 'MOBILE', 'ILSAN');    
    COMMIT;
   
    -- 시퀀스 삭제
    drop sequence dept_seq;
    -- 테이블 삭제
    drop table deptseq;
    drop table empidx;
    -- 뷰삭제
    drop view empidx_over15k;
    -- 인덱스 삭제
    drop index idx_empidx_empno;