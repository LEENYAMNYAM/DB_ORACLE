-- @D:\JMT\DB\workspace\hr_test_data2

-- student 테이블
-- 1. student 테이블에서 각 학년별 최대 몸무게를 가진 학생들의 학년, 이름, 몸무게 출력
select grade 학년, name 이름, weight 몸무게
from student
where weight in (select max(weight)
                from student
                group by grade)
order by grade asc;

-- 2. professor department 테이블
-- 각 학과별 입사일이 가장 오래된 교수의 교수번호, 이름, 학과명 출력
-- 단, 입사일은 오름차순으로
select profno 교수번호, name 이름, dname 학과명, hiredate 입사일, deptno 학과번호
from professor natural join department
where hiredate in (select min(hiredate)
                    from professor
                    group by deptno)
order by hiredate asc;

-- 3. emp2 테이블
-- 'Section head'(position) 직급의 최소 연봉자보다
-- 연봉이 높은 사람의 이름(name), 직급(position), 연봉(pay) 출력

select name 이름, position 직급, pay 연봉, to_char(pay, 'L999,999,999')
from emp2
where pay > (select min(pay)
             from emp2
             where position = 'Section head');

-- 4 employees 테이블
-- 부서번호가 80보다 큰 부서의 사원아이디(employee_id), 사원이름(first_name), 매니저이름(first_name) 출력

select e.employee_id 사원아이디, e.first_name 사원이름, m.employee_id "매니저 아이디", m.first_name "매니저 이름"
from employees e left outer join employees m 
                 on e.manager_id = m.employee_id
where e.department_id > 80
order by 사원아이디;

-- 5. student, professore 테이블
-- 모든 학생 출력(즉, 지도교수가 없는 학생도 출력) 학생이름(name), 교수이름(name)
select s.name 학생이름, p.name 교수이름
from student s left outer join professor p using(profno);




