/*
* DB: Store
* Table: products
* Question: Show NULL when the product is not on special (0)
*/

SELECT
    prod_id,
    title,
    price,
    NULLIF(special, 0) AS "special"
FROM products;

-- Using NULLIF() function to prevent division-by-zero

-- https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-nullif/
SELECT 
  (
    SUM (CASE WHEN gender = 1 THEN 1 ELSE 0 END) / NULLIF (
      SUM (CASE WHEN gender = 2 THEN 1 ELSE 0 END), 
      0
    )
  ) * 100 AS "Male/Female ratio" 
FROM 
  members;
