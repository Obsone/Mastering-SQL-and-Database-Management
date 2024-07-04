-- VIEW - allows you to store and query previously run queries

-- Materialized -stores the data physically and periodically updated it when tables change
-- Non Materialized - query gets re-run each time the view is called on

CREATE VIEW view_name AS QUERY;

-- VIEWs are the output of the query we ran; views act like tables, you can query them; 

-- VIEWs take very little space to store.
-- We only store the definition of a view, not all of the data that it returns (non_materialized view)

--UPDATING A VIEW
CREATE OR REPLACE view_name AS QUERY; 
-- RENAME A VIEW
ALTER VIEW view_name RENAME TO view_name;
-- DELETING A VIEW
DROP VIEW [IF EXISTS ] view_name;