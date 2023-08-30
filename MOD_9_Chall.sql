
CREATE TABLE titles (
    title_id VARCHAR   NOT NULL,
    title VARCHAR   NOT NULL,
    PRIMARY KEY (title_id)
);
drop table titles;

drop table employees;

select * from employees;

CREATE TABLE employees (
    emp_no INT   NOT NULL,
    emp_title_id VARCHAR NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    sex VARCHAR   NOT NULL,
    hire_date DATE   NOT NULL,
    FOREIGN KEY (emp_title_id) REFERENCES titles (title_id),
    PRIMARY KEY (emp_no)
);
drop table departments;

select * from departments;

CREATE TABLE departments (
    dept_no VARCHAR(40),   --NOT NULL,
    dept_name VARCHAR(40),   --NOT NULL,
    PRIMARY KEY (dept_no)
);
DROP TABLE dept_emp;
select * from dept_emp;

CREATE TABLE dept_emp (
    emp_no INT   NOT NULL,
    dept_no VARCHAR   NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);
DROP TABLE dept_manager;
create table dept_manager(
	dept_no VARCHAR,
	emp_no int
);
CREATE TABLE salaries (
    emp_no INT   NOT NULL,
    salary INT   NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no)
);
CREATE TABLE dept_emp (
	emp_no int,
	dept_no VARCHAR
	
);
-- 1) List the employee number, last name, first name, sex, and salary of each employee.
SELECT  emp.emp_no,
        emp.last_name,
        emp.first_name,
        emp.sex,
        sal.salary
FROM employees as emp
    LEFT JOIN salaries as sal
    ON (emp.emp_no = sal.emp_no)
ORDER BY emp.emp_no;


-- 2) List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT  last_name,first_name,hire_date
FROM employees
where hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY hire_date;

-- 3) List the manager of each department along with their department number, department name, 
--employee number, last name, and first name.
SELECT 	dm.dept_no, d.dept_name, emp.last_name, emp.first_name, emp.emp_no
FROM employees as emp 
inner join dept_manager as dm on 
emp.emp_no = dm.emp_no
INNER JOIN departments as d ON
d.dept_no = dm.dept_no;



-- 4) List the department number for each employee along with that employee’s employee 
--number, last name, first name, and department name.


select dm.dept_no, d.dept_name, emp.emp_no, emp.last_name, emp.first_name
--"from" tabel should be the table with the most usabel comulns 
FROM employees as emp 
--right join dept_emp as dm on
--dm.dept_no = dm.dept_name
-- the joins must relate to the "from" tabel 
inner JOIN dept_emp as dm ON emp.emp_no = dm.emp_no
inner JOIN departments as d ON d.dept_no = dm.dept_no;
--RIGHT JOIN table2 ON table1.column = table2.column;;


-- 5) List first name, last name, and sex of each employee whose first name is 
--Hercules and whose last name begins with the letter B.

select employees.first_name, employees.last_name, employees.sex
from employees
WHERE employees.first_name LIKE '%Hercules%' and employees.last_name like '%B___';



-- 6) List each employee in the Sales department, including their employee number, last name, and first name.

select d.dept_name, d.dept_no, dm.emp_no, employees.last_name, employees.first_name, dm.emp_no
from employees
inner JOIN dept_emp as dm ON dm.emp_no = employees.emp_no
inner JOIN departments as d ON d.dept_no = dm.dept_no
where d.dept_name like 'Sales';


-- 7) List each employee in the Sales and Development departments, including their employee 
-- number, last name, first name, and department name.


select d.dept_name, d.dept_no, dm.emp_no, employees.last_name, employees.first_name, dm.emp_no
from employees
inner JOIN dept_emp as dm ON dm.emp_no = employees.emp_no
inner JOIN departments as d ON d.dept_no = dm.dept_no
where d.dept_name = 'Sales' or d.dept_name = 'Development';


-- 8) List the frequency counts, in descending order, of all the employee
-- last names (that is, how many employees share each last name).
 
 select employees.last_name, COUNT(employees.last_name) AS frequency 
 from employees
 group by employees.last_name;