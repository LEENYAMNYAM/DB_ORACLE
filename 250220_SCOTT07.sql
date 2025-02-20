--p439 �ݺ���
set serveroutput on;   -- ��� ��� Ȯ��(�����ų�� ���� ��ũ��Ʈ �����ư���� �����ؾ߸� ��)

DECLARE
    v_num number := 0;
begin 
    loop
        dbms_output.put_line('v_num :' || v_num);
        v_num := v_num+1;
        if v_num > 5 then
            exit;
        end if;
    end loop;
end;
/
--------------------------------------------------
declare
    v_number number :=0;
begin
    while v_number < 5 loop
        dbms_output.put_line('v_number :' || v_number);
        v_number := v_number+1;
    end loop;
    ----
    for i in 1..4 loop
        dbms_output.put_line('v_number :' || v_number);
    end loop;
end;
/

------------------------------------
-- for �� �̿��ؼ� 0���� 4���� ���� : ¦���� ���
begin
    for i in 0..4 loop
        if mod(i,2) = 0 then
            dbms_output.put_line('���� ¦�� i : '||i);
        end if;
    end LOOP;
end;
/

begin
    for k in 0..4 loop
        continue when mod(k,2) =1;
        dbms_output.put_line('���� ¦�� k : '||k);
    end LOOP;
    
    dbms_output.put_line('------------------------');

    for m in 0..4 loop
        exit when mod(m,2) = 1;         -- exit ������ ������ �ٽ� for �� ��������
        dbms_output.put_line('���� ¦�� m : '||m);
    end LOOP;
    
end;
/

---- p444 16�� ��������
---- 1. ���� 1���� 10 ���� Ȧ�� ���
begin 
    for i in 1..10 loop
        if mod(i,2) = 1 then
            dbms_output.put_line('Ȧ�� i �� : ' || i);
        end if;
    end loop;
end;
/

--- while�� Ȱ��
declare
    m_number number :=1;
begin
    while m_number < 10 loop
        dbms_output.put_line('Ȧ�� : ' || m_number);
        m_number := m_number +2;
    end loop;
end;
/
        
-- 2. dept���̺��� deptno �� �ڷ����� ���� ����  v_deptno ����
-- v_deptno ���� ���� �μ��� ���(10, 20, 30, 40, �� �ƴϸ� N/A)

--case��
ACCEPT p_deptno prompt '�μ���ȣ�Է�:'; 

declare
    v_deptno dept.deptno%type := &p_deptno;      -- v_deptno number;   �Է°� �������� &�� ��ȣ�� �� �����.
begin
    case v_deptno
        when 10 then dbms_output.put_line('DNAME: ACCOUNTING');
        when 20 then dbms_output.put_line('DNAME: RESEARCH');
        when 30 then dbms_output.put_line('DNAME: SALES');
        when 40 then dbms_output.put_line('DNAME: OPERATIONS');
        else dbms_output.put_line('DNAME: N/A');
    end case;
end;
/        
       
-- if��
ACCEPT p_deptno prompt '�μ���ȣ�Է�:'; 

declare
    v_deptno dept.deptno%type := &p_deptno;      -- v_deptno number;   �Է°� �������� &�� ��ȣ�� �� �����.
begin
    if v_deptno  = 10 then dbms_output.put_line('DNAME: ACCOUNTING');
    elsif v_deptno  =  20 then dbms_output.put_line('DNAME: RESEARCH');
    elsif v_deptno  =  30 then dbms_output.put_line('DNAME: SALES');
    elsif v_deptno  =  40 then dbms_output.put_line('DNAME: OPERATIONS');
    else dbms_output.put_line('DNAME: N/A');
    end if;
end;
/     

---- ����ó��

select dname from dept where deptno=40;
Accept p_deptno1 prompt 'select �μ���ȣ �Է� : ';
declare
    v_dname dept.dname%type;
    v_deptno dept.deptno%type := &p_deptno1;
begin
    select dname into v_dname
    from dept
    where deptno=v_deptno;
    dbms_output.put_line('�μ���ȣ : ' || v_deptno || ' DNAME: '||v_dname);
exception
    when no_data_found then
    dbms_output.put_line('�μ��� : N/A');
end;
/

-------------------------
-- 2�� ���
-- 2*1 = 2
-- 2*2 = 4
--  ...
-- 2*9 = 18

-- for�� ���
begin  
    for i in 1..9 loop
        dbms_output.put_line('2*' || i || '=' || 2*i);
    end loop;
