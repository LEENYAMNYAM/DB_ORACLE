-- 9�� ��������
-- <1�� ����>
select job, empno, ename, sal, deptno, dname 
from emp join dept using(deptno)
where job = (select job from emp where ename = 'ALLEN')
order by sal desc;

-- <2������>
select empno, ename, dname, hiredate, loc, sal, grade
from emp join dept using(deptno)
         join salgrade on sal between losal and hisal
where sal > (select avg(sal) from emp)
order by sal desc, empno asc;
         
--<3������>
select empno, ename, job, deptno, dname, loc
from emp join dept using(deptno)
where deptno = 10
    and job <> all (select job from emp where deptno = 30);

--<4������>
-- ������ �̿����
select empno, ename, sal, grade
from emp join salgrade on sal between losal and hisal
where sal > (select max(sal) 
                from emp
                group by job
                having job = 'SALESMAN'
                )
order by empno asc;
-- ������ �̿���
select empno, ename, sal, grade
from emp join salgrade on sal between losal and hisal
where sal > all(select sal 
                from emp
                where job = 'SALESMAN'
                )
order by empno asc;





