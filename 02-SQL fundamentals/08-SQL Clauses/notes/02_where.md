# WHERE

WHERE is used to filter rows based on a condition.

Example:

SELECT *
FROM products_crud
WHERE category = 'Electronics';

Comparison operators:

=   Equal
>   Greater than
<   Less than
>=  Greater than or equal
<=  Less than or equal
<>  Not equal

Multiple conditions can be combined using AND or OR.

Example:

SELECT *
FROM products_crud
WHERE category = 'Electronics'
AND price > 1000;