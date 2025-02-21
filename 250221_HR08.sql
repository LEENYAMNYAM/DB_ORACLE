set serveroutput on;

/*
���, ����, �μ��ڵ�, �μ���, ��Ÿ�� ����ϵ�,
employee_id/ first_name /department_id/department_name
�μ��ڵ尡 80�̸� '�츮�μ�', �ƴϸ� 'Ÿ�μ�'�� ��Ÿ �ڸ��� ���.
EMPLOYEES   DEPARTMENTS
*/
select * from EMPLOYEES;
select * from DEPARTMENTS;
--Ŀ�� �̿�

select employee_id, first_name, department_id, department_name
from employees join departments using(department_id);

-- cursor, for loop��, if�� ���
declare
    cursor c1 is
    select employee_id, first_name, department_id, department_name
    from employees join departments using(department_id);
    etc varchar(20);
begin
    dbms_output.put_line('employee_id | ' 
                      || 'first_name | ' 
                      || 'department_id | ' 
                      || 'department_name | ' 
                      || '   etc ');
    for e in c1 loop
        if e.department_id = 80  then etc := '�츮�μ�';
        else etc := 'Ÿ�μ�';
        dbms_output.put_line(lpad(e.employee_id,7)
                          || lpad(e.first_name,17)
                          || lpad(e.department_id,16) 
                          || lpad(e.department_name,18)
                          || lpad(etc,10));
        end if;
    end loop;
end;
/

declare
    cursor c1 is
    select employee_id, first_name, department_id, department_name
    from employees join departments using(department_id);
    etc varchar(20);
begin
    dbms_output.put_line('employee_id | ' 
                      || 'first_name | ' 
                      || 'department_id | ' 
                      || 'department_name | ' 
                      || '   etc ');
    for i in c1 loop
        if i.department_id = 80  then etc := '�츮�μ�';
        else etc := 'Ÿ�μ�';
        end if;
        dbms_output.put_line(lpad(i.employee_id,7)
                          || lpad(i.first_name,17)
                          || lpad(i.department_id,16) 
                          || lpad(i.department_name,18)
                          || lpad(etc,10));
    end loop;
end;
/


