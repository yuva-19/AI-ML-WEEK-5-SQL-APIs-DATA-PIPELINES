# ORDER BY

ORDER BY is used to sort query results.

Ascending:

SELECT *
FROM products_crud
ORDER BY price ASC;

Descending:

SELECT *
FROM products_crud
ORDER BY price DESC;

ASC means ascending.

DESC means descending.

ASC is the default, so:

ORDER BY price;

is equivalent to:

ORDER BY price ASC.

ORDER BY can be combined with WHERE.

Example:

SELECT product_name, price
FROM products_crud
WHERE category = 'Electronics'
ORDER BY price DESC;