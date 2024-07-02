--EXERCISE--
/*
* Database: Store
* Table: products
* Create a case statement that's named "price class" where if a product is over 20 dollars you show 'expensive'
* if it's between 10 and 20 you show 'average' 
* and of is lower than or equal to 10 you show 'cheap'.
*/
 SELECT
    prod_id,
    price,
    title,
    CASE
        WHEN price > 20 THEN 'expensive'
        WHEN price BETWEEN 10 AND 20 THEN 'average'
        WHEN price <= 10 THEN 'cheap'
    END AS "price class"
FROM products;

--PRACTICE--
/*What if you only want to select something when a certain criteria is met?
*/
SELECT a,
        CASE WHEN a=1 THEN 'one'
             WHEN a=2 THEN 'two'
             ELSE 'other'
        END
FROM test;

-- case statements can be used in multiple places in a query 
-- each return must be a single output

SELECT
    o.orderid,
    o.customerid,
    CASE
        WHEN o.customerid = 1
        THEN 'my first customer'
        ELSE 'not my first customer'
    END,
    o.netamount
FROM orders AS o
ORDER BY o.customerid

-- FILTERING IN A WHERE STATEMENT
SELECT
    o.orderid,
    o.customerid,
    o.netamount
FROM orders AS o
WHERE   CASE
            WHEN o.customerid > 10
            THEN o.netamount < 100
            ELSE o.netamount > 100
        END
ORDER BY o.customerid

-- AGGREGATE FUNCTION
SELECT
    sum(
        CASE
            WHEN o.netamount > 300
            THEN -100
            ELSE o.netamount
        END
    ) AS "returns",
    sum(o.netamount) AS "normal total"
FROM orders AS o
-- This case in a business, let's say you want to make a discount when the order is > 300, you'll discount 100. 
-- You want to see how it will impact the total sales.