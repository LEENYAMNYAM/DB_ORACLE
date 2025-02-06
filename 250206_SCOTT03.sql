select * from emp;
select * from dept;
-- 1. 뉴욕(NEW YORK)에서 근무하는 사원의 이름(ename), 급여(sal) 출력
select e.ename, e.sal
from emp e, dept d
where e.deptno = d.deptno and d.loc = 'NEW YORK';

select e.ename, e.sal
from emp e join dept d
           on e.deptno = d.deptno
where d.loc = 'NEW YORK';

-- 2. 매니저(mgr)가 KING 인 사원들의 이름과 직급을 출력
select * from emp;
select ename, job
from emp
where mgr = 7839;

select ename, job
from emp
where mgr = (select empno
            from emp
            where ename ='KING');

select e.ename 사원이름, e.job 직급
from emp m, emp e
where m.empno = e.mgr  and m.ename = 'KING';

-- 3. SMITH 동료(같은 부서인 사람)의 이름 출력
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
select * from emp; --12 출력
-- 사원번호, 사원이름, 상사(mgr) 상사사원번호, 상사이름
select e1.empno 사원번호, e1.ename 사원이름, e1.mgr 직속상사, e2.empno "상사 사원번호", e2.ename 상사이름   -- 11개 출력( 상사가 null인 사원은 출력 안함)
from emp e1, emp e2
where e1.mgr = e2.empno
order by e1.empno;


-- 외부조인(outer join)
-- 모든 사원에 대해 사원번호, 사원이름, 상사, 상사사원번호, 상사이름
select e1.empno 사원번호, e1.ename 사원이름, e1.mgr 직속상사, e2.empno "상사 사원번호", e2.ename 상사이름   -- 11개 출력( 상사가 null인 사원은 출력 안함)
from emp e1 join emp e2
            on e1.mgr = e2.empno(+)     -- 부족한 쪽에 (+)를 추가하면 null값도 추가함(외부조인)
order by e1.empno;


select e1.empno 사원번호, e1.ename 사원이름, e1.mgr 직속상사, e2.empno "상사 사원번호", e2.ename 상사이름
from emp e1 left outer join emp e2
            on e1.mgr = e2.empno      
order by e1.empno;

select e1.empno 사원번호, e1.ename 사원이름, e1.mgr 직속상사, e2.empno "상사 사원번호", e2.ename 상사이름
from emp e1 right outer join emp e2
            on e2.mgr = e1.empno
order by e2.empno;

-- 사원이름(ename), 부서번호(deptno), 부서명(dname)
select * from emp;
select * from dept;

select ename 사원이름, e.deptno 부서번호, dname 부서명
from emp e, dept d
where e.deptno = d.deptno;

-- 모든 부서의 정보 출력 --> 사원이름(ename), 부서번호(deptno), 부서명(dname)
select ename 사원이름, d.deptno 부서번호, dname 부서명
from emp e, dept d
where e.deptno(+) = d.deptno 
order by d.deptno;

select ename 사원이름, d.deptno 부서번호, dname 부서명
from emp e right outer join dept d
                        on e.deptno = d.deptno 
order by d.deptno;

select ename 사원이름, d.deptno 부서번호, dname 부서명
from dept d left outer join emp e
                        on e.deptno = d.deptno 
order by d.deptno;

-- p232
-- sal 2000보다 큰 사원번호, 이름, 급여, 상사, 부서번호, 부서명, 지역 출력
select d.deptno, empno, ename, sal, mgr, dname, loc
from emp e, dept d
where e.deptno(+) = d.deptno
and e.sal > 2000
order by deptno, e.empno;

-- SQL-99 표준
-- NATURAL JOIN(공통컬럼을 알아서 잡아서 join해줌)
-- 공통된부분(deptno)를 하나로 만들어주기 때문에 d.deptno처럼 앞에 뭘 달 필요 없음.
select deptno, empno, ename, sal, mgr, dname, loc
from emp e natural join dept d
where sal > 2000
order by deptno, empno;

