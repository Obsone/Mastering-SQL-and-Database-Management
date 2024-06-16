----GROUP BY mental mode -----

/*
get me the most recent date that they got a salary bump
*/ 
SELECT emp_no, salary, max(from_date) 
--note: what if they got a salary decrease? we cant use MAX and we can't say that is the max salary from_date
FROM salaries
GROUP BY emp_no

--we want to combine the results of multiple groupings 
-- we will know more on how to do it next...