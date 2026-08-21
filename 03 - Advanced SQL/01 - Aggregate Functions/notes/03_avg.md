# AVG

AVG is an aggregate function used to calculate the
average value of a numeric column.

## Basic Example

SELECT AVG(price)
FROM products_crud;

## Using an Alias

SELECT AVG(price) AS average_price
FROM products_crud;

## Using WHERE

SELECT AVG(price) AS avg_electronics_price
FROM products_crud
WHERE category = 'Electronics';

## Important

AVG works with numeric values.

AVG can be used with WHERE to calculate the average
for a specific group of rows.

## AI/ML Relevance

AVG is commonly used during data analysis and
statistical exploration of datasets.