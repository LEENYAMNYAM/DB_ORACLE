-- emp 모든 정보 조회
select * from emp;
-- dept 모든 정보 조회

-- dept테이블 : 부서 정보 테이블
-- emp 테이블 : 사원 정보 테이블
select * from dept;
-- 1. 부서번호(deptno) 가 10번인 모든 사원정보를 출력
select * from emp where deptno = 10;
-- 2. 부서번호(deptno) 가 10번인 이름(ename), 입사일(hiredate), 부서번호(deptno)

select ename, hiredate, deptno from emp where deptno =10;
-- 3. 사원번호(empno) 가 7369인 사원의 이름, 입사일, 부서번호 출력
select ename, hiredate, deptno from emp where empno = 7369;
-- 4. 이름(ename)이 allen인 사원의 모든 정보 출력
-- 명령어와 변수값은 대소문자 구분이 없지만, 데이터값은 대/소문자구분함
select * from emp where ename = 'ALLEN';
SELECT * FROM EMP WHERE ENAME = 'ALLEN';

-- 5. 입사일(hiredate)이 19980 12 17인 사원의 이름(ename), 부서번호(deptno),월급(sal) 출력
select ename, deptno, sal from emp where hiredate = '1980/12/17';
select ename, deptno, sal from emp where hiredate = '80/12/17';
-- 6. 직업(job)이 MANAGER 인 사원의 모든 정보 출력
select * FROM emp where job = 'MANAGER';
-- 7. 직업(job)이 MANAGER 가 아닌 사원의 모든 정보 출력
select * FROM emp where job != 'MANAGER';
select * FROM emp where job <> 'MANAGER';
-- 8. 입사일(hiredate)이 81/04/02 이후에 입사한 사원의 모든 정보 출력
select * from emp where hiredate >= '81/04/02';
describe emp;
desc emp;
-- 9. 급여(sal)가 1000 이상인 사원의 이름(ename), 급여(sal), 부서번호(deptno)조회
select ename, sal, deptno from emp where sal >= 1000;
select * from emp where sal >= 1000;
-- 10. 급여(sal)가 1000 이상인 사원의 이름(ename), 급여(sal), 부서번호(deptno)조회
-- 급여가 높은 순으로 출력(desc : 내림차순, asc : 오름차순(기본값))
select ename, sal, deptno 
from emp 
where sal >= 1000
order by sal asc;

select ename, sal, deptno 
from emp 
where sal >= 1000
order by sal desc;

-- 급여를 내림차순으로 출력 / 급여가 같다면 이름으로 오름차순
select ename, sal, deptno 
from emp 
where sal >= 1000
order by sal desc, ename asc;

-- 11. 이름이 'K'로 시작하는 사람보다 높은 이름을 가진 사원의 모든 정보
select * from emp where ename > 'K';

-- 집합연산자
-- union : 합집합
-- minus : 차집합
-- intersect : 교집합 
-- emp 테이블에서 부서번호가 10인 사원번호(empno), 이름(ename), 급여(sal), 부서번호(deptno) 출력
-- emp 테이블에서 부서번호가 20인 사원번호(empno), 이름(ename), 급여(sal), 부서번호(deptno) 출력
-- emp 테이블에서 부서번호가 10이거나 20인 사원번호(empno), 이름(ename), 급여(sal), 부서번호(deptno) 출력
SELECT empno, ename, sal, deptno from emp where  deptno = 10;
SELECT empno, ename, sal, deptno from emp where  deptno = 20;
SELECT empno, ename, sal, deptno from emp where  deptno = 10 
union
SELECT empno, ename, sal, deptno from emp where  deptno = 20;

-- 모든 부서중에서 20인 부서를 제외하고 출력(집합연산자활용)
SELECT * from emp
Minus
select * from emp where  deptno = 20;

-- 모든 부서중에서 20인 부서 출력(교집합 연산자 활용)
SELECT * from emp
intersect
select * from emp where  deptno = 20;


