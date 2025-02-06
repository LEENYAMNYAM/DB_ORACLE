select * from emp;
select * from dept;
-- 1. ����(NEW YORK)���� �ٹ��ϴ� ����� �̸�(ename), �޿�(sal) ���
select e.ename, e.sal
from emp e, dept d
where e.deptno = d.deptno and d.loc = 'NEW YORK';

select e.ename, e.sal
from emp e join dept d
           on e.deptno = d.deptno
where d.loc = 'NEW YORK';

-- 2. �Ŵ���(mgr)�� KING �� ������� �̸��� ������ ���
select * from emp;
select ename, job
from emp
where mgr = 7839;

select ename, job
from emp
where mgr = (select empno
            from emp
            where ename ='KING');

select e.ename ����̸�, e.job ����
from emp m, emp e
where m.empno = e.mgr  and m.ename = 'KING';

-- 3. SMITH ����(���� �μ��� ���)�� �̸� ���
select e2.ename
from emp e1 join emp e2
            on e1.deptno = e2.deptno
where e1.ename = 'SMITH' and e2.ename <> 'SMITH';

select ename
from emp 
where ename <> 'SMITH' and
      deptno = (select deptno
                from emp
                where ename = 'SMITH');

-- p229
select * from emp; --12 ���
-- �����ȣ, ����̸�, ���(mgr) �������ȣ, ����̸�
select e1.empno �����ȣ, e1.ename ����̸�, e1.mgr ���ӻ��, e2.empno "��� �����ȣ", e2.ename ����̸�   -- 11�� ���( ��簡 null�� ����� ��� ����)
from emp e1, emp e2
where e1.mgr = e2.empno
order by e1.empno;


-- �ܺ�����(outer join)
-- ��� ����� ���� �����ȣ, ����̸�, ���, �������ȣ, ����̸�
select e1.empno �����ȣ, e1.ename ����̸�, e1.mgr ���ӻ��, e2.empno "��� �����ȣ", e2.ename ����̸�   -- 11�� ���( ��簡 null�� ����� ��� ����)
from emp e1 join emp e2
            on e1.mgr = e2.empno(+)     -- ������ �ʿ� (+)�� �߰��ϸ� null���� �߰���(�ܺ�����)
order by e1.empno;


select e1.empno �����ȣ, e1.ename ����̸�, e1.mgr ���ӻ��, e2.empno "��� �����ȣ", e2.ename ����̸�
from emp e1 left outer join emp e2
            on e1.mgr = e2.empno      
order by e1.empno;

select e1.empno �����ȣ, e1.ename ����̸�, e1.mgr ���ӻ��, e2.empno "��� �����ȣ", e2.ename ����̸�
from emp e1 right outer join emp e2
            on e2.mgr = e1.empno
order by e2.empno;

-- ����̸�(ename), �μ���ȣ(deptno), �μ���(dname)
select * from emp;
select * from dept;

select ename ����̸�, e.deptno �μ���ȣ, dname �μ���
from emp e, dept d
where e.deptno = d.deptno;

-- ��� �μ��� ���� ��� --> ����̸�(ename), �μ���ȣ(deptno), �μ���(dname)
select ename ����̸�, d.deptno �μ���ȣ, dname �μ���
from emp e, dept d
where e.deptno(+) = d.deptno 
order by d.deptno;

select ename ����̸�, d.deptno �μ���ȣ, dname �μ���
from emp e right outer join dept d
                        on e.deptno = d.deptno 
order by d.deptno;

select ename ����̸�, d.deptno �μ���ȣ, dname �μ���
from dept d left outer join emp e
                        on e.deptno = d.deptno 
order by d.deptno;

-- p232
-- sal 2000���� ū �����ȣ, �̸�, �޿�, ���, �μ���ȣ, �μ���, ���� ���
select d.deptno, empno, ename, sal, mgr, dname, loc
from emp e, dept d
where e.deptno(+) = d.deptno
and e.sal > 2000
order by deptno, e.empno;

-- SQL-99 ǥ��
-- NATURAL JOIN(�����÷��� �˾Ƽ� ��Ƽ� join����)
-- ����Ⱥκ�(deptno)�� �ϳ��� ������ֱ� ������ d.deptnoó�� �տ� �� �� �ʿ� ����.
select deptno, empno, ename, sal, mgr, dname, loc
from emp e natural join dept d
where sal > 2000
order by deptno, empno;