end;
/

-- 3�� ���
declare
    total number(3);
begin
    for i in 1..9 loop
        total :=3*i;
        dbms_output.put_line('3*' || i || '=' || total);
    end loop;
end;
/
        
-- �Է¹��� ������ �������� ���� ���
       
declare
    stage number(3):= &p_stage;
    total number(3);
begin
    for i in 1..9 loop
        total :=stage*i;
        dbms_output.put_line(stage || '*' || i || '=' || total);
    end loop;
end;
/    

--dept ���̺� �̿�
-- �μ���ȣ�� �Է¹޾� �μ���� ������ ����ϱ�
select dname, loc from dept where deptno =10;

ACCEPT p_deptno prompt '�μ���ȣ �Է� : ';
declare
    v_deptno dept.deptno%type := &p_deptno;
    v_dname dept.dname%type;
    v_loc dept.loc%type;    
begin
    select dname, loc into v_dname, v_loc
    from dept
    where deptno=v_deptno;
    dbms_output.put_line('�μ���ȣ : ' || v_deptno || ' �μ��� : '|| v_dname || ' ��ġ : ' ||v_loc);
exception
    when no_data_found then
    dbms_output.put_line('�μ��� : N/A');        
end;
/  

-- ���̺� �ڷ� �߰��ϱ� 
create table A (
        a1 number,
        a2 number,
        a3 number
);

select * from A;
accept p_dan prompt '���Է�:';
declare
    dan number(2) := &p_dan;
    total number(3);
begin
    for i in 1..9 loop
        total := dan*i;
        dbms_output.put_line(dan || '*' || i || '=' || total);
        insert into A values(dan, i, total);
    end loop;
end;
/
select * from A;
        
---- �ǽ�����
-- �μ���ȣ�� �Է¹޾� �� �μ��� �μ���� ������ ����ϰ�
-- dept_tmp ���̺� �� ������ �߰��ϱ�

-- num ������ : dept_tmp_seq
create sequence dept_tmp_seq
increment by 1
start with 1
minvalue 1
nocache
nocycle;

-- dept_tmp ���̺� ����
create table dept_tmp(
    num number,
    dname varchar2(50),
    loc varchar2(50)
);

-- �μ���ȣ�� �Է¹޾� �� �μ��� �μ���� ������ ����ϰ�
-- dept_tmp ���̺� �� ������ �߰��ϱ�

declare
    v_deptno dept.deptno%type := &p_deptno;
    v_dname dept.dname%type;
    v_loc dept.loc%type;    
begin
    select dname, loc into v_dname, v_loc
    from dept
    where deptno=v_deptno;
    dbms_output.put_line('�μ���ȣ : ' || v_deptno || ' �μ��� : '|| v_dname || ' ��ġ : ' ||v_loc);
    insert into dept_tmp values(dept_tmp_seq.nextval, v_dname, v_loc);
    commit;
exception
    when no_data_found then
    dbms_output.put_line('�μ��� : N/A');        
end;
/  

select * from dept_tmp;

-- p446 record
-- ctas ������� dept ���̺��� �̿��� dept_record ���̺� ����
create table dept_record
as select * from dept;

select * from dept_record;
-- dept_record ���̺� 99, database, seoul �߰�

declare
    r_deptno number(3);
    r_dname varchar2(20);
    r_loc varchar2(20);
begin
    r_deptno := 99;
    r_dname := 'DATABASE';
    r_loc := 'SEOUL';
    insert into dept_record values(r_deptno, r_dname, r_loc);
    commit;
end;
/

select * from dept_record;

-----------------------------------------------
declare
    type REC_DEPT is record(
    deptno number(2) not null :=99,
    dname dept.dname%type,
    loc dept.loc%type
    );
    dept_rec REC_DEPT;
begin
    dept_rec.deptno :=29;
    dept_rec.dname := 'ORACLE';
    dept_rec.loc := 'BUSAN';
    insert into dept_record values dept_rec;
    commit;
end;
/

select * from dept_record;
---------------------------------
declare
    v_dept_rec dept%rowType;   -- ���ٿ� ���� �� �о��?
begin
    v_dept_rec.deptno := 11;
    v_dept_rec.dname := 'JAVA';
    v_dept_rec.lo := 'BUSAN1';
    insert into dept_record values v_dept_rec;
end;
/

