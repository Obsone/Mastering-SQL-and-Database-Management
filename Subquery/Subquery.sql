-- SUBQUERY - is a construct that allows you to build extremely complex queries.
-- a query within a another sql query most often found in the where clause.

SELECT *
FROM table_name
WHERE column_name condition (
    SELECT column_name, column_name, ...
    FROM table_name
    [WHERE | GROUP BY | ORDER BY | ...]
)

-- subquery can also be use in the SELECT, FROM, and HAVING clause

--example using in SELECT:
SELECT (
    SELECT column_name, column_name, ...
    FROM table_name
    [WHERE | GROUP BY | ORDER BY | ...]
) -- must return a single record
FROM table_name AS <n4me>

--in FROM clause: application - if we only wanted to select the subset of something that already ran a calculation...
SELECT *
FROM (
    SELECT column_name, column_name, ...
    FROM table_name
    [WHERE | GROUP BY | ORDER BY | ...]
) AS <n4me>

--in HAVING clause: 
SELECT *
FROM table_name AS <n4me>
GROUP BY column_name
HAVING (
    -- must return a single record;  cannot select multiple column
    SELECT column_name
    FROM table_name
    [WHERE | GROUP BY | ORDER BY | ...]
) > X


-- SUBQUERIES VS JOINS
-- both subquery and joins combine data from different tables
-- SUBQUERIES are queries that could stand alone; can return a single result or a row set
-- JOINS combines rows from one or more tables based on a match condition; can only return a row set(combination of table A AND B)

SELECT title, price, (SELECT avg(price) FROM products) AS -- SELECT clause single result
"golbal avergage price"
FROM (                                                    -- FROM clause return multiple rows 
    SELECT * FROM products WHERE price < 10
) AS "products_sub"

-- SUBQUERY result are immediately used/shown on the screen
-- JOIN can be used in the outer query

-- **Just prefer using JOIN ^_^

-- GUIDELINES
-- a subquery must be enclosed in parentheses
-- must be placed on the right side of the comparison operator
-- cannot manipulate their results internally
-- use single-row operators with single-row subqueries
-- subqueries that return null may not return results

--SINGLE ROW - returns zero or one row
SELECT "name", salary
FROM salaries
WHERE salary =
    (SELECT avg(salary) FROM salaries);
    
SELECT "name", salary,
    (SELECT avg(salary) FROM salaries)
    AS "Company average salary"
FROM salaries;

-- MULTIPLE ROW - returns one or more rows
SELECT title, price, category
FROM products
WHERE category IN (
    SELECT category FROM categories
    WHERE categoryname IN ('Comedy', 'Family', 'Classics')
);

--MUTIPLE COLUMN - returns one or more columns
SELECT emp_no, salary, dea.avg AS "Department average salary"
FROM salaries AS s
JOIN dept_emp AS de USING( emp_no)
JOIN (
        SELECT dept_no, AVG( salary) FROM salaries AS s2
        JOIN dept_emp AS e USING( emp_no)
        GROUP BY dept_no
     ) AS dea USING(dept_no)
WHERE salary > dea.avg;

--CORRELATED - reference one or more columns in the outer statement - runs against each row
SELECT emp_no, salary, from_date
FROM salaries AS s
WHERE from_date = (
    SELECT max( s2.from_date) AS max
    FROM salaries AS s2
    WHERE s2.emp_no = s.emp_no
)
ORDER BY emp_no;

--NESTED - subq in a subq
SELECT orderlineid, prod_id, quantity
FROM orderlines
JOIN (
    SELECT prod_id
    FROM products
    WHERE category IN (
        SELECT category FROM categories
        WHERE categoryname IN ('Comedy', 'Family', 'Classics')
    )
) AS limited USING (prod_id);
