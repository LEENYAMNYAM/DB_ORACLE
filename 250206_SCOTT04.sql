-- p251(������ ��������) -- in, all, any, exits
-- in() : ��ȣ�� ���ǵ�� ���� �͵��� ���
select ename, sal
from emp
where sal in (1600,1250,1500);

-- any() : ��ȣ�� ���ǵ��߿� �ƹ��ų� �ϳ��� �����ϴ� �͵��� ���
select ename, sal
from emp
where sal < any (1600,1250,1500);

select ename, sal
from emp
where sal < any (select sal
                 from emp
                 where job = 'SALESMAN');

-- all() : ��ȣ�� ���ǵ��� ��� �����ش� �͵��� ���                 
select ename, sal
from emp
where sal < any (select sal
                 from emp
                 where job = 'SALESMAN');
                 
-- ��������
-- emp ���̺�
-- 30�� �μ��� �ִ�޿����� ���� �޿��� �޴� ��� ���(any, all ���)
select *
from emp
where sal > any(select sal
                from emp
                where deptno = 30);

select sal
                from emp
                where deptno = 30;

-- exists() : �����ϸ� true ������ false
select *
from emp
where EXISTS (select sal
                from emp
                where deptno = 30);
                 
            
-- DML (���۾� : data manipulation language) Insert, select, update, delete
--     : �����͸� �߰�, ����, ���� ==> ������ ���۾�
-- DDL (���Ǿ� : data definition language) create, alter, drop, truncate 
--     : ��ü�� ����, ����, �����ϴ� ������ ���Ǿ�
-- DCL (�������� : ) Grant, revoke)
-- DOL (��ü���� : ) �ε���, Ŭ������ ��)

-- test1(no, name, address, tel) ���̺� ���� ==> create table ���̺��(�÷�����)
-- ����(5), ������(10), ���ڿ�(50), ���ڿ�(20)
drop table test1;
create table test1(
    no number(5) primary key,
    name varchar2(10),
    address varchar2(50),
    tel varchar2(20)
);
select * from test1;
select count(*) from test1;
-- (no, name) �� (1, 'aaa') �߰� ==> insert into ���̺��(Į��) values(��)
insert into test1(no, name) values(1, 'aaa');
-- (2, 'bbb', '�λ�', '010-1111-2222')�߰�
insert into test1(no, name, address, tel) values(2, 'bbb', '�λ�', '010-1111-2222');
insert into test1(no, name, address, tel) values(3, 'ccc', '����', '010-3333-4444');
-- ��� �÷��� ���� �Է��Ҷ��� �÷��� ��������
insert into test1 values(4, 'ddd', '�뱸', '010-4444-5555');
insert into test1(no, name, address) values(5, 'eee', '����');
-- commit�� �ؾ� ������ ������ �����.
commit;
insert into test1 (no, name, tel) values(6,'ffff','010-6666-7777'); 
-- commit ������ ���ư�
rollback;
-- test1 ���̺� no�� 2 �� ���� ���
select * from test1 where no=2;

-- ���� ==> no=2 �� ����� �̸��� ȫ�浿 ����
-- update ���̺�� set Į���� = ������ �����ۼ� where ����;
update test1
set name = 'ȫ�浿'
where no =2;
commit;
-- no 4 name�� �̼��� / address ����� ����
select * from test1 where no=4;
update test1
set name = '�̼���', address = '����'
where no = 4;


-- ����
-- delete ���̺�� where ����;
select * from test1;                
delete test1 where no=1;
delete from test1 where no=2;
commit;

delete from test1;
rollback;

-- test ���̺� ����(no, name, hiredate)
            -- ����(4), ���ڿ�(20), date
create table test(
    no number(4) default 0,
    name varchar2(20) default 'NONAME',
    hiredate date default sysdate
);
-- default�� ���� �Է¾��ϰ� �������� ��, �⺻������ ���� ����

-- test ���̺� (1, ȫ�浿)  �߰�
insert into test(no, name) values(1, 'ȫ�浿');
select * from test;
-- test �� 25/2/6 �߰�
insert into test(hiredate) values('25/2/6');
-- test ���̺��� ��ȣ�� 1���� ����� �̸��� ���������� ����
update test
set name = '������'
where no = 1;

-- test ���̺��� no=0 �� ����
delete test where no=0;
-- test ���̺��� no=2 �߰�
insert into test(no) values(2);
commit;

------------------------------------
-- CRUD(create, select, update, delete) �Ϸ�!!

-- p266(CTAS: create table as select) : �̸��� �ٸ� �Ȱ��� ���̺� �����(���̺� ����)
-- dept_temp ���̺� ����(dept ���̺�� �Ȱ���)
select * from dept;

create table dept_temp
as select * from dept;
select * from dept_temp;
desc dept_temp;

-- dept_temp ���̺� 50, DATEBASE, SEOUL �߰�
insert into dept_temp values(50, 'DATABASE', 'SEOUL');
commit;
--���̺� ������ ����
create table emp_temp
as select * from emp
where 1<>1;   -- ������ �ɾ �ƹ� �����͵� select���� �ʵ��� �ϸ� ������ ���簡��
select * from emp_temp;
-- emp_temp : empno, ename, job, mgr, hiredate, sa, comm, deptno
-- (2111, '�̼���', 'MANAGER', 9999, '07/01/2019', 4000, null, 20) �߰�
insert into emp_temp values(2111, '�̼���', 'MANAGER', 9999, '07/01/19', 4000, null, 20);
update emp_temp
set hiredate = to_date('08/01/2019', 'DD/MM/YYYY')
where empno = 2111;

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, deptno)
values(2112, '�̼���', 'MANAGER', 9999, to_date('07/01/2019', 'DD/MM/YYYY'), 4000, 20);

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(2113, '�̼���3', 'MANAGER', 9999, to_date('06/02/2025', 'DD/MM/YYYY'), 4000, null, 20);

