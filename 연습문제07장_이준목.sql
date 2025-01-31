-- 7�� �������� (p212~213)

-- 1�� ����
select deptno, round(avg(sal)) AVG_SAL, max(sal) MAX_SAL, min(sal) MIN_SAL, count(*) CNT
from emp
group by deptno
order by deptno desc;

-- 2�� ����
select job, count(*)
from emp
group by job
having count(*) >=3;

-- 3�� ����
select To_char(hiredate, 'YYYY') HIRE_YEAR, deptno, count(*) CNT
from emp
group by deptno, To_char(hiredate, 'YYYY')
order by To_char(hiredate, 'YYYY') desc;

-- 4�� ����
select nvl2(comm, 'O', 'X'), count(*)
from emp
group by nvl2(comm, 'O', 'X');

-- 5�� ����
select deptno, To_char(hiredate, 'YYYY') HIRE_YEAR, count(*) CNT, max(sal) MAX_SAL, sum(sal) SUM_SAL, round(avg(sal)) AVG_SAL
from emp
group by rollup(deptno, To_char(hiredate, 'YYYY'))
order by deptno, To_char(hiredate, 'YYYY');