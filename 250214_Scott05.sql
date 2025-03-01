-- p396 15�� �����, ����, �� ����
-- ����� / �����ͺ��̽� => ��Ű��
    -- ��) scott : �����
    -- scott�� ������ ���̺�, ��������, ������ �� �����ͺ��̽����� ���� ��� ��ü�� ��Ű��
    -- ����� ����  ==> ������ �����̹Ƿ�
    -- ��� 250214_system02.sql ���Ͽ��� �۾���
-----------------------------------------------------
-- p416 15�� ��������
    -- 2. scott�������� �����ؼ� 
    --prev_hw�� emp, dept, salgrade ���̺��� select ���� �ο�
    
    grant select on emp to prev_hw;
    grant select on dept to prev_hw; 
    grant select on salgrade to prev_hw;
    
    --3. 2���� �ο��� ���� ���
    revoke select on emp from prev_hw;
    revoke select on dept from prev_hw; 
    revoke select on salgrade from prev_hw;
    
    --4. prev_hw ���� ==> ������ �������� �۾��ؾߵ�.
    
    
    
--------------------------------------------------------------------------------
-- 16��
   -- pl/sql(p420)
set serveroutput on; -- ��� ��� Ȯ��

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
    v_deptno1 dept.deptno%type :=5; --������(dept���̺��� deptno������ ���� ���� ��
begin
    v_ename := 'SMITH';
    v_empno := 7788;
    dbms_output.put_line('v_ename :' ||v_ename);
    dbms_output.put_line('v_empno :' ||v_empno);
    v_empno := 9900;
    dbms_output.put_line('v_empno :' ||v_empno);
    dbms_output.put_line('v_tax :' ||v_tax);
--    v_tax :=5; -- ���� �߻� constant�� ����(���� �Ұ�)
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
        dbms_output.put_line(v_number ||'¦��');
    else
        dbms_output.put_line(v_number ||'Ȧ��');    
    end if;
    dbms_output.put_line('deptno : ' || v_deptno_row.deptno);
    dbms_output.put_line('deptno : ' || v_deptno_row.dname);
    dbms_output.put_line('deptno : ' || v_deptno_row.loc);
end;    
/       

-------------------------------------------------
-- p434 �������(A/B/C/D/F ����)
DECLARE
    v_score number := 88;
BEGIN
    if v_score >= 90 then
    dbms_output.put_line('A����');
    elsif v_score >= 80 then
    dbms_output.put_line('B����');
    elsif v_score >= 70 then
    dbms_output.put_line('C����');
    elsif v_score >= 60 then
    dbms_output.put_line('D����');
    else
    dbms_output.put_line('F����');
    end if;
    
    case
        when v_score >= 90 then dbms_output.put_line('A����!!');
        when v_score >= 80 then dbms_output.put_line('B����!!');
        when v_score >= 70 then dbms_output.put_line('C����!!');
        when v_score >= 60 then dbms_output.put_line('D����!!');
        else dbms_output.put_line('F����!!');
    end case;
    
    case trunc(v_score/10)
        when 10 then dbms_output.put_line('A����!!!');
        when 9 then dbms_output.put_line('A����!!!');
        when 8 then dbms_output.put_line('B����!!!');
        when 7 then dbms_output.put_line('C����!!!');
        when 6 then dbms_output.put_line('D����!!!');
        else dbms_output.put_line('F����!!');
    end case;
    
END;
/

    
    
    