-- emp ��� ���� ��ȸ
select * from emp;
-- dept ��� ���� ��ȸ

-- dept���̺� : �μ� ���� ���̺�
-- emp ���̺� : ��� ���� ���̺�
select * from dept;
-- 1. �μ���ȣ(deptno) �� 10���� ��� ��������� ���
select * from emp where deptno = 10;
-- 2. �μ���ȣ(deptno) �� 10���� �̸�(ename), �Ի���(hiredate), �μ���ȣ(deptno)

select ename, hiredate, deptno from emp where deptno =10;
-- 3. �����ȣ(empno) �� 7369�� ����� �̸�, �Ի���, �μ���ȣ ���
select ename, hiredate, deptno from emp where empno = 7369;
-- 4. �̸�(ename)�� allen�� ����� ��� ���� ���
-- ��ɾ�� �������� ��ҹ��� ������ ������, �����Ͱ��� ��/�ҹ��ڱ�����
select * from emp where ename = 'ALLEN';
SELECT * FROM EMP WHERE ENAME = 'ALLEN';

-- 5. �Ի���(hiredate)�� 19980 12 17�� ����� �̸�(ename), �μ���ȣ(deptno),����(sal) ���
select ename, deptno, sal from emp where hiredate = '1980/12/17';
select ename, deptno, sal from emp where hiredate = '80/12/17';
-- 6. ����(job)�� MANAGER �� ����� ��� ���� ���
select * FROM emp where job = 'MANAGER';
-- 7. ����(job)�� MANAGER �� �ƴ� ����� ��� ���� ���
select * FROM emp where job != 'MANAGER';
select * FROM emp where job <> 'MANAGER';
-- 8. �Ի���(hiredate)�� 81/04/02 ���Ŀ� �Ի��� ����� ��� ���� ���
select * from emp where hiredate >= '81/04/02';
describe emp;
desc emp;
-- 9. �޿�(sal)�� 1000 �̻��� ����� �̸�(ename), �޿�(sal), �μ���ȣ(deptno)��ȸ
select ename, sal, deptno from emp where sal >= 1000;
select * from emp where sal >= 1000;
-- 10. �޿�(sal)�� 1000 �̻��� ����� �̸�(ename), �޿�(sal), �μ���ȣ(deptno)��ȸ
-- �޿��� ���� ������ ���(desc : ��������, asc : ��������(�⺻��))
select ename, sal, deptno 
from emp 
where sal >= 1000
order by sal asc;

select ename, sal, deptno 
from emp 
where sal >= 1000
order by sal desc;

-- �޿��� ������������ ��� / �޿��� ���ٸ� �̸����� ��������
select ename, sal, deptno 
from emp 
where sal >= 1000
order by sal desc, ename asc;

-- 11. �̸��� 'K'�� �����ϴ� ������� ���� �̸��� ���� ����� ��� ����
select * from emp where ename > 'K';

-- ���տ�����
-- union : ������
-- minus : ������
-- intersect : ������ 
-- emp ���̺��� �μ���ȣ�� 10�� �����ȣ(empno), �̸�(ename), �޿�(sal), �μ���ȣ(deptno) ���
-- emp ���̺��� �μ���ȣ�� 20�� �����ȣ(empno), �̸�(ename), �޿�(sal), �μ���ȣ(deptno) ���
-- emp ���̺��� �μ���ȣ�� 10�̰ų� 20�� �����ȣ(empno), �̸�(ename), �޿�(sal), �μ���ȣ(deptno) ���
SELECT empno, ename, sal, deptno from emp where  deptno = 10;
SELECT empno, ename, sal, deptno from emp where  deptno = 20;
SELECT empno, ename, sal, deptno from emp where  deptno = 10 
union
SELECT empno, ename, sal, deptno from emp where  deptno = 20;

-- ��� �μ��߿��� 20�� �μ��� �����ϰ� ���(���տ�����Ȱ��)
SELECT * from emp
Minus
select * from emp where  deptno = 20;

-- ��� �μ��߿��� 20�� �μ� ���(������ ������ Ȱ��)
SELECT * from emp
intersect
select * from emp where  deptno = 20;


