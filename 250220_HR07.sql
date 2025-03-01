-- PL / SQL (16,17,18�� ����)
set serveroutput on; 

---1)employee_id = 200 �� ȸ����� ��� ���� �����ؼ� ���̵�, �̸�, �Ի��� ���
---employee_id , first_name, hire_date
select * 
from employees 
where employee_id = 200;

-- ��)Ŀ�� ��� ���ϴ� ���
declare
    v_row employees%rowType;

begin 
    select * into v_row
    from employees 
    where employee_id = 200;
    dbms_output.put_line('employee_id : ' || v_row.employee_id);
    dbms_output.put_line('first_name : ' || v_row.first_name);
    dbms_output.put_line('hire_date : ' || v_row.hire_date);    
end;
/

-- ��) Ŀ�� ����ϴ� ���
declare
    cursor c1 is
    select * 
    from employees 
    where employee_id = 200;

begin 
    for item in c1 loop
        dbms_output.put_line('employee_id : ' || item.employee_id);
        dbms_output.put_line('first_name : ' || item.first_name);
        dbms_output.put_line('hire_date : ' || item.hire_date);
    end loop;
end;
/

/*2.
EMPLOYEES ���� DEPARTMENT_ID, FIRST_NAME,SALARY, 
                PHONE_NUMBER,��Ÿ�� ����ϵ� 
�޿��� õ���� �и� ��ȣ ���
�޿��� 5000������ ��� ��Ÿ�� '���ӱ�', 5000~10000 '�����ӱ�',
10000 �ʰ� '���ӱ�'  
*/
--sql��
select department_id, first_name, salary, phone_number,
    case
        when salary > 10000 then '���ӱ�'
        when salary > 5000 then '�����ӱ�'
        when salary <= 5000 then '���ӱ�'
    end ��Ÿ
from employees
order by department_id;

declare
    cursor c1 is
    select department_id, first_name, salary, phone_number
    from employees;
    
    etc varchar2(20);
begin
    dbms_output.put_line('department_id | first_name | salary |     phone_number     |    etc');
    
    for i in c1 loop
        if i.salary <= 5000 then etc := '���ӱ�';
        elsif i.salary <= 10000 then etc := '�����ӱ�';
        elsif i.salary > 10000 then etc := '���ӱ�';
        end if;
        
        dbms_output.put_line(lpad(i.department_id, 10) || lpad(i.first_name, 15) 
                               || lpad(to_char(i.salary, '999,999'), 10) || lpad(i.phone_number, 20) 
                               || lpad(etc, 15) );
    end loop;    
end;
/

