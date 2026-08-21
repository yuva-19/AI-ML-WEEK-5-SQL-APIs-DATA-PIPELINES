# Multi-Row Subquery

A multi-row subquery returns multiple rows.

Example:

SELECT price
FROM subquery_products;

A multi-row subquery cannot normally be used where
a single value is expected.

Operators commonly used with multi-row subqueries:

- IN
- ANY
- ALL

## IN

IN checks whether a value matches one of the values
returned by the subquery.

Example:

SELECT
    product_name,
    price
FROM subquery_products
WHERE price IN (
    SELECT price
    FROM subquery_products
    WHERE price >= 1500
);

## ANY

ANY means the condition must be true for at least
one value returned by the subquery.

Example:

WHERE price > ANY (
    SELECT price
    FROM subquery_products
    WHERE price < 1500
);

## ALL

ALL means the condition must be true for every value
returned by the subquery.

Example:

WHERE price > ALL (
    SELECT price
    FROM subquery_products
    WHERE price < 1500
);

## Summary

Scalar subquery:
Returns one value.

Multi-row subquery:
Returns multiple rows.

IN:
Matches one of the returned values.

ANY:
Condition is true for at least one returned value.

ALL:
Condition is true for every returned value.


---
