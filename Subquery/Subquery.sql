-- SUBQUERY - is a construct that allows you to build extremely complex queries.
-- a query within a another sql query most often found in the where clause.

SELECT *
FROM table_name
WHERE column_name condition (
    SELECT column_name, column_name, ...
    FROM table_name
    [WHERE | GROUP BY | ORDER BY | ...]
)

-- subquery can also be use in the SELECT, FROM, and HAVING clause

--example using in SELECT:
SELECT (
    SELECT column_name, column_name, ...
    FROM table_name
    [WHERE | GROUP BY | ORDER BY | ...]
) -- must return a single record
FROM table_name AS <n4me>

--in FROM clause: application - if we only wanted to select the subset of something that already ran a calculation...
SELECT *
FROM (
    SELECT column_name, column_name, ...
    FROM table_name
    [WHERE | GROUP BY | ORDER BY | ...]
) AS <n4me>

--in HAVING clause: 
SELECT *
FROM table_name AS <n4me>
GROUP BY column_name
HAVING (
    -- must return a single record;  cannot select multiple column
    SELECT column_name
    FROM table_name
    [WHERE | GROUP BY | ORDER BY | ...]
) > X


-- SUBQUERIES VS JOINS
