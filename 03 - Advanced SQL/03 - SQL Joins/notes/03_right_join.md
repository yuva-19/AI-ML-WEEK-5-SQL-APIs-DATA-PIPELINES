# RIGHT JOIN

RIGHT JOIN returns all rows from the right table and
matching rows from the left table.

Example:

SELECT
    c.customer_name,
    o.product_name,
    o.amount
FROM join_customers AS c
RIGHT JOIN join_orders AS o
    ON c.customer_id = o.customer_id;

All rows from the right table are preserved.

If a right-table row has no matching left-table row,
NULL values appear for the left-table columns.

## RIGHT JOIN vs LEFT JOIN

RIGHT JOIN preserves the right table.

LEFT JOIN preserves the left table.

A RIGHT JOIN can usually be rewritten as a LEFT JOIN
by switching the table order.

Many developers prefer LEFT JOIN because it can make
queries easier to read.