# EXISTS and NOT EXISTS

## EXISTS

EXISTS checks whether the subquery returns at least
one row.

Example:

SELECT
    c.customer_id,
    c.customer_name
FROM exists_customers AS c
WHERE EXISTS (
    SELECT 1
    FROM exists_orders AS o
    WHERE o.customer_id = c.customer_id
);

If a matching order exists, EXISTS returns TRUE.

## SELECT 1

SELECT 1 is commonly used inside EXISTS because
the actual value returned by the subquery is not
important.

EXISTS only cares whether at least one row exists.

---

# NOT EXISTS

NOT EXISTS checks whether the subquery returns no
matching rows.

Example:

SELECT
    c.customer_id,
    c.customer_name
FROM exists_customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM exists_orders AS o
    WHERE o.customer_id = c.customer_id
);

This finds customers who have no orders.

---

# EXISTS vs IN

IN checks whether a value appears in a set.

EXISTS checks whether a matching row exists.

IN example:

WHERE customer_id IN (
    SELECT customer_id
    FROM exists_orders
);

EXISTS example:

WHERE EXISTS (
    SELECT 1
    FROM exists_orders AS o
    WHERE o.customer_id = c.customer_id
);

---

# NOT EXISTS vs NOT IN

NOT IN can produce unexpected results when the
subquery contains NULL values because SQL uses
three-valued logic.

NOT EXISTS directly checks whether a matching row
exists and is often safer for exclusion checks
involving potentially NULL values.

## Common Uses

- Checking relationships between tables
- Finding records with related rows
- Finding records without related rows
- Data validation
- Finding missing relationships



