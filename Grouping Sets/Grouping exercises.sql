/*
*  Calculate the total amount of employees per department using grouping sets
*  Database: Employees
*  Table: Employees
*/
SELECT  count(e.emp_no),
        d.dept_no
FROM employees AS e
INNER JOIN dept_emp AS d USING(emp_no)
GROUP BY d.dept_no;

--differenciate your work ^up^--
 
SELECT GROUPING(e.dept_no), e.dept_no, COUNT(e.emp_no)
FROM public.dept_emp AS e
GROUP BY
	GROUPING SETS (
		(e.dept_no),
     		()
	)
ORDER BY e.dept_no;


/*
*  Calculate the total average salary per department and the total using grouping sets
*  Database: Employees
*  Table: Employees
*/
SELECT GROUPING(de.dept_no), de.dept_no, AVG(e.salary)
FROM salaries AS e
INNER JOIN dept_emp AS de USING (emp_no)
GROUP BY
    GROUPING SETS (
        (de.dept_no),
        ()
    )
ORDER BY de.dept_no;