--------------------
--p450
-- �����ȣ, ����̸�, �μ���ȣ, �μ���, �μ�����, ==> �����ȣ 7369
select * from emp;
select * from dept;
--join
select empno, ename, e.deptno, dname, loc
from emp e, dept d
where e.deptno = d.deptno
    and empno = 7369;

declare
    v_empno emp.empno%type;
    v_ename emp.ename%type;
    v_deptno emp.deptno%type;
    v_dname dept.dname%type;
    v_loc dept.loc%type;
begin
    select empno, ename, e.deptno, dname, loc
    into v_empno, v_ename, v_deptno, v_dname, v_loc
    from emp e, dept d
    where e.deptno = d.deptno
    and empno = 7369;
    dbms_output.put_line('�����ȣ : ' || v_empno);
    dbms_output.put_line('����̸� : ' || v_ename);
    dbms_output.put_line('�μ���ȣ : ' || v_deptno);
    dbms_output.put_line('�μ��� : ' || v_dname);
    dbms_output.put_line('�μ����� : ' || v_loc);    
end;
/
---------------------------------
declare
    type REC_TABLE is record(
        empno emp.empno%type,
        ename emp.ename%type,
        deptno dept.deptno%type,
        dname dept.dname%type,
        loc dept.loc%type
    );
    emp_record REC_TABLE;
    
begin
    select empno, ename, e.deptno, dname, loc
    into emp_record
    from emp e, dept d
    where e.deptno = d.deptno
    and empno = 7369;
    dbms_output.put_line('�����ȣ~ : ' || emp_record.empno);
    dbms_output.put_line('����̸�~ : ' || emp_record.ename);
    dbms_output.put_line('�μ���ȣ~ : ' || emp_record.deptno);
    dbms_output.put_line('�μ���~ : ' || emp_record.dname);
    dbms_output.put_line('�μ�����~ : ' || emp_record.loc); 
end;
/        
       
-----------------------
-- p460 cursor
-- select�� ������ ���۾� ���� sql�� ����������
-- �ش� sql �� ó���ϴ� ������ �����ϴ� �޸� ����

-- cursor open fetch close(����, ����, �ݱ�)  �Ǵ�  for loop end �� �ذᰡ��
select * from emp where deptno =20;
declare
    vemp emp%rowType;       -- ��������
    cursor c1 is
    select empno, ename, sal
    from emp 
    where deptno =20;

begin
    dbms_output.put_line('��ȣ  �̸�  �޿�' );
    for vemp in c1 loop
        dbms_output.put_line(vemp.empno || ' ' || vemp.ename || ' ' || vemp.sal);
    end loop;
end;
/

--------------------------------------------
--- emp ���̺��� ��� ��� �̸��� �޿� ����ϰ� ȸ������ �޿� �յ� ���
select ename, sal from emp;
select sum(sal) from emp;

declare
    total number :=0;    
    CURSOR emp_cursor is 
    select ename, sal
    from emp;
begin
    for emp_item in emp_cursor loop
        dbms_output.put_line(emp_item.ename || ' ' || emp_item.sal);
        total := total + emp_item.sal;
    end loop;
    dbms_output.put_line('�޿� �հ� : ' || total);
end;
/
----
declare
    total number :=0;    
    CURSOR emp_cursor is 
    select ename, sal
    from emp;
begin
    for emp_item in emp_cursor loop
        dbms_output.put_line(emp_item.ename || ' ' || emp_item.sal);
    end loop;
    select sum(sal) into total from emp;
    dbms_output.put_line('sal total :' || to_char(total, '999,999'));
end;
/

----
select ename, sal from emp order by sal desc;
-- ����� �޿���Ȳ ( �޿��� ������������ ��� )
-- �̸� ��ǥ (100�� ��ǥ�ϳ�)  <- �ݿø�(sal)
-- ��) JAMES(950) : JAMES *********(950)

declare
    cursor star_cursor is
    select ename, sal
    from emp
    order by sal desc;
    cnt number :=0;         -- �� ����
    star varchar2(100);     -- �� ���ڿ��� ���� 
begin
    dbms_output.put_line('----����� �޿���Ȳ ----');
    for item in star_cursor loop
        cnt := round(item.sal/100);
        star := null;
        for i in 1..cnt loop
            star := star || '*';
        end loop;
--        dbms_output.put_line(item.ename || ' ' || star || ' (' || item.sal || ')');
        dbms_output.put_line(lpad(item.ename, 10) || ' ' || star || ' (' || item.sal || ')');
    end loop;
end;
/

