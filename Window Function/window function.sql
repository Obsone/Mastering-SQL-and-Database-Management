-- how do we apply functions against a set of rows related to the current row?

-- average salary per department and then add the avg to every salary so we could
-- visually see how much each employee is from the average 

-- WINDOW FUNCTION - create a new column based on functions performed on a subset or 'window' of the data
-- https://www.postgresql.org/docs/12/tutorial-window.html

-- Let's get current salary and show also each individual employee salary
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

SELECT  emp_no,
        salary,
        count(salary) OVER (
                ORDER BY emp_no
        )
FROM salaries
-- in this example. With ORDER BY we will notice cumulative counting everything that came beofre with everything
-- that comes after(counting the employee no, the amount of times it occurs and basically adding that to the prev. sum)

SELECT  emp_no,
        salary,
        count(salary) OVER (
                PARTITION BY emp_no
                ORDER BY emp_no
        )
FROM salaries

-- notice the PARTITION BY. It does not take into account the prev count/partition
-- if we ORDER BY salary. Salary shows unique values so the result will count forward

SELECT  emp_no,
        salary,
        count(salary) OVER (
                PARTITION BY emp_no
                ORDER BY salary
                RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        )
FROM salaries

-- take everything into account before and after. RETURNS ALL.
-- same as removing line 54 and 55.
-- RANGE - behaves similarly to ROWS but if there are ties in ORDER BY clause we can see differences

--FRAME CLAUSE - when using a frame clause in a window function we can create a sub-range or frame

-- THE CURRENT SALARY PROBLEM
SELECT  e.emp_no,
        e.first_name,
        d.dept_name,
        max(s.salary) --this will be good if the salary of the emp is progressing forward and not hitting a bumb,
        -- but we know it is not as per the emp_no.3 hit a bump
        -- the max salary isnt necessarily what you make right now
        -- if max(s.from_date) we won't know what it was
FROM salaries AS s

JOIN employees AS e USING (emp_no)
JOIN dept_emp AS de USING (emp_no)
JOIN departments AS d USING (dept_no)

GROUP BY e.emp_no, e.first_name, d.dept_name
ORDER BY e.emp_no;

--simple answer
SELECT  DISTINCT emp_no,
        last_value(s.salary) OVER (
            PARTITION BY s.emp_no
            ORDER BY s.from_date
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS "current salary"
            
FROM salaries AS s
JOIN dept_emp AS de USING (emp_no);

-- THE ANSWER
SELECT  DISTINCT e.emp_no,
        e.first_name,
        d.dept_name,
        last_value(s.from_date) OVER (
            PARTITION BY e.emp_no
            ORDER BY s.from_date
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ),
-- we can add this syntax (last_value-from_date)if we want to be certain that
-- we get the current salary/last_value of the employee
        last_value(s.salary) OVER (
            PARTITION BY e.emp_no
            ORDER BY s.from_date
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS "current salary"
            
FROM salaries AS s

JOIN employees AS e USING (emp_no)
JOIN dept_emp AS de USING (emp_no)
JOIN departments AS d USING (dept_no)

ORDER BY e.emp_no;

-- notice the DISTINCT keyword to filter further.
-- LAST_VALUE -  

SELECT  DISTINCT emp_no,
--         s.from_date,
--         s.salary
        last_value(s.salary) OVER (
            PARTITION BY s.emp_no
            ORDER BY s.from_date
        ) AS "current salary"
            
FROM salaries AS s
JOIN dept_emp AS de USING (emp_no);

-- removing the FRAME CLAUSE to see what will happen. ORDER BY - looks at everything that came before and the current row.
-- we will notice that it doesn't change anything, as if we just put s.salary, s.from_date.
-- remove line 124-127.
-- that's why FRAMING IS THE MOST IMPORTANT PART so that we take into account the entire range.

