--Practice 
SELECT d.dept_name, count(e.emp_no) AS "# of employees"
FROM employees AS e
INNER JOIN dept_emp AS de USING(emp_no)
INNER JOIN departments AS d USING(dept_no)
WHERE e.gender = 'M'
GROUP BY d.dept_name
HAVING count( e.emp_no) > 25000

/*
*  Show me all the employees, hired after 1991, that have had more than 2 titles
*  Database: Employees
*/
SELECT e.emp_no, e.hire_date, count(t.title) AS "amount of title"
FROM employees AS e
INNER JOIN titles AS t USING (emp_no)
WHERE EXTRACT(YEAR FROM e.hire_date) > 1991
GROUP BY e.emp_no
HAVING count(t.title) > 2 
ORDER BY e.emp_no;

/*
*  Show me all the employees that have had more than 15 salary changes that work in the department development
*  Database: Employees
*/
SELECT e.emp_no, count(s.salary) AS "amount of raises"
FROM employees AS e
INNER JOIN salaries AS s USING(emp_no)
INNER JOIN dept_emp AS d USING(emp_no)
WHERE d.dept_no = 'd005'
GROUP BY e.emp_no
HAVING count(s.salary) > 15
ORDER BY e.emp_no;

/*
*  Show me all the employees that have worked for multiple departments
*  Database: Employees
*/
SELECT e.emp_no, count(d.dept_no) AS "# of dept worked on"
FROM employees AS e
INNER JOIN dept_emp AS d USING (emp_no)
GROUP BY e.emp_no
HAVING count(d.dept_no) > 1
ORDER BY e.emp_no;
-- my answer ^up^
SELECT e.emp_no, count(de.dept_no) AS "worked for # departments"
FROM employees AS e
JOIN dept_emp AS de USING(emp_no)
GROUP BY e.emp_no
HAVING count(de.dept_no) > 1
ORDER BY e.emp_no;