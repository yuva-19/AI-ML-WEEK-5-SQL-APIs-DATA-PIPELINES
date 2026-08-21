# Query Optimization

Query optimization means reducing unnecessary work
so PostgreSQL can execute a query efficiently.

## Main Principle

Process less data and avoid unnecessary work.

## Select Required Columns

Prefer selecting only the columns needed.

Example:

SELECT product_name, amount
FROM orders
WHERE status = 'Completed';

SELECT * is convenient for exploration but should
not be used unnecessarily in production queries.

## Filter Early

Use WHERE to reduce rows before expensive operations
such as aggregation when logically appropriate.

Example:

SELECT
    category,
    AVG(amount)
FROM orders
WHERE status = 'Completed'
GROUP BY category;

## WHERE vs HAVING

WHERE filters rows before aggregation.

HAVING filters groups after aggregation.

Using WHERE to remove unnecessary rows before
aggregation can reduce the amount of data processed.

## LIMIT

LIMIT can reduce the amount of result data returned.

Example:

SELECT *
FROM orders
ORDER BY order_date DESC
LIMIT 5;

## DISTINCT

DISTINCT requires duplicate-removal processing.
Use it only when duplicate removal is actually needed.

## Index Awareness

Applying functions to indexed columns can affect
normal index usage.

Example:

WHERE LOWER(email) = 'yuva@gmail.com'

may not use a normal index on email in the same
way as a direct comparison.

## Optimization Workflow

1. Identify the slow query.
2. Use EXPLAIN.
3. Understand the execution plan.
4. Identify unnecessary work.
5. Optimize the query.
6. Use EXPLAIN again.
7. Compare the plans.

## Key Idea

Query optimization is mainly about reducing
unnecessary work and processing fewer rows.