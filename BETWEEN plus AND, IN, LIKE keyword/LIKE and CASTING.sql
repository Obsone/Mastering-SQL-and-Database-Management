-- practice 
SELECT first_name, last_name FROM employees
WHERE first_name ILIKE 'cH%a' ;
-- starts with cH(ilike usage regardless of upp/lower; ends with a)

/*
* DB: Employees
* Table: employees
* Question: Find the age of all employees who's name starts with M.
* Sample output: https://imgur.com/vXs4093
*/
SELECT emp_no, first_name, EXTRACT (YEAR FROM AGE(birth_date)) AS "age" FROM employees
WHERE first_name ILIKE 'M%';

/*
* DB: Employees
* Table: employees
* Question: How many people's name start with A and end with R?
* Expected output: 1846
*/
SELECT count(first_name) FROM employees
WHERE first_name ILIKE 'a%r';

/*
* DB: Store
* Table: customers
* Question: How many people's zipcode have a 2 in it?.
* Expected output: 4211 
*/
SELECT count(customerid) FROM customers
WHERE zip::TEXT LIKE '%2%';

/*
* DB: Store
* Table: customers
* Question: How many people's zipcode start with 2 with the 3rd character being a 1.
* Expected output: 109 
*/
SELECT count(customerid) FROM customers
WHERE zip::TEXT LIKE '2_1%';

/*
* DB: Store
* Table: customers
* Question: Which states have phone numbers starting with 302?
* Replace null values with "No State"                                                  
* Expected output: https://imgur.com/AVe6G4c
*/
SELECT phone, COALESCE(state, 'No state') FROM customers
WHERE phone::TEXT LIKE '302%';






