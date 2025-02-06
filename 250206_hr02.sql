-- hr ��������

-- ALTER SESSION set "_ORACLE_SCRIPT" = TRUE;  
-- C##�Ⱦ��� �����ϰ� ����

-- CREATE USER hr IDENTIFIED BY TIGER;
-- ���� ����

-- �ο��� ��(cunnect�� resouce), ���Ѻο�(unlimitted tablespace) �ϰ� �ʷϻ�+������ ������ �ϸ� ��.

-- ���ο� sql���� ���� ���ҽ�(������ �߰�)
-- @D:\JMT\DB\workspace\hr_test_data2.sql;

-- Professor ���̺�
-- 1. �а���(deptno)�� �Ҽ� �������� ��ձ޿�, �ּұ޿�, �ִ�޿� ���(pay��)
-- ��, ��ձ޿��� 300 �Ѵ� �͸� ���
select round(avg(pay)) ��ձ޿�, min(pay) �ּұ޿�, max(pay) �ִ�޿� 
from professor
having avg(pay) > 300
group by deptno;

-- 2. student ���̺�
-- �г�, �л���, ���Ű, ��� �����Ը� ����ϵ�
-- �л� ���� 4�� �̻��� �г⿡ ���ؼ� ���
-- ��, ��� Ű�� ��� �����Դ� �Ҽ��� ù��° �ڸ����� �ݿø�
-- ��� ������ ���Ű�� ���� ������ ������������ Ǯ��
select * from student;
select grade �г�, count(studno) "�л� ��", round(avg(height)) "��� Ű", round(avg(weight)) "��� ������" 
from student
group by grade
having count(studno) >= 4
order by avg(height) desc;

-- 3. professor, student ���̺�
-- �л��̸�(name) �������� �̸�(name) ���
select s.name �л��̸�, p.name ��������
from student s, professor p
where s.profno = p.profno;

select s.name �л��̸�, p.name ��������
from student s join professor p
on s.profno = p.profno;

-- gift, customer ���̺�
-- 4. ���̸�(gname), ����Ʈ(point), ����(gname)
select c.gname ���̸�, c.point ����Ʈ, g.gname ����
from gift g, customer c
where c.point between G_START and G_END;

select c.gname ���̸�, to_char(c.point,'999,999') ����Ʈ, g.gname ����
from gift g join customer c
on c.point between G_START and G_END;

-- student, score ���̺�
-- 5. �л����� �̸�(name), ����(total), ����(grade) ���
select st.name �̸�, sc.total ����, ha.grade ����
from student st, score sc, hakjum ha
where st.studno = sc.studno 
      and sc.total between min_point and max_point;

select st.name �̸�, sc.total ����, ha.grade ����
from student st join score sc on st.studno = sc.studno
                join hakjum ha on sc.total between min_point and max_point;

-- student, professor ���̺�
-- 1. �л��̸��� �������� �̸� ��� �ϵ� ���������� �������� ���� �л� �̸��� ���
--SQL-99 �������
select s.name �л��̸�, p.name "�������� �̸�" 
from student s, professor p 
where s.profno = p.profno(+);
--SQL-99��� 
    -- natural join�� �̸��� ���� Į���� 2��(profno, name)�� �Ұ�����.
    -- using �̿�
select s.name �л��̸�, p.name "�������� �̸�" 
from student s left outer join professor p using(profno);
    -- join on �̿�
select s.name �л��̸�, p.name "�������� �̸�" 
from student s left outer join professor p 
                            on s.profno = p.profno;
                            
-- 2. 101(deptno1)�� �а��� �Ҽӵ� �л� ���
-- ��, ���������� ���� �л��� ���(�а���ȣ, �л��̸�, ���������̸�)
-- SQL-99 �������
select s.deptno1, s.name, p.name
from student s, professor p
where s.profno = p.profno(+)
    and s.deptno1 = 101;
--SQL-99����
    -- using �̿�
select s.deptno1, s.name, p.name
from student s left outer join professor p using(profno)
where s.deptno1 = 101;
    -- join on
select s.deptno1, s.name, p.name
from student s left outer join professor p 
                            on s.profno = p.profno
where s.deptno1 = 101;

-- 3. dept2, emp2 ���̺��� area �� Seoul Branch Office �� �����
-- �����ȣ(empno), �̸�(name), �μ���ȣ(deptno) ���
-- �������� �̿�
select empno �����ȣ, name �̸�, deptno �μ���ȣ
from emp2
where deptno in (select dcode
                 from dept2
                 where area like 'Seoul%');
--SQL-99�������                 
select empno �����ȣ, name �̸�, deptno �μ���ȣ
from dept2 d, emp2 e 
where d.dcode = e.deptno
    and area like 'Seoul%';
-- join on�̿�
select empno �����ȣ, name �̸�, deptno �μ���ȣ
from dept2 d join emp2 e on d.dcode = e.deptno
where area like 'Seoul%';

-- 4. Student ���̺��� �� �г⺰ �ִ� �����Ը� ���� �л��� �г�, �̸�, ������ ���
select grade �г�, name �̸�, weight ������
from student
where weight in (select max(weight) from student group by grade);

select grade �г�, name �̸�, weight ������
from student
where (grade, weight) in (select grade, max(weight) from student group by grade);












