set serveroutput on;

/*
사번, 성명, 부서코드, 부서명, 기타를 출력하되,
employee_id/ first_name /department_id/department_name
부서코드가 80이면 '우리부서', 아니면 '타부서'를 기타 자리에 출력.
EMPLOYEES   DEPARTMENTS
*/
select * from EMPLOYEES;
select * from DEPARTMENTS;
--커서 이용

select employee_id, first_name, department_id, department_name
from employees join departments using(department_id);

-- cursor, for loop문, if문 사용
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
        if e.department_id = 80  then etc := '우리부서';
        else etc := '타부서';
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
        if i.department_id = 80  then etc := '우리부서';
        else etc := '타부서';
        end if;
        dbms_output.put_line(lpad(i.employee_id,7)
                          || lpad(i.first_name,17)
                          || lpad(i.department_id,16) 
                          || lpad(i.department_name,18)
                          || lpad(etc,10));
    end loop;
end;
/