-- 12. 부서번호가 10이거나 20인 부서의 사원 정보를 출력
-- or 연산자 사용해서 출력
select empno, ename, sal, deptno from emp where deptno = 10 or deptno = 20;
-- in을 사용하면 deptno이 여러값을 동시에 출력가능
select empno, ename, sal, deptno from emp where deptno in (10, 20);


-- 13. 사원이름이 s로 끝나는 사원의 모든 정보 조회
-- %를 이용하면 변수명 앞에 * 의미를 가짐.
-- 정확한 값이 아니므로 등호대신에 like를 사용해야함.
select * from emp where ename like '%S';

-- 14. 30번 부서에서 근무하는 사원 중 job이 SALESNAM 사원의
--     사원번호(empno), 이름(ename), 직책(job), 급여(sal) 부서번호(deptno) 조회
-- and 연산자 사용해서 출력
select empno, ename, job, sal, deptno from emp where deptno = 30 and job = 'SALESMAN';
-- intersect(교집합 연산자) 사용해서 출력
select empno, ename, job, sal, deptno from emp where deptno = 30
intersect
select empno, ename, job, sal, deptno from emp where job = 'SALESMAN';

-- 15. 30번 부서에서 근무하는 사원 중 job이 SALESNAM 사원의
--     사원번호(empno), 이름(ename), 직책(job), 급여(sal) 부서번호(deptno) 조회
--     급여가 높은 순으로 조회
select empno, ename, job, sal, deptno 
from emp 
where deptno = 30 and job = 'SALESMAN' 
order by sal desc;

