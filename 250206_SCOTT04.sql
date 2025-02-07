-- p251(다중행 서브쿼리) -- in, all, any, exits
-- in() : 괄호안 조건들과 같은 것들을 출력
select ename, sal
from emp
where sal in (1600,1250,1500);

-- any() : 괄호안 조건들중에 아무거나 하나만 만족하는 것들을 출력
select ename, sal
from emp
where sal < any (1600,1250,1500);

select ename, sal
from emp
where sal < any (select sal
                 from emp
                 where job = 'SALESMAN');

-- all() : 괄호안 조건들을 모두 만족해는 것들을 출력                 
select ename, sal
from emp
where sal < any (select sal
                 from emp
                 where job = 'SALESMAN');
                 
-- 연습문제
-- emp 테이블
-- 30번 부서의 최대급여보다 적은 급여를 받는 사원 출력(any, all 사용)
select *
from emp
where sal > any(select sal
                from emp
                where deptno = 30);

select sal
                from emp
                where deptno = 30;

-- exists() : 존재하면 true 없으면 false
select *
from emp
where EXISTS (select sal
                from emp
                where deptno = 30);
                 
            
-- DML (조작어 : data manipulation language) Insert, select, update, delete
--     : 데이터를 추가, 수정, 삭제 ==> 데이터 조작어
-- DDL (정의어 : data definition language) create, alter, drop, truncate 
--     : 객체를 생성, 변경, 삭제하는 데이터 정의어
-- DCL (권한제어 : ) Grant, revoke)
-- DOL (객체관리 : ) 인덱스, 클러스터 등)

-- test1(no, name, address, tel) 테이블 생성 ==> create table 테이블명(컬럼정의)
-- 숫자(5), 무낮열(10), 문자열(50), 문자열(20)
drop table test1;
create table test1(
    no number(5) primary key,
    name varchar2(10),
    address varchar2(50),
    tel varchar2(20)
);
select * from test1;
select count(*) from test1;
-- (no, name) 에 (1, 'aaa') 추가 ==> insert into 테이블명(칼럼) values(값)
insert into test1(no, name) values(1, 'aaa');
-- (2, 'bbb', '부산', '010-1111-2222')추가
insert into test1(no, name, address, tel) values(2, 'bbb', '부산', '010-1111-2222');
insert into test1(no, name, address, tel) values(3, 'ccc', '서울', '010-3333-4444');
-- 모든 컬럼에 값을 입력할때는 컬럼명 생략가능
insert into test1 values(4, 'ddd', '대구', '010-4444-5555');
insert into test1(no, name, address) values(5, 'eee', '제주');
-- commit을 해야 서버에 완전히 저장됨.
commit;
insert into test1 (no, name, tel) values(6,'ffff','010-6666-7777'); 
-- commit 전으로 돌아감
rollback;
-- test1 테이블 no가 2 인 정보 출력
select * from test1 where no=2;

-- 수정 ==> no=2 인 사람의 이름을 홍길동 수정
-- update 테이블명 set 칼럼명 = 수정할 내용작성 where 조건;
update test1
set name = '홍길동'
where no =2;
commit;
-- no 4 name을 이순신 / address 서울로 수정
select * from test1 where no=4;
update test1
set name = '이순신', address = '서울'
where no = 4;


-- 삭제
-- delete 테이블명 where 조건;
select * from test1;                
delete test1 where no=1;
delete from test1 where no=2;
commit;

delete from test1;
rollback;

-- test 테이블 생성(no, name, hiredate)
            -- 숫자(4), 문자열(20), date
create table test(
    no number(4) default 0,
    name varchar2(20) default 'NONAME',
    hiredate date default sysdate
);
-- default는 값을 입력안하고 삽입했을 때, 기본값으로 넣을 내용

-- test 테이블에 (1, 홍길동)  추가
insert into test(no, name) values(1, '홍길동');
select * from test;
-- test 에 25/2/6 추가
insert into test(hiredate) values('25/2/6');
-- test 테이블에서 번호가 1번인 사람의 이름을 강감찬으로 수정
update test
set name = '강감찬'
where no = 1;

-- test 테이블에서 no=0 을 삭제
delete test where no=0;
-- test 테이블에서 no=2 추가
insert into test(no) values(2);
commit;

------------------------------------
-- CRUD(create, select, update, delete) 완료!!

-- p266(CTAS: create table as select) : 이름이 다른 똑같은 테이블 만들기(테이블 복사)
-- dept_temp 테이블 생성(dept 테이블과 똑같은)
select * from dept;

create table dept_temp
as select * from dept;
select * from dept_temp;
desc dept_temp;

-- dept_temp 테이블에 50, DATEBASE, SEOUL 추가
insert into dept_temp values(50, 'DATABASE', 'SEOUL');
commit;
--테이블 구조만 복사
create table emp_temp
as select * from emp
where 1<>1;   -- 조건을 걸어서 아무 데이터도 select되지 않도록 하면 구조만 복사가능
select * from emp_temp;
-- emp_temp : empno, ename, job, mgr, hiredate, sa, comm, deptno
-- (2111, '이순신', 'MANAGER', 9999, '07/01/2019', 4000, null, 20) 추가
insert into emp_temp values(2111, '이순신', 'MANAGER', 9999, '07/01/19', 4000, null, 20);
update emp_temp
set hiredate = to_date('08/01/2019', 'DD/MM/YYYY')
where empno = 2111;

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, deptno)
values(2112, '이순신', 'MANAGER', 9999, to_date('07/01/2019', 'DD/MM/YYYY'), 4000, 20);

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(2113, '이순신3', 'MANAGER', 9999, to_date('06/02/2025', 'DD/MM/YYYY'), 4000, null, 20);

insert into emp_temp
values(3111, '강감찬', 'MANAGER', 9999, sysdate, 4000, null, 20);
commit;

-- p275  
-- 서브퀘리를 이용해서 한 번에 여러 데이터를 추가(values를 사용하지 않는다.)
-- 즉, 다른테이블에서 특정조건에 해당하는 값들을 가져와 입력하기
-- emp 테이블에서 급여등급(salgrade)이 1(700~1200)사원만 emp_tmp 테이블에 추가
select * from emp_temp;
select * from salgrade;

select * from emp where sal between 700 and 1200;

insert into emp_temp
select * from emp
where sal between 700 and 1200;

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
select empno, ename, job, mgr, hiredate, sal, comm, deptno from emp
where sal between 700 and 1200;

delete from emp_temp;  -- 모든 데이터 삭제
select * from emp_temp;
-- 급여등급(salgrade) 이 3인 사원만 emp_temp 추가
-- 3등급의 losal, hisal 찾아내서 그냥 입력하는 방법
insert into emp_temp
select * from emp 
where sal between 1400 and 2000;
-- 외부쿼리활용
insert into emp_temp
select * 
from emp
where sal between (select losal from salgrade where grade = 3) 
          and (select hisal from salgrade where grade = 3);
-- join활용
insert into emp_temp
select * 
from emp e join salgrade s
              on e.sal
              between s.losal and s.hisal
where s.grade = 3;

-- dept 테이블을 복사해서 dept_temp2 테이블을 생성하고
-- 40번 부서명을 DATABASE // 지역은 SEOUL 로 수정
drop table dept_temp2;
create table dept_temp2
as select * from dept;

update dept_temp2
set dname = 'DATABASE' , loc = 'SEOUL'
where deptno = 40;

select * from dept_temp2;
commit;

-- dept_temp2 테이블에서 부서번호가 40번인 부서명과 지역을 수정
-- dept 테이블의 40번 부서의 내용을 수정하기
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

commit;      -- 참고로 commit은 dml에 대한 적용이라고 생각하면 됨.

-- dept_temp2 모든 데이터 삭제
select * from dept_temp2;
delete from dept_temp2;  -- 모든 데이터 삭제

--테이블 삭제 
--drop table 테이블명;
drop table dept_temp2;
drop table dept_temp;

create table dept_temp
as select * from dept;
select * from dept_temp;

-- LOCATION 칼럼 추가
alter table dept_temp add(LOCATION varchar2(30));
--10번 부서의 LOCATION을 뉴욕으로 수정
update dept_temp
set Location = '뉴욕'
where deptno = 10;
select * from dept_temp;

-- LOCATION 칼럼 수정 : varchar2(70)
alter table dept_temp modify(LOCATION varchar2(70));
describe dept_temp;

-- LOCATION 컬럼 삭제
alter table dept_temp drop column LOCATION;

-- LOC 컬럼명을 LOCATION 변경
alter table dept_temp rename column LOC to LOCATION;

-- 테이블 이름 변경 dept_temp ==> dept_temptemp
alter table dept_temp rename to dept_temptemp;
describe dept_temptemp;
rename dept_temptemp to dept_temp;
describe dept_temp;

delete from dept_temp;
select * from dept_temp;

rollback;


--truncate table 테이블명 : truncate는 DDL 이므로 rollback이 적용되지 않아 복구 안됨
truncate table dept_temp;
select * from dept_temp;
rollback;
select * from dept_temp;
--dept_temp 테이블삭제
drop table dept_temp;
-- select * from dept_temp;  -- 오류발생

-----------------------------------------
-- 복습연습문제
select * from test1;
-- 1. 컬럼 추가 : birthday date 형
alter table test1 add(Birthday date);
describe test1;

-- 2. 컬럼 명 수정 : tel => phone
alter table test1 rename column tel to Phone;
describe test1;

-- 3. no 컬럼을 삭제
alter table test1 drop column no;
describe test1;

-- 4. num 컬럼 추가 : number(3)
alter table test1 add(num number(3));
describe test1;

-- 5. address 문자열(50) ==> 문자열(70) 변경
alter table test1 modify( address varchar2(70));
describe test1;

-- 6. test1 테이블 이름을 ==> testtest
alter table test1 rename to testtest;
select * from testtest;
rename testtest to test2;
select * from test2;

-- 7. 테이블 삭제
drop table test2;
-- select * from test2;    -- 오류발생(테이블 삭제)


