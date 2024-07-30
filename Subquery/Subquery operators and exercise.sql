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
