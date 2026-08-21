# HAVING

HAVING is used to filter groups after GROUP BY and
aggregation.

## Basic Example

SELECT
    category,
    COUNT(*) AS product_count
FROM products_crud
GROUP BY category
HAVING COUNT(*) > 1;

Only categories with more than 1 product are returned.

## WHERE vs HAVING

WHERE filters individual rows before grouping.

HAVING filters groups after grouping and aggregation.

WHERE example:

SELECT *
FROM products_crud
WHERE price > 1000;

HAVING example:

SELECT
    category,
    AVG(price) AS average_price
FROM products_crud
GROUP BY category
HAVING AVG(price) > 1000;

## WHERE + GROUP BY + HAVING

WHERE can filter rows before grouping.

HAVING can then filter the resulting groups.

Example:

SELECT
    category,
    AVG(price) AS average_price
FROM products_crud
WHERE price > 500
GROUP BY category
HAVING AVG(price) > 1000;

Concept:

WHERE
→ Filter rows

GROUP BY
→ Create groups

Aggregate function
→ Calculate group values

HAVING
→ Filter groups

## Important

WHERE cannot normally be used to filter aggregate
results such as COUNT(), SUM(), or AVG().

HAVING is used for filtering aggregate results.