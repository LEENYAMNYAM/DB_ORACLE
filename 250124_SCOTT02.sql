--p125~126��������
SELECT
    *
FROM
    emp;

--1.Emp ���̺��� ����̸�(ename)�� S�� ������ ����� ���� ���
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '%S';

--2. Emp ���̺��� 30�� �μ� �� ��å(job)��  SALESMAN�� 
--�����ȣ(empno), �̸�(ename) , ��å(job), �޿�(sal), �μ���ȣ(deptno)
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

--3.20��, 30�� �μ��� �ٹ��ϸ鼭 �޿��� 2000 �ʰ��ϴ� �����
-- �����ȣ(empno), �̸�(ename) , ��å(job), �޿�(sal), �μ���ȣ(deptno)
--1) ���տ����� ���
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

--2) ���տ����� �̻��
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

--4.�޿��� 2000�̻� 3000 ���� ���� �̿�  not between a and b ������� �ʱ�
SELECT
    *
FROM
    emp
WHERE
    sal < 2000
    OR sal <= 3000;

--5.����̸��� E �� ���ԵǾ� �ִ� 30�� �μ��� ��� �� �޿��� 1000~2000 ���̰�
--�ƴ� ����̸�, �����ȣ, �޿�, �μ���ȣ ���
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

--6. �߰����� ���� ���� �ʰ� ����� �ְ� MANAGER CLERK �߿��� 
--����̸��� �ι� ° ���� L �ƴ� ���� ���
SELECT
    *
FROM
    emp
WHERE
    comm IS NULL
    AND mgr IS NOT NULL
    AND job IN ( 'MANAGER', 'CLERK' )
    AND ename NOT LIKE '_L%';

------------------------------- ���ڿ� ���� �Լ� ----------------------------------
-- select * from emp;
-- 1. ���ڿ� ���� (concat �Լ�) ename:job  ��) SMITH:CLERK
SELECT
    concat(ename, ':'),
    concat(concat(ename, ':'),
           job),
    concat(ename,
           concat(':', job))
FROM
    emp;
       
-- p142 ���ڿ� ���� ||
SELECT
    ename
    || ':'
    || job AS �̸�_����
FROM
    emp;

-- ��������
SELECT
    '    oracle   ',
    length('   oracle   '),
    TRIM('    oracle   '),
    length(TRIM('    oracle   '))  trim����,
    ltrim('    oracle   '),
    length(ltrim('    oracle   ')) ltrim����,
    rtrim('    oracle   '),
    length(rtrim('    oracle   ')) rtrim����
FROM
    dual;

------------------------------- ���� ���� �Լ�-----------------------------------
-- �ݿø� �Լ� : round(�ݿø��� ����, �Ҽ��� �Ʒ� ����ڸ����� ǥ���ұ�)
SELECT
    123.567,
    round(123.567, 1),
    round(123.567, 2),
    round(123.567, - 1),
    round(123.567),
    round(123.567, 0)
FROM
    dual;

-- ���� �Լ� : trunc(������ ����, �Ҽ��� �Ʒ� ����ڸ����� ǥ���ұ�)
--              trunc(����, ���)�� �� �����ϱ�
SELECT
    153793,
    trunc(15.793, 1),
    trunc(15.793, 2),
    trunc(15.793, - 1),
    trunc(15.793)
FROM
    dual;

-- �ø� �Լ� : ceil(�ø��� ����) : ���� ����� ū ������ ��ȯ
-- ���콺[] �Լ� : floor(���콺 ���� ����)   ���� ����� ���� ������ ��ȯ 
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

-- �ŵ������� :  power(��, ����)
SELECT
    power(2, 3)
FROM
    dual;

-- ������ : mod(������, ����)
SELECT
    mod(15, 6)
FROM
    dual;

------------------------------- ��¥���� �Լ�-------------------------------------
-- �ý��ۻ� ���ó�¥ ��� : sysdate
SELECT
    sysdate     ����,
    sysdate + 1 ����,
    sysdate - 1 ����,
    sysdate + 3 �����
FROM
    dual;
-- �������� ���� �Լ� : add_months(���س�¥, ����� ������)
-- 3���� ��
SELECT
    sysdate,
    add_months(sysdate, 3),
    add_months('22/05/01', 3)
