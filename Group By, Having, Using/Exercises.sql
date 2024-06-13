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
