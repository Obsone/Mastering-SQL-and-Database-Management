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
--correlated subquery where 2 queries are related and cannot stand alone
*/
SELECT
    emp_no,
    salary,
    from_date,
    (SELECT 
        title
    FROM titles AS t
    WHERE
        t.emp_no = s.emp_no AND t.from_date = s.from_date
--         t.emp_no = s.emp_no and (t.from_date = s.from_date + INTERVAL '2 days'
--         or t.from_date = s.from_date) --video reference-6.143
    )
FROM salaries AS s
ORDER BY emp_no;

--using LEFT OUTER JOIN is much easier
SELECT
    emp_no,
    salary,
    from_date,
    t.title
FROM salaries AS s
LEFT OUTER JOIN titles AS t USING (emp_no, from_date)
ORDER BY emp_no;

/*Getting the latest salary
*/
SELECT
    emp_no,
    salary AS "most recent salary",
    from_date
FROM salaries AS s
WHERE
    from_date = (
        SELECT max(from_date)
        FROM salaries AS sp
        --correlated subquery
        WHERE sp.emp_no = s.emp_no
    )
ORDER BY emp_no ASC;

--comparing when using CREATE VIEW 
CREATE OR REPLACE VIEW last_salary_change AS
SELECT  e.emp_no,
        max(s.from_date)
FROM salaries AS s

JOIN employees AS e USING(emp_no)
JOIN dept_emp AS de USING(emp_no)
JOIN departments AS d USING(dept_no)

GROUP BY e.emp_no
ORDER BY e.emp_no;

--then **we can use EXPLAIN ANALYZE
SELECT
    emp_no,
    salary AS "most recent salary",
    from_date
FROM salaries AS s
JOIN last_salary_change AS ls USING (emp_no)
WHERE from_date = ls.max
ORDER BY emp_no ASC;

--trying JOIN method as subquery can return multiple columns **this much less complex method and faster
-- EXPLAIN ANALYZE
SELECT
    emp_no,
    salary AS "most recent salary",
    from_date
FROM salaries AS s
JOIN (
    SELECT emp_no, max(from_date) AS "max"
    FROM salaries AS sp
    GROUP BY emp_no
) AS ls USING (emp_no)
WHERE ls.max = from_date
ORDER BY emp_no ASC;