-- 12. �μ���ȣ�� 10�̰ų� 20�� �μ��� ��� ������ ���
-- or ������ ����ؼ� ���
select empno, ename, sal, deptno from emp where deptno = 10 or deptno = 20;
-- in�� ����ϸ� deptno�� �������� ���ÿ� ��°���
select empno, ename, sal, deptno from emp where deptno in (10, 20);


-- 13. ����̸��� s�� ������ ����� ��� ���� ��ȸ
-- %�� �̿��ϸ� ������ �տ� * �ǹ̸� ����.
-- ��Ȯ�� ���� �ƴϹǷ� ��ȣ��ſ� like�� ����ؾ���.
select * from emp where ename like '%S';

-- 14. 30�� �μ����� �ٹ��ϴ� ��� �� job�� SALESNAM �����
--     �����ȣ(empno), �̸�(ename), ��å(job), �޿�(sal) �μ���ȣ(deptno) ��ȸ
-- and ������ ����ؼ� ���
select empno, ename, job, sal, deptno from emp where deptno = 30 and job = 'SALESMAN';
-- intersect(������ ������) ����ؼ� ���
select empno, ename, job, sal, deptno from emp where deptno = 30
intersect
select empno, ename, job, sal, deptno from emp where job = 'SALESMAN';

-- 15. 30�� �μ����� �ٹ��ϴ� ��� �� job�� SALESNAM �����
--     �����ȣ(empno), �̸�(ename), ��å(job), �޿�(sal) �μ���ȣ(deptno) ��ȸ
--     �޿��� ���� ������ ��ȸ
select empno, ename, job, sal, deptno 
from emp 
where deptno = 30 and job = 'SALESMAN' 
order by sal desc;