FROM
    dual;

--emp ���̺��� �����ȣ(empno), �̸�(ename), �Ի���(hiredate),
-- �Ի� 10�� ��(�Ի� 10����) ��¥ ���

SELECT
    empno                     �����ȣ,
    ename                     �̸�,
    hiredate                  �Ի���,
    add_months(hiredate, 120) "�Ի� 10�� ��"
FROM
    emp;

-- ��¥���� ���� �� ��� �Լ� : months_between(��¥, ��¥)
SELECT
    months_between(sysdate, '24/01/24')
FROM
    dual;

-- emp ���̺� �̸�(ename), �Ի���(hiredate), �ٹ�������( ����-�Ի��� )
-- �ٹ��������� �Ҽ�ù°�ڸ����� ǥ��(trunc ���)
SELECT
    ename                             �̸�,
    hiredate                          �Ի���,
    months_between(sysdate, hiredate) �ٹ�������,
    trunc(months_between(sysdate, hiredate),
          1)                          �ٹ�������1,
    trunc(months_between(hiredate, sysdate),
          1)                          �ٹ�������2
FROM
    emp;

-- �ٹ����� ���� ����ϴµ� '����' ���� ���, �Ҽ��� ���ϴ� ���� ==> ��) 529����
-- �̸�, �ٹ������� ���
-- concat(A,B) ���
SELECT
    ename        �̸�,
    concat(trunc(months_between(sysdate, hiredate),
                 0),
           '����') "�̸�+�ٹ�������"
FROM
    emp;

SELECT
    ename   �̸�,
    trunc(months_between(sysdate, hiredate),
          0)
    || '����' "�̸�+�ٹ�������"
FROM
    emp;

-- ���� ���� ������ִ� �Լ� : next_day(��¥, '����')
-- �� ���� ���������� ������ִ� �Լ� : last_day(��¥)
SELECT
    sysdate,
    next_day(sysdate, '������') ������,
    next_day(sysdate, '�����') �����,
    last_day(sysdate)        "�� ���� ������ ��",
    last_day('24/07/01')
FROM
    dual;

-- �������� 
-- �����ȣ(empno)�� ¦���� ����� �����ȣ(empno), �̸�(ename), ����(job) ���
SELECT
    empno,
    ename,
    job
FROM
    emp
WHERE
    mod(empno, 2) = 0;
-- �޿�(sal)�� 1500���� 3000 ������ ����� �� �޿��� 15%(0.15)�� ȸ��� ����
-- �̸�(ename), �޿�(sal), ȸ��(�ݿø�), ���
SELECT
    ename,
    sal,
    round(sal * 0.15, 0) ȸ��
FROM
    emp
WHERE
    sal BETWEEN 1500 AND 3000;

--------------------------------- p157 ����ȯ �Լ� -------------------------------
-- describe ���̺�� : ������� �� �˷���
describe emp;
-- ������ ����ȯ(�ڵ���ȯ) : empno(����) + '500'(����) ==> ���� 7369+500 = 7869 (500�� ���ڷ� ������ ����ȯ)
SELECT
    empno,
    ename,
    empno + '500'
FROM
    emp;
-- �������� ����(����+����)�϶��� ���� ���� �ʾ� ������ �߻��Ѵ�.
-- select empno, ename, empno+'ABCD', 'ABCD' + empno
-- from emp;

--------------------------- ����� ����ȯ(������ȯ) ------------------------------ 
-- ��¥ �� ��ȯ(��¥�� -> ������)  : to_char(��¥, ����)
SELECT
    sysdate
FROM
    dual;

SELECT
    to_char(sysdate, 'YYYY/MM/DD HH:MI:SS') ���糯¥�ð�
FROM
    dual;

SELECT
    to_char(sysdate, 'MM') ��
FROM
    dual;

SELECT
    to_char(sysdate, 'DD') ��
FROM
    dual;

SELECT
    to_char(sysdate, 'HH') ��
FROM
    dual;

SELECT
    to_char(sysdate, 'mi') ��
FROM
    dual;

SELECT
    to_char(sysdate, 'ss') ��
FROM
    dual;

SELECT
    to_char(sysdate, 'Mon') ��
FROM
    dual;  // ����+'��' ����
