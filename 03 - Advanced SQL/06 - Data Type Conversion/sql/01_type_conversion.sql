SELECT CAST('100' AS INTEGER);

SELECT
    CAST('500' AS INTEGER) AS converted_value,
    pg_typeof(CAST('500' AS INTEGER)) AS data_type;

SELECT CAST('125.75' AS DECIMAL(10,2));

-- we can also do it to a table
-- SELECT CAST(price AS DECIMAL(10,2))
-- FROM some_table;

SELECT CAST(100 AS DECIMAL(10,2));

SELECT CAST(5 AS DECIMAL) / 2;

SELECT 5 / CAST(2 AS DECIMAL);

-- Shorthand syntax: ::

SELECT '100' :: INTEGER;

SELECT '2026-08-19'::DATE;

SELECT '14:12:00' :: TIME;