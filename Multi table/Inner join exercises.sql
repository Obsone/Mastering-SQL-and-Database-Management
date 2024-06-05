-- Using WHERE clause on multi table SELECT
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



--exercise--  
