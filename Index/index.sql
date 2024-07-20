-- creating an index
CREATE UNIQUE INDEX index_name
ON table_name (column1, column2, ...);

--delete index
DROP INDEX index_name

-- when to use
/*
-index foreign keys
-index primary keys and unique columns
-index on columns that end up in the order by/where clause often
*/

-- when not to use
/*
• DON'T ADD AN INDEX JUST to add INDEX
• DON'T USE INDEXES ON SMALL TABLES
• DON'T USE ON TABLES that are UPDATED FREQUENTLY
• DON'T USE ON COLUMNS THAT CAN CONTAIN NULL values
• DON'T USE ON COLUMNS THAT HAVE large values
*/

-- INDEX TYPES
/*Single-column - most frequently used column in a query | use when retrieving data that satisfies one condition
Multi-column - '' | use when retrieving data that satisfies multiple condition
Unique - for speed and integrity
Partial - index over a subset of a table
implicit - automatically created by the database: primary and unique key
*/

--partial example
CREATE INDEX index_name
ON table_name (exppression)

EXPLAIN ANALYZE
SELECT "name", district, countrycode FROM city
WHERE countrycode IN ('TUN','BE', 'NL')
-- we will see on the execution time on this

--partial
CREATE INDEX idx_countrycode
ON city (countrycode) WHERE coutnrycode IN IN ('TUN','BE', 'NL');
--execute
EXPLAIN ANALYZE
SELECT "name", district, countrycode FROM city
WHERE countrycode IN ('TUN','BE', 'NL') --'PSE'
--notice the execution time


-- ALGORITHMS that can be used for index (like doing Google search)