-- �޿��� 2000 �̻��� �͸� ���
-- ��� 1
declare
    cursor star_cursor is
    select ename, sal
    from emp
    where sal >=2000
    order by sal desc;
    cnt number :=0;         -- �� ����
    star varchar2(100);     -- �� ���ڿ��� ���� 
begin
    dbms_output.put_line('----����� �޿���Ȳ ----');
    for item in star_cursor loop
        cnt := round(item.sal/100);
        star := null;
        for i in 1..cnt loop
            star := star || '*';
        end loop;
--        dbms_output.put_line(item.ename || ' ' || star || ' (' || item.sal || ')');
        dbms_output.put_line(lpad(item.ename, 10) || ' ' || star || ' (' || item.sal || ')');
    end loop;
end;
/

-- ���2
declare
    cursor star_cursor is
    select ename, sal
    from emp
    order by sal desc;
    cnt number :=0;         -- �� ����
    star varchar2(100);     -- �� ���ڿ��� ���� 
begin
    dbms_output.put_line('----����� �޿���Ȳ ----');
    for item in star_cursor loop
        if item.sal > 2000 then
            cnt := round(item.sal/100);
            star := null;
            for i in 1..cnt loop
                star := star || '*';
            end loop;
    --        dbms_output.put_line(item.ename || ' ' || star || ' (' || item.sal || ')');
            dbms_output.put_line(lpad(item.ename, 10) || ' ' || star || ' (' || item.sal || ')');
        end if;
    end loop;
end;
/

-- p462 �ϳ��� �����͸� ���� ==> Ŀ�� ���
declare
    v_dept_row dept%rowType;
    --����� Ŀ�� ����
    cursor c1 is
    select deptno, dname, loc
    from dept
    where deptno = 40;
    
begin
    -- Ŀ�� ����(open)
    open c1;
    -- Ŀ���κ��� �о�� ������ ���(fetch)
    fetch c1 into v_dept_row;
    dbms_output.put_line('deptno : ' || v_dept_row.deptno);
    dbms_output.put_line('dname : ' || v_dept_row.dname);
    dbms_output.put_line('loc : ' || v_dept_row.loc);
    -- Ŀ�� �ݱ�
    close c1;
end;
/

-- cursor for loop
declare
    cursor c1 is
    select deptno, dname, loc
    from dept
    where deptno =10;
begin
    for i in c1 loop
        dbms_output.put_line('deptno : ' || i.deptno);
        dbms_output.put_line('dname : ' || i.dname);
        dbms_output.put_line('loc : ' || i.loc);
    end loop;
end;
/

-- cursor ������� �ʰ�
declare
    v_row dept%rowType;
begin
    select deptno, dname, loc into v_row
    from dept
    where deptno=20;
    dbms_output.put_line('deptno : ' || v_row.deptno);
    dbms_output.put_line('dname : ' || v_row.dname);
    dbms_output.put_line('loc : ' || v_row.loc);
end;
/

-- p468 Ŀ���� ����� �Ķ���� �Է¹ޱ�
-- �μ���ȣ�� �Է¹޾� �� �μ��� ��ȣ, �μ���, ������ ���


declare
    v_deptno dept.deptno%type;
    cursor c1(p_deptno dept.deptno%type) is 
    select deptno, dname, loc
    from dept
    where deptno = p_deptno;
    
begin
    v_deptno := &input_deptno;
    for item in c1(v_deptno) loop
        dbms_output.put_line('deptno : ' || item.deptno );
        dbms_output.put_line('dname : ' || item.dname );
        dbms_output.put_line('loc : ' || item.loc);
    end loop;
end;
/
    
----
-- input-deptno �� �μ���ȣ�� �Է¹ް� v_deptno�� ����
-- input-deptno �̰ų� �μ����� sales ��� ���� ��� �μ����� 'SALES'

declare
    v_deptno dept.deptno%type;
    v_dname dept.dname%type;
    cursor c1 (p_deptno dept.deptno%type, p_dname dept.dname%type) is
    select deptno, dname, loc
    from dept
    where deptno = p_deptno or dname = p_dname;
begin
    v_deptno := &INPUT_DEPTNO;
    v_dname := &INPUR_DNAME;
    for item in c1(v_deptno, v_dname) loop
        dbms_output.put_line('deptno : ' || item.deptno );
        dbms_output.put_line('dname : ' || item.dname );
        dbms_output.put_line('loc : ' || item.loc);   
    end loop;
end;
/
    




       
       
       
       
       
       
       
       
       
       
       
       
       
       
        