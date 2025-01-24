--p125~126연습문제
Select * from emp;

--1.Emp 테이블에서 사원이름(ename)이 S로 끝나는 사원의 정보 출력
Select * from emp where ename LIKE '%S';

--2. Emp 테이블에서 30번 부서 중 직책(job)이  SALESMAN인 
--사원번호(empno), 이름(ename) , 직책(job), 급여(sal), 부서번호(deptno)
select empno, ename, job, sal, deptno from emp where (deptno = 30 and job ='SALESMAN');

--3.20번, 30번 부서에 근무하면서 급여가 2000 초과하는 사원의
-- 사원번호(empno), 이름(ename) , 직책(job), 급여(sal), 부서번호(deptno)
--1) 집합연산자 사용
select empno, ename, job, sal, deptno from emp where deptno = 20 union 
select empno, ename, job, sal, deptno from emp where deptno = 30 intersect 
select empno, ename, job, sal, deptno from emp wheresal > 2000);  

--2) 집합연사자 미사용
select empno, ename, job, sal, deptno from emp where deptno in (20, 30) and sal >2000;

--4.급여가 2000이상 3000 이하 범위 이외  not between a and b 사용하지 않기
select * from emp where sal<2000 or sal <=3000;

--5.사원이름에 E 가 포함되어 있는 30번 부서의 사원 중 급여가 1000~2000 사이가
--아닌 사원이름, 사원번호, 급여, 부서번호 출력
select ename, empno, sal, deptno
from emp
where ename like '%E%'
    and deptno =30
    and sal not between 2000 and 3000;

--6. 추가수당 존재 하지 않고 상급자 있고 MANAGER CLERK 중에서 
--사원이름의 두번 째 글자 L 아닌 정보 출력