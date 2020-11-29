-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/HJ4iBZ
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


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

-- imported data from csv file to pgadmin using this code
COPY titles(title_id, title)
FROM '/Users/Taslemun/Data Analytics Challanges /SQL_Challenge/EmployeeSQL/SQL Case Assignment /data/titles.csv'
DELIMITER ','
CSV HEADER;
