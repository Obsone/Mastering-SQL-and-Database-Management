-- Using WHERE clause on multi table SELECT
-- self join
SELECT a.emp_no, concat( a.first_name, ' ' ,a.last_name ) AS "name", b.salary 
FROM employees AS a, salaries AS b 
WHERE a.emp_no = b.emp_no;

-- 
SELECT  a.emp_no,
        concat( a.first_name, ' ' ,a.last_name ) AS "name",
        b.salary 
FROM employees AS a 
INNER JOIN salaries AS b ON b.emp_no = a.emp_no;

-- 3 tables
SELECT  a.emp_no,
        concat( a.first_name, ' ' ,a.last_name ) AS "name",
        b.salary,
        c.title,
        c.from_date AS "prompted on"
FROM employees AS a
INNER JOIN titles AS c ON c.emp_
INNER JOIN salaries AS b ON b.emp_no = a.emp_no;

-- get the emp.no salary when they came in and salary when they got a raise
SELECT  a.emp_no,
        concat( a.first_name, ' ' ,a.last_name ) AS "name",
        b.salary,
        c.title,
        c.from_date AS "prompted on"
FROM employees AS a
INNER JOIN salaries AS b ON b.emp_no = a.emp_no
INNER JOIN titles AS c 
        ON c.emp_no = a.emp_no
        AND ( b.from_date = c.from_date -- initial title
        OR c.from_date = (b.from_date + INTERVAL '2 days') -- tenured salary
        )
ORDER BY a.emp_no;

--how many employees that arent managers
SELECT emp.emp_no, dep.emp_no
FROM employees AS emp
LEFT JOIN dept_manager AS dep ON emp.emp_no = dep.emp_no
WHERE dep.emp_no IS NULL; -- IS NOT NULL determines # of managers

--know every salary raise and also which ones were a promotion
SELECT  a.emp_no,
        concat( a.first_name, ' ' ,a.last_name ) AS "name",
        b.salary,
        COALESCE( c.title, 'no title change'),
        c.from_date AS "prompted on"
FROM employees AS a
INNER JOIN salaries AS b ON b.emp_no = a.emp_no
LEFT JOIN titles AS c 
        ON c.emp_no = a.emp_no
        AND ( b.from_date = c.from_date -- initial title
        OR c.from_date = (b.from_date + INTERVAL '2 days') -- tenured salary
        )
ORDER BY a.emp_no;
 

--exercise--  
