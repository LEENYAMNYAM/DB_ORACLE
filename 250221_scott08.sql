set serveroutput on;

-- 프로시저
-- ctas emp_mon 테이블 생성(emp 이용)
create table emp_mon
as select * from emp;

-- (empno, ename, job, mgr, sal)
-- 4000, '홍길동', '사원', 5000, 800 추가
-- 4001, '홍길동1', '사원1', 5000, 900 추가

create or replace PROCEDURE emp_proc(v_empno emp.empno%type,
                                     v_ename emp.ename%type,
                                     v_job   emp.job%type,
                                     v_mgr   emp.mgr%type,
                                     v_sal   emp.sal%type)
is
begin
    insert into emp_mon(empno, ename, job, mgr, sal)
    values(v_empno,v_ename,v_job,v_mgr,v_sal);
    commit;
end;
/

execute emp_proc(4000, '홍길동', '사원', 5000, 800);
execute emp_proc(4001, '홍길동1', '사원1', 5000, 900);

select * from emp_mon;

--------------------------------------------------------
-- 부서명, 인원수, 급여 합계를 구하는 프로시저 작성
create or replace procedure sumProcess
is
    cursor c1 is
    select d.dname 부서명, count(*) 인원수, sum(e.sal) 급여합계
    from emp e, dept d
    where e.deptno = d.deptno
    group by d.dname;
begin
    for i in c1 loop
        dbms_output.put_line('부서명 : ' || i.부서명);
        dbms_output.put_line('인원수 : ' || i.인원수);
        dbms_output.put_line('급여합계 : ' || i.급여합계);
        dbms_output.put_line(' ');
    end loop;
end;
/
EXECUTE sumprocess;









