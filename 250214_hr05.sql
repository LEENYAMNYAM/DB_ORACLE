--1. Professor ���̺��  department ���̺�
--������ȣ(profno)�� �����̸�(name), �Ҽ��а��̸�(dname)�� ��ȸ�ϴ�
--view ���� (v_prof_dept2)
create view v_prof_dept2
as (select profno ������ȣ, name �����̸�, dname �Ҽ��а��̸�
    from Professor natural join department);

--2.1�� �並 �б� ��������  v_prof_dept3
create view v_prof_dept3
as( select * from v_prof_dept2)
with read only;

--3. student , department ����Ͽ� 
--�а���(deptno1)�� �л����� �ִ�Ű�� �ִ� ������, �а� �̸��� ���

    -- �ζ��� �� Ȱ��
    select s.deptno1 �а���ȣ , d.dname �а���, s.max_height �ִ�Ű, s.max_weight �ִ������
    from (select deptno1, max(height) max_height, max(weight) max_weight
          from student
          group by deptno1) s, department d
    where s. deptno1 = d.deptno;

    -- �ζ��� �� Ȱ�� X
    select s.deptno1 �а���ȣ , d.dname �а���, s.height �ִ�Ű, s.weight �ִ������
    from student s, department d
    where s. deptno1 = d.deptno
    and (s.deptno1, s.height, s.weight )
            in (select deptno1, max(height), max(weight)
                from student
                group by deptno1);
    -- join on Ȱ��
        select s.deptno1 �а���ȣ , d.dname �а���, s.height �ִ�Ű, s.weight �ִ������
    from student s join department d
                     on s. deptno1 = d.deptno
    and (s.deptno1, s.height, s.weight )
            in (select deptno1, max(height), max(weight)
                from student
                group by deptno1);

--(DNAME      MAX_HEIGHT    MAX_WEIGHT)
--4. �а��̸�, �а��� �ִ�Ű, �а����� ���� Ű�� ū �л����� �̸��� Ű��  
    select deptno1, max(height)
    from student s
    group by deptno1;
-- �ζ��κ�
    select d.dname, s.�ִ�Ű, s1.name, s1.height �л�Ű
    from (select deptno1, max(height) �ִ�Ű
                from student
                group by deptno1) s, department d, student s1
    where s.deptno1 = d.deptno and s.deptno1 = s1.deptno1
                               and �ִ�Ű = s1.height;

-- 
    select d.dname, s.deptno1, height �ִ�Ű, s.name, s.height �л�Ű
    from student s, department d
    where s.deptno1 = d.deptno
        and (deptno1, height) in (select deptno1, max(height) �ִ�Ű
                                    from student
                                    group by deptno1);
    
--5.  student �л��� Ű�� ���� �г��� ��� Ű���� ū �л���                           
--�г�, �̸�,Ű, �ش� �г��� ���Ű ��� (�ζ��κ� �̿�, �г����� ��������)

select grade, avg(height)
from student
group by grade;

select s.grade, s.���Ű, stu.name, stu.height �л�Ű
from (select grade, avg(height) ���Ű
      from student
      group by grade) s, student stu
where s.grade = stu.grade and stu.height > s.���Ű;





