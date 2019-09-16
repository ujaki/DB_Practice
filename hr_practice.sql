show databases;
use hr;

show tables;

desc employees;
select * from employees;
select count(*) from employees;

desc departments;
select * from departments;
select count(*) from departments;

desc locations;
select * from locations;
select count(*) from locations;

desc countries;
select * from countries;
select count(*) from countries;

desc regions;
select * from regions;
select count(*) from regions;

desc jobs;
select * from jobs;
select count(*) from jobs;


desc job_history;
select * from job_history;
select count(*) from job_history;
-- --------------------------------------------------------
select * from employees;
select department_id from employees where EMPLOYEE_ID=101;

select * from departments;
select * from departments where DEPARTMENT_ID
=(select DEPARTMENT_ID from employees where employee_id=101);

select * from employees where EMPLOYEE_ID=100;
select * from employees where EMPLOYEE_ID=
(select MANAGER_ID from employees where employee_id=101);

select * from locations where LOCATION_ID=1700;
select COUNTRY_ID from locations where LOCATION_ID=1700;

select * from countries where COUNTRY_ID=
(select COUNTRY_ID from locations where LOCATION_ID=1700);

select * from regions where REGION_ID=2;
select * from employees;
select * from departments;
select * from locations;

select EMPLOYEE_ID, EMAIL, JOB_ID from employees;
select DEPARTMENT_ID, DEPARTMENT_NAME from departments;
-- 2 alias -> cross join, cartasian
select e.EMPLOYEE_ID, e.EMAIL, e.JOB_ID, d.DEPARTMENT_ID, d.DEPARTMENT_NAME from employees e, departments d;

select count(*) from employees e, departments d;

-- 3
-- natural join은 테이블 이름에 변경이 될 가능성이 커서 잘 사용되지 않음
select e.EMPLOYEE_ID, e.EMAIL, e.JOB_ID, d.DEPARTMENT_ID, d.DEPARTMENT_NAME from employees e natural join departments d;
-- -->
select e.EMPLOYEE_ID, e.EMAIL, e.JOB_ID, d.DEPARTMENT_ID, d.DEPARTMENT_NAME from employees e join departments d
on e.DEPARTMENT_ID=d.DEPARTMENT_ID;

select e.EMPLOYEE_ID, e.EMAIL, e.JOB_ID, d.DEPARTMENT_ID, d.DEPARTMENT_NAME from employees e inner join departments d
on e.DEPARTMENT_ID=d.DEPARTMENT_ID;

select e.EMPLOYEE_ID, e.EMAIL, e.JOB_ID, d.DEPARTMENT_ID, d.DEPARTMENT_NAME from employees e, departments d where  e.DEPARTMENT_ID=d.DEPARTMENT_ID
and e.EMPLOYEE_ID=101;


select employee_id, first_name, email, job_id from employees;

select DEPARTMENT_ID, DEPARTMENT_NAME from departments;

select STREET_ADDRESS, CITY from locations;


select e.employee_id, e.first_name, e.email, e.job_id, 
	d.DEPARTMENT_ID, d.DEPARTMENT_NAME, l.STREET_ADDRESS, l.CITY from employees e, departments d, locations l;

select count(*) from employees e, departments d, locations l;


select e.employee_id, e.first_name, e.email, e.job_id, 
	d.DEPARTMENT_ID, d.DEPARTMENT_NAME, l.STREET_ADDRESS, l.CITY from employees e join departments d
    on e.DEPARTMENT_ID=d.DEPARTMENT_ID
    join locations l on d.LOCATION_ID = l.LOCATION_ID;


select e.employee_id, e.first_name, e.email, e.job_id, 
	d.DEPARTMENT_ID, d.DEPARTMENT_NAME, l.STREET_ADDRESS, l.CITY from employees e, departments d, locations l
    where e.DEPARTMENT_ID=d.DEPARTMENT_ID and d.LOCATION_ID = l.LOCATION_ID;


-- 1. Write a query to list the number of jobs available in the employees table
select * from employees;
select * from jobs;

select count(*) from jobs;

select distinct JOB_ID from employees;
select count(distinct JOB_ID) from employees;


-- 2. Write a query to get the total salaries payable to employees
select department_id, sum(salary) from employees
group by DEPARTMENT_ID;

select department_id, min(SALARY), max(salary), avg(SALARY), sum(salary) from employees
group by DEPARTMENT_ID;

-- 3. Write a query to get the minimum salary from employees table
select job_id, min(SALARY), max(salary), avg(SALARY), sum(salary) from employees
group by job_id;

-- 4. Write a query to get the maximum salary of an employee working as a Programmer.
select * from employees;
select min(SALARY) from employees where job_id='IT_PROG';

-- 5. Write a query to get the average salary and number of employees working the department 90
select avg(salary), count(*), DEPARTMENT_ID from employees group by DEPARTMENT_ID;
select avg(salary), count(*) from employees where DEPARTMENT_ID=90;


-- 6. Write a query to get the highest, lowest, sum, and average salary of all employees.
select max(salary) max_salary, min(salary) min_salary, sum(salary) sum_salary, avg(salary) avg_salary from employees;

-- 7. Write a query to get the number of employees with the same job
select count(*), job_id from employees group by job_id;

