-- p396 15장 사용자, 권한, 롤 관리
-- 사용자 / 데이터베이스 => 스키마
    -- 예) scott : 사용자
    -- scott이 생성한 테이블, 제약조건, 시퀀스 등 데이터베이스에서 만든 모든 객체를 스키마
    -- 사용자 생성  ==> 관리자 권한이므로
    -- 잠시 250214_system02.sql 파일에서 작업함
-----------------------------------------------------
-- p416 15장 연습문제
    -- 2. scott계정으로 접속해서 
    --prev_hw에 emp, dept, salgrade 테이블의 select 권한 부여
    
    grant select on emp to prev_hw;
    grant select on dept to prev_hw; 
    grant select on salgrade to prev_hw;
    
    --3. 2번에 부여한 권한 취소
    revoke select on emp from prev_hw;
    revoke select on dept from prev_hw; 
    revoke select on salgrade from prev_hw;
    
    --4. prev_hw 삭제 ==> 관리자 계정에서 작업해야됨.
    
    
    
--------------------------------------------------------------------------------
-- 16장
   -- pl/sql(p420)
set serveroutput on; -- 출력 결과 확인

BEGIN 
    dbms_output.put_line('Hello');
end;
/

-- p421
declare
    v_ename varchar2(20);
    v_empno number(4);
    v_tax constant number(3) :=3;
    v_deptno number(2) not null default 10;
    v_deptno1 dept.deptno%type :=5; --참조형(dept테이블의 deptno변수의 형과 같은 형
begin
    v_ename := 'SMITH';
    v_empno := 7788;
    dbms_output.put_line('v_ename :' ||v_ename);
    dbms_output.put_line('v_empno :' ||v_empno);
    v_empno := 9900;
    dbms_output.put_line('v_empno :' ||v_empno);
    dbms_output.put_line('v_tax :' ||v_tax);
--    v_tax :=5; -- 오류 발생 constant로 선언(변경 불가)
    dbms_output.put_line('v_deptno :' ||v_deptno);
    dbms_output.put_line('v_deptno1 :' ||v_deptno1);    
end;

---------------------------------------------------
--p429

select * from dept;
select deptno, dname, loc from dept where deptno=40;
---------
declare
    v_deptno dept.deptno%type;
    v_dname varchar2(20);
    v_loc   varchar2(20);
begin
    select deptno, dname, loc into v_deptno, v_dname, v_loc
    from dept
    where deptno=40;
    dbms_output.put_line('deptno : ' || v_deptno);
    dbms_output.put_line('deptno : ' || v_dname);
    dbms_output.put_line('deptno : ' || v_loc);
end;    
/   

declare
    v_deptno_row dept%rowtype;
    v_number number := 30;
begin
    select deptno, dname, loc into v_deptno_row
    from dept
    where deptno=40;
    if mod(v_number,2) = 0 THEN
        dbms_output.put_line(v_number ||'짝수');
    else
        dbms_output.put_line(v_number ||'홀수');    
    end if;
    dbms_output.put_line('deptno : ' || v_deptno_row.deptno);
    dbms_output.put_line('deptno : ' || v_deptno_row.dname);
    dbms_output.put_line('deptno : ' || v_deptno_row.loc);
end;    
/       

-------------------------------------------------
-- p434 학점출력(A/B/C/D/F 학점)
DECLARE
    v_score number := 88;
BEGIN
    if v_score >= 90 then
    dbms_output.put_line('A학점');
    elsif v_score >= 80 then
    dbms_output.put_line('B학점');
    elsif v_score >= 70 then
    dbms_output.put_line('C학점');
    elsif v_score >= 60 then
    dbms_output.put_line('D학점');
    else
    dbms_output.put_line('F학점');
    end if;
    
    case
        when v_score >= 90 then dbms_output.put_line('A학점!!');
        when v_score >= 80 then dbms_output.put_line('B학점!!');
        when v_score >= 70 then dbms_output.put_line('C학점!!');
        when v_score >= 60 then dbms_output.put_line('D학점!!');
        else dbms_output.put_line('F학점!!');
    end case;
    
    case trunc(v_score/10)
        when 10 then dbms_output.put_line('A학점!!!');
        when 9 then dbms_output.put_line('A학점!!!');
        when 8 then dbms_output.put_line('B학점!!!');
        when 7 then dbms_output.put_line('C학점!!!');
        when 6 then dbms_output.put_line('D학점!!!');
        else dbms_output.put_line('F학점!!');
    end case;
    
END;
/

    
    
    