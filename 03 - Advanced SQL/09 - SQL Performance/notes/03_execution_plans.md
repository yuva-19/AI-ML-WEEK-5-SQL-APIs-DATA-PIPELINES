# Execution Plans

An execution plan describes how PostgreSQL plans
to execute a SQL query.

## Basic Flow

SQL Query
    ↓
Query Planner
    ↓
Execution Plan
    ↓
Query Execution

## EXPLAIN

EXPLAIN shows the execution plan PostgreSQL
intends to use.

Example:

EXPLAIN
SELECT *
FROM orders_performance
WHERE status = 'Completed';

## Sequential Scan

Seq Scan means PostgreSQL plans to scan table
rows sequentially.

Example:

Seq Scan on orders_performance

A sequential scan is not automatically bad.

For small tables, scanning the entire table can
be cheaper than using an index.

## Execution Plan Nodes

Execution plans consist of operations called nodes.

Examples:

- Seq Scan
- Index Scan
- Index Only Scan
- Sort
- Aggregate
- Hash Join
- Nested Loop

## Cost

EXPLAIN may show:

cost=0.00..1.12

Cost represents PostgreSQL's estimated cost of
executing a plan.

It is not directly the execution time in milliseconds.

## Rows

The rows value represents PostgreSQL's estimated
number of rows produced by a plan node.

## Width

Width represents PostgreSQL's estimated average
row size in bytes.

## Important

An execution plan is PostgreSQL's chosen strategy
for executing a query.

A Seq Scan is not automatically a problem.

The correct plan depends on the table size,
data distribution, indexes, query structure,
and PostgreSQL's cost estimates.

## Optimization Workflow

Slow query
    ↓
EXPLAIN
    ↓
Understand execution plan
    ↓
Identify unnecessary or expensive work
    ↓
Optimize
    ↓
EXPLAIN again