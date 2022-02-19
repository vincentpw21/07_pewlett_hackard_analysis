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

-- number of employees by recent job title who are about to retire
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

-- double check retiring titles table
SELECT *
FROM retiring_titles;

-- 