-- 15. 30번 부서에서 근무하는 사원 중 job이 SALESNAM 사원의
--     사원번호(empno), 이름(ename), 직책(job), 급여(sal) 부서번호(deptno) 조회
--     급여가 많은 순으로 출력, 급여가 같다면 사원번호가 작은 순으로 출력
select empno, ename, job, sal, deptno 
from emp 
where deptno = 30 and job = 'SALESMAN' 
order by sal desc, empno asc;
--------------------------------여기까지 복습------------------------------------
-- [20번, 30번 부서에 근무하는 사원 중에서
-- 급여(sal)가 2000 초과하는 사원의 사원번호(empno), 이름(ename), 급여(sal), 부서번호(deptno) 출력
-- 17. 집합연산자를 사용해서
select empno, ename, sal, deptno from emp where sal > 2000
intersect
(select empno, ename, sal, deptno from emp where deptno = 20
union
select empno, ename, sal, deptno from emp where deptno = 30);

-- 18. 집합연산자를 사용하지 않고
select empno, ename, sal, deptno from emp where deptno in(20,30) and  sal > 2000;

-- 19. 급여(sal) 가 2000 이상 3000 이하 범위인 사원 정보 출력
select * from emp where sal>=2000 and sal <=3000;
-- between ~ and ~  를 사용할 수도 있음.
select * from emp where sal between 2000 and 3000;

-- 20. 급여(sal) 가 2000 이상 3000 이하 범위 이외의 사원 정보 출력
select * from emp where sal<2000 or sal >3000;
-- not between ~ and ~ 를 사용 할 수도 있음.
select * from emp where sal not between 2000 and 3000;

-- 21. 사원이름, 사원번호, 급여, 부서번호 출력
select ename, empno, sal, deptno from emp;

-- 개별 별칭지정하기(as 생략가능, 쌍따옴표 생략가능, 단 공백을 함께 쓸경우는 쌍따옴표 써야함
select ename as 사원이름, empno as 사원번호, sal 급여, deptno "부서 번호"
from emp;
-- 때문에 주로 아래와 같이 사용함(띄어쓰기 대신에 _사용)
select ename 사원이름, empno 사원번호, sal 급여, deptno 부서_번호
from emp;

-- 22. 사원이름에 E가 포함되어 있는 30번 부서 사원 중에서
--     급여가 1000~2000 사이가 아닌 사원 출력
select ename 사원이름, empno "사원 번호", sal 급여, deptno "부서 번호" 
from emp
where (sal < 1000 or sal > 2000) 
       and ename like '%E%' 
       and deptno = 30;

-- 23. 주가수당(comm)이 존재하지 않는 사원 정보 출력
-- null값을 뽑아낼 때는 is null써야함. = null 안됨!
select * 
from emp 
where comm is null;
--     주가수당(comm)이 존재하는 사원 정보 출력
select * 
from emp 
where comm is not null;
-- 주가수당이 0인 사람도 제외하고 싶을 시
select * 
from emp 
where comm is not null and comm != 0;




-- 25. 주가수당(comm)이 존재하지 않고, 상급자(mgr)는 있고, 
-- 직급이 MANAGER, CLERK 인 사원  중에서 
-- 사원이름의 두번째 글자가 L이 아닌 사원 정보 출력

-- 변수명에 _를 쓰면 임의의 한글자를 뜻함.
select * 
from emp  
where comm is null 
       and mgr is not null 
       and job in ('MANAGER', 'CLERK') 
       and ename not like '_L%';

--------------------------p128 오라클함수(내장함수) ------------------------------
-- <문자열 관련 내장함수>
-- upper(변수명) : 대문자로 바꿔주는 내장함수
-- lower(변수명) : 소문자로 바꿔주는 내장함수
-- initcap(변수명) : 첫글자만 대문자로 바꿔주는 내장함수

select * from emp;
select ename, upper(ename) as 대문자, lower(ename) 소문자, initcap(ename)
from emp ;

--<그 외>
-- length(변수명) : 이름의 글자수를 알려줌
select ename, length(ename) 이름글자수 from emp;
-- 사원이름(ename)이 5글자 이상인 사원의 이름(ename), 글자수 출력
select ename, length(ename) 이름글자수 from emp where length(ename)>=5;

-- 이름 추출
-- substr(변수명,시작위치,개수) : 변수의 일부분만 추출해서 출력, 개수를 안쓰면 끝까지 출력
select ename ,substr(ename, 1, 2), substr(ename, 3, 2), substr(ename, 3), 
        substr(ename, 3, length(ename)),
        length(substr(ename, 3)), length(substr(ename,3,length(ename)))
        -- 두가지 방법의 글자수가 같음.-> 뒤에 공백없음
        from emp;
        
--------------------------------------------------------------------------------
-- dual : 비어있는 테이블을 만들어주는것 같음.
select 'CORPORATE'
from dual;

-- 위치값 리턴
-- instr(문자 or 변수명, 찾을 문자, 어디서부터 , 몇번째로 일치하는지 ) : 그 글자의 위치를 정수로 리턴
select instr('CORPORATE FLOOR', 'OR', 1, 1)
from dual;
select instr('CORPORATE FLOOR', 'OR')       -- 뒤를 생략하면 위의뜻과 똑같아짐(1,1)로 판단함.
from dual;
select instr('CORPORATE FLOOR', 'OR', 1, 2)  -- 두번째로 OR 이 나오는 지점의 시작점 즉 O의 위치를 반환
from dual;
select instr('CORPORATE FLOOR', 'OR', -1, 2)  -- -1을 저기에 쓰면 뒤에서 부터 2번째에 나오는 OR 값의 위치를 반환
from dual;
select instr('CORPORATE FLOOR', 'OR', -3, 1)  -- -3이므로 뒤에서 3번째글자부터 시작해서 OR이 1번째 나오는 O의 위치를 반환
from dual;
select instr('CORPORATE FLOOR', 'OR', -3, 2)  -- -3이므로 뒤에서 3번째글자부터 시작해서 OR이 2번째 나오는 O의 위치를 반환
from dual;
-- 문자열 ABCDDEF 에서 D의 위치값 출력
-- 처음부터 => 4
select instr('ABCDDEF', 'D') from dual;
select instr('ABCDDEF', 'D', 1, 1) from dual;
-- 끝에서  => 5
select instr('ABCDDEF', 'D', -1, 1) from dual;
-- emp 테이블에서 ename 중 s가 있는 위치 출력
select ename, instr(ename, 'S'), instr(ename, 'S',-1,1)
from emp;
-- emp테이블에서 사원이름에 s가 들어있는 이름만 출력(instr 함수 사용)
select * from emp where ename like '%S%';  -- like '%S%'를 이용하여
select ename from emp where instr(ename, 'S') > 0;
-- emp 테이블에서 ename 출력(이름의 2글자만 추출하여 소문자로 변환하여 출력) 
select ename, lower( substr(ename,1,2) ) 소문자1, substr(lower( ename ),1,2) 소문자2 from emp;

-- Replace(바꿀 변수명 or 데이터값, 바꿀문자, 바뀔문자) : 
select '010-1234-5678' as rep_before,
    replace('010-1234-5678', '-', ' ') as rep_after
from dual;
--emp 테이블에서 s를 소문자 s로 변경하여 출력(replace 함수 사용)
select ename, replace(ename, 'S', 's') 
from emp;

-- lengthB : 바이트로 몇바이트인지 알려줌
------------------------------------------
select length('한글'), lengthB('한글')
from dual;

select 'Oracle', length('Oracle'), lengthB('Oracle')
from dual;

-- LPAD(변수명 or 데이터, 몇글자로 만들래?, 왼쪽빈칸에 뭐 채울래?) 마지막 안적으면 공백으로 채워짐
-- RPAD(변수명 or 데이터, 몇글자로 만들래?, 오른쪽빈칸에 뭐 채울래?) 마지막 안적으면 공백으로 채워짐
select 'Oracle' , LPAD('Oracle', 10, '#') LPAD1,
                  RPAD('Oracle', 10, '#') RPAD1,
                  LPAD('Oracle', 10) LPAD2, length(LPAD('Oracle', 10)),
                  RPAD('Oracle', 10) RPAD2, length(RPAD('Oracle', 10))
from dual;
-- 때문에 모두 10글자가 되었고 LPAD1은 왼쪽빈칸이 #으로, RPAD1은 오른쪽 빈칸이 #으로
--                          LPAD2는 왼쪽에 스페이스가, RPAD2는 오른쪽에 빈칸이 들어감.
-- 문제 : emp 테이블에서 사원번호(앞2자리 숫자 나머지 '*') 별칭은 사원번호,
-- 사원이름 별칭은 사원이름 (첫 2글자만) 나오고 나머지는 '*'로 출력 

select RPAD(substr(empno, 1, 2), length(empno) , '*') 사원번호, 
       RPAD(substr(ename, 1, 2), length(ename) , '*')  사원이름  
from emp;
-- p141
select rpad('971225-',14,'*') as RPAD_JMNO,
       rpad('010-1234-',13,'*') as RPAD_PHONE
from dual;
--------------------------------------------------------------------------------
-- SCOTT 테이블 추가.txt 데이터 추가했음.

select * from student;
-- 1. jumin 7510231901810  ==> 751023*******
select name, RPAD(substr(jumin, 1,6), length(jumin), '*') JUMIN_NO from Student;

-- 2. tel 055)381-2158   ==> 055-381-2158
select tel, name, replace( tel , ')', '-') from Student;

-- 3. 키(height)가 170이상인 학생의 studno, name, grade, height, weight 출력
-- 단, 키가 큰 학생순으로 출력, 만약 키가 같다면 studno가 작은 순으로 출력
select studno, name, grade, height, weight 
from student 
where height >= 170 
order by height desc, studno asc;

-- 4. 교수 porfessor 테이블에서 보너스를 받지 못하는 사람 출력
--    교수번호(profno), 이름(name), 월급(pay), 보너스(bonus) 순으로 출력
select profno 교수번호, name 이름, pay 월급, bonus 보너스 
from professor 
where bonus is null;

-- 5. 교수 professor 테이블에서 email중에서 아이디만 출력
-- (@앞까지만 출력 : captain@abc.net ==> captain)
select name 이름, email 이메일, substr(email, 1 , instr(email, '@')-1) 아이디 
from professor;