-- 8. Write a query to get the difference between the highest and lowest salaries.
select max(salary)-min(salary) diff_salary from employees;

-- 9. Write a query to find the manager ID and the salary of the lowest-paid employee for that manager.
select min(salary), MANAGER_ID from employees group by MANAGER_ID;

-- 10. Write a query to get the department ID and the total salary payable in each department
select sum(salary), department_id from employees group by DEPARTMENT_ID;

-- 11. Write a query to get the average salary for each job ID excluding programmer. 
select avg(salary), job_id from employees where job_id!='IT_PROG' group by job_id ;


-- 12. Write a query to get the total salary, maximum, minimum, average salary of employees (job ID wise), for department ID 90 only
select sum(salary) sum_salary, max(salary) max_salary, min(salary) min_salary, avg(salary) avg_salary, job_id from employees where department_id=90 group by job_id;

-- 13. Write a query to get the job ID and maximum salary of the employees where maximum salary is greater than or equal to $4000
select job_id, max(salary) max_sal from employees group by job_id having max_sal>=4000;


-- 14. Write a query to get the average salary for all departments employing more than 10 employees.
select avg(salary), count(*) ecount, department_id from employees group by DEPARTMENT_ID having ecount>=10;

-- ---------------------------------------------------------------------------------------------------------------
select * from employees;
select * from locations;
select * from countries;
select * from departments;
-- 1. Write a query to find the name (first_name, last_name) and the salary of the employees who have a higher salary than the employee whose last_name='Bull'.
select * from employees where last_name='Bull';
select first_name, last_name, salary from employees where SALARY>(select SALARY from employees where last_name='Bull');

-- 2. Write a query to find the name (first_name, last_name) of all employees who works in the IT department.
select * from departments; 
select first_name, last_name from employees where department_id=60;
select first_name, last_name from employees where department_id=(select department_id from departments where department_name='IT');

-- 3. Write a query to find the name (first_name, last_name) of the employees who have a manager and worked in a USA based department
select location_id from locations where country_id='US';
select * from departments where location_id in (select location_id from locations where country_id='US');

select * from employees 
where (department_id in 
(select department_id from departments where location_id in
(select location_id from locations where country_id='US'))) and manager_id <> 0;

select first_name, last_name from employees where MANAGER_ID!=0 and (DEPARTMENT_ID=
(select DEPARTMENT_ID from departments where location_id=(select location_id from locations where country_id='US')));

select e.first_name, e.EMPLOYEE_ID, m.first_name, m.EMPLOYEE_ID from employees e, employees m
where e.MANAGER_ID=m.EMPLOYEE_ID;


-- 4. Write a query to find the name (first_name, last_name) of the employees who are managers
select first_name, last_name from employees where manager_id=0;
select first_name, last_name from employees where (employee_id in (select manager_id from employees));

-- 5. Write a query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary.
select avg(salary) from employees;
select * from employees;
select first_name, last_name, salary from employees where SALARY > (select avg(salary) from employees);

-- 6. Write a query to find the name (first_name, last_name), and salary of the employees whose salary is equal to the minimum salary for their job grade
select * from jobs;
select first_name, last_name, salary from employees e where e.SALARY = (select min_salary from jobs j where e.JOB_ID=j.JOB_ID);

-- 아래 두개를 묶는 방법 --> 서브쿼리 조인
select job_id, salary from employees;
select job_id, min_salary from jobs;

select first_name, last_name, salary from employees e where e.salary=(select min_salary from jobs j where e.job_id=j.job_id);
 -- select salary from employees;

-- 

-- ------------------------------------------
-- 7. Write a query to find the name (first_name, last_name), and salary of the employees who earns more than the average salary and works in any of the IT departments.
select * from departments;
select first_name, last_name, salary from employees
where (SALARY > (select avg(salary) from employees)) 
and (department_id in (select department_id from departments where department_name like 'IT%'));


-- 8. Write a query to find the name (first_name, last_name), and salary of the employees who earns more than the earning of Mr. Bell.
select * from employees where last_name like '%Bell%';
select salary from employees where last_name = 'Bell';
select first_name, last_name, salary from employees where SALARY > (select salary from employees where last_name = 'Bell');

-- 9. Write a query to find the name (first_name, last_name), and salary of the employees who earn the same salary as the minimum salary for all departments.

-- 10. Write a query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary of all departments.

-- 11. Write a query to find the name (first_name, last_name) and salary of the employees who earn a salary that is higher than the salary of all the Shipping Clerk (JOB_ID = 'SH_CLERK'). Sort the results of the salary of the lowest to highest.alter

-- 12. Write a query to find the name (first_name, last_name) of the employees who are not supervisors.

-- 13. Write a query to display the employee ID, first name, last name, and department names of all employees.

-- 14. Write a query to display the employee ID, first name, last name, salary of all employees whose salary is above average for their departments.

-- 15. Write a query to fetch even numbered records from employees table

-- 16. Write a query to find the 5th maximum salary in the employees table.

-- 17. Write a query to find the 4th minimum salary in the employees table.

-- 18. Write a query to select last 10 records from a table

-- 19. Write a query to list the department ID and name of all the departments where no employee is working.

-- 20. Write a query to get 3 maximum salaries.

-- 21. Write a query to get 3 minimum salaries.

-- 22. Write a query to get nth max salaries of employees.
















