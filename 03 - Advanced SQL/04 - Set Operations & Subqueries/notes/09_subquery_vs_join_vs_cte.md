---

# Subquery vs JOIN vs CTE

## JOIN

JOIN is generally used to combine related data
from different tables.

Example:

SELECT
    c.customer_name,
    o.product_name,
    o.amount
FROM join_customers AS c
INNER JOIN join_orders AS o
    ON c.customer_id = o.customer_id;

Think:

"Which rows belong together?"

---

## Subquery

A subquery is useful when the result of one query
is needed by another query.

Common uses include:

- Filtering
- Comparisons
- Existence checks
- Calculations

Example:

SELECT
    product_name,
    price
FROM subquery_products
WHERE price > (
    SELECT AVG(price)
    FROM subquery_products
);

Think:

"What result do I need from another query?"

---

## CTE

A CTE creates a named intermediate result using
the WITH clause.

Example:

WITH expensive_products AS (
    SELECT *
    FROM subquery_products
    WHERE price > 10000
)
SELECT *
FROM expensive_products;

CTEs are useful for:

- Breaking complex queries into steps
- Improving readability
- Reusing an intermediate result within a query
- Multi-step data transformations

Think:

"Can I name this intermediate result and use it
as a building block?"

---

## Quick Decision Guide

JOIN:
Combine related data.

Subquery:
Use the result of another query for filtering,
comparison, existence checks, or calculations.

CTE:
Create readable intermediate query steps.

These approaches can also be combined in the
same SQL query.