-- join ~ using  : ����� ���� �÷��� using�� �̿��ؼ� ������
select deptno, empno, ename, sal, mgr, dname, loc
from emp e join dept d using(deptno)
where sal > 2000
order by deptno, empno;

-- p240 join ~ on : on �ڿ� ���ǵ��� �̾߱� �ؼ� join�ϴ� ���
-- ���� ���� ����ϴ� ��� 
select d.deptno, empno, ename, sal, mgr, dname, loc
from emp e join dept d
            on e.deptno = d.deptno
where sal > 2000
order by deptno, empno;

-- p238
-- emp, dept ���̺�
-- �޿�(sal)�� 2000 �̻��̸� ���ӻ��(mgr)�� �ݵ�� �־�� ��.
-- �����ȣ(empno), �̸�(ename), ��å(job), ���ӻ��(mgr), ��볯¥(hiredate),
-- ����(sal), comm, deptno, dname, loc ���  

-- join using ���
select empno �����ȣ, ename �̸� , job ��å, mgr ���ӻ��, hiredate ��볯¥,
        sal ����, comm ���ʽ�, deptno �μ���ȣ, dname �μ���, loc ����
from emp join dept using(deptno)
where sal >= 2000 and mgr is not null;

-- natural join ���
select empno �����ȣ, ename �̸� , job ��å, mgr ���ӻ��, hiredate ��볯¥,
        sal ����, comm ���ʽ�, deptno �μ���ȣ, dname �μ���, loc ����
from emp natural join dept 
where sal >= 2000 and mgr is not null;

-- join on ���
select empno �����ȣ, ename �̸� , job ��å, mgr ���ӻ��, hiredate ��볯¥,
        sal ����, comm ���ʽ�, d.deptno �μ���ȣ, dname �μ���, loc ����
from emp e join dept d
            on e.deptno = d.deptno
where sal >= 2000 and mgr is not null;

-- p242
-- WARD ������� ������ ���� �޴� ��� �̸� ���
select sal from emp where ename = 'WARD';
select ename from emp where sal > 1250;
-- �׷� ���� �� �ΰ��� �ϳ��� ��ɹ����� �����

--��������(SQL ���ο� ����ϴ� select ���� �ǹ���)
select ename
from emp
where sal > (select sal from emp where ename = 'WARD');

-- 'ALLEN'�� ����(job)�� ���� ����� �̸�(enmae), �μ���(dname), �޿�(sal), ����(job) ���
select ename, dname, sal, job
from emp e, dept d 
where e.deptno = d.deptno 
      and job = (select job from emp where ename = 'ALLEN')
      and ename <> 'ALLEN';

-- ��ü ����� ��� �ӱݺ��� ���� �����
-- �����ȣ(empno), �̸�(ename), �μ���(dname), �Ի���(hiredate) ���
select empno, ename, dname, hiredate
from emp e, dept d
where e.deptno = d.deptno
      and sal > (select avg(sal) from emp); 

-- ALLEN ���� ���� �Ի��� ����� ����
select *
from emp
where hiredate < (select hiredate from emp where ename = 'ALLEN');

--p248
-- ��ü ����� ��ձ޿����� �۰ų� ���� �޿��� �޴� 20�� �μ��� ��� �� �μ�����
-- empno, ename, job, sal, deptno, dname, loc ���

-- SQL-99�������
select empno, ename, job, d.deptno, dname, loc
from emp e, dept d
where e.deptno = d.deptno
    and sal <= (select avg(sal) from emp)
    and d.deptno = 20;
-- natural join �̿�
select empno, ename, job, deptno, dname, loc
from emp natural join dept
where sal <= (select avg(sal) from emp)
    and deptno = 20;
-- join using
select empno, ename, job, deptno, dname, loc
from emp join dept using(deptno)
where sal <= (select avg(sal) from emp)
    and deptno = 20;
-- join on
select empno, ename, job, d.deptno, dname, loc
from emp e join dept d
             on e.deptno = d.deptno
where sal <= (select avg(sal) from emp)
      and d.deptno = 20;
      
-- �� �μ��� �ְ�޿��� ������ �޿��� �޴� ��� ���� ���
-- �� �μ��� �ְ� �޿��� ���
select deptno, max(sal)
from emp
group by deptno;
-- ���������� �̿��Ͽ�      
select *
from emp
where sal in (select max(sal) from emp  group by deptno);
      
-- �������� ���� �񱳰���
select *
from emp
where (deptno, sal) in (select deptno, max(sal) from emp  group by deptno);
