# FULL OUTER JOIN

FULL OUTER JOIN returns all rows from both tables.

Matching rows are combined.

Non-matching rows are also preserved, with NULL values
for the missing side.

Example:

SELECT
    c.customer_name,
    o.product_name,
    o.amount
FROM join_customers AS c
FULL OUTER JOIN join_orders AS o
    ON c.customer_id = o.customer_id;

## Concept

INNER JOIN:
Only matching rows.

LEFT JOIN:
All left rows + matching right rows.

RIGHT JOIN:
All right rows + matching left rows.

FULL OUTER JOIN:
All rows from both tables.

## Finding Unmatched Records

A FULL OUTER JOIN can be used to find records that
exist only on one side.

Example:

WHERE c.customer_id IS NULL
   OR o.order_id IS NULL;