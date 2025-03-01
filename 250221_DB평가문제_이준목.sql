--1. emp 테이블에서 사원번호가 7369 인 사람 중 이름, 입사일, 부서번호를 출력하시오.

select ename 이름, hiredate 입사일, deptno 부서번호
from emp
where empno = 7369;


--2. emp 테이블에서  각 부서 번호별 
--   부서번호, 평균급여, 최고급여, 최저급여, 사원수를 출력하시오 
--   단, 평균급여는 소수점 제외하여 출력하시오

select deptno 부서번호, round(avg(sal)) 평균급여, 
       max(sal) 최고급여, min(sal) 최저급여, count(*) 사원수
from emp
group by deptno;

-- 3. emp 테이블에서 사원번호(empno)를 앞 2자리만 표현하고 뒤 2자리는 *표로 출력하시오. 
select RPAD(substr(empno,1,2), length(empno), '*') 사원번호
from emp;

-- 4. emp테이블에서 사원번호, 사원이름, 상사를 출력하되 
--    상사(mgr)가 없으면 ‘CEO’ 로 출력하시오.
select e1.empno 사원번호, e1.ename 사원이름, 
       e1.mgr 상사사원번호, nvl(e2.ename,'CEO') 상사이름 
from emp e1  left outer join emp e2
             on e1.mgr = e2.empno;

-- 5. emp 테이블에서 1000이상의 급여를 가지고 있는 사람들에 대해서만 부서별 평균을 
--    구하되 부서별 평균이 2000 이상인 부서번호, 부서별 평균 급여를 출력하시오.
select deptno 부서번호, avg(sal) 부서별평균급여
from emp
where sal >= 1000
group by deptno
having avg(sal)>= 2000;

-- 6. SMITH와 동일한 근무지에서 근무하는 사원의 이름을 출력하시오
select ename
from emp
where ename <> 'SMITH' and
    deptno = (select deptno
              from emp
              where ename = 'SMITH');

-- 7. emp, dept 테이블에서 사원이름, 부서번호, 부서명을 출력하되 모든 부서를 출력하시오

select ename 사원이름, deptno 부서번호, dname 부서명
from emp right outer join dept using(deptno)
order by deptno;

-- 8. emp 테이블에서 각 부서별 최고 급여와 동일한 급여를 받는 사원 정보를 출력하시오.
select *
from emp
where sal in (select max(sal)
              from emp
              group by deptno)
order by deptno;

-- 9. emp사원을 3개 팀으로 분류하기 위해 empno 사번을 3으로 나누어 
--    나머지가 0이면 A팀 1이면 B팀, 2이면 C 팀으로 분류하여 
--    teamName, ename, job, deptno 를 출력하시오
--    단, A팀/B팀/C팀은 teamName 컬럼명을 사용하고 decode 함수를 사용한다.

select decode( mod(empno,3), 0, 'A팀', 1, 'B팀', 2, 'C팀') teamName, 
       ename, job, deptno
from emp
order by teamName;

-- 10. emp 테이블과 dept테이블을 참고하여 
--     부서번호(deptno), 부서명(dname), 사원이름을 출력하시오.

select deptno 부서번호, dname 부서명, ename 사원이름
from emp natural join dept
order by deptno;

-- 11. scott 계정의 emp 테이블에서 30번 부서에 소속된 사원의 
--     사원번호 empno와 ename, 부서번호 deptno를 출력하는 select 문을 
--     하나의 뷰로 생성하시오 (뷰이름 : view_emp_dept30)
create view view_emp_dept30
as (select empno 사원번호, ename 사원이름, deptno 부서번호
    from emp
    where deptno = 30);
select * from view_emp_dept30;

-- 12. 관리자로 접속하여 비밀번호가 1234 이고 계정이 guest 인 사용자를 생성하시오
alter session set "_oracle_script" = true;
create user guest
       identified by 1234;

-- 13. 위에서 생성한 guest 계정에 데이터베이스에 접속하고 테이블을 생성할 수 있도록 
--     롤과 권한을 부여하시오.

grant create table, create view, create session, 
      connect, resource, unlimited tablespace to guest;

