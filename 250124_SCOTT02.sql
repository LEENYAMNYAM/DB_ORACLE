--p125~126��������
Select * from emp;

--1.Emp ���̺��� ����̸�(ename)�� S�� ������ ����� ���� ���
Select * from emp where ename LIKE '%S';

--2. Emp ���̺��� 30�� �μ� �� ��å(job)��  SALESMAN�� 
--�����ȣ(empno), �̸�(ename) , ��å(job), �޿�(sal), �μ���ȣ(deptno)
select empno, ename, job, sal, deptno from emp where (deptno = 30 and job ='SALESMAN');

--3.20��, 30�� �μ��� �ٹ��ϸ鼭 �޿��� 2000 �ʰ��ϴ� �����
-- �����ȣ(empno), �̸�(ename) , ��å(job), �޿�(sal), �μ���ȣ(deptno)
--1) ���տ����� ���
select empno, ename, job, sal, deptno from emp where deptno = 20 union 
select empno, ename, job, sal, deptno from emp where deptno = 30 intersect 
select empno, ename, job, sal, deptno from emp wheresal > 2000);  

--2) ���տ����� �̻��
select empno, ename, job, sal, deptno from emp where deptno in (20, 30) and sal >2000;

--4.�޿��� 2000�̻� 3000 ���� ���� �̿�  not between a and b ������� �ʱ�
select * from emp where sal<2000 or sal <=3000;

--5.����̸��� E �� ���ԵǾ� �ִ� 30�� �μ��� ��� �� �޿��� 1000~2000 ���̰�
--�ƴ� ����̸�, �����ȣ, �޿�, �μ���ȣ ���
select ename, empno, sal, deptno
from emp
where ename like '%E%'
    and deptno =30
    and sal not between 2000 and 3000;

--6. �߰����� ���� ���� �ʰ� ����� �ְ� MANAGER CLERK �߿��� 
--����̸��� �ι� ° ���� L �ƴ� ���� ���