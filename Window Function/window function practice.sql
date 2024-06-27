-- PRACTICE
-- FIRST_VALUE - return a value evaluated against the first row within its partition
 /*I want to know how my price compares to the item with lowest price in the same category
 */
 SELECT
    prod_id,
    price,
    category,
    first_value( price ) OVER (
        PARTITION BY category
        ORDER BY price
--         RANGE between UNBOUNDED PRECEDING and UNBOUNDED FOLLOWING
-- nothing changes even if we add the range, coz we are looking first_value and ORDER BY works in everything that
--came before and that we are certain that we're getting the lowest price.
    ) AS "cheapest in category"
FROM products;

-- more simplier way, we use MIN()
SELECT
    prod_id,
    price,
    category,
    min( price ) OVER (
        PARTITION BY category
    ) AS "cheapest in category"
FROM products;

-- LAST_VALUE
/*I want to know how my price compares to the item with the highest price in the same category
*/
SELECT
    prod_id,
    price,
    category,
    last_value( price ) OVER (
        PARTITION BY category
        ORDER BY price
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS "expensive in category"
FROM products;

-- more simplier way, we use MAX()
SELECT
    prod_id,
    price,
    category,
    max( price ) OVER (
        PARTITION BY category
    ) AS "expensive in category"
FROM products;

-- SUM - Sum the values within a group depending on the framing
/*I want to see how much cumulatively a customer has ordered at our store
*/
SELECT
    o.orderid,
    o.customerid,
    o.netamount,
    sum(o.netamount) OVER (
        PARTITION BY o.customerid
        ORDER BY o.orderid
    ) AS "cumulative sum"
FROM orders AS o
ORDER BY o.customerid;

-- this is is useful when we want to see client's order total over time


-- ROW_NUMBER - number the current row within the partition starting from 1 regardless of framing
/*I want to know where my products is positioned in the category by price
*/
SELECT
    prod_id,
    price,
    category,
    row_number() OVER (
        PARTITION BY category
        ORDER BY price
    ) AS "position in category by price"
FROM products;

--SAME AS
SELECT
    prod_id,
    price,
    category,
    row_number() OVER (
        PARTITION BY category
        ORDER BY price
        RANGE BETWEEN CURRENT ROW AND CURRENT ROW
    ) AS "position in category by price"
FROM products;

--extra notes--
/*
ROWS: Defines the frame in terms of a physical number of rows.
RANGE: Defines the frame in terms of logical range of values. Useful on date with ties
*/ 
