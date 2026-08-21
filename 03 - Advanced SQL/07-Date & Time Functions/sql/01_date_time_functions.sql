-- DATE_TRUNC
-- DATE_TRUNC is used to truncate a date/time to a specific time unit.
-- "Give me the beginning of this month / day / year / week."

SELECT DATE_TRUNC('year', TIMESTAMP '2026-08-19 14:35:27');

SELECT DATE_TRUNC('month',TIMESTAMP '2026-08-19 14:35:27');

SELECT DATE_TRUNC(
    'day',
    TIMESTAMP '2026-08-19 14:35:27'
);



CREATE TABLE date_sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id INT,
    sale_amount DECIMAL(10,2),
    sale_time TIMESTAMP
);

INSERT INTO date_sales
    (customer_id, sale_amount, sale_time)
VALUES
    (1, 500, '2026-01-05 10:30:00'),
    (2, 700, '2026-01-15 14:20:00'),
    (3, 300, '2026-02-03 09:15:00'),
    (1, 900, '2026-02-19 16:45:00'),
    (4, 1200, '2026-03-10 11:00:00'),
    (2, 450, '2026-03-25 18:30:00');

SELECT * FROM date_sales;


-- SQL Query Execution Order (simplified)
-- FROM → pick the table(s)
-- WHERE → filter rows (if condition exists)
-- GROUP BY → group rows into buckets
-- HAVING → filter groups (like WHERE but after grouping)
-- SELECT → choose columns & apply aggregates (SUM, COUNT, etc.)
-- ORDER BY → sort the final result
-- LIMIT → restrict number of rows returned


-- So in this Querey first it will run from data_sales
-- then it will groupby each month
-- then it will Process SELECT
-- now finnaly it will do ORDERBY month
SELECT
    DATE_TRUNC('month',sale_time) as month,
    SUM(sale_amount) AS total_sales
FROM date_sales
GROUP BY DATE_TRUNC('month',sale_time)
ORDER BY month;


-- EXTRACT

SELECT EXTRACT(YEAR FROM TIMESTAMP '2026-08-19 14:35:27');
SELECT EXTRACT(MONTH FROM TIMESTAMP '2026-08-19 14:35:27');
SELECT EXTRACT(DAY FROM TIMESTAMP '2026-08-19 14:35:27');

SELECT EXTRACT(HOUR FROM TIMESTAMP '2026-08-19 14:35:27');
SELECT EXTRACT(MINUTE FROM TIMESTAMP '2026-08-19 14:35:27');
SELECT EXTRACT(SECOND FROM TIMESTAMP '2026-08-19 14:35:27');

SELECT * FROM date_sales;

SELECT
    sale_id,
    sale_time,
    EXTRACT(MONTH FROM sale_time) AS sale_month
FROM date_sales;

SELECT
    sale_time,
    EXTRACT(DOW FROM sale_time) AS day_of_week
FROM date_sales;

SELECT
    sale_time,
    EXTRACT(WEEK FROM sale_time) AS week_number
FROM date_sales;

SELECT
    sale_time,
    EXTRACT(QUARTER FROM sale_time) AS quarter
FROM date_sales;

SELECT
    EXTRACT(MONTH from sale_time) AS month,
    SUM(sale_amount) AS total_sales
FROM date_sales
GROUP BY EXTRACT(MONTH from sale_time)
ORDER BY month;



-- DATE ARITHMETIC

SELECT DATE '2026-08-19' + INTERVAL '7 days';
SELECT DATE '2026-08-19' - INTERVAL '7 days';
SELECT DATE '2026-08-19' + INTERVAL '2 months';
SELECT DATE '2026-08-19' - DATE '2026-08-10';

SELECT
    TIMESTAMP '2026-08-19 18:30:00'
    -
    TIMESTAMP '2026-08-19 15:00:00';

-- CURRENT_DATE is inbuilt function
-- uses ur exact date and time
SELECT
    sale_id,
    sale_time,
    CURRENT_DATE - sale_time::DATE AS days_since_sale
FROM date_sales;

-- adding time to column
SELECT
    sale_id,
    sale_time,
    sale_time + INTERVAL '30 days' AS follow_up_date
FROM date_sales;

SELECT AGE(
    DATE '2026-08-18',
    DATE '2008-08-18'
);

SELECT
    AGE(
        CURRENT_DATE,
        DATE '2000-05-15'
    );

-- DATE COMPARISONS

SELECT *
FROM date_sales
WHERE sale_time > TIMESTAMP '2026-02-01 00:00:00';

SELECT *
FROM date_sales
WHERE sale_time < TIMESTAMP '2026-02-01 00:00:00';


SELECT *
FROM date_sales
WHERE sale_time = TIMESTAMP '2026-02-19 16:45:00';

-- Compare only the date
SELECT *
FROM date_sales
WHERE sale_time::DATE = DATE '2026-02-19';

-- In BETWEEN Range
SELECT *
FROM date_sales
WHERE sale_time BETWEEN
    TIMESTAMP '2026-02-01 00:00:00'
    AND
    TIMESTAMP '2026-02-28 23:59:59';
        
-- we can also use current_date for comparision
SELECT *
FROM date_sales
WHERE sale_time::DATE < CURRENT_DATE;




