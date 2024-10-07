SELECT *
FROM departments;

SELECT *
FROM dept_emp;

SELECT *
FROM dept_manager;

SELECT *
FROM employees;

SELECT *
FROM salaries;

SELECT *
FROM titles;

-- 1. List the employee number, last name, first name, sex, and salary of each employee.
CREATE VIEW employee_salary AS
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e 
LEFT JOIN salaries AS s
ON e.emp_no = s.emp_no;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
CREATE VIEW hires AS 
SELECT e.first_name, e.last_name, e.hire_date
FROM employees AS e
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
CREATE VIEW dept_manager_info AS 
SELECT m.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
FROM employees AS e
LEFT JOIN dept_manager AS m
ON e.emp_no = m.emp_no
LEFT JOIN departments AS d
ON m.dept_no = d.dept_no;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
CREATE VIEW employee_department AS 
SELECT de.dept_no, e.emp_no, e.first_name, e.last_name, d.dept_name
FROM employees AS e
LEFT JOIN dept_emp AS de
ON e.emp_no = de.emp_no
LEFT JOIN departments AS d
ON d.dept_no = de.dept_no;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
CREATE VIEW hercules_info AS
SELECT e.first_name, e.last_name, e.sex
FROM employees AS e
WHERE e.first_name = 'Hercules'
AND e.last_name LIKE 'B%';

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
CREATE VIEW sales_employees AS
SELECT e.emp_no, e.last_name, e.first_name
FROM employees AS e 
LEFT JOIN dept_emp AS de
ON e.emp_no = de.emp_no
LEFT JOIN departments AS d
ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales';

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
CREATE VIEW sales_development_employees AS
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
LEFT JOIN dept_emp AS de
ON e.emp_no = de.emp_no
LEFT JOIN departments AS d
ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales'
OR d.dept_name = 'Development';

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
CREATE VIEW last_name AS
SELECT e.last_name, COUNT(last_name) AS last_name_frequency
FROM employees AS e
GROUP BY e.last_name
ORDER BY last_name_frequency DESC;
