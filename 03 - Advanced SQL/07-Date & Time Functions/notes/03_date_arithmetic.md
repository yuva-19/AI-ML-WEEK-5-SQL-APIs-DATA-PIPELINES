# Date Arithmetic

Date arithmetic is used to add, subtract, and compare
dates and timestamps.

## Add Time

Dates and timestamps can be combined with INTERVAL.

Example:

SELECT DATE '2026-08-19' + INTERVAL '7 days';

## Subtract Time

Example:

SELECT DATE '2026-08-19' - INTERVAL '7 days';

## Add Months / Years

SELECT DATE '2026-08-19' + INTERVAL '2 months';

SELECT DATE '2026-08-19' + INTERVAL '1 year';

## Date Difference

Subtracting two DATE values returns the number
of days between them.

Example:

SELECT DATE '2026-08-19' - DATE '2026-08-10';

→ 9

## Timestamp Difference

Subtracting two TIMESTAMP values returns an INTERVAL.

Example:

SELECT
    TIMESTAMP '2026-08-19 18:30:00'
    -
    TIMESTAMP '2026-08-19 15:00:00';

## AGE

AGE() calculates the difference between dates or
timestamps in years, months, and days.

Example:

SELECT AGE(
    CURRENT_DATE,
    DATE '2000-05-15'
);

## ML / Feature Engineering

Date arithmetic is useful for creating features such as:

- Customer age
- Days since last purchase
- Time between events
- Days until next event
- Customer lifetime duration