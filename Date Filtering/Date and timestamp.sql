--PRACTICE
-- SELECT to_char( CURRENT_DATE, 'yyyy');
SELECT age(date '1800/01/01'); -- casting date
SELECT age( CURRENT_DATE, date '1996-09-26');
-- calculate age between
/*
you can change current_date into any specific date you want ie: date '2024-01-01' 
*/

SELECT EXTRACT(DAY FROM date '1996-09-26') AS DAY; --extract day
-- extract month **use MONTH
-- extract YEAR

SELECT date_trunc( 'year', date '1996-09-26');
-- round a date **try 'month''

-- EXECERSIE
/*
* DB: Employees
* Table: employees
* Question: Get me all the employees above 60, use the appropriate date functions
*/
SELECT first_name, EXTRACT (YEAR FROM age( birth_date)) AS "age" FROM employees
WHERE EXTRACT (YEAR FROM age( birth_date)) > 60;

/*
* DB: Employees
* Table: employees
* Question: How many employees where hired in February?
*/
SELECT first_name, hire_date FROM employees
WHERE EXTRACT( MONTH FROM hire_date) = 02; 

/*
* DB: Employees
* Table: employees
* Question: How many employees were born in november?
*/
SELECT birth_date FROM employees
WHERE EXTRACT (MONTH FROM birth_date) = 11;

/*
* DB: Employees
* Table: employees
* Question: Who is the oldest employee? (Use the analytical function MAX)
*/
SELECT first_name, birth_date FROM employees
WHERE birth_date = (SELECT min(birth_date) FROM employees);

/*
* DB: Store
* Table: orders
* Question: How many orders were made in January 2004?
*/
-- 3 POSSIBLE SYNTAX

SELECT count(orderdate) FROM orders
WHERE EXTRACT (YEAR FROM orderdate) = 2004
AND
EXTRACT (MONTH FROM orderdate) = 01;

SELECT count(orderid)
FROM orders
WHERE DATE_TRUNC('month', orderdate) = date '2004-01-01';

SELECT date_trunc('month', orderdate) AS MONTH, COUNT(*) AS order_count
FROM orders
GROUP BY date_trunc('month', orderdate)
ORDER BY MONTH; 