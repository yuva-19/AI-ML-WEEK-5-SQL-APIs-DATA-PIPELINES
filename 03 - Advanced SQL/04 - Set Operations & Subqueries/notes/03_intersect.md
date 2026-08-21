# INTERSECT

INTERSECT returns rows that exist in both SELECT
query results.

## Example

SELECT customer_name
FROM set_customers_a

INTERSECT

SELECT customer_name
FROM set_customers_b;

Only rows present in both results are returned.

## Important

INTERSECT removes duplicate rows.

INTERSECT is not directional:

A INTERSECT B

produces the same set of rows as:

B INTERSECT A