--p125~126연습문제
SELECT
    *
FROM
    emp;

--1.Emp 테이블에서 사원이름(ename)이 S로 끝나는 사원의 정보 출력
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '%S';

--2. Emp 테이블에서 30번 부서 중 직책(job)이  SALESMAN인 
--사원번호(empno), 이름(ename) , 직책(job), 급여(sal), 부서번호(deptno)
SELECT
    empno,
    ename,
    job,
    sal,
    deptno
FROM
    emp
WHERE
    ( deptno = 30
      AND job = 'SALESMAN' );

--3.20번, 30번 부서에 근무하면서 급여가 2000 초과하는 사원의
-- 사원번호(empno), 이름(ename) , 직책(job), 급여(sal), 부서번호(deptno)
--1) 집합연산자 사용
SELECT
    empno,
    ename,
    job,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 20
UNION
SELECT
    empno,
    ename,
    job,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 30
INTERSECT
SELECT
    empno,
    ename,
    job,
    sal,
    deptno
FROM
    emp
WHERE
    sal > 2000;  

--2) 집합연사자 미사용
SELECT
    empno,
    ename,
    job,
    sal,
    deptno
FROM
    emp
WHERE
    deptno IN ( 20, 30 )
    AND sal > 2000;

--4.급여가 2000이상 3000 이하 범위 이외  not between a and b 사용하지 않기
SELECT
    *
FROM
    emp
WHERE
    sal < 2000
    OR sal <= 3000;

--5.사원이름에 E 가 포함되어 있는 30번 부서의 사원 중 급여가 1000~2000 사이가
--아닌 사원이름, 사원번호, 급여, 부서번호 출력
SELECT
    ename,
    empno,
    sal,
    deptno
FROM
    emp
WHERE
    ename LIKE '%E%'
    AND deptno = 30
    AND sal NOT BETWEEN 2000 AND 3000;

--6. 추가수당 존재 하지 않고 상급자 있고 MANAGER CLERK 중에서 
--사원이름의 두번 째 글자 L 아닌 정보 출력
SELECT
    *
FROM
    emp
WHERE
    comm IS NULL
    AND mgr IS NOT NULL
    AND job IN ( 'MANAGER', 'CLERK' )
    AND ename NOT LIKE '_L%';

------------------------------- 문자열 관련 함수 ----------------------------------
-- select * from emp;
-- 1. 문자연 연결 (concat 함수) ename:job  예) SMITH:CLERK
SELECT
    concat(ename, ':'),
    concat(concat(ename, ':'),
           job),
    concat(ename,
           concat(':', job))
FROM
    emp;
       
-- p142 문자열 연결 ||
SELECT
    ename
    || ':'
    || job AS 이름_직업
FROM
    emp;

-- 공백제거
SELECT
    '    oracle   ',
    length('   oracle   '),
    TRIM('    oracle   '),
    length(TRIM('    oracle   '))  trim길이,
    ltrim('    oracle   '),
    length(ltrim('    oracle   ')) ltrim길이,
    rtrim('    oracle   '),
    length(rtrim('    oracle   ')) rtrim길이
FROM
    dual;

------------------------------- 숫자 관련 함수-----------------------------------
-- 반올림 함수 : round(반올림할 숫자, 소수점 아래 어느자리까지 표현할까)
SELECT
    123.567,
    round(123.567, 1),
    round(123.567, 2),
    round(123.567, - 1),
    round(123.567),
    round(123.567, 0)
FROM
    dual;

-- 버림 함수 : trunc(버림할 숫자, 소수점 아래 어느자리까지 표현할까)
--              trunc(음수, 양수)일 때 조심하기
SELECT
    153793,
    trunc(15.793, 1),
    trunc(15.793, 2),
    trunc(15.793, - 1),
    trunc(15.793)
FROM
    dual;

