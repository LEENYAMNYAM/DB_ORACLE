--1. Professor 테이블과  department 테이블
--교수번호(profno)와 교수이름(name), 소속학과이름(dname)을 조회하는
--view 생성 (v_prof_dept2)
create view v_prof_dept2
as (select profno 교수번호, name 교수이름, dname 소속학과이름
    from Professor natural join department);

--2.1번 뷰를 읽기 전용으로  v_prof_dept3
create view v_prof_dept3
as( select * from v_prof_dept2)
with read only;

--3. student , department 사용하여 
--학과별(deptno1)로 학생들의 최대키와 최대 몸무게, 학과 이름을 출력

    -- 인라인 뷰 활용
    select s.deptno1 학과번호 , d.dname 학과명, s.max_height 최대키, s.max_weight 최대몸무게
    from (select deptno1, max(height) max_height, max(weight) max_weight
          from student
          group by deptno1) s, department d
    where s. deptno1 = d.deptno;

    -- 인라인 뷰 활용 X
    select s.deptno1 학과번호 , d.dname 학과명, s.height 최대키, s.weight 최대몸무게
    from student s, department d
    where s. deptno1 = d.deptno
    and (s.deptno1, s.height, s.weight )
            in (select deptno1, max(height), max(weight)
                from student
                group by deptno1);
    -- join on 활용
        select s.deptno1 학과번호 , d.dname 학과명, s.height 최대키, s.weight 최대몸무게
    from student s join department d
                     on s. deptno1 = d.deptno
    and (s.deptno1, s.height, s.weight )
            in (select deptno1, max(height), max(weight)
                from student
                group by deptno1);

--(DNAME      MAX_HEIGHT    MAX_WEIGHT)
--4. 학과이름, 학과별 최대키, 학과별로 가장 키가 큰 학생들의 이름과 키를  
    select deptno1, max(height)
    from student s
    group by deptno1;
-- 인라인뷰
    select d.dname, s.최대키, s1.name, s1.height 학생키
    from (select deptno1, max(height) 최대키
                from student
                group by deptno1) s, department d, student s1
    where s.deptno1 = d.deptno and s.deptno1 = s1.deptno1
                               and 최대키 = s1.height;

-- 
    select d.dname, s.deptno1, height 최대키, s.name, s.height 학생키
    from student s, department d
    where s.deptno1 = d.deptno
        and (deptno1, height) in (select deptno1, max(height) 최대키
                                    from student
                                    group by deptno1);
    
--5.  student 학생의 키가 동일 학년의 평균 키보다 큰 학생의                           
--학년, 이름,키, 해당 학년의 평균키 출력 (인라인뷰 이용, 학년으로 오름차순)

select grade, avg(height)
from student
group by grade;

select s.grade, s.평균키, stu.name, stu.height 학생키
from (select grade, avg(height) 평균키
      from student
      group by grade) s, student stu
where s.grade = stu.grade and stu.height > s.평균키;