-- join ~ using  : 사용할 공통 컬럼을 using을 이용해서 지정함
select deptno, empno, ename, sal, mgr, dname, loc
from emp e join dept d using(deptno)
where sal > 2000
order by deptno, empno;

-- p240 join ~ on : on 뒤에 조건들을 이야기 해서 join하는 방법
-- 가장 많이 사용하는 방법 
select d.deptno, empno, ename, sal, mgr, dname, loc
from emp e join dept d
            on e.deptno = d.deptno
where sal > 2000
order by deptno, empno;

-- p238
-- emp, dept 테이블
-- 급여(sal)가 2000 이상이며 직속상관(mgr)이 반드시 있어야 함.
-- 사원번호(empno), 이름(ename), 직책(job), 직속상사(mgr), 고용날짜(hiredate),
-- 월급(sal), comm, deptno, dname, loc 출력  

-- join using 사용
select empno 사원번호, ename 이름 , job 직책, mgr 직속상사, hiredate 고용날짜,
        sal 월급, comm 보너스, deptno 부서번호, dname 부서명, loc 지역
from emp join dept using(deptno)
where sal >= 2000 and mgr is not null;

-- natural join 사용
select empno 사원번호, ename 이름 , job 직책, mgr 직속상사, hiredate 고용날짜,
        sal 월급, comm 보너스, deptno 부서번호, dname 부서명, loc 지역
from emp natural join dept 
where sal >= 2000 and mgr is not null;

-- join on 사용
select empno 사원번호, ename 이름 , job 직책, mgr 직속상사, hiredate 고용날짜,
        sal 월급, comm 보너스, d.deptno 부서번호, dname 부서명, loc 지역
from emp e join dept d
            on e.deptno = d.deptno
where sal >= 2000 and mgr is not null;

-- p242
-- WARD 사원보다 월급을 많이 받는 사원 이름 출력
select sal from emp where ename = 'WARD';
select ename from emp where sal > 1250;
-- 그럼 이제 위 두개를 하나는 명령문으로 적어보자

--서브쿼리(SQL 내부에 사용하는 select 문을 의미함)
select ename
from emp
where sal > (select sal from emp where ename = 'WARD');

-- 'ALLEN'의 직무(job)와 같은 사람의 이름(enmae), 부서명(dname), 급여(sal), 직무(job) 출력
select ename, dname, sal, job
from emp e, dept d 
where e.deptno = d.deptno 
      and job = (select job from emp where ename = 'ALLEN')
      and ename <> 'ALLEN';

-- 전체 사원의 평균 임금보다 많은 사원의
-- 사원번호(empno), 이름(ename), 부서명(dname), 입사일(hiredate) 출력
select empno, ename, dname, hiredate
from emp e, dept d
where e.deptno = d.deptno
      and sal > (select avg(sal) from emp); 

-- ALLEN 보다 일찍 입사한 사원의 정보
select *
from emp
where hiredate < (select hiredate from emp where ename = 'ALLEN');

--p248
-- 전체 사원의 평균급여보다 작거나 같은 급여를 받는 20번 부서의 사원 및 부서정보
-- empno, ename, job, sal, deptno, dname, loc 출력

-- SQL-99이전방식
select empno, ename, job, d.deptno, dname, loc
from emp e, dept d
where e.deptno = d.deptno
    and sal <= (select avg(sal) from emp)
    and d.deptno = 20;
-- natural join 이용
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
      
-- 각 부서별 최고급여와 동일한 급여를 받는 사원 정보 출력
-- 각 부서별 최고 급여값 출력
select deptno, max(sal)
from emp
group by deptno;
-- 서브쿼리를 이용하여      
select *
from emp
where sal in (select max(sal) from emp  group by deptno);
      
-- 여러개를 같이 비교가능
select *
from emp
where (deptno, sal) in (select deptno, max(sal) from emp  group by deptno);
