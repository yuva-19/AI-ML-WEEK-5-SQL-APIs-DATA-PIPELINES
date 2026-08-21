# EXPLAIN

EXPLAIN shows the execution plan PostgreSQL intends
to use for a SQL query.

## Syntax

EXPLAIN
SELECT ...
FROM ...;

## Example

EXPLAIN
SELECT *
FROM orders_performance
WHERE status = 'Completed';

## Sequential Scan

Seq Scan means PostgreSQL plans to scan table rows
sequentially.

A sequential scan is not automatically bad.

For small tables, it may be cheaper than using an index.

## Cost

Example:

cost=0.00..1.12

The first value represents estimated startup cost.

The second value represents estimated total cost.

Cost is an internal PostgreSQL estimate and is not
directly measured in milliseconds.

## Rows

The rows value is PostgreSQL's estimated number of
rows produced by a plan node.

## Width

Width is PostgreSQL's estimated average row size
in bytes produced by a plan node.

## Filter

A Filter condition shows how PostgreSQL plans to
filter rows.

Example:

Filter: status = 'Completed'

## Common Plan Operations

Examples:

- Seq Scan
- Index Scan
- Sort
- Aggregate
- HashAggregate
- Hash Join
- Nested Loop

## Plan Tree

Execution plans are represented as a tree of
operations.

Example:

Sort
  |
  └── Seq Scan

Conceptually:

Seq Scan
    ↓
read rows
    ↓
Sort
    ↓
result

## EXPLAIN Does Not Normally Execute the Query

EXPLAIN shows the planned execution strategy.

It is different from executing the query normally.

## Optimization Workflow

Slow query
    ↓
EXPLAIN
    ↓
Understand plan
    ↓
Identify expensive or unnecessary work
    ↓
Optimize
    ↓
EXPLAIN again

## Important

Do not assume that:

Seq Scan = bad

or:

Index Scan = always good

The PostgreSQL planner chooses a plan based on
estimated costs, table size, statistics, indexes,
and query structure.