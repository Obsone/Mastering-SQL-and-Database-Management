-- how do we apply functions against a set of rows related to the current row?

-- average salary per department and then add the avg to every salary so we could
-- visually see how much each employee is from the average 

-- WINDOW FUNCTION - create a new column based on functions performed on a subset or 'window' of the data
-- https://www.postgresql.org/docs/12/tutorial-window.html

-- Let's get max salary and show also each individual employee salary
SELECT
    *,
    max(salary) OVER()
FROM salaries
-- limit 100;


-- PARTITION BY - divide rows into groups to apply the function against (optional)
SELECT
    *,
    avg(salary) OVER(
        PARTITION BY d.dept_name
    )
FROM salaries
JOIN dept_emp AS de USING (emp_no)
JOIN departments AS d USING (dept_no)
WHERE d.dept_name IN ('Marketing', 'Finance', 'Human Resources', 'Sales', 'Quality Management', 'Research')
-- not on the lession. You use the where clause to get a glimpse of every record in the department coz
-- the query or record output is more than 3million, you'll notice you get 1M records maybe because of the limitation of valentina studio

