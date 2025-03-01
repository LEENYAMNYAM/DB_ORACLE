-- PL / SQL (16,17,18장 복습)
set serveroutput on; 

---1)employee_id = 200 인 회사원의 모든 정보 추출해서 아이디, 이름, 입사일 출력
---employee_id , first_name, hire_date
select * 
from employees 
where employee_id = 200;

-- 답)커서 사용 안하는 방법
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

-- 답) 커서 사용하는 방법
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
EMPLOYEES 에서 DEPARTMENT_ID, FIRST_NAME,SALARY, 
                PHONE_NUMBER,기타를 출력하되 
급여는 천단위 분리 기호 사용
급여가 5000이하인 경우 기타에 '저임금', 5000~10000 '보통임금',
10000 초과 '고임금'  
*/
--sql문
select department_id, first_name, salary, phone_number,
    case
        when salary > 10000 then '고임금'
        when salary > 5000 then '보통임금'
        when salary <= 5000 then '저임금'
    end 기타
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
        if i.salary <= 5000 then etc := '저임금';
        elsif i.salary <= 10000 then etc := '보통임금';
        elsif i.salary > 10000 then etc := '고임금';
        end if;
        
        dbms_output.put_line(lpad(i.department_id, 10) || lpad(i.first_name, 15) 
                               || lpad(to_char(i.salary, '999,999'), 10) || lpad(i.phone_number, 20) 
                               || lpad(etc, 15) );
    end loop;    
end;
/

