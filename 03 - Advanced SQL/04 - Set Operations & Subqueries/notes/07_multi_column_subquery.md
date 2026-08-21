# Multi-Column Subquery

A multi-column subquery returns multiple columns.

It can be used to compare multiple values together.

## Example

SELECT
    product_name,
    category,
    price
FROM subquery_products
WHERE (product_name, category, price) IN (
    SELECT
        product_name,
        category,
        price
    FROM subquery_product_targets
);

The outer query compares the complete combination of
product_name, category, and price with the rows returned
by the subquery.

## Row Constructor

The following is a row constructor:

(product_name, category, price)

It allows multiple column values to be compared
together.

## Important Difference

Multi-row:
Multiple rows are returned.

Multi-column:
Multiple columns are returned.

A subquery can be both multi-row and multi-column.


---