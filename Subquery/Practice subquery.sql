--using SUBQUERY--

/*Show all employees older than the average age
*/
SELECT
    first_name,
    last_name,
    age(birth_date), -- age() to see
    (SELECT avg(age(birth_date)) FROM employees) --checking
FROM employees
WHERE age(birth_date) > (SELECT avg(age(birth_date)) FROM employees); -- add AND gender = 'M' filter out F.
-- or (SELECT avg(age(birth_date)) from employees WHERE gender = 'M')

/*Show the title by salary for each employee
*/