-- 올림 함수 : ceil(올림할 숫자) : 가장 가까운 큰 정수를 반환
-- 가우스[] 함수 : floor(가우스 씌울 숫자)   가장 가까운 작은 정수를 반환 
SELECT
    3.14,
    ceil(3.14),
    floor(3.14),
    trunc(3.14),
    ceil(- 3.14),
    floor(- 3.14),
    trunc(- 3.14)
FROM
    dual;

-- 거듭제곱수 :  power(밑, 지수)
SELECT
    power(2, 3)
FROM
    dual;

-- 나머지 : mod(피제수, 제수)
SELECT
    mod(15, 6)
FROM
    dual;

------------------------------- 날짜관련 함수-------------------------------------
-- 시스템상 오늘날짜 출력 : sysdate
SELECT
    sysdate     오늘,
    sysdate + 1 내일,
    sysdate - 1 어제,
    sysdate + 3 사흘뒤
FROM
    dual;
-- 월단위의 연산 함수 : add_months(기준날짜, 계산할 개월수)
-- 3개월 뒤
SELECT
    sysdate,
    add_months(sysdate, 3),
    add_months('22/05/01', 3)
FROM
    dual;

--emp 테이블에서 사원번호(empno), 이름(ename), 입사일(hiredate),
-- 입사 10년 후(입사 10년후) 날짜 출력

SELECT
    empno                     사원번호,
    ename                     이름,
    hiredate                  입사일,
    add_months(hiredate, 120) "입사 10년 후"
FROM
    emp;

-- 날짜사이 개월 수 계산 함수 : months_between(날짜, 날짜)
SELECT
    months_between(sysdate, '24/01/24')
FROM
    dual;

-- emp 테이블 이름(ename), 입사일(hiredate), 근무개월수( 현재-입사일 )
-- 근무개월수를 소수첫째자리까지 표현(trunc 사용)
SELECT
    ename                             이름,
    hiredate                          입사일,
    months_between(sysdate, hiredate) 근무개월수,
    trunc(months_between(sysdate, hiredate),
          1)                          근무개월수1,
    trunc(months_between(hiredate, sysdate),
          1)                          근무개월수2
FROM
    emp;

-- 근무개월 수를 출력하는데 '개원' 글자 출력, 소수점 이하는 버림 ==> 예) 529개월
-- 이름, 근무개월수 출력
-- concat(A,B) 사용
SELECT
    ename        이름,
    concat(trunc(months_between(sysdate, hiredate),
                 0),
           '개월') "이름+근무개월수"
FROM
    emp;

SELECT
    ename   이름,
    trunc(months_between(sysdate, hiredate),
          0)
    || '개월' "이름+근무개월수"
FROM
    emp;

-- 다음 요일 계산해주는 함수 : next_day(날짜, '요일')
-- 그 달의 마지막날은 계산해주는 함수 : last_day(날짜)
SELECT
    sysdate,
    next_day(sysdate, '월요일') 월요일,
    next_day(sysdate, '토요일') 토요일,
    last_day(sysdate)        "그 달의 마지막 날",
    last_day('24/07/01')
FROM
    dual;

-- 연습문제 
-- 사원번호(empno)가 짝수인 사원의 사원번호(empno), 이름(ename), 직급(job) 출력
SELECT
    empno,
    ename,
    job
FROM
    emp
WHERE
    mod(empno, 2) = 0;
-- 급여(sal)가 1500에서 3000 사이의 사원은 그 급여의 15%(0.15)를 회비로 지불
-- 이름(ename), 급여(sal), 회비(반올림), 출력
SELECT
    ename,
    sal,
    round(sal * 0.15, 0) 회비
FROM
    emp
WHERE
    sal BETWEEN 1500 AND 3000;

--------------------------------- p157 형변환 함수 -------------------------------
-- describe 테이블명 : 변수명과 형 알려줌
describe emp;
-- 묵시적 형변환(자동변환) : empno(숫자) + '500'(문자) ==> 숫자 7369+500 = 7869 (500을 숫자로 묵시적 형변환)
SELECT
    empno,
    ename,
    empno + '500'
