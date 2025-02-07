-- @D:\JMT\DB\workspace\hr_test_data2

-- student ���̺�
-- 1. student ���̺��� �� �г⺰ �ִ� �����Ը� ���� �л����� �г�, �̸�, ������ ���
select grade �г�, name �̸�, weight ������
from student
where weight in (select max(weight)
                from student
                group by grade)
order by grade asc;

-- 2. professor department ���̺�
-- �� �а��� �Ի����� ���� ������ ������ ������ȣ, �̸�, �а��� ���
-- ��, �Ի����� ������������
select profno ������ȣ, name �̸�, dname �а���, hiredate �Ի���, deptno �а���ȣ
from professor natural join department
where hiredate in (select min(hiredate)
                    from professor
                    group by deptno)
order by hiredate asc;

-- 3. emp2 ���̺�
-- 'Section head'(position) ������ �ּ� �����ں���
-- ������ ���� ����� �̸�(name), ����(position), ����(pay) ���

select name �̸�, position ����, pay ����, to_char(pay, 'L999,999,999')
from emp2
where pay > (select min(pay)
             from emp2
             where position = 'Section head');

-- 4 employees ���̺�
-- �μ���ȣ�� 80���� ū �μ��� ������̵�(employee_id), ����̸�(first_name), �Ŵ����̸�(first_name) ���

select e.employee_id ������̵�, e.first_name ����̸�, m.employee_id "�Ŵ��� ���̵�", m.first_name "�Ŵ��� �̸�"
from employees e left outer join employees m 
                 on e.manager_id = m.employee_id
where e.department_id > 80
order by ������̵�;

-- 5. student, professore ���̺�
-- ��� �л� ���(��, ���������� ���� �л��� ���) �л��̸�(name), �����̸�(name)
select s.name �л��̸�, p.name �����̸�
from student s left outer join professor p using(profno);