-- 15. 30�� �μ����� �ٹ��ϴ� ��� �� job�� SALESNAM �����
--     �����ȣ(empno), �̸�(ename), ��å(job), �޿�(sal) �μ���ȣ(deptno) ��ȸ
--     �޿��� ���� ������ ���, �޿��� ���ٸ� �����ȣ�� ���� ������ ���
select empno, ename, job, sal, deptno 
from emp 
where deptno = 30 and job = 'SALESMAN' 
order by sal desc, empno asc;
--------------------------------������� ����------------------------------------
-- [20��, 30�� �μ��� �ٹ��ϴ� ��� �߿���
-- �޿�(sal)�� 2000 �ʰ��ϴ� ����� �����ȣ(empno), �̸�(ename), �޿�(sal), �μ���ȣ(deptno) ���
-- 17. ���տ����ڸ� ����ؼ�
select empno, ename, sal, deptno from emp where sal > 2000
intersect
(select empno, ename, sal, deptno from emp where deptno = 20
union
select empno, ename, sal, deptno from emp where deptno = 30);

-- 18. ���տ����ڸ� ������� �ʰ�
select empno, ename, sal, deptno from emp where deptno in(20,30) and  sal > 2000;

-- 19. �޿�(sal) �� 2000 �̻� 3000 ���� ������ ��� ���� ���
select * from emp where sal>=2000 and sal <=3000;
-- between ~ and ~  �� ����� ���� ����.
select * from emp where sal between 2000 and 3000;

-- 20. �޿�(sal) �� 2000 �̻� 3000 ���� ���� �̿��� ��� ���� ���
select * from emp where sal<2000 or sal >3000;
-- not between ~ and ~ �� ��� �� ���� ����.
select * from emp where sal not between 2000 and 3000;

-- 21. ����̸�, �����ȣ, �޿�, �μ���ȣ ���
select ename, empno, sal, deptno from emp;

-- ���� ��Ī�����ϱ�(as ��������, �ֵ���ǥ ��������, �� ������ �Բ� ������ �ֵ���ǥ �����
select ename as ����̸�, empno as �����ȣ, sal �޿�, deptno "�μ� ��ȣ"
from emp;
-- ������ �ַ� �Ʒ��� ���� �����(���� ��ſ� _���)
select ename ����̸�, empno �����ȣ, sal �޿�, deptno �μ�_��ȣ
from emp;

-- 22. ����̸��� E�� ���ԵǾ� �ִ� 30�� �μ� ��� �߿���
--     �޿��� 1000~2000 ���̰� �ƴ� ��� ���
select ename ����̸�, empno "��� ��ȣ", sal �޿�, deptno "�μ� ��ȣ" 
from emp
where (sal < 1000 or sal > 2000) 
       and ename like '%E%' 
       and deptno = 30;

-- 23. �ְ�����(comm)�� �������� �ʴ� ��� ���� ���
-- null���� �̾Ƴ� ���� is null�����. = null �ȵ�!
select * 
from emp 
where comm is null;
--     �ְ�����(comm)�� �����ϴ� ��� ���� ���
select * 
from emp 
where comm is not null;
-- �ְ������� 0�� ����� �����ϰ� ���� ��
select * 
from emp 
where comm is not null and comm != 0;




-- 25. �ְ�����(comm)�� �������� �ʰ�, �����(mgr)�� �ְ�, 
-- ������ MANAGER, CLERK �� ���  �߿��� 
-- ����̸��� �ι�° ���ڰ� L�� �ƴ� ��� ���� ���

-- ������ _�� ���� ������ �ѱ��ڸ� ����.
select * 
from emp  
where comm is null 
       and mgr is not null 
       and job in ('MANAGER', 'CLERK') 
       and ename not like '_L%';

--------------------------p128 ����Ŭ�Լ�(�����Լ�) ------------------------------
-- <���ڿ� ���� �����Լ�>
-- upper(������) : �빮�ڷ� �ٲ��ִ� �����Լ�
-- lower(������) : �ҹ��ڷ� �ٲ��ִ� �����Լ�
-- initcap(������) : ù���ڸ� �빮�ڷ� �ٲ��ִ� �����Լ�

select * from emp;
select ename, upper(ename) as �빮��, lower(ename) �ҹ���, initcap(ename)
from emp ;

--<�� ��>
-- length(������) : �̸��� ���ڼ��� �˷���
select ename, length(ename) �̸����ڼ� from emp;
-- ����̸�(ename)�� 5���� �̻��� ����� �̸�(ename), ���ڼ� ���
select ename, length(ename) �̸����ڼ� from emp where length(ename)>=5;

-- �̸� ����
-- substr(������,������ġ,����) : ������ �Ϻκи� �����ؼ� ���, ������ �Ⱦ��� ������ ���
select ename ,substr(ename, 1, 2), substr(ename, 3, 2), substr(ename, 3), 
        substr(ename, 3, length(ename)),
        length(substr(ename, 3)), length(substr(ename,3,length(ename)))
        -- �ΰ��� ����� ���ڼ��� ����.-> �ڿ� �������
        from emp;
        
--------------------------------------------------------------------------------
-- dual : ����ִ� ���̺��� ������ִ°� ����.
select 'CORPORATE'
from dual;

-- ��ġ�� ����
-- instr(���� or ������, ã�� ����, ��𼭺��� , ���°�� ��ġ�ϴ��� ) : �� ������ ��ġ�� ������ ����
select instr('CORPORATE FLOOR', 'OR', 1, 1)
from dual;
select instr('CORPORATE FLOOR', 'OR')       -- �ڸ� �����ϸ� ���Ƕ�� �Ȱ�����(1,1)�� �Ǵ���.
from dual;
select instr('CORPORATE FLOOR', 'OR', 1, 2)  -- �ι�°�� OR �� ������ ������ ������ �� O�� ��ġ�� ��ȯ
from dual;
select instr('CORPORATE FLOOR', 'OR', -1, 2)  -- -1�� ���⿡ ���� �ڿ��� ���� 2��°�� ������ OR ���� ��ġ�� ��ȯ
from dual;
select instr('CORPORATE FLOOR', 'OR', -3, 1)  -- -3�̹Ƿ� �ڿ��� 3��°���ں��� �����ؼ� OR�� 1��° ������ O�� ��ġ�� ��ȯ
from dual;
select instr('CORPORATE FLOOR', 'OR', -3, 2)  -- -3�̹Ƿ� �ڿ��� 3��°���ں��� �����ؼ� OR�� 2��° ������ O�� ��ġ�� ��ȯ
from dual;
-- ���ڿ� ABCDDEF ���� D�� ��ġ�� ���
-- ó������ => 4
select instr('ABCDDEF', 'D') from dual;
select instr('ABCDDEF', 'D', 1, 1) from dual;
-- ������  => 5
select instr('ABCDDEF', 'D', -1, 1) from dual;
-- emp ���̺��� ename �� s�� �ִ� ��ġ ���
select ename, instr(ename, 'S'), instr(ename, 'S',-1,1)
from emp;
-- emp���̺��� ����̸��� s�� ����ִ� �̸��� ���(instr �Լ� ���)
select * from emp where ename like '%S%';  -- like '%S%'�� �̿��Ͽ�
select ename from emp where instr(ename, 'S') > 0;
-- emp ���̺��� ename ���(�̸��� 2���ڸ� �����Ͽ� �ҹ��ڷ� ��ȯ�Ͽ� ���) 
select ename, lower( substr(ename,1,2) ) �ҹ���1, substr(lower( ename ),1,2) �ҹ���2 from emp;

-- Replace(�ٲ� ������ or �����Ͱ�, �ٲܹ���, �ٲ���) : 
select '010-1234-5678' as rep_before,
    replace('010-1234-5678', '-', ' ') as rep_after
from dual;
--emp ���̺��� s�� �ҹ��� s�� �����Ͽ� ���(replace �Լ� ���)
select ename, replace(ename, 'S', 's') 
from emp;

-- lengthB : ����Ʈ�� �����Ʈ���� �˷���
------------------------------------------
select length('�ѱ�'), lengthB('�ѱ�')
from dual;

select 'Oracle', length('Oracle'), lengthB('Oracle')
from dual;

-- LPAD(������ or ������, ����ڷ� ���鷡?, ���ʺ�ĭ�� �� ä�﷡?) ������ �������� �������� ä����
-- RPAD(������ or ������, ����ڷ� ���鷡?, �����ʺ�ĭ�� �� ä�﷡?) ������ �������� �������� ä����
select 'Oracle' , LPAD('Oracle', 10, '#') LPAD1,
                  RPAD('Oracle', 10, '#') RPAD1,
                  LPAD('Oracle', 10) LPAD2, length(LPAD('Oracle', 10)),
                  RPAD('Oracle', 10) RPAD2, length(RPAD('Oracle', 10))
from dual;
-- ������ ��� 10���ڰ� �Ǿ��� LPAD1�� ���ʺ�ĭ�� #����, RPAD1�� ������ ��ĭ�� #����
--                          LPAD2�� ���ʿ� �����̽���, RPAD2�� �����ʿ� ��ĭ�� ��.
-- ���� : emp ���̺��� �����ȣ(��2�ڸ� ���� ������ '*') ��Ī�� �����ȣ,
-- ����̸� ��Ī�� ����̸� (ù 2���ڸ�) ������ �������� '*'�� ��� 

select RPAD(substr(empno, 1, 2), length(empno) , '*') �����ȣ, 
       RPAD(substr(ename, 1, 2), length(ename) , '*')  ����̸�  
from emp;
-- p141
select rpad('971225-',14,'*') as RPAD_JMNO,
       rpad('010-1234-',13,'*') as RPAD_PHONE
from dual;
--------------------------------------------------------------------------------
-- SCOTT ���̺� �߰�.txt ������ �߰�����.

select * from student;
-- 1. jumin 7510231901810  ==> 751023*******
select name, RPAD(substr(jumin, 1,6), length(jumin), '*') JUMIN_NO from Student;

-- 2. tel 055)381-2158   ==> 055-381-2158
select tel, name, replace( tel , ')', '-') from Student;

-- 3. Ű(height)�� 170�̻��� �л��� studno, name, grade, height, weight ���
-- ��, Ű�� ū �л������� ���, ���� Ű�� ���ٸ� studno�� ���� ������ ���
select studno, name, grade, height, weight 
from student 
where height >= 170 
order by height desc, studno asc;

-- 4. ���� porfessor ���̺��� ���ʽ��� ���� ���ϴ� ��� ���
--    ������ȣ(profno), �̸�(name), ����(pay), ���ʽ�(bonus) ������ ���
select profno ������ȣ, name �̸�, pay ����, bonus ���ʽ� 
from professor 
where bonus is null;

-- 5. ���� professor ���̺��� email�߿��� ���̵� ���
-- (@�ձ����� ��� : captain@abc.net ==> captain)
select name �̸�, email �̸���, substr(email, 1 , instr(email, '@')-1) ���̵� 
from professor;



