# SUM

SUM is an aggregate function used to calculate the total
of a numeric column.

Example:

SELECT SUM(price)
FROM products_crud;

Using an alias:

SELECT SUM(price) AS total_value
FROM products_crud;

SUM can be combined with WHERE.

Example:

SELECT SUM(price)
FROM products_crud
WHERE category = 'Electronics';

## AI/ML Relevance

SUM can be useful during exploratory data analysis and
feature/statistical calculations.