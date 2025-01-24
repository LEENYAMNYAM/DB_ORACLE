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
--p170 decade문 (if문과 동일)
--     decade(무엇이?, 뭐라면?, 뭐할래?, 다른 뭐라면?, 뭐할래?, ....... , 나머지 경우일때 뭐할래)
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
    case to_char(comm)
         when null then '해당사항 없음'
         when '0' then '수당 없음'
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

