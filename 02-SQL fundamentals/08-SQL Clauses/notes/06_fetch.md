# FETCH

FETCH is used to retrieve a specific number of rows from
a query result.

## Basic Syntax

SELECT *
FROM table_name
FETCH FIRST 2 ROWS ONLY;

This retrieves the first 2 rows.

## FETCH with OFFSET

Example:

SELECT *
FROM table_name
OFFSET 2
FETCH FIRST 2 ROWS ONLY;

This skips the first 2 rows and retrieves the next 2 rows.

## FETCH with ORDER BY

Example:

SELECT product_name, price
FROM products_crud
ORDER BY price DESC
FETCH FIRST 2 ROWS ONLY;

This sorts the products from highest to lowest price and
retrieves the first 2.

## LIMIT vs FETCH

LIMIT is commonly used in PostgreSQL.

FETCH is part of standard SQL.

Both can be used to restrict the number of rows returned.

For PostgreSQL, LIMIT is commonly encountered, but
understanding FETCH provides awareness of standard SQL.