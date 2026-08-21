# GROUP BY

GROUP BY is used to divide rows into groups based on
one or more columns.

Aggregate functions can then be applied to each group.

## Single-column grouping

Example:

SELECT
    category,
    COUNT(*) AS product_count
FROM products_crud
GROUP BY category;

This counts products separately for each category.

## GROUP BY with aggregate functions

COUNT:

SELECT category, COUNT(*)
FROM products_crud
GROUP BY category;

SUM:

SELECT category, SUM(price)
FROM products_crud
GROUP BY category;

AVG:

SELECT category, AVG(price)
FROM products_crud
GROUP BY category;

MIN and MAX:

SELECT
    category,
    MIN(price),
    MAX(price)
FROM products_crud
GROUP BY category;

## Multi-column grouping

GROUP BY can use multiple columns.

Example:

SELECT
    department,
    job_role,
    AVG(salary)
FROM employees
GROUP BY department, job_role;

Rows are grouped according to the combination
of department and job_role.

## Aggregation Strategy

When solving a grouping problem:

1. Identify what defines the groups.
2. Choose the aggregate function.
3. Use GROUP BY on the grouping column(s).

Example:

Average salary per department:

GROUP BY department
+
AVG(salary)