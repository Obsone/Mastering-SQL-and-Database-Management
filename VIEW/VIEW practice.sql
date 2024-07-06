-- VIEW - allows you to store and query previously run queries

-- Materialized -stores the data physically and periodically updated it when tables change
-- Non Materialized - query gets re-run each time the view is called on

CREATE VIEW view_name AS QUERY;

-- VIEWs are the output of the query we ran; views act like tables, you can query them; 

-- VIEWs take very little space to store.
-- We only store the definition of a view, not all of the data that it returns (non_materialized view)

--UPDATING A VIEW
CREATE OR REPLACE view_name AS QUERY; 
-- RENAME A VIEW
ALTER VIEW view_name RENAME TO view_name;
-- DELETING A VIEW
DROP VIEW [IF EXISTS ] view_name;

-- PRACTICE
/*Getting the most recent salary of an employee (lesson GROUP BY can't but WINDOW function can but complicated syntax; example)
*/  -- using VIEW

CREATE VIEW last_salary_change AS --step 1-- this one store the query line24-34 and we can SELECT * FROM last_salary_change
SELECT  e.emp_no,
        max(s.from_date)
FROM salaries AS s

JOIN employees AS e USING(emp_no)
JOIN dept_emp AS de USING(emp_no)
JOIN departments AS d USING(dept_no)

GROUP BY e.emp_no
ORDER BY e.emp_no;

-- step2 -- with this we can get the same result of current emp salary as we do on WINDOW function with much easier and intuitive syntax.
SELECT * FROM salaries
JOIN last_salary_change AS l USING (emp_no)
WHERE from_date = l.max
ORDER BY emp_no;

-- more elaborate way of the query same as step 2. We are joining the other way around using salaries
SELECT s.emp_no, d.dept_name, s.from_date, s.salary
FROM last_salary_change

JOIN salaries AS s USING(emp_no)
JOIN dept_emp AS de USING(emp_no)
JOIN departments AS d USING(dept_no)

WHERE max = s.from_date
ORDER BY s.emp_no;

 