insert into emp_temp
values(3111, '������', 'MANAGER', 9999, sysdate, 4000, null, 20);
commit;

-- p275  
-- ���������� �̿��ؼ� �� ���� ���� �����͸� �߰�(values�� ������� �ʴ´�.)
-- ��, �ٸ����̺��� Ư�����ǿ� �ش��ϴ� ������ ������ �Է��ϱ�
-- emp ���̺��� �޿����(salgrade)�� 1(700~1200)����� emp_tmp ���̺� �߰�
select * from emp_temp;
select * from salgrade;

select * from emp where sal between 700 and 1200;

insert into emp_temp
select * from emp
where sal between 700 and 1200;

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
select empno, ename, job, mgr, hiredate, sal, comm, deptno from emp
where sal between 700 and 1200;

delete from emp_temp;  -- ��� ������ ����
select * from emp_temp;
-- �޿����(salgrade) �� 3�� ����� emp_temp �߰�
-- 3����� losal, hisal ã�Ƴ��� �׳� �Է��ϴ� ���
insert into emp_temp
select * from emp 
where sal between 1400 and 2000;
-- �ܺ�����Ȱ��
insert into emp_temp
select * 
from emp
where sal between (select losal from salgrade where grade = 3) 
          and (select hisal from salgrade where grade = 3);
-- joinȰ��
insert into emp_temp
select * 
from emp e join salgrade s
              on e.sal
              between s.losal and s.hisal
where s.grade = 3;

-- dept ���̺��� �����ؼ� dept_temp2 ���̺��� �����ϰ�
-- 40�� �μ����� DATABASE // ������ SEOUL �� ����
drop table dept_temp2;
create table dept_temp2
as select * from dept;

update dept_temp2
set dname = 'DATABASE' , loc = 'SEOUL'
where deptno = 40;

select * from dept_temp2;
commit;

-- dept_temp2 ���̺��� �μ���ȣ�� 40���� �μ���� ������ ����
-- dept ���̺��� 40�� �μ��� ������ �����ϱ�
select * from dept where deptno = 40;
update dept_temp2
set dname ='OPERATIONS', loc = 'BOSTON'
where deptno = 40;
select * from dept_temp2;

update dept_temp2
set dname = (select dname from dept where deptno = 40), 
    loc = (select loc from dept where deptno = 40)
where deptno = 40;
select * from dept_temp2;

update dept_temp2
set (dname, loc) = (select dname, loc from dept where deptno=40)
where deptno=40;

commit;      -- ����� commit�� dml�� ���� �����̶�� �����ϸ� ��.

-- dept_temp2 ��� ������ ����
select * from dept_temp2;
delete from dept_temp2;  -- ��� ������ ����

--���̺� ���� 
--drop table ���̺��;
drop table dept_temp2;
drop table dept_temp;

create table dept_temp
as select * from dept;
select * from dept_temp;

-- LOCATION Į�� �߰�
alter table dept_temp add(LOCATION varchar2(30));
--10�� �μ��� LOCATION�� �������� ����
update dept_temp
set Location = '����'
where deptno = 10;
select * from dept_temp;

-- LOCATION Į�� ���� : varchar2(70)
alter table dept_temp modify(LOCATION varchar2(70));
describe dept_temp;

-- LOCATION �÷� ����
alter table dept_temp drop column LOCATION;

-- LOC �÷����� LOCATION ����
alter table dept_temp rename column LOC to LOCATION;

-- ���̺� �̸� ���� dept_temp ==> dept_temptemp
alter table dept_temp rename to dept_temptemp;
describe dept_temptemp;
rename dept_temptemp to dept_temp;
describe dept_temp;

delete from dept_temp;
select * from dept_temp;

rollback;


--truncate table ���̺�� : truncate�� DDL �̹Ƿ� rollback�� ������� �ʾ� ���� �ȵ�
truncate table dept_temp;
select * from dept_temp;
rollback;
select * from dept_temp;
--dept_temp ���̺����
drop table dept_temp;
-- select * from dept_temp;  -- �����߻�

-----------------------------------------
-- ������������
select * from test1;
-- 1. �÷� �߰� : birthday date ��
alter table test1 add(Birthday date);
describe test1;

-- 2. �÷� �� ���� : tel => phone
alter table test1 rename column tel to Phone;
describe test1;

-- 3. no �÷��� ����
alter table test1 drop column no;
describe test1;

-- 4. num �÷� �߰� : number(3)
alter table test1 add(num number(3));
describe test1;

-- 5. address ���ڿ�(50) ==> ���ڿ�(70) ����
alter table test1 modify( address varchar2(70));
describe test1;

-- 6. test1 ���̺� �̸��� ==> testtest
alter table test1 rename to testtest;
select * from testtest;
rename testtest to test2;
select * from test2;

-- 7. ���̺� ����
drop table test2;
-- select * from test2;    -- �����߻�(���̺� ����)


