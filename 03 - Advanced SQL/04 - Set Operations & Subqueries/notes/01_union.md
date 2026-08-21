# UNION

UNION combines the results of two or more SELECT
queries and removes duplicate rows.

## Example

SELECT customer_name
FROM set_customers_a

UNION

SELECT customer_name
FROM set_customers_b;

Duplicate rows appear only once.

## Rules

The SELECT statements used with UNION should have:

- The same number of columns
- Compatible data types
- Corresponding columns in the same order

## Important

UNION removes duplicate rows.