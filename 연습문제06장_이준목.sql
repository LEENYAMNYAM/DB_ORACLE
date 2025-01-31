-- 1번 문제
select
    empno, 
    rpad(substr(empno, 1, 2), length(empno), '*') MASKING_EMPNO,
    ename,
    rpad(substr(ename, 1, 1), length(ename), '*') MASKING_ENAME
from emp
where length(ename) = 5;

-- 2번 문제
select
    empno, 
    ename, 
    sal, 
    trunc(sal/21.5 , 2) DAY_PAY, 
    round(sal/(21.5*8), 1) TIME_PAY
from emp;

-- 3번 문제
select
    empno,
    ename,
    to_char( hiredate, 'YYYY/MM/DD' ) HIREDATE,
    to_char(next_day(add_months(hiredate, 3), '월요일'), 'YYYY-MM-DD') R_JOB,
    nvl(to_char(comm), 'N/A') COMM1,
    case 
        when to_char(comm) is null then 'N/A'
        else to_char(comm)
    end COMM
from emp;  

-- 4번 문제
select
    empno,
    ename,
    nvl(to_char(mgr), ' ') mgr,
    case 
        when substr(mgr, 1, 2) is null then '0000'
        when substr(mgr, 1, 2) = '75' then '5555'
        when substr(mgr, 1, 2) = '76' then '6666'
        when substr(mgr, 1, 2) = '77' then '7777'
        when substr(mgr, 1, 2) = '78' then '8888'
        else to_char(mgr)
    end CHG_MGR
from emp;

select
    empno,
    ename,
    nvl(to_char(mgr), ' ') mgr,
    decode( substr(mgr, 1, 2), null, '0000', 
                               '75', '5555', 
                               '76', '6666',
                               '77', '7777',
                               '78', '8888',
                               to_char(mgr))
    CHG_MGR
from emp;
