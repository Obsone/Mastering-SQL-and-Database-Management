/*
* DB: Store
* Table: Customers
* Question: 
* Select people either under 30 or over 50 with an income above 50000
* Include people that are 50
* that are from either Japan or Australia
*/
SELECT age, income, country FROM customers
WHERE (age < 30 OR age >= 50) AND income > 50000
AND (country = 'Japan' OR country = 'Australia');

/*
* DB: Store
* Table: Orders
* Question: 
* What was our total sales in June of 2004 for orders over 100 dollars?
*/
SELECT SUM(totalamount) FROM orders
WHERE (orderdate >= '2004-06-01' AND orderdate <= '2004-06-30') AND totalamount > 100 

