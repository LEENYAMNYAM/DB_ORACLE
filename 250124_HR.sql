-- sql파일 실행하기
-- @C:\JMT\DATABASE\workspace\hr_table.sql;

-- 1. employees 테이블 모든 정보 조회
select * from employees;

-- 2. departments 테이블 모든 정보 조회
select * from departments;

-- 3. employees 테이블에서 first_name 조회
select first_name from employees;

-- 4. employees 테이블에서 department_id 가 30번인 first_name 만 조회
select first_name from employees where department_id = 30;

-- 5. employees 테이블에서 연봉(salary)이 9000 이상인 사람의 first_name 조회
-- 연봉이 높은 순으로 출력
select first_name, salary from employees where salary >= 9000 order by salary desc;

-- 6. employees 테이블에서 연봉이 9000 이상이고
-- 부서번호(department_id) 가 30번인 사람의 first_name 조회
select first_name, salary from employees where salary >= 9000 or department_id = 30;

-- 7. employees 테이블에서 연봉이 9000 이상이거나
-- 부서번호가 30번인 사람의 first_name 조회
select first_name from employees where salary >=9000
Union
select first_name from employees where department_id = 30;

-- 8. 부서번호가 20이 아닌 사람의 first_name, department_id 조회
select first_name, department_id from employees where department_id <> 20;
select first_name, department_id from employees where department_id != 20;

-- 9. job_id 가 PU_CLERK 이거나 ST_MAN 이거나 SA_MAN 인 사람의 first_name과 job_id 출력
select first_name, job_id from employees where job_id = 'PU_CLERK' or job_id = 'ST_MAN' or job_id = 'SA_MAN';

-- 10. 부서번호가 100인 사원의 first_name, first_name의 첫문자(첫글자), 부서번호 출력
select first_name, substr(first_name, 1, 1) 첫글자, department_id from employees where department_id = 100;

-- 11. 부서번호가 100인 사원의 first_name 10글자로 표현하되 왼쩍을 '*'로 채우기
select first_name, LPAD(first_name, 10 , '*'), department_id from employees where department_id = 100;

-- 12. 부서번호가 100인 사원의 first_name의 두글자만 나오고 나머지 * 채우기
select first_name, RPAD(substr(first_name, 1, 2), length(first_name) , '*'), department_id from employees where department_id = 100;
