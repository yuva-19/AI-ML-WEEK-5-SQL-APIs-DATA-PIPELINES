# SELECT and DISTINCT

## SELECT

SELECT is used to specify which columns/data should
be retrieved from a table.

Example:

SELECT product_name, price
FROM products_crud;

SELECT * retrieves all columns.

Example:

SELECT *
FROM products_crud;

## DISTINCT

DISTINCT removes duplicate values from the result.

Example:

SELECT DISTINCT category
FROM products_crud;

If the table contains:

Electronics
Electronics
Stationery
Electronics

DISTINCT returns:

Electronics
Stationery

## Difference

SELECT:
Returns the requested values, including duplicates.

SELECT DISTINCT:
Returns only unique values.