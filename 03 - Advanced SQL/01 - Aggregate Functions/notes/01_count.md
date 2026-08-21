# COUNT

COUNT is an aggregate function used to count rows or
non-NULL values.

## Count all rows

SELECT COUNT(*)
FROM products_crud;

## Using an alias

SELECT COUNT(*) AS total_products
FROM products_crud;

COUNT(*) counts all rows in the result.

## With WHERE

COUNT can be combined with WHERE to count rows matching
a condition.

Example:

SELECT COUNT(*)
FROM products_crud
WHERE category = 'Electronics';

## AI/ML Relevance

COUNT is commonly used during data analysis to understand
dataset size and the number of records matching conditions.