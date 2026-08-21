# IN and NOT IN

## IN

IN checks whether a value matches any value in a
specified list or subquery result.

## Example

SELECT *
FROM filtering_products
WHERE category IN ('Electronics', 'Furniture');

This is equivalent to:

WHERE category = 'Electronics'
   OR category = 'Furniture';

## IN with Subquery

SELECT *
FROM filtering_products
WHERE category IN (
    SELECT category_name
    FROM preferred_categories
);

The outer query keeps rows whose category appears
in the subquery result.

---

# NOT IN

NOT IN returns rows whose value does not match any
value in the specified list.

## Example

SELECT *
FROM filtering_products
WHERE category NOT IN ('Electronics', 'Furniture');

## Important NULL Behavior

Be careful when using NOT IN with NULL values.

Example:

WHERE category NOT IN ('Electronics', NULL)

Because SQL uses three-valued logic, NULL can cause
the comparison to become UNKNOWN.

Therefore, NOT IN can produce unexpected results
when the list or subquery contains NULL.

NOT EXISTS is often a safer choice for exclusion
checks involving potentially NULL data.

## Quick Difference

IN:
Keep matching values.

NOT IN:
Keep non-matching values.

IN can be used with:
- Explicit lists
- Subqueries