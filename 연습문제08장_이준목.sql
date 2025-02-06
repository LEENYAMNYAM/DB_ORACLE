-- ���� 8�� ��������(p239~240)

-- <1������>
-- ORACLE������ ���
select d.deptno, dname, empno, ename, sal
from emp e, dept d
where e.deptno = d.deptno
      and sal > 2000;
-- natural join ���
select deptno, dname, empno, ename, sal
from emp e natural join dept d
where sal > 2000;
-- join using ���
select deptno, dname, empno, ename, sal
from emp join dept using(deptno)
where sal > 2000;
-- join on ���
select d.deptno, dname, empno, ename, sal
from emp e join dept d
            on d.deptno = e.deptno
where sal > 2000;
            
-- <2������>
-- ORACLE������ ���
select d.deptno, dname, round(avg(sal)) AVG_SAL, round(max(sal)) MAX_SAL, round(min(sal)) MIN_SAL, count(*) CNT
from emp e, dept d 
where e.deptno = d.deptno
group by d.deptno, dname
order by d.deptno;
-- natural join ���
select deptno, dname, round(avg(sal)) AVG_SAL, round(max(sal)) MAX_SAL, round(min(sal)) MIN_SAL, count(*) CNT
from emp natural join dept
group by deptno, dname
order by deptno;
-- join using ���
select deptno, dname, round(avg(sal)) AVG_SAL, round(max(sal)) MAX_SAL, round(min(sal)) MIN_SAL, count(*) CNT
from emp join dept using(deptno)
group by deptno, dname
order by deptno;
-- join on ���
select d.deptno, dname, round(avg(sal)) AVG_SAL, round(max(sal)) MAX_SAL, round(min(sal)) MIN_SAL, count(*) CNT
from emp e join dept d 
         on e.deptno = d.deptno
group by d.deptno, dname
order by d.deptno;

--<3������>
-- ORACLE������ ��� & (+) ���
select d.deptno, dname, empno, ename, job, sal
from emp e, dept d
where e.deptno(+) = d.deptno
order by d.deptno, ename;
-- natural join ��� & right outer ���
select deptno, dname, empno, ename, job, sal
from emp natural right outer join dept
order by deptno, ename;
-- join using ��� & left outer ���
select deptno, dname, empno, ename, job, sal
from dept left outer join emp using(deptno)
order by deptno, ename;
-- join on ��� & (+) ���
select d.deptno, dname, empno, ename, job, sal
from emp e join dept d
             on e.deptno(+) = d.deptno
order by d.deptno, ename;

-- <4������>
-- (SQL-99 �������)ORACLE������ ��� & (+) ���
select d.deptno DEPTNO, d.dname, e.empno, e.ename, e.mgr, e.sal, 
       e.deptno DEPTNO_1, losal, hisal, grade, m.empno MGR_EMPNO, m.ename MGR_ENAME
from emp e, dept d, salgrade s, emp m
where e.deptno(+) = d.deptno 
      and e.sal between losal(+) and hisal(+)
      and m.empno(+) = e.mgr
order by d.deptno, empno;

--  (SQL-99 ���)join ��� & �ܺ����� ���
select d.deptno DEPTNO, d.dname, e.empno, e.ename, e.mgr, e.sal, 
       e.deptno DEPTNO_1, losal, hisal, grade, m.empno MGR_EMPNO, m.ename MGR_ENAME
from emp e right outer join dept d on d.deptno = e.deptno
           left outer join salgrade on e.sal between losal and hisal
           left outer join emp m on m.empno = e.mgr
order by deptno, empno;

