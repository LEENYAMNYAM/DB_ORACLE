--1. emp ���̺��� �����ȣ�� 7369 �� ��� �� �̸�, �Ի���, �μ���ȣ�� ����Ͻÿ�.

select ename �̸�, hiredate �Ի���, deptno �μ���ȣ
from emp
where empno = 7369;


--2. emp ���̺���  �� �μ� ��ȣ�� 
--   �μ���ȣ, ��ձ޿�, �ְ�޿�, �����޿�, ������� ����Ͻÿ� 
--   ��, ��ձ޿��� �Ҽ��� �����Ͽ� ����Ͻÿ�

select deptno �μ���ȣ, round(avg(sal)) ��ձ޿�, 
       max(sal) �ְ�޿�, min(sal) �����޿�, count(*) �����
from emp
group by deptno;

-- 3. emp ���̺��� �����ȣ(empno)�� �� 2�ڸ��� ǥ���ϰ� �� 2�ڸ��� *ǥ�� ����Ͻÿ�. 
select RPAD(substr(empno,1,2), length(empno), '*') �����ȣ
from emp;

-- 4. emp���̺��� �����ȣ, ����̸�, ��縦 ����ϵ� 
--    ���(mgr)�� ������ ��CEO�� �� ����Ͻÿ�.
select e1.empno �����ȣ, e1.ename ����̸�, 
       e1.mgr �������ȣ, nvl(e2.ename,'CEO') ����̸� 
from emp e1  left outer join emp e2
             on e1.mgr = e2.empno;

-- 5. emp ���̺��� 1000�̻��� �޿��� ������ �ִ� ����鿡 ���ؼ��� �μ��� ����� 
--    ���ϵ� �μ��� ����� 2000 �̻��� �μ���ȣ, �μ��� ��� �޿��� ����Ͻÿ�.
select deptno �μ���ȣ, avg(sal) �μ�����ձ޿�
from emp
where sal >= 1000
group by deptno
having avg(sal)>= 2000;

-- 6. SMITH�� ������ �ٹ������� �ٹ��ϴ� ����� �̸��� ����Ͻÿ�
select ename
from emp
where ename <> 'SMITH' and
    deptno = (select deptno
              from emp
              where ename = 'SMITH');

-- 7. emp, dept ���̺��� ����̸�, �μ���ȣ, �μ����� ����ϵ� ��� �μ��� ����Ͻÿ�

select ename ����̸�, deptno �μ���ȣ, dname �μ���
from emp right outer join dept using(deptno)
order by deptno;

-- 8. emp ���̺��� �� �μ��� �ְ� �޿��� ������ �޿��� �޴� ��� ������ ����Ͻÿ�.
select *
from emp
where sal in (select max(sal)
              from emp
              group by deptno)
order by deptno;

-- 9. emp����� 3�� ������ �з��ϱ� ���� empno ����� 3���� ������ 
--    �������� 0�̸� A�� 1�̸� B��, 2�̸� C ������ �з��Ͽ� 
--    teamName, ename, job, deptno �� ����Ͻÿ�
--    ��, A��/B��/C���� teamName �÷����� ����ϰ� decode �Լ��� ����Ѵ�.

select decode( mod(empno,3), 0, 'A��', 1, 'B��', 2, 'C��') teamName, 
       ename, job, deptno
from emp
order by teamName;

-- 10. emp ���̺�� dept���̺��� �����Ͽ� 
--     �μ���ȣ(deptno), �μ���(dname), ����̸��� ����Ͻÿ�.

select deptno �μ���ȣ, dname �μ���, ename ����̸�
from emp natural join dept
order by deptno;

-- 11. scott ������ emp ���̺��� 30�� �μ��� �Ҽӵ� ����� 
--     �����ȣ empno�� ename, �μ���ȣ deptno�� ����ϴ� select ���� 
--     �ϳ��� ��� �����Ͻÿ� (���̸� : view_emp_dept30)
create view view_emp_dept30
as (select empno �����ȣ, ename ����̸�, deptno �μ���ȣ
    from emp
    where deptno = 30);
select * from view_emp_dept30;

-- 12. �����ڷ� �����Ͽ� ��й�ȣ�� 1234 �̰� ������ guest �� ����ڸ� �����Ͻÿ�
alter session set "_oracle_script" = true;
create user guest
       identified by 1234;

-- 13. ������ ������ guest ������ �����ͺ��̽��� �����ϰ� ���̺��� ������ �� �ֵ��� 
--     �Ѱ� ������ �ο��Ͻÿ�.

