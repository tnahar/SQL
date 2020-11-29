-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/HJ4iBZ
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

--Created tables for my database using quickdbd.
CREATE TABLE "departments" (
    "dept_no" varchar   NOT NULL,
    "dept_name" varchar   NOT NULL
);

CREATE TABLE "dept_emp" (
    "emp_no" varchar   NOT NULL,
    "dept_no" varchar   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar   NOT NULL,
    "emp_no" varchar   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" varchar   NOT NULL,
    "emp_title_id" varchar   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "sex" varchar   NOT NULL,
    "hire_date" date   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" integer   NOT NULL,
    "salary" integer   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" varchar   NOT NULL,
    "title" varchar   NOT NULL
);

--insert data into tables in pgadmin
insert into departments (dept_no, dept_name)
values
	('d001', 'Marketing'),
	('d002', 'Finance'),
	('d003', 'Human_Resources'),
	('d004', 'Production'),
	('d005', 'Development'),
	('d006', 'Quality_Management'),
	('d007', 'Sales'),
	('d008', 'Research'),
	('d009', 'Customer_Service')

-- imported data from each csv file to pgadmin using this code below
COPY titles(title_id, title)
FROM '/Users/Taslemun/Data Analytics Challanges /SQL_Challenge/EmployeeSQL/SQL Case Assignment /data/titles.csv'
DELIMITER ','
CSV HEADER;
-- had to change the data type to make the foreign and primary key
ALTER TABLE dept_emp
ALTER COLUMN emp_no type integer using (emp_no::integer);

-- had to change my tables primary key
ALTER TABLE products
ADD PRIMARY KEY (product_no);
-- had to change my tables foriegn key
ALTER TABLE dept_manager
ADD CONSTRAINT fk_dept_manager
FOREIGN KEY(emp_no)
REFERENCES employees (emp_no)

--1. List the following details of each employee: employee number, last name, first name, sex, and salary.
select
	e.emp_no, e.sex, s.salary,
	e.first_name || ' ' || e.last_name as employee_name
from
	employees e
	inner join salaries s
	on e.emp_no = s.emp_no
order by
  e.emp_no

--2.  List first name, last name, and hire date for employees who were hired in 1986.
select first_name ||' '|| last_name as employee_name, hire_date
from employees
where hire_date between '1986-01-01' and '1986-12-31'
order by hire_date

--3.  List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
select
	d.dept_no,
	d.dept_name,
	dm.emp_no,
	e.first_name ||' '|| e.last_name as employee_name
from
	departments d
	inner join dept_manager dm
	on d.dept_no = dm.dept_no
	inner join employees e
	on dm.emp_no = e.emp_no
order by
	emp_no

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
select
	e.emp_no,
	e.first_name ||' '|| e.last_name as employee_name,
	d.dept_name
from employees e
	inner join dept_emp de
	on e.emp_no=de.emp_no
	inner join departments d
	on d.dept_no = de.dept_no
order by emp_no

--5.  List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select
	first_name, last_name, sex
from
	employees
where first_name = 'Hercules' and last_name like 'B%'

--6.  List all employees in the Sales department, including their employee number, last name, first name, and department name.

Select
	e.first_name ||' '|| e.last_name as employee_name,
	e.emp_no,
	d.dept_name
from employees e
	inner join dept_emp de
	on e.emp_no=de.emp_no
	inner join departments d
	on d.dept_no=de.dept_no
where dept_name = 'Sales'
order by emp_no

--7.  List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
Select
	e.first_name ||' '|| e.last_name as employee_name,
	e.emp_no,
	d.dept_name
from employees e
	inner join dept_emp de
	on e.emp_no=de.emp_no
	inner join departments d
	on d.dept_no=de.dept_no
where
	dept_name = 'Sales' or
	dept_name = 'Development'
order by emp_no

--8.  In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, count(last_name) as Last_Name_Count
from employees
GROUP BY last_name
ORDER BY Last_Name_Count desc 
