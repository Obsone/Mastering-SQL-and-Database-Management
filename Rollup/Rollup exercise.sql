SELECT  EXTRACT (YEAR FROM orderdate) AS "year" ,
        EXTRACT (MONTH FROM orderdate) AS "month",
        EXTRACT (DAY FROM orderdate) AS "day" ,
        sum(ol.quantity)
FROM orderlines AS ol
GROUP BY
    GROUPING SETS (
        (EXTRACT (YEAR FROM orderdate)),
        (
            EXTRACT (YEAR FROM orderdate),
            EXTRACT (MONTH FROM orderdate)
        ),
        (
            EXTRACT (YEAR FROM orderdate),
            EXTRACT (MONTH FROM orderdate),
            EXTRACT (DAY FROM orderdate)
        ),
        (
            EXTRACT (MONTH FROM orderdate),
            EXTRACT (DAY FROM orderdate)
        ),
        (EXTRACT (MONTH FROM orderdate)),
        (EXTRACT (DAY FROM orderdate)),
        ()
    )
ORDER BY
    EXTRACT (YEAR FROM orderdate),
    EXTRACT (MONTH FROM orderdate),
    EXTRACT (DAY FROM orderdate);
    
--     This example is too long and a lot of work that is why we will use ROLLUP (see the difference)

SELECT  EXTRACT (YEAR FROM orderdate) AS "year" ,
        EXTRACT (MONTH FROM orderdate) AS "month",
        EXTRACT (DAY FROM orderdate) AS "day" ,
        sum(ol.quantity)
FROM orderlines AS ol
GROUP BY
    ROLLUP (
        EXTRACT (YEAR FROM orderdate),
        EXTRACT (MONTH FROM orderdate),
        EXTRACT (DAY FROM orderdate)
    )
ORDER BY
    EXTRACT (YEAR FROM orderdate),
    EXTRACT (MONTH FROM orderdate),
    EXTRACT (DAY FROM orderdate);