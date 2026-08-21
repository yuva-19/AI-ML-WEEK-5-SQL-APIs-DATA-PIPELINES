# Semi Join and Anti Join

Semi Join returns rows from one table when a matching
row exists in another table.

Anti Join returns rows from one table when no matching
row exists in another table.

## Semi Join using EXISTS

Example:

SELECT
    c.customer_name
FROM join_customers AS c
WHERE EXISTS (
    SELECT 1
    FROM join_orders AS o
    WHERE o.customer_id = c.customer_id
);

This returns customers who have at least one order.

EXISTS returns TRUE when the subquery returns at least
one row.

## Anti Join using NOT EXISTS

Example:

SELECT
    c.customer_name
FROM join_customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM join_orders AS o
    WHERE o.customer_id = c.customer_id
);

This returns customers who have no orders.

## Semi Join using IN

Example:

SELECT customer_name
FROM join_customers
WHERE customer_id IN (
    SELECT customer_id
    FROM join_orders
);

## Anti Join using NOT IN

Example:

SELECT customer_name
FROM join_customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM join_orders
);

## Important: NULL and NOT IN

NOT IN can produce unexpected results when the
subquery contains NULL values.

For Anti Join logic, NOT EXISTS is often safer and
clearer.

## Summary

Semi Join:
Matching record exists.

Anti Join:
Matching record does not exist.

EXISTS:
Useful for Semi Join.

NOT EXISTS:
Useful for Anti Join.

IN:
Can implement Semi Join.

NOT IN:
Can implement Anti Join, but NULL must be considered.