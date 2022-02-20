-- CHALLENGE 1

-- retrieve list of employees based on birth year, match to titles and create new retirement table 
SELECT employees.emp_no, employees.first_name, employees.last_name, titles.title, titles.from_date, titles.to_date
INTO retirement_titles
FROM employees
INNER JOIN titles 
ON(employees.emp_no = titles.emp_no)
WHERE employees.birth_date >= '1/1/1952' and employees.birth_date <='12/31/1955'
ORDER BY emp_no;

-- double check title created correctly
SELECT *
FROM retirement_titles;

-- remove duplicates employees (due to title changes)
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC, from_date DESC;

-- double check unique titles table created correctly
SELECT *
FROM unique_titles;

DROP TABLE retiring_titles;

-- number of employees by recent job title who are about to retire
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

-- double check retiring titles table
SELECT *
FROM retiring_titles;

-- CHALLENGE 2

--mentorship elligibility list
SELECT DISTINCT ON (emp_no) employees.emp_no, employees.first_name, employees.last_name, employees.birth_date, dept_emp.from_date, dept_emp.to_date, titles.title
INTO mentorship_elligibility_list
FROM employees
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE dept_emp.to_date = '9999-01-01' AND employees.birth_date >= '1/1/1965' AND employees.birth_date <= '12/31/1965'
ORDER BY emp_no ASC, titles.from_date DESC;

-- double check mentorship eligibility table
SELECT *
FROM mentorship_elligibility_list;

-- SUMMARY ANALYSIS QUERIES
-- mentorship available list by title for comparison
SELECT COUNT(title), title
INTO mentorship_list_by_title
FROM mentorship_elligibility_list
GROUP BY title
ORDER BY COUNT(title) DESC;

-- double check mentorship by title list
SELECT *
FROM mentorship_list_by_title;

SELECT *
FROM dept_emp;

-- total employees by title
SELECT DISTINCT ON (emp_no) employees.emp_no, employees.first_name, employees.last_name, employees.birth_date, dept_emp.from_date, dept_emp.to_date, titles.title
INTO employee_roster
FROM employees
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE dept_emp.to_date = '9999-01-01'
ORDER BY emp_no ASC, titles.from_date DESC;
-- double check table
SELECT *
FROM employee_roster;
-- segment by title
SELECT COUNT(title), title
INTO employees_roster_by_title
FROM employee_roster
GROUP BY title
ORDER BY COUNT(title) DESC;
-- double check table
SELECT *
FROM employees_roster_by_title;

-- retiring first names for HR prizes
SELECT COUNT(first_name), first_name
INTO retiring_first_names
FROM unique_titles
GROUP BY first_name
ORDER BY COUNT(first_name) DESC;

SELECT *
FROM retiring_first_names;