# MIN and MAX

## MIN

MIN returns the smallest value in a column.

Example:

SELECT MIN(price) AS lowest_price
FROM products_crud;

## MAX

MAX returns the largest value in a column.

Example:

SELECT MAX(price) AS highest_price
FROM products_crud;

## Using WHERE

SELECT MIN(price)
FROM products_crud
WHERE category = 'Electronics';

SELECT MAX(price)
FROM products_crud
WHERE category = 'Electronics';

## Aggregate Summary

Multiple aggregate functions can be used in one query.

Example:

SELECT
    COUNT(*) AS total_products,
    SUM(price) AS total_value,
    AVG(price) AS average_price,
    MIN(price) AS lowest_price,
    MAX(price) AS highest_price
FROM products_crud;