SELECT
    to_char(sysdate, 'Month') ��
FROM
    dual;

SELECT
    to_char(sysdate, 'day') ����
FROM
    dual;
-- �������� 
-- �Ի����� 1,2,3 ���� ����� ��ȣ(empno), �̸�(ename), �Ի���(hiredate) ���
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
-- �Ʒ��� �ڵ��� ��ȯ���� ���� ��� �Ǵ°��� Ȯ�ΰ���
SELECT
    '1300' - '1500'
FROM
    dual;

SELECT
    TO_NUMBER('1300') - TO_NUMBER('1500')
FROM
    dual;
-- ������ �ȵ�.
--select to_number('1,300') - to_number('1,500') from dual;
--������ �̷��Դ� ����(999,999�� ������ �ǹ���
SELECT
    TO_NUMBER('1,300', '999,999')
FROM
    dual;

SELECT
    TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999')
FROM
    dual;

--p164
-- to_datr(��¥, ����) : ������ ==> ��¥�� �ٲ���, ���´� ��������
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
--81/12/03 ���� �Ի��� ��� ���
SELECT
    *
FROM
    emp
WHERE hiredate > to_date( '81/12/03', 'rr/MM/DD' );
----------------------------------------------------
-- nvl(null���� �ִ� �� Ȯ���� ����,�ٲ��� ��) : null�� �ٲپ� �ִ� �Լ�
-- ���(empno), �̸�(enaem), �޿�(sal), Ŀ�̼�(comm), �޿�+Ŀ�̼�(sal+comm)���
select empno, ename, sal, comm, sal+comm ����,
        nvl(comm,0), sal+nvl(comm,0) ��������
from emp;

-- ���(empno), �̸�(eanme), �޿�(sal) Ŀ�̼�(comm), �޿� Ŀ�̼�(sal + comm) ����
-- ������ õ������ �����Ͽ� ���
select empno, ename, sal, comm, to_char(sal+nvl(comm,0),'999,999') ���� from emp;

--comm�� ������ O ���� �������� x�� ���
select empno, ename, comm, nvl2(comm,'0','x') comm����
from emp;
-- nvl2 ����Ͽ� ���� ���(sal*12)
-- empno, ename, sal, comm, ����(sal*12 +comm)
select empno, ename, sal, comm , sal*12 + nvl2(comm,comm, 0) ���� from emp;
select empno, ename, sal, comm , to_char(sal*12 + nvl(comm, 0), '999,999') ���� from emp;

select * from emp;
-- empno, ename, mgr ��� / mgr�� null �̸� 'CEO'���
select empno, ename, nvl(to_char(mgr), 'CEO') from emp;
select empno, ename, nvl2(to_char(mgr),to_char(mgr), 'CEO') from emp;
-- nvl������ �� �������� ���������  ����������ȯ�� ������ ���´� �Ǳ���
select empno, ename, nvl2(mgr,to_char(mgr), 'CEO') from emp;
-- �̶��� ùĭ�� mgr�� �ᵵ �� ���� null���� �ƴ��� �Ǵܸ� �ϱ� ����

----------------------------------------------------
--p170 decode�� (if���� ����)
--     decode(������?, �����?, ���ҷ�?, �ٸ� �����?, ���ҷ�?, ....... , ������ ����϶� ���ҷ�)
-- job�� ���� �޿� �ٸ��� �λ�
-- MANAGER 1.5 / SALESMAN 1.2 / ANALYST 1.05 / 1.04
select empno, ename, job, sal, 
    decode(job, 'MANAGER', sal*1.5, 
                'SALESMAN', sal*1.2,
                'ANALYST', sal*1.05,
                 sal*1.04) �λ�޿�
    from emp;
-- case ~ when�� (switch���� ����)
-- �⺻����
select empno, ename, job, sal,
    case job
        when 'MANAGER' then sal*1.5
        when 'SALESMAN' then sal*1.2
        when 'ANALYST' then sal*1.05
        else sal*1.04
    end as �λ�޿�
from emp;
-- �ٸ� ����
select empno, ename, job, sal,
    case
        when job = 'MANAGER' then sal*1.5
        when job = 'SALESMAN' then sal*1.2
        when job = 'ANALYST' then sal*1.05
        else sal*1.04
    end �λ�޿�
from emp;
-- �������� 
-- comm �� null �̸� �ش���� ����, comm=0�̸� �������
-- cpmm �� ������ ����( ��:comm �� 50 �̸� ���� :50)
-- empno, ename, comm, comm_txt ���
-- decode ���
select empno, ename, comm, 
    decode(comm, null, '�ش���� ����',
                 0, '�������',
                '���� : '|| comm ) as comm_txt
from emp;

-- case when ~ then ���
select empno, ename, comm, 
    case 
         when to_char(comm) is null then '�ش���� ����'
         when to_char(comm) = '0' then '���� ����'
         else '���� : ' || to_char(comm) 
    end comm_txt
from emp;

-- professor ���̺�
select * from professor;
-- 1. professor ���̺��� ������(name)�� �а���ȣ(deptno), �а��� ���
-- deptno = 101�̸� '��ǻ�Ͱ��а�'
-- case������
select name, deptno,
    case deptno
        when 101 then '��ǻ�Ͱ��а�'
        else ''   -- �� �� ��������
    end �а���
from professor;
    
-- decode������
select name, deptno,
    decode(deptno, 101, '��ǻ�Ͱ��а�', null) �а���   --else�� �Ƚᵵ ��.
from professor;
-- 2. professor ���̺��� ������(name)�� �а���ȣ(deptno), �а��� ���
-- deptno = 101�̸� '��ǻ�Ͱ��а�' ������ �а��� ��Ÿ ��� 
-- case��
select name, deptno,
    case deptno
        when 101 then '��ǻ�Ͱ��а�'
        else '��Ÿ'
    end �а���
from professor;
-- decode������
select name, deptno,
    decode(deptno, 101, '��ǻ�Ͱ��а�', '��Ÿ') �а��� 
from professor;

-- 2. professor ���̺��� ������(name)�� �а���ȣ(deptno), �а��� ���
-- deptno = 101�̸� '��ǻ�Ͱ��а�' 102�� ��Ƽ�̵����а�
-- 201�̸� ����Ʈ������а� / �������� ��Ÿ
-- case��
select name, deptno,
    case deptno
        when 101 then '��ǻ�Ͱ��а�'
        when 102 then '��Ƽ�̵����а�'
        when 201 then '����Ʈ������а�'
        else '��Ÿ'
    end �а���
from professor;
-- decode������
select name, deptno,
    decode(deptno, 101, '��ǻ�Ͱ��а�',102, '��Ƽ�̵����а�', 201, '����Ʈ������а�', '��Ÿ') �а��� 
from professor;

---------student ���̺�
select * from student;
--�л��� 3�� ������ �з��ϱ� ���� �й�(studno)�� 3���� ������
-- �������� 0�̸� A��, 1�̸� B��, 2�̸� C��
-- �л���ȣ(studno), �̸�(name), �а���ȣ(deptno1), ���̸�(teamName) ���
-- case��
select studno, name, deptno1, 
    case mod(studno,3)
        when 0 then 'A��'
        when 1 then 'B��'
        else 'C��'
    end teamName
from student;
-- decode��
select studno, name, deptno1, 
    decode( mod(studno,3), 0 ,'A��',1,'B��', 'C��')  teamName
from student;

-- 1. �л����̺��� jumin 7������ 1�̸� ����, 2�̸� ����
-- �й�(studno), �̸�(name), �ֹ�(jumin), ����
select studno, name, jumin,
    decode( substr(jumin, 7, 1), 1, '����',
                                 2, '����') ����
from student;

select studno, name, jumin,
    decode(substr(jumin, 7, 1), '1', '����', '2', '����') ����
from student;

-- 2 tel�� ������ȣ���� 02 ����, 051 �λ�, 052 ���, 053 �뱸
-- �������� ��Ÿ�� ���
-- �̸�, ��ȭ��ȣ, ���� ���
select name, tel, 
    case decode( substr(tel,2,1) , '2', substr(tel,1,2), substr(tel,1,3)) 
        when '02' then '����'
        when '051' then '�λ�'
        when '052' then '���'
        when '053' then '�뱸'
        else '��Ÿ'
    end ����
from student;

select name, tel, 
    decode(substr(tel,1,3),
    '02)','����',
    '051','�λ�',
    '052','���',
    '053','�뱸',
    '��Ÿ')����
from student;

select name, tel, 
    case substr(tel,1,instr(tel, ')')-1) 
        when '02' then '����'
        when '051' then '�λ�'
        when '052' then '���'
        when '053' then '�뱸'
        else '��Ÿ'
    end ����
from student;

select name, jumin, rpad(substr(jumin, 1, 7), length(jumin), '*') �ֹι�ȣ,
    substr(jumin, 1, 7) || '-' || substr(jumin, 7) �ֹι�ȣ1
from student;

-- �ߺ� ���� distinct()
select distinct(sal) from emp;

----- �׷��Լ� = �������Լ� = �������Լ�(�ϳ��� ���� ��°���� ��� �Լ�)(p177~) ------
-- sum() : �հ踦 �������
select sum(sal), sum(comm) from emp;

-- count () : �ڷ��� ������ �˷���
select count(*) from emp;
select count(sal) from emp;
-- ��, null���� ������ ����
select count(comm) from emp;

-- �ߺ� �����ϰ� ���� ���ϱ�
select count(distinct(sal)) from emp;

-- �������� : emp ���̺��� �μ���ȣ(deptno)�� 30���� ��� ��
select count(*)
from emp
where deptno = 30;

-- comm �� null �� �ƴ� ��
select count(comm) from emp;
select 
count(comm) 
from emp
where comm is not null;

-- comm�� null �� ����
-- ���⿡�� count(comm)�� 0�� ������ comm �� null���� �̾Ҵµ� null�� ������ �����༭
select count(*), count(comm)
from emp
where comm is null;


-- ���� �߻�
-- select ename, sum(sal) from emp;

select count(sal), count(distinct(sal)), count(all(sal))
from emp;

-- max() : �ִ밪
select sal from emp;
select max(sal) from emp;

-- min() : �ּҰ�
select min(sal) from emp;
select max(sal), min(sal) from emp;

-- avg() : ���
select avg(sal) from emp;
-- ����� �ݿø��ؼ� �Ҽ� ù��°���� ���
select avg(sal), round(avg(sal), 1) from emp;

-- �μ���ȣ�� 20�� ��� �߿��� �Ի����� ���� �ֱ��� ��� ���
select max(hiredate) 
from emp
where deptno =20;

-- professor ���̺���
-- 1. �� ���� �� ���
select count(*)
from professor;

-- 2. ���� �޿� �հ�
select sum(pay) "�޿� �հ�"
from professor;

-- 3. ���� �޿� ���
select sum(pay)/count(*) "�޿� ���"
from professor;

-- 4. ������ �޿��� ����� �Ҽ��� ù° �ڸ����� �ݿø�
select round(avg(pay))
from professor;

-- 5. �ְ� �޿�
select max(pay)
from professor;

-- 6. ���� �޿�
select min(pay)
from professor;

-- 7. ���� �� �ְ� �޿��� �޴� ������ �̸�(name)�� �޿�(pay) ���
-- ����� ���ڵ� max/min �Լ� ���밡��(������ �迭��)
-- �̷��� �ϸ� ���ε��� max���� ������ ��.
select max(name), max(pay)  from professor;
--
select name, pay
from professor
where pay = (select max(pay) from professor);

-- 8. ���� �޿� �հ踦 ���, õ ���� ��ǥ ���
select to_char(sum(pay), '999,999') SUM_PAY
from professor;

-- emp ���̺���
-- 1. 10�� �μ�(deptno) �� ��� �޿�
select to_char(avg(sal), '999,999') AVG_SAL
from emp
where deptno = 10;
-- 2. 20�� �μ�(deptno) �� ��� �޿�
select to_char(avg(sal), '999,999') AVG_SAL
from emp
where deptno = 20;
-- 3. 30�� �μ�(deptno) �� ��� �޿�
select to_char(avg(sal), '999,999') AVG_SAL
from emp
where deptno = 30;

-- �μ���ȣ�� 10, 20, 30 �� �μ��� ��� �޿�
-- ���տ����� Ȱ��(�μ��� ����� ����)
select to_char(avg(sal), '999,999') AVG_SAL from emp where deptno = 10
union
select to_char(avg(sal), '999,999') AVG_SAL from emp where deptno = 20
union
select to_char(avg(sal), '999,999') AVG_SAL from emp where deptno = 30;

-- in �Լ� ���(3���� �μ��� ��ü ����� ����)
select to_char(avg(sal), '999,999') AVG_SAL from emp where deptno in(10, 20, 30);

-- group by ������ : ���� �������� ���� ģ���鿡 ���� �׷��Լ��� �ǽ���.
-- �μ��� ��� �޿�
select deptno "�μ���ȣ(��������)", round(avg(sal)) "�μ��� ��� �޿�"
from emp
group by deptno
order by deptno desc;

select * from emp;
-- �μ���(deptno) �� ���޺�(job) ��ձ޿�
select deptno "�μ���ȣ(��������)", job "����", round(avg(sal)) "�μ��� ��� �޿�"
from emp
group by deptno, job
order by deptno desc, "�μ��� ��� �޿�" desc;

-- professor ���̺���
-- 1. �а���(deptno) �������� ��� �޿�(pay)
select deptno, round(avg(pay))
from professor
group by deptno;
-- 2. �а���(deptno) �������� �޿� �հ�
select deptno, round(sum(pay))
from professor
group by deptno;
-- 3. �а���(deptno) ���޺�(position) �������� ��� �޿�
select deptno, position, round(avg(pay))
from professor
group by deptno, position
order by deptno, position;
-- 4. ���� �߿��� �޿�(pay)�� ��������(bonus)�� ��ģ �ݾ��� ���� ���� ���� ���� ���� ��� ���
--    ��, bonus �� ���� ������ �޿��� bonus�� 0���� ���
--    �޿�(��ģ�ݾ�)�� �Ҽ� ��° �ڸ����� �ݿø�
select 
max(round(pay + nvl(bonus, 0),1)) "�ִ� �޿�", 
min(round(pay + decode(bonus, null, 0, bonus),1)) "�ּ� �޿�"
from professor;
-- 5. ����(position)�� ��� �޿�(pay)�� 300 ���� ũ�� '���',
--    �۰ų� ������ '����'
--    ����(position), ��� �޿�, ��� ���
select 
position ����,
round(avg(pay)) "��� �޿�",
case 
    when avg(pay) > 300 then '���'
    when avg(pay) <= 300 then '����'
end "���"
from professor
group by position;

--emp ���̺��� �Ի�⵵�� �ο���
-- total  1980�⵵ 1981�⵵ 1982�⵵
-- 12      1        10      1
select count(*) total,
    sum( decode(to_char(hiredate,'YYYY'),1980,1,0) ) "1980�⵵",
    sum( decode(to_char(hiredate,'YYYY'),1981,1,0) ) "1981�⵵",
    sum( decode(to_char(hiredate,'YYYY'),1982,1,0) ) "1982�⵵"
from emp;
select count(*) total,
    count( decode(to_char(hiredate,'YYYY'),1980,2,null) ) "1980�⵵",
    count( decode(to_char(hiredate,'YYYY'),1981,3,null) ) "1981�⵵",
    count( decode(to_char(hiredate,'YYYY'),1982,4,null) ) "1982�⵵"
from emp;

-- emp ���̺��� 1000 �̻��� �޿��� ������ ����� ���ؼ��� �μ��� ��� ���ϵ�
-- �� �μ��� ����� 2000 �̻��� �μ���ȣ, �μ��� ��� �޿� ���
select 
deptno,
round(avg(sal))
where sal >=1000
group by deptno
having avg(sal) >= 2000;

-- professor ���̺�
-- 1. �а���(deptno)�� �Ҽ� �������� ��� �޿�, �ּ� �޿�, �ִ� �޿� ���ϱ�
--  ��, ��ձ޿��� 300 �Ѵ� �͸� ���
select deptno, round(avg(pay)), min(pay), max(pay)
from professor
group by deptno
having avg(pay) >= 300 ;

-- 2. �а���(deptno) ���޺�(position) �������� ��� �޿� ���ϱ�
-- ��� �޿��� 400 �̻��� �͸� ��� ==> �а���ȣ, ����, ��ձ޿�
select deptno, position, round(avg(pay)) "��ձ޿�"
from professor
group by deptno, position
having avg(pay) >= 400;

-- student ���̺�
-- 3. �г⺰(grade) �л���, ��� Ű, ��� ������ ���ϱ�
-- ��, �л����� 4�� �̻��� �͸� ���
select grade, count(*) �л���, round(avg(height)) "��� Ű", round(avg(weight)) "��� ������"
from student
group by grade
having count(*)>=4
order by "��� Ű" desc;

-- p196
-- 1. �μ� �� ���޺� 
select deptno, job, count(*), max(sal), min(sal), sum(sal), avg(sal)
from emp
group by deptno, job
order by deptno, job;

-- group �� �Ұ踦 �̾� ���� ���� �� : 
-- rollup(A,B) : A,B / A�� ���� �Ұ踦 ���
-- rollup(A,B,C) A,B,C / A,B / C �� ���� �Ұ谡 ���
select deptno, job, count(*), max(sal), min(sal), sum(sal), avg(sal)
from emp
group by rollup(deptno, job)
order by deptno, job;
-- group�� �Ұ踦 ����ȭ �Ͽ� ���� ���� �� : 
-- cube(A,B) : A,B / A / B�� ���� �Ұ谡 ��� 
-- cube(A,B,C) : A,B,C / A,B / A,C / B,C / A / B / C �� ���� �Ұ谡 ��� ���
select deptno, job, count(*), max(sal), min(sal), sum(sal), avg(sal)
from emp
group by cube(deptno, job)
order by deptno, job;

-- emp���̺���
-- �μ��� ���޺� ��� �޿� �� ��� �� ���ϱ�
-- ��, �μ��� ��ձ޿��� �����, ��ü����� ��ձ޿��� ��� �� ���
select deptno, job, round(avg(sal)), count(*)
from emp
group by rollup(deptno, job)        -- �μ���, ��ü �Ұ� ���
order by deptno, job;
select deptno, job, round(avg(sal)), count(*)
from emp
group by rollup(job, deptno)        -- ���޺�, ��ü �Ұ� ���
order by  job, deptno;

-- �μ� �� ���޺� ��� �޿��� ��� �� ���
-- ��, �μ��� ��� �޿��� �����, ���޺� ��� �޿��� �����, ��ü����� ��ձ޿��� ��� ��
select deptno, job, round(avg(sal)), count(*)
from emp
group by cube(deptno, job)        -- �μ���, ��ü �Ұ� ���
order by deptno, job;

--------------------------------  p215 ����  ------------------------------------
select * from emp;    --12�� 
select * from dept;   -- 4��
-- SMITH�� �ٴϴ� �μ��� ���
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
-- �����ȣ(empno), ����̸�(ename), ����(job), �μ���(dname), ����(loc)
-- �����
select empno, ename, job, dname, loc, e.deptno
from emp e, dept d
where e.deptno = d.deptno;

select * from salgrade;

-- ������ 
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

--- ��ü����(��������)
-- ����� ���(mgr)�� ���� ���
select e1.empno �����ȣ, e1.ename ����̸�, e1.mgr ����ȣ, e2.empno �������ȣ, e2.ename ����̸� 
from emp e1, emp e2
where e1.mgr = e2.empno
order by e1.empno;






--1. ACCOUNTING(dname) �μ� �Ҽ� ����� �̸��� �Ի��� ��� 
select * from dept;
select * from emp;

select empno, hiredate, dname, e.deptno
from emp e, dept d
where e.deptno = d.deptno and dname = 'ACCOUNTING';
---SQL-00 ǥ�ع���
select empno, hiredate
from emp e join dept d 
            on e.deptno = d.deptno
where dname = 'ACCOUNTING';

-- 2. 0���� ���� comm �� �޴� ����̟��� �μ��� ���
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

-- 3. ������ �Ŵ����� �����Դϴ�.
-- ��) SMITH �� �Ŵ����� FORD �Դϴ�.

select e.ename ���, m.ename ���
from emp e, emp m
where e.mgr = m.empno
order by e.ename;

select e.ename||'�� �Ŵ�����'||m.ename||'�Դϴ�.' ���_���
from emp e, emp m
where e.mgr = m.empno
order by e.ename;

select e.ename||'�� �Ŵ�����'||m.ename||'�Դϴ�.' ���_���
from emp e join emp m
on e.mgr = m.empno
order by e.ename;