grant create table, create view, create session, 
      connect, resource, unlimited tablespace to guest;

-- �� guest ����ڷ� �����Ͽ� ������ �׸��� ���� 
--    �а�(dept), �л�(student), ����(professor) ���̺�� �����͸� �����Ͽ� 
--    ���õ� ������ ���Ͻÿ�.

-- 14. dept(�а�) ���̺��� �Ʒ� �������� �����ϰ� �����͸� �߰��ϼ���.
--     deptno �������� ���� 3���� �����ϰ�, dname �������� ���� 20���� �����Ѵ�.
    create table dept(
        deptno CHAR(3),
        dname VARCHAR2(20)
    );
    insert into dept values(101, '�濵�а�');
    insert into dept values(102, '��ǻ�Ͱ��а�');
    insert into dept values(103, '�����а�');

-- 15. �л�(student) ���̺��� �Ʒ� �������� �����ϰ� ����Ʈ�� �߰��ϼ���
-- studno ���ڷ� �����ϰ�, �⺻Ű �������� ����
-- name�� ������ Ÿ�� �������� ���ڿ� 10, not null�� unique ���� ������ ����
-- deptno�� �������� ���ڿ� 3��, �а�(deptno)�� �����ϵ��� foregin key�� ����
-- grade �ʵ�� ���� 1�ڷ� �����ϰ� ���� 1~4�� ���� ������ check ���������� ����
-- profno �ʵ�� ���ڷ�  �����϶�.

alter table dept
add constraint dept_deptno_pk primary key(deptno);

create table student(
    studno number constraint student_studno_pk primary key,
    name VARCHAR2(10) not null unique,
    grade number(1) check(grade between 1 and 4),
    deptno CHAR(3) references dept(deptno) on delete cascade, 
    profno number
);    
    insert into student values(101, '�����', 1, 101, 1001);
    insert into student values(102, '��ο�', 2, 101, 1003);
    insert into student values(103, '����ȯ', 3, 101, 1001);    
    insert into student values(104, '������', 4, 101, 1003);
    insert into student values(105, '������', 1, 102, 1002);
    insert into student values(106, '����', 2, 102, null);
    insert into student values(107, '������', 3, 102, 1002);
    insert into student values(108, '�����', 1, 103, 1004);
    insert into student values(109, '�ڿ���', 2, 103, 1006);
    insert into student values(110, '������', 3, 103, null);
select * from student;

-- 16. ����(professor) ���̺��� �����ϰ� �� �����͸� �߰��ϼ��� 
--     ��, deptno �� �ܷ�Ű�� �����Ͻÿ�.
create table professor(
    profno number constraint professor_profno_pk primary key,
    name VARCHAR2(10) not null unique,
    deptno CHAR(3) references dept(deptno) on delete cascade, 
    position VARCHAR(15),
    pay number
);  

    insert into professor values(1001, 'ȫ�浿', 101, '������', 450);    
    insert into professor values(1002, '�迬��', 102, '������', 400);    
    insert into professor values(1003, '������', 101, '�α���', 350);    
    insert into professor values(1004, '���±�', 103, '������', 410);    
    insert into professor values(1005, '������', 101, '���Ӱ���', 250);    
    insert into professor values(1006, '�����', 103, '�α���', 350);    
    insert into professor values(1007, '������', 102, '���Ӱ���', 320);    
    insert into professor values(1008, '������', 103, '���Ӱ���', 200);    
select * from professor;

-- 17. ����(professor) ���̺�� �а�(dept) ���̺��� Ȱ���Ͽ� 
-- �а��� �޿��� ���� ���� ����� ������(name), �а���(dname),  �޿�(pay)�� ����϶�.

select p.name ������, d.dname �а���, pay �޿�
from professor p, dept d
where p.deptno = d.deptno
      and p.pay in (select max(pay)
                    from professor
                    group by deptno);

-- 18. �л�(student) ���̺��� 101�� �л��� �̸��� �̱������� 
-- �����ϴ� ������ �ۼ��Ͻÿ�.

update student
set name = '�̱���'
where studno =101;
select * from student;

-- 19. scott ����ڿ��� guest�� student ���̺��� select ���� �ο� �� �����ϼ���
--   �� scott ����ڿ��� guest�� student ���̺��� select �� �� �ִ� ������ �����ϼ���.
    grant select on student to scott;

--   �� scott ����ڿ��� guest�� student ���̺��� select �� �� �ִ� ������ �����϶�.
    revoke select on student from scott;



























































