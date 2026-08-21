# INNER JOIN

INNER JOIN combines rows from two tables when their
join condition matches.

## Basic Syntax

SELECT columns
FROM table1
INNER JOIN table2
    ON table1.column = table2.column;

## Example

SELECT
    c.customer_name,
    o.product_name,
    o.amount
FROM join_customers AS c
INNER JOIN join_orders AS o
    ON c.customer_id = o.customer_id;

Only customers with matching orders are returned.

## Important

The ON clause defines how the two tables are connected.

INNER JOIN excludes rows that do not have a match
in both tables.

Example:

If a customer has no order, that customer will not
appear in an INNER JOIN result.

## JOIN + WHERE

JOIN connects the tables.

WHERE filters the resulting rows.

Example:

SELECT
    c.customer_name,
    o.product_name,
    o.amount
FROM join_customers AS c
INNER JOIN join_orders AS o
    ON c.customer_id = o.customer_id
WHERE o.amount > 1000;