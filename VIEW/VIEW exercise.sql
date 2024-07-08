/*
*  Create a view "90-95" that:
*  Shows me all the employees, hired between 1990 and 1995
*  Database: Employees
*/

CREATE VIEW "90-95" AS
SELECT *
FROM employees AS e
WHERE EXTRACT (YEAR FROM e.hire_date) BETWEEN 1990 AND 1995
ORDER BY e.emp_no;

--my answer--
SELECT  emp_no, hire_date FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1995-12-31';

/*
*  Create a view "bigbucks" that:
*  Shows me all employees that have ever had a salary over 80000
*  Database: Employees
*/

CREATE VIEW "bigbucks" AS
SELECT e.emp_no, s.salary
FROM employees AS e
JOIN salaries AS s USING(emp_no)
WHERE s.salary > 80000
ORDER BY s.salary;