# LEFT JOIN

LEFT JOIN returns all rows from the left table and
matching rows from the right table.

If no matching row exists in the right table, NULL
values are returned for the right table columns.

## Basic Syntax

SELECT columns
FROM table1
LEFT JOIN table2
    ON table1.column = table2.column;

## Example

SELECT
    c.customer_name,
    o.product_name,
    o.amount
FROM join_customers AS c
LEFT JOIN join_orders AS o
    ON c.customer_id = o.customer_id;

All customers are returned.

Customers without orders will have NULL values for
the order columns.

## INNER JOIN vs LEFT JOIN

INNER JOIN:
Returns only rows with matches in both tables.

LEFT JOIN:
Returns all rows from the left table and matching
rows from the right table.

## Finding Unmatched Rows

A LEFT JOIN can be used to find rows that do not have
a matching record.

Example:

SELECT
    c.customer_name
FROM join_customers AS c
LEFT JOIN join_orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

This finds customers who have no orders.

## Important

LEFT JOIN preserves every row from the left table.

Missing matches from the right table appear as NULL.