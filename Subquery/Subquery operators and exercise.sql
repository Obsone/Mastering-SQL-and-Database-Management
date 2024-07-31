--Subquery operators

/*EXISTS - check if the subquery returns any rows
*/
SELECT firstname, lastname, income
FROM customers AS c
WHERE EXISTS (
    SELECT * FROM orders AS o
    WHERE c.customerid = o.customerid AND totalamount > 400
) AND income > 90000;

/*IN - check if the value is equal to any of the rows in the return (null yields null)
*/
SELECT prod_id
FROM products
WHERE category IN (
    SELECT category FROM categories
    WHERE categoryname IN ('Comedy', 'Family', 'Classics')
);

/*NOT IN - check if the value is not equal to any of the rows in the return (null yields null)
*/
SELECT prod_id
FROM products
WHERE category IN (
    SELECT category FROM categories
    WHERE categoryname NOT IN ('Comedy', 'Family', 'Classics')
);

/*ANY/SOME - check each row against the operator and if any comparison
matches return true
*/
SELECT prod_id
FROM products
WHERE category = ANY (
    SELECT category FROM categories
    WHERE categoryname IN ('Comedy', 'Family', 'Classics')
);

/*ALL - inverse of any/some - check each row against the operator and if ALL comparisons match return true
--Use Case: Ideal for scenarios where you need to compare a value against every value in a subquery result.
*/
SELECT prod_id, title, sales
FROM products
JOIN inventory AS i USING (prod_id)
WHERE i.sales > ALL (
    SELECT avg(sales) FROM inventory
    JOIN products AS p1 USING (prod_id)
    GROUP BY p1.category
);

/*SINGLE VALUE COMPARISON (>, <, =) - subquery must return a single row check comparato against row 
*/
SELECT prod_id
FROM products
WHERE category = (
    SELECT category FROM categories
    WHERE categoryname IN ('Comedy')
);

-----------------------------------------------------------------------------------------------------------------------------------
/* TRY TO WRITE THESE AS JOINS FIRST */
/*
* DB: Store
* Table: orders
* Question: Get all orders from customers who live in Ohio (OH), New York (NY) or Oregon (OR) state
* ordered by orderid
*/

SELECT c.firstname, c.lastname, o.orderid 
FROM orders AS o, (
    SELECT customerid, state, firstname, lastname
    FROM customers
) AS c
WHERE  o.customerid = c.customerid AND 
c.state IN ('NY', 'OH', 'OR')
ORDER BY o.orderid;

/*
* DB: Employees
* Table: employees
* Question: Filter employees who have emp_no 110183 as a manager
*/

SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no IN (
    SELECT emp_no
    FROM dept_emp
    WHERE dept_no = (
        SELECT dept_no 
        FROM dept_manager
        WHERE emp_no = 110183
    )
)
ORDER BY emp_no

-- Written with JOIN
SELECT e.emp_no, first_name, last_name
FROM employees AS e
JOIN dept_emp AS de USING (emp_no)
JOIN dept_manager AS dm USING (dept_no)
WHERE dm.emp_no = 110183