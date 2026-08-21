# EXCEPT

EXCEPT returns rows from the first SELECT query that
do not exist in the second SELECT query.

## Example

SELECT customer_name
FROM set_customers_a

EXCEPT

SELECT customer_name
FROM set_customers_b;

This returns rows that exist in A but not in B.

## Important

EXCEPT is directional.

A EXCEPT B

is different from:

B EXCEPT A

EXCEPT removes duplicate rows from the result.