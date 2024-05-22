SELECT avg(lifeexpectancy) FROM "public"."country";
-- 66.486 
SELECT * FROM "public"."countrylanguage"
WHERE isofficial = TRUE;

SELECT avg(population) FROM city
WHERE countrycode = 'NLD';

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