-- ★ guest 사용자로 접속하여 다음의 그림과 같이 
--    학과(dept), 학생(student), 교수(professor) 테이블과 데이터를 참고하여 
--    제시된 문제에 답하시오.

-- 14. dept(학과) 테이블을 아래 조건으로 생성하고 데이터를 추가하세요.
--     deptno 고정길이 문자 3으로 지정하고, dname 가변길이 문자 20으로 설정한다.
    create table dept(
        deptno CHAR(3),
        dname VARCHAR2(20)
    );
    insert into dept values(101, '경영학과');
    insert into dept values(102, '컴퓨터공학과');
    insert into dept values(103, '영문학과');

-- 15. 학생(student) 테이블을 아래 조건으로 생성하고 데이트를 추가하세요
-- studno 숫자로 설정하고, 기본키 제약조건 설정
-- name은 데이터 타입 가변길이 문자열 10, not null과 unique 제약 조건을 설정
-- deptno는 고정길이 문자열 3자, 학과(deptno)를 참조하도록 foregin key를 설정
-- grade 필드는 숫자 1자로 설정하고 값이 1~4의 값만 들어가도록 check 제약조건을 설정
-- profno 필드는 숫자로  설정하라.

alter table dept
add constraint dept_deptno_pk primary key(deptno);

create table student(
    studno number constraint student_studno_pk primary key,
    name VARCHAR2(10) not null unique,
    grade number(1) check(grade between 1 and 4),
    deptno CHAR(3) references dept(deptno) on delete cascade, 
    profno number
);    
    insert into student values(101, '김기현', 1, 101, 1001);
    insert into student values(102, '김민영', 2, 101, 1003);
    insert into student values(103, '김정환', 3, 101, 1001);    
    insert into student values(104, '김준태', 4, 101, 1003);
    insert into student values(105, '김지용', 1, 102, 1002);
    insert into student values(106, '김진', 2, 102, null);
    insert into student values(107, '김찬권', 3, 102, 1002);
    insert into student values(108, '김옥규', 1, 103, 1004);
    insert into student values(109, '박원영', 2, 103, 1006);
    insert into student values(110, '박의종', 3, 103, null);
select * from student;

-- 16. 교수(professor) 테이블을 생성하고 위 데이터를 추가하세요 
--     단, deptno 는 외래키로 설정하시오.
create table professor(
    profno number constraint professor_profno_pk primary key,
    name VARCHAR2(10) not null unique,
    deptno CHAR(3) references dept(deptno) on delete cascade, 
    position VARCHAR(15),
    pay number
);  

    insert into professor values(1001, '홍길동', 101, '정교수', 450);    
    insert into professor values(1002, '김연아', 102, '정교수', 400);    
    insert into professor values(1003, '박지성', 101, '부교수', 350);    
    insert into professor values(1004, '김태근', 103, '정교수', 410);    
    insert into professor values(1005, '서찬수', 101, '전임강사', 250);    
    insert into professor values(1006, '김수현', 103, '부교수', 350);    
    insert into professor values(1007, '정동진', 102, '전임강사', 320);    
    insert into professor values(1008, '임진영', 103, '전임강사', 200);    
select * from professor;

-- 17. 교수(professor) 테이블과 학과(dept) 테이블을 활용하여 
-- 학과별 급여가 가장 높은 사람의 교수명(name), 학과명(dname),  급여(pay)를 출력하라.

select p.name 교수명, d.dname 학과명, pay 급여
from professor p, dept d
where p.deptno = d.deptno
      and p.pay in (select max(pay)
                    from professor
                    group by deptno);

-- 18. 학생(student) 테이블에서 101번 학생의 이름을 이기현으로 
-- 수정하는 쿼리를 작성하시오.

update student
set name = '이기현'
where studno =101;
select * from student;

-- 19. scott 사용자에서 guest의 student 테이블을 select 권한 부여 및 제거하세요
--   ① scott 사용자에게 guest의 student 테이블을 select 할 수 있는 권한을 설정하세요.
    grant select on student to scott;

--   ② scott 사용자에게 guest의 student 테이블을 select 할 수 있는 권한을 제거하라.
    revoke select on student from scott;



























































