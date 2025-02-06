-- hr 계정생성

-- ALTER SESSION set "_ORACLE_SCRIPT" = TRUE;  
-- C##안쓰고 가능하게 해줌

-- CREATE USER hr IDENTIFIED BY TIGER;
-- 계정 생성

-- 부여된 롤(cunnect랑 resouce), 권한부여(unlimitted tablespace) 하고 초록색+눌러서 새접속 하면 됨.

-- 새로운 sql파일 실행 원할시(데이터 추가)
-- @D:\JMT\DB\workspace\hr_test_data2.sql;

-- Professor 테이블
-- 1. 학과별(deptno)로 소속 교수들의 평균급여, 최소급여, 최대급여 출력(pay만)
-- 단, 평균급여가 300 넘는 것만 출력
select round(avg(pay)) 평균급여, min(pay) 최소급여, max(pay) 최대급여 
from professor
having avg(pay) > 300
group by deptno;

-- 2. student 테이블
-- 학년, 학생수, 평균키, 평균 몸무게를 계산하되
-- 학생 수가 4명 이상인 학년에 대해서 출력
-- 단, 평균 키와 평균 몸무게는 소숫점 첫번째 자리에서 반올림
-- 출력 순서는 평균키가 높은 순부터 내림차순으로 풀력
select * from student;
select grade 학년, count(studno) "학생 수", round(avg(height)) "평균 키", round(avg(weight)) "평균 몸무게" 
from student
group by grade
having count(studno) >= 4
order by avg(height) desc;

-- 3. professor, student 테이블
-- 학생이름(name) 지도교수 이름(name) 출력
select s.name 학생이름, p.name 지도교수
from student s, professor p
where s.profno = p.profno;

select s.name 학생이름, p.name 지도교수
from student s join professor p
on s.profno = p.profno;

-- gift, customer 테이블
-- 4. 고객이름(gname), 포인트(point), 선물(gname)
select c.gname 고객이름, c.point 포인트, g.gname 선물
from gift g, customer c
where c.point between G_START and G_END;

select c.gname 고객이름, to_char(c.point,'999,999') 포인트, g.gname 선물
from gift g join customer c
on c.point between G_START and G_END;

-- student, score 테이블
-- 5. 학생들의 이름(name), 점수(total), 학점(grade) 출력
select st.name 이름, sc.total 점수, ha.grade 학점
from student st, score sc, hakjum ha
where st.studno = sc.studno 
      and sc.total between min_point and max_point;

select st.name 이름, sc.total 점수, ha.grade 학점
from student st join score sc on st.studno = sc.studno
                join hakjum ha on sc.total between min_point and max_point;

-- student, professor 테이블
-- 1. 학생이름과 지도교수 이름 출력 하되 지도교수가 정해지지 않은 학생 이름도 출력
--SQL-99 이전방법
select s.name 학생이름, p.name "지도교수 이름" 
from student s, professor p 
where s.profno = p.profno(+);
--SQL-99방법 
    -- natural join은 이름이 같은 칼럼이 2개(profno, name)라서 불가능함.
    -- using 이용
select s.name 학생이름, p.name "지도교수 이름" 
from student s left outer join professor p using(profno);
    -- join on 이용
select s.name 학생이름, p.name "지도교수 이름" 
from student s left outer join professor p 
                            on s.profno = p.profno;
                            
-- 2. 101(deptno1)번 학과에 소속된 학생 출력
-- 단, 지도교수가 없는 학생도 출력(학과번호, 학생이름, 지도교수이름)
-- SQL-99 이전방법
select s.deptno1, s.name, p.name
from student s, professor p
where s.profno = p.profno(+)
    and s.deptno1 = 101;
--SQL-99버전
    -- using 이용
select s.deptno1, s.name, p.name
from student s left outer join professor p using(profno)
where s.deptno1 = 101;
    -- join on
select s.deptno1, s.name, p.name
from student s left outer join professor p 
                            on s.profno = p.profno
where s.deptno1 = 101;

-- 3. dept2, emp2 테이블에서 area 가 Seoul Branch Office 인 사원의
-- 사원번호(empno), 이름(name), 부서번호(deptno) 출력
-- 서브쿼리 이용
select empno 사원번호, name 이름, deptno 부서번호
from emp2
where deptno in (select dcode
                 from dept2
                 where area like 'Seoul%');
--SQL-99이전방법                 
select empno 사원번호, name 이름, deptno 부서번호
from dept2 d, emp2 e 
where d.dcode = e.deptno
    and area like 'Seoul%';
-- join on이용
select empno 사원번호, name 이름, deptno 부서번호
from dept2 d join emp2 e on d.dcode = e.deptno
where area like 'Seoul%';

-- 4. Student 테이블에서 각 학년별 최대 몸무게를 가진 학생의 학년, 이름, 몸무게 출력
select grade 학년, name 이름, weight 몸무게
from student
where weight in (select max(weight) from student group by grade);

select grade 학년, name 이름, weight 몸무게
from student
where (grade, weight) in (select grade, max(weight) from student group by grade);












