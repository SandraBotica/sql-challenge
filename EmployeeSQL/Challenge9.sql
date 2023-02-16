
CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "emp_title_id" VARCHAR(5)   NOT NULL,
    "birth_date" VARCHAR(10)   NOT NULL,
    "first_name" VARCHAR(20)   NOT NULL,
    "last_name" VARCHAR(20)   NOT NULL,
    "sex" VARCHAR(1)   NOT NULL,
    "hire_date" VARCHAR(10)   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

select * from employees;

CREATE TABLE "titles" (
    "title_id" VARCHAR(5)   NOT NULL,
    "title" VARCHAR(18)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

select * from titles;

CREATE TABLE "departments" (
    "dept_no" VARCHAR(4)   NOT NULL,
    "dept_name" VARCHAR(18)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

select * from departments;

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(4)   NOT NULL,
    "emp_no" INTEGER   NOT NULL
);

select * from dept_manager;

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR(4)   NOT NULL
);

select * from dept_emp;

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL
);

select * from salaries;

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

--Question 1
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
from employees e
left join salaries as s
on e.emp_no = s.emp_no;

select e.emp_no, e.last_name, e.first_name, e.sex
from employees as e 
where e.emp_no in
	(
	select emp_no
	from salaries 
	);

--Question 2

select e.first_name, e.last_name, e.hire_date
from employees as e
where hire_date LIKE '%/%/1986';

--Question 3

select d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name  
from departments as d
inner join dept_manager as dm on
dm.dept_no=d.dept_no
inner join employees as e on
e.emp_no = dm.emp_no ;

--Question 4

select d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
from departments as d
inner join dept_emp as de on
de.dept_no=d.dept_no
inner join employees as e on
e.emp_no = de.emp_no ;

--Question 5

select e.first_name, e.last_name, e.sex
from employees as e 
where e.first_name = 'Hercules'
	and e.last_name like 'B%';

--Question 6

select e.emp_no, e.last_name, e.first_name
from employees as e
inner join dept_emp as de on
de.emp_no = e.emp_no
inner join departments as d on
d.dept_no = de.dept_no
where d.dept_name = 'Sales';

--Question 7

select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees as e
inner join dept_emp as de on
de.emp_no = e.emp_no
inner join departments as d on
d.dept_no = de.dept_no
where d.dept_name = 'Sales'
or d.dept_name = 'Development';

--Question 8

select last_name, count(last_name) as "Frequency counts last_name"
from employees
group by last_name
order by "Frequency counts last_name" desc;