FROM
    emp;
-- 다음같은 형태(숫자+문자)일때는 형이 맞지 않아 오류가 발생한다.
-- select empno, ename, empno+'ABCD', 'ABCD' + empno
-- from emp;

--------------------------- 명시적 형변환(강제변환) ------------------------------ 
-- 날짜 형 변환(날짜형 -> 문자형)  : to_char(날짜, 포멧)
SELECT
    sysdate
FROM
    dual;

SELECT
    to_char(sysdate, 'YYYY/MM/DD HH:MI:SS') 현재날짜시간
FROM
    dual;

SELECT
    to_char(sysdate, 'MM') 월
FROM
    dual;

SELECT
    to_char(sysdate, 'DD') 일
FROM
    dual;

SELECT
    to_char(sysdate, 'HH') 시
FROM
    dual;

SELECT
    to_char(sysdate, 'mi') 분
FROM
    dual;

SELECT
    to_char(sysdate, 'ss') 초
FROM
    dual;

SELECT
    to_char(sysdate, 'Mon') 월
FROM
    dual;  // 숫자+'월' 형태
SELECT
    to_char(sysdate, 'Month') 월
FROM
    dual;

SELECT
    to_char(sysdate, 'day') 요일
FROM
    dual;
-- 연습문제 
-- 입사일이 1,2,3 월인 사원의 번호(empno), 이름(ename), 입사일(hiredate) 출력
SELECT
    *
FROM
    emp;

SELECT
    empno,
    ename,
    hiredate
FROM
    emp
WHERE
        to_char(hiredate, 'MM') >= 1
    AND to_char(hiredate, 'MM') <= 3;

SELECT
    sal,
    to_char(sal, '$999,999') sal_$,
    to_char(sal, 'L999,999') sal_l,
    to_char(sal, '999,999')  sal_9,
    to_char(sal, '000,999')  sal_0
FROM
    emp;

SELECT
    1300 - 1500
FROM
    dual;
-- 아래는 자동형 변환으로 인해 계산 되는것을 확인가능
SELECT
    '1300' - '1500'
FROM
    dual;

SELECT
    TO_NUMBER('1300') - TO_NUMBER('1500')
FROM
    dual;
