-- PRACTICE
-- FIRST_VALUE
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