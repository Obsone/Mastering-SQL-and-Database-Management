SELECT  c.firstname,
        c.lastname,
        o.orderid FROM orders AS o
INNER JOIN customers AS c ON o.customerid = c.customerid
WHERE c.state IN ('NY', 'OH', 'OR')
ORDER BY o.orderid;

--USING keyword replacing ON de.emp = e.emp
SELECT e. emp_no, e.first_name, dp.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de USING(emp_no)
INNER JOIN departments AS dp USING(dept_no);


--GROUP BY
SELECT dept_no, count(emp_no)
FROM dept_emp
GROUP BY dept_no;

/*
*  How many people were hired on any given hire date?
*  Database: Employees
*  Table: Employees
*/
SELECT e.hire_date, count(e.emp_no) AS num_of_emp
FROM employees AS e
GROUP BY e.hire_date;

/*
*   Show me all the employees, hired after 1991 and count the amount of positions they've had
*  Database: Employees
*/
SELECT e.emp_no, count(t.title) AS "amonut of position/title"
FROM employees AS e
JOIN  titles AS t USING(emp_no)
WHERE EXTRACT (YEAR FROM e.hire_date) > 1991
GROUP BY e.emp_no;

/*
*  Show me all the employees that work in the department development and the from and to date.
*  Database: Employees
*/
SELECT e.emp_no, de.from_date, de.to_date, dp.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de USING(emp_no)
INNER JOIN departments AS dp USING (dept_no)
WHERE dp.dept_name = 'Development'
GROUP BY e.emp_no, de.from_date, de.to_date, dp.dept_name
ORDER BY e.emp_no;
--My answer ^up^
SELECT e.emp_no, de.from_date, de.to_date
FROM employees AS e
JOIN dept_emp AS de USING(emp_no)
WHERE de.dept_no = 'd005'
GROUP BY e.emp_no, de.from_date, de.to_date
ORDER BY e.emp_no, de.to_date;