-- 다음은 안됨.
--select to_number('1,300') - to_number('1,500') from dual;
--때문에 이렇게는 가능(999,999가 포멧을 의미함
SELECT
    TO_NUMBER('1,300', '999,999')
FROM
    dual;

SELECT
    TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999')
FROM
    dual;

--p164
-- to_datr(날짜, 형태) : 문자형 ==> 날짜형 바꿔줌, 형태는 생략가능
SELECT
    '20240727' AS str_date
FROM
    dual;

SELECT
    TO_DATE('20240727') AS str_date
FROM
    dual;

SELECT
    TO_DATE('20240727', 'YYYY-MM-DD') AS str_date
FROM
    dual;
--81/12/03 이후 입사한 사원 출력
SELECT
    *
FROM
    emp
WHERE hiredate > to_date( '81/12/03', 'rr/MM/DD' );
----------------------------------------------------
-- nvl(null값이 있는 지 확인할 변수,바꿔줄 값) : null을 바꾸어 주는 함수
-- 사번(empno), 이름(enaem), 급여(sal), 커미션(comm), 급여+커미션(sal+comm)출력
select empno, ename, sal, comm, sal+comm 수업,
        nvl(comm,0), sal+nvl(comm,0) 실제수업
from emp;

-- 사번(empno), 이름(eanme), 급여(sal) 커미션(comm), 급여 커미션(sal + comm) 수입
-- 수입을 천단위로 구분하여 출력
select empno, ename, sal, comm, to_char(sal+nvl(comm,0),'999,999') 연봉 from emp;

--comm을 받으면 O 받지 ㅇ낳으면 x로 출력
select empno, ename, comm, nvl2(comm,'0','x') comm유무
from emp;
-- nvl2 사용하여 연봉 출력(sal*12)
-- empno, ename, sal, comm, 연봉(sal*12 +comm)
select empno, ename, sal, comm , sal*12 + nvl2(comm,comm, 0) 연봉 from emp;
select empno, ename, sal, comm , to_char(sal*12 + nvl(comm, 0), '999,999') 연봉 from emp;

select * from emp;
-- empno, ename, mgr 출력 / mgr이 null 이면 'CEO'출력
select empno, ename, nvl(to_char(mgr), 'CEO') from emp;
select empno, ename, nvl2(to_char(mgr),to_char(mgr), 'CEO') from emp;
-- nvl쓸때는 꼭 변수형을 맞춰줘야함  묵시적형변환이 가능한 형태는 되긴함
select empno, ename, nvl2(mgr,to_char(mgr), 'CEO') from emp;
-- 이때는 첫칸에 mgr만 써도 됨 저긴 null인지 아닌지 판단만 하기 때문

----------------------------------------------------
--p170 decode문 (if문과 동일)
--     decode(무엇이?, 뭐라면?, 뭐할래?, 다른 뭐라면?, 뭐할래?, ....... , 나머지 경우일때 뭐할래)
-- job에 따라 급여 다르게 인상
-- MANAGER 1.5 / SALESMAN 1.2 / ANALYST 1.05 / 1.04
select empno, ename, job, sal, 
    decode(job, 'MANAGER', sal*1.5, 
                'SALESMAN', sal*1.2,
                'ANALYST', sal*1.05,
                 sal*1.04) 인상급여
    from emp;
-- case ~ when문 (switch문과 동일)
-- 기본형태
select empno, ename, job, sal,
    case job
        when 'MANAGER' then sal*1.5
        when 'SALESMAN' then sal*1.2
        when 'ANALYST' then sal*1.05
        else sal*1.04
    end as 인상급여
from emp;
-- 다른 버전
select empno, ename, job, sal,
    case
        when job = 'MANAGER' then sal*1.5
        when job = 'SALESMAN' then sal*1.2
        when job = 'ANALYST' then sal*1.05
        else sal*1.04
    end 인상급여
from emp;
-- 연습문제 
-- comm 이 null 이면 해당사항 없음, comm=0이면 수당없음
-- cpmm 이 있으면 수당( 예:comm 이 50 이면 수당 :50)
-- empno, ename, comm, comm_txt 출력
-- decode 사용
select empno, ename, comm, 
    decode(comm, null, '해당사항 없음',
                 0, '수당없음',
                '수당 : '|| comm ) as comm_txt
from emp;

-- case when ~ then 사용
select empno, ename, comm, 
    case 
         when to_char(comm) is null then '해당사항 없음'
         when to_char(comm) = '0' then '수당 없음'
         else '수당 : ' || to_char(comm) 
    end comm_txt
from emp;

-- professor 테이블
select * from professor;
-- 1. professor 테이블에서 교수명(name)과 학과번호(deptno), 학과명 출력
-- deptno = 101이면 '컴퓨터공학과'
-- case문으로
select name, deptno,
    case deptno
        when 101 then '컴퓨터공학과'
        else ''   -- 이 줄 생략가능
    end 학과명
from professor;
    
-- decode문으로
select name, deptno,
    decode(deptno, 101, '컴퓨터공학과', null) 학과명   --else값 안써도 됨.
from professor;
-- 2. professor 테이블에서 교수명(name)과 학과번호(deptno), 학과명 출력
-- deptno = 101이면 '컴퓨터공학과' 나머지 학과는 기타 출력 
-- case문
select name, deptno,
    case deptno
        when 101 then '컴퓨터공학과'
        else '기타'
    end 학과명
from professor;
-- decode문으로
select name, deptno,
    decode(deptno, 101, '컴퓨터공학과', '기타') 학과명 
from professor;

-- 2. professor 테이블에서 교수명(name)과 학과번호(deptno), 학과명 출력
-- deptno = 101이면 '컴퓨터공학과' 102면 멀티미디어공학과
-- 201이면 소프트웨어공학과 / 나머지는 기타
-- case문
select name, deptno,
    case deptno
        when 101 then '컴퓨터공학과'
        when 102 then '멀티미디어공학과'
        when 201 then '소프트웨어공학과'
        else '기타'
    end 학과명
from professor;
-- decode문으로
select name, deptno,
    decode(deptno, 101, '컴퓨터공학과',102, '멀티미디어공학과', 201, '소프트웨어공학과', '기타') 학과명 
from professor;

---------student 테이블
select * from student;
--학생을 3개 팀으로 분류하기 위해 학번(studno)을 3으로 나누어
-- 나머지가 0이면 A팀, 1이면 B팀, 2이면 C팀
-- 학생번호(studno), 이름(name), 학과번호(deptno1), 팀이름(teamName) 출력
-- case문
select studno, name, deptno1, 
    case mod(studno,3)
        when 0 then 'A팀'
        when 1 then 'B팀'
        else 'C팀'
    end teamName
from student;
-- decode문
select studno, name, deptno1, 
    decode( mod(studno,3), 0 ,'A팀',1,'B팀', 'C팀')  teamName
from student;

-- 1. 학생테이블에서 jumin 7번쨰가 1이면 남자, 2이면 여자
-- 학번(studno), 이름(name), 주민(jumin), 성별
select studno, name, jumin,
    decode( substr(jumin, 7, 1), 1, '남자',
                                 2, '여자') 성별
from student;

select studno, name, jumin,
    decode(substr(jumin, 7, 1), '1', '남자', '2', '여자') 성별
from student;

-- 2 tel의 지역번호에서 02 서울, 051 부산, 052 울산, 053 대구
-- 나머지는 기타로 출력
-- 이름, 전화번호, 지역 출력
select name, tel, 
    case decode( substr(tel,2,1) , '2', substr(tel,1,2), substr(tel,1,3)) 
        when '02' then '서울'
        when '051' then '부산'
        when '052' then '울산'
        when '053' then '대구'
        else '기타'
    end 지역
from student;

select name, tel, 
    decode(substr(tel,1,3),
    '02)','서울',
    '051','부산',
    '052','울산',
    '053','대구',
    '기타')지역
from student;

select name, tel, 
    case substr(tel,1,instr(tel, ')')-1) 
        when '02' then '서울'
        when '051' then '부산'
        when '052' then '울산'
        when '053' then '대구'
        else '기타'
    end 지역
from student;

select name, jumin, rpad(substr(jumin, 1, 7), length(jumin), '*') 주민번호,
    substr(jumin, 1, 7) || '-' || substr(jumin, 7) 주민번호1
from student;

-- 중복 제외 distinct()
select distinct(sal) from emp;

----- 그룹함수 = 복수행함수 = 다중행함수(하나의 열에 출력결과를 담는 함수)(p177~) ------
-- sum() : 합계를 계산해줌
select sum(sal), sum(comm) from emp;

-- count () : 자료의 개수를 알려줌
select count(*) from emp;
select count(sal) from emp;
-- 단, null값의 개수는 제외
select count(comm) from emp;

-- 중복 제외하고 개수 구하기
select count(distinct(sal)) from emp;

-- 연습문제 : emp 테이블에서 부서번호(deptno)가 30번인 사원 수
select count(*)
from emp
where deptno = 30;

-- comm 이 null 이 아닌 수
select count(comm) from emp;
select 
count(comm) 
from emp
where comm is not null;

-- comm이 null 인 갯수
-- 여기에서 count(comm)이 0인 이유는 comm 이 null값만 뽑았는데 null은 갯수를 안쳐줘서
select count(*), count(comm)
from emp
where comm is null;


-- 오류 발생
-- select ename, sum(sal) from emp;

select count(sal), count(distinct(sal)), count(all(sal))
from emp;

-- max() : 최대값
select sal from emp;
select max(sal) from emp;

-- min() : 최소값
select min(sal) from emp;
select max(sal), min(sal) from emp;

-- avg() : 평균
select avg(sal) from emp;
-- 평균을 반올림해서 소수 첫번째까지 출력
select avg(sal), round(avg(sal), 1) from emp;

-- 부서번호가 20인 사원 중에서 입사일이 가장 최근인 사원 출력
select max(hiredate) 
from emp
where deptno =20;

-- professor 테이블에서
-- 1. 총 교수 수 출력
select count(*)
from professor;

-- 2. 교수 급여 합계
select sum(pay) "급여 합계"
from professor;

-- 3. 교수 급여 평균
select sum(pay)/count(*) "급여 평균"
from professor;

-- 4. 교수들 급여의 평균을 소수점 첫째 자리에서 반올림
select round(avg(pay))
from professor;

-- 5. 최고 급여
select max(pay)
from professor;

-- 6. 최저 급여
select min(pay)
from professor;

-- 7. 교수 중 최고 급여를 받는 교수의 이름(name)과 급여(pay) 출력
-- 참고로 문자도 max/min 함수 적용가능(사전식 배열순)
-- 이렇게 하면 따로따로 max값이 나오게 됨.
select max(name), max(pay)  from professor;
--
select name, pay
from professor
where pay = (select max(pay) from professor);

-- 8. 교수 급여 합계를 출력, 천 단위 쉼표 출력
select to_char(sum(pay), '999,999') SUM_PAY
from professor;

-- emp 테이블에서
-- 1. 10번 부서(deptno) 의 평균 급여
select to_char(avg(sal), '999,999') AVG_SAL
from emp
where deptno = 10;
-- 2. 20번 부서(deptno) 의 평균 급여
select to_char(avg(sal), '999,999') AVG_SAL
from emp
where deptno = 20;
-- 3. 30번 부서(deptno) 의 평균 급여
select to_char(avg(sal), '999,999') AVG_SAL
from emp
where deptno = 30;

-- 부서번호가 10, 20, 30 인 부서의 평균 급여
-- 집합연산자 활용(부서별 평균이 나옴)
select to_char(avg(sal), '999,999') AVG_SAL from emp where deptno = 10
union
select to_char(avg(sal), '999,999') AVG_SAL from emp where deptno = 20
union
select to_char(avg(sal), '999,999') AVG_SAL from emp where deptno = 30;

-- in 함수 사용(3개의 부서의 전체 평균이 나옴)
select to_char(avg(sal), '999,999') AVG_SAL from emp where deptno in(10, 20, 30);

-- group by 변수명 : 같은 변수값을 갖는 친구들에 대해 그룹함수를 실시함.
-- 부서별 평균 급여
select deptno "부서번호(내림차순)", round(avg(sal)) "부서별 평균 급여"
from emp
group by deptno
order by deptno desc;

select * from emp;
-- 부서별(deptno) 및 직급별(job) 평균급여
select deptno "부서번호(내림차순)", job "직업", round(avg(sal)) "부서별 평균 급여"
from emp
group by deptno, job
order by deptno desc, "부서별 평균 급여" desc;

-- professor 테이블에서
-- 1. 학과별(deptno) 교수들의 평균 급여(pay)
select deptno, round(avg(pay))
from professor
group by deptno;
-- 2. 학과별(deptno) 교수들의 급여 합계
select deptno, round(sum(pay))
from professor
group by deptno;
-- 3. 학과별(deptno) 직급별(position) 교수들의 평균 급여
select deptno, position, round(avg(pay))
from professor
group by deptno, position
order by deptno, position;
-- 4. 교수 중에서 급여(pay)와 보직수당(bonus)을 합친 금액이 가장 많은 경우와 가장 적은 경우 출력
--    단, bonus 가 없는 교수의 급여는 bonus를 0으로 계산
--    급여(합친금액)는 소수 둘째 자리에서 반올림
select 
max(round(pay + nvl(bonus, 0),1)) "최대 급여", 
min(round(pay + decode(bonus, null, 0, bonus),1)) "최소 급여"
from professor;
-- 5. 직급(position)별 평균 급여(pay)가 300 보다 크면 '우수',
--    작거나 같으면 '보통'
--    직급(position), 평균 급여, 비고 출력
select 
position 직급,
round(avg(pay)) "평균 급여",
case 
    when avg(pay) > 300 then '우수'
    when avg(pay) <= 300 then '보통'
end "비고"
from professor
group by position;

--emp 테이블에서 입사년도별 인원수
-- total  1980년도 1981년도 1982년도
-- 12      1        10      1
select count(*) total,
    sum( decode(to_char(hiredate,'YYYY'),1980,1,0) ) "1980년도",
    sum( decode(to_char(hiredate,'YYYY'),1981,1,0) ) "1981년도",
    sum( decode(to_char(hiredate,'YYYY'),1982,1,0) ) "1982년도"
from emp;
select count(*) total,
    count( decode(to_char(hiredate,'YYYY'),1980,2,null) ) "1980년도",
    count( decode(to_char(hiredate,'YYYY'),1981,3,null) ) "1981년도",
    count( decode(to_char(hiredate,'YYYY'),1982,4,null) ) "1982년도"
from emp;

-- emp 테이블에서 1000 이상의 급여를 가지는 사원에 대해서만 부서별 평균 구하되
-- 그 부서별 평균이 2000 이상인 부서번호, 부서별 평균 급여 출력
select 
deptno,
round(avg(sal))
where sal >=1000
group by deptno
having avg(sal) >= 2000;

-- professor 테이블
-- 1. 학과별(deptno)로 소속 교수들의 평균 급여, 최소 급여, 최대 급여 구하기
--  단, 평균급여가 300 넘는 것만 출력
select deptno, round(avg(pay)), min(pay), max(pay)
from professor
group by deptno
having avg(pay) >= 300 ;

-- 2. 학과별(deptno) 직급별(position) 교수들의 평균 급여 구하기
-- 평균 급여가 400 이상인 것만 출력 ==> 학과번호, 직급, 평균급여
select deptno, position, round(avg(pay)) "평균급여"
from professor
group by deptno, position
having avg(pay) >= 400;

-- student 테이블
-- 3. 학년별(grade) 학생수, 평균 키, 평균 몸무게 구하기
-- 단, 학생수가 4명 이상인 것만 출력
select grade, count(*) 학생수, round(avg(height)) "평균 키", round(avg(weight)) "평균 몸무게"
from student
group by grade
having count(*)>=4
order by "평균 키" desc;

-- p196
-- 1. 부서 및 직급별 
select deptno, job, count(*), max(sal), min(sal), sum(sal), avg(sal)
from emp
group by deptno, job
order by deptno, job;

-- group 의 소계를 뽑아 내고 싶을 때 : 
-- rollup(A,B) : A,B / A에 대한 소계를 출력
-- rollup(A,B,C) A,B,C / A,B / C 에 대한 소계가 출력
select deptno, job, count(*), max(sal), min(sal), sum(sal), avg(sal)
from emp
group by rollup(deptno, job)
order by deptno, job;
-- group의 소계를 세분화 하여 내고 싶을 때 : 
-- cube(A,B) : A,B / A / B에 대한 소계가 출력 
-- cube(A,B,C) : A,B,C / A,B / A,C / B,C / A / B / C 에 대한 소계가 모두 출력
select deptno, job, count(*), max(sal), min(sal), sum(sal), avg(sal)
from emp
group by cube(deptno, job)
order by deptno, job;

-- emp테이블에서
-- 부서와 직급별 평균 급여 및 사원 수 구하기
-- 단, 부서별 평균급여와 사원수, 전체사원의 평균급여와 사원 수 출력
select deptno, job, round(avg(sal)), count(*)
from emp
group by rollup(deptno, job)        -- 부서별, 전체 소계 출력
order by deptno, job;
select deptno, job, round(avg(sal)), count(*)
from emp
group by rollup(job, deptno)        -- 직급별, 전체 소계 출력
order by  job, deptno;

-- 부서 및 직급별 평균 급여와 사원 수 출력
-- 단, 부서별 평균 급여와 사원수, 직급별 평균 급여와 사원수, 전체사원의 평균급여와 사원 수
select deptno, job, round(avg(sal)), count(*)
from emp
group by cube(deptno, job)        -- 부서별, 전체 소계 출력
order by deptno, job;

--------------------------------  p215 조인  ------------------------------------
select * from emp;    --12개 
select * from dept;   -- 4개
-- SMITH가 다니는 부서명 출력
select deptno from emp where ename='SMITH';
select dname from dept where deptno = 20;

select dname
from dept
where deptno = (select deptno from emp where ename='SMITH');
---
select *
from emp, dept;
--
select *
from emp e, dept d
where e.deptno = d.deptno;
-- 사원번호(empno), 사원이름(ename), 직급(job), 부서명(dname), 지역(loc)
-- 등가조인
select empno, ename, job, dname, loc, e.deptno
from emp e, dept d
where e.deptno = d.deptno;

select * from salgrade;

-- 비등가조인 
select *
from emp e, salgrade s
where e.sal between s.losal and s.hisal;

select *
from emp e, salgrade s
where e.sal >= s.losal and e.sal <= s.hisal;

select * from emp;
select mgr from emp where ename = 'SMITH';
select ename from emp where empno = 7902;

select ename
from emp 
where empno = (select mgr from emp where ename = 'SMITH');

--- 자체조인(셀프조인)
-- 사원의 상사(mgr)의 정보 출력
select e1.empno 사원번호, e1.ename 사원이름, e1.mgr 상사번호, e2.empno 상사사원번호, e2.ename 상사이름 
from emp e1, emp e2
where e1.mgr = e2.empno
order by e1.empno;






--1. ACCOUNTING(dname) 부서 소속 사원의 이름과 입사일 출력 
select * from dept;
select * from emp;

select empno, hiredate, dname, e.deptno
from emp e, dept d
where e.deptno = d.deptno and dname = 'ACCOUNTING';
---SQL-00 표준문법
select empno, hiredate
from emp e join dept d 
            on e.deptno = d.deptno
where dname = 'ACCOUNTING';

-- 2. 0보다 많은 comm 을 받는 사원이읆과 부서명 출력
select * from emp;
select ename, dname, comm
from emp e, dept d
where e.deptno = d.deptno and comm > 0;

select ename, dname, comm
from emp e, dept d
where e.deptno = d.deptno
and comm is not null and comm<> 0;

select ename, dname, comm
from emp e join dept d
            on e.deptno = d.deptno
where comm > 0;

select ename, dname, comm
from emp e join dept d
            on e.deptno = d.deptno
where comm is not null and comm <> 0;

-- 3. 누구의 매니저는 누구입니다.
-- 예) SMITH 의 매니저는 FORD 입니다.

select e.ename 사원, m.ename 상사
from emp e, emp m
where e.mgr = m.empno
order by e.ename;

select e.ename||'의 매니저는'||m.ename||'입니다.' 사원_상사
from emp e, emp m
where e.mgr = m.empno
order by e.ename;

select e.ename||'의 매니저는'||m.ename||'입니다.' 사원_상사
from emp e join emp m
on e.mgr = m.empno
order by e.ename;



