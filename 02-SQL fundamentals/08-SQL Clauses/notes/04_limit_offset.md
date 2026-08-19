# LIMIT and OFFSET

## LIMIT

LIMIT restricts the number of rows returned by a query.

Example:

SELECT *
FROM products_crud
LIMIT 2;

Only the first 2 rows are returned.

LIMIT can be combined with ORDER BY.

Example:

SELECT *
FROM products_crud
ORDER BY price DESC
LIMIT 2;

This returns the 2 most expensive products.

## OFFSET

OFFSET skips a specified number of rows before returning
the remaining results.

Example:

SELECT *
FROM products_crud
OFFSET 2;

The first 2 rows are skipped.

## LIMIT + OFFSET

Example:

SELECT *
FROM products_crud
LIMIT 2
OFFSET 2;

This skips the first 2 rows and returns the next 2 rows.

## Pagination

LIMIT and OFFSET can be used to implement pagination.

Example with page size 10:

Page 1:
LIMIT 10 OFFSET 0

Page 2:
LIMIT 10 OFFSET 10

Page 3:
LIMIT 10 OFFSET 20

Formula:

OFFSET = (page_number - 1) × page_size

## AI/ML / Data Pipeline Relevance

LIMIT and OFFSET can help retrieve large datasets in
smaller batches.

They are also commonly used in APIs and applications
that display paginated results.