-- 10장 연습문제
drop table chap10hw_emp;
drop table chap10hw_dept;
drop table chap10hw_salgrade;

create table CHAP10HW_EMP as select * from emp;
create table CHAP10HW_dept as select * from dept;
create table CHAP10HW_salgrade as select * from salgrade;

commit;

-- <1번문제>
select * from chap10hw_dept;
insert into chap10hw_dept values (50, 'ORACLE', 'BUSAN');
insert into chap10hw_dept values (60, 'SQL', 'ILSAN');
insert into chap10hw_dept values (70, 'SELECT', 'INCHEON');
insert into chap10hw_dept values (80, 'DML', 'BUNDANG');

commit;

-- <2번문제>
select * from chap10hw_emp;
insert into chap10hw_emp values(7201, 'TEST_USER1', 'MANAGER', 7788, 
                                 to_date('2016/01/02', 'YYYY/MM/DD'), 4500, null, 50);
insert into chap10hw_emp values(7202, 'TEST_USER2', 'CLERK', 7201, 
                                 to_date('2016/02/21', 'YYYY/MM/DD'), 1800, null, 50);
insert into chap10hw_emp values(7203, 'TEST_USER3', 'ANALYST', 7201, 
                                 to_date('2016/04/11', 'YYYY/MM/DD'), 3400, null, 60);
insert into chap10hw_emp values(7204, 'TEST_USER4', 'SALESMAN', 7201, 
                                 to_date('2016/05/31', 'YYYY/MM/DD'), 2700, 300, 60);
insert into chap10hw_emp values(7205, 'TEST_USER5', 'CLERK', 7201, 
                                 to_date('2016/07/20', 'YYYY/MM/DD'), 2600, null, 70);
insert into chap10hw_emp values(7206, 'TEST_USER6', 'CLERK', 7201, 
                                 to_date('2016/09/08', 'YYYY/MM/DD'), 2600, null, 70);
insert into chap10hw_emp values(7207, 'TEST_USER7', 'LECTURER', 7201, 
                                 to_date('2016/10/28', 'YYYY/MM/DD'), 2300, null, 80);
insert into chap10hw_emp values(7208, 'TEST_USER8', 'STUDENT', 7201, 
                                 to_date('2018/03/09', 'YYYY/MM/DD'), 1200, null, 80);
select * from chap10hw_emp; 

commit;

-- <3번문제>
update chap10hw_emp
set deptno = 70
where sal > (select avg(sal) from chap10hw_emp where deptno = 50);

select * from chap10hw_emp; 

commit;

-- <4번문제>
update chap10hw_emp
set sal = sal*1.1, deptno = 80
where hiredate > any(select hiredate
                        from chap10hw_emp
                        where deptno = 60);

select * from chap10hw_emp;                     

commit;

-- <5번문제>
delete chap10hw_emp
where sal in (select sal
              from chap10hw_emp e join chap10hw_salgrade s 
                                  on e.sal between s.losal and hisal
              where grade = 5);
              
select * from chap10hw_emp; 

commit;




