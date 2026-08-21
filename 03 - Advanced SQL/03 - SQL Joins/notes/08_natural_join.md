# NATURAL JOIN

NATURAL JOIN automatically joins two tables using
columns that have the same name.

## Example

SELECT
    customer_name,
    product_name,
    amount
FROM join_customers
NATURAL JOIN join_orders;

If both tables contain customer_id, PostgreSQL can
automatically use customer_id as the join condition.

## Why Explicit JOIN is Preferred

NATURAL JOIN hides the join condition.

Example:

SELECT *
FROM join_customers AS c
INNER JOIN join_orders AS o
    ON c.customer_id = o.customer_id;

The explicit JOIN clearly shows how the tables are
connected.

## Potential Problem

If additional columns with the same name are added
to both tables, NATURAL JOIN may automatically use
those columns as additional join conditions.

This can unexpectedly change the query result.

## Recommendation

Prefer explicit JOIN conditions in real projects
because they are:

- Clear
- Predictable
- Easier to maintain
- Safer when table structures change

Natural JOIN is mainly useful to understand as a
SQL concept.