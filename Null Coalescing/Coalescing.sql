/*
* DB: https://www.db-fiddle.com/f/PnGNcaPYfGoEDvfexzEUA/0
* Question: 
* Assuming a students minimum age for the class is 15, what is the average age of a student?
*
* 30.4000000000000000
*/
SELECT avg(COALESCE(age, 15)) FROM "Student";

/*
* DB: https://www.db-fiddle.com/f/PnGNcaPYfGoEDvfexzEUA/0
* Question: 
* Replace all empty first or last names with a default?
*/
SELECT id, COALESCE(NAME, 'fallback'), COALESCE(lastName, 'lastName'), age FROM "Student";

-- more practice
-- 

SELECT id, NAME, lastName FROM "Student"
WHERE lastName IS NOT NULL;

-- NULL COALESCE PRACTICE 
SELECT id, COALESCE(NAME, 'no name available'), lastName FROM "Student";
-- on coalesce, you take name, else no name available.

-- sum ages
SELECT sum(COALESCE(age, 20))  FROM "Student"
-- if it is not age, return 20

-- coalesce application -> we had a database table where we have values and we had an approximation of what price should be, then we use COALESCE 