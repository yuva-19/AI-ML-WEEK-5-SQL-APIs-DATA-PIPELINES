# Subqueries

A subquery is a query written inside another SQL query.

The inner query is called the subquery.

The outer query uses the result of the subquery.

---

# Scalar Subquery

A scalar subquery returns exactly one value.

## Example

SELECT
    product_name,
    price
FROM subquery_products
WHERE price > (
    SELECT AVG(price)
    FROM subquery_products
);

The inner query calculates the average price.

The result is one value, which is then used by the
outer query.

## Another Example

SELECT
    product_name,
    price
FROM subquery_products
WHERE price = (
    SELECT MAX(price)
    FROM subquery_products
);

The MAX() subquery returns one value.

## Important

A scalar subquery must return one value when used in
a context that expects a single value.

Aggregate functions such as:

- AVG()
- MAX()
- MIN()
- SUM()
- COUNT()

commonly produce scalar results.

A query returning multiple rows is not a scalar
subquery.


---




