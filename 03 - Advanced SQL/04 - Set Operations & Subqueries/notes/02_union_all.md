# UNION ALL

UNION ALL combines the results of SELECT queries
without removing duplicates.

## Example

SELECT customer_name
FROM set_customers_a

UNION ALL

SELECT customer_name
FROM set_customers_b;

If the same row exists in both queries, it appears
multiple times.

## UNION vs UNION ALL

UNION:
Combines results and removes duplicates.

UNION ALL:
Combines results and keeps duplicates.

UNION ALL is generally faster when duplicate
elimination is not required.