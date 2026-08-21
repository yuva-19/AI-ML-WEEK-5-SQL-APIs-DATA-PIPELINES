# EXPLAIN ANALYZE

EXPLAIN shows PostgreSQL's planned execution strategy.

EXPLAIN ANALYZE executes the query and provides
actual execution information.

## Syntax

EXPLAIN ANALYZE
SELECT ...
FROM ...;

## EXPLAIN vs EXPLAIN ANALYZE

EXPLAIN:
- Shows the planned execution strategy
- Does not normally execute the query
- Provides estimated information

EXPLAIN ANALYZE:
- Actually executes the query
- Shows actual execution information
- Allows comparison between estimates and reality

## Actual Time

Example:

actual time=0.010..0.014

This represents actual execution timing in milliseconds
for the plan node.

## Actual Rows

Example:

actual ... rows=7

This represents the actual number of rows produced
by the plan node.

## Loops

loops indicates how many times a plan node was executed.

## Planning Time

Planning Time shows how long PostgreSQL spent
planning the query.

## Execution Time

Execution Time shows how long PostgreSQL spent
executing the query.

## Estimated vs Actual

EXPLAIN:

rows=10

EXPLAIN ANALYZE:

actual rows=500000

A large difference between estimated and actual rows
can indicate inaccurate estimates and may influence
query planning decisions.

## Rows Removed by Filter

This can show how many rows were examined but
removed by a filter condition.

## Important Warning

EXPLAIN ANALYZE actually executes the query.

Be careful when using it with:

- INSERT
- UPDATE
- DELETE

Use SELECT queries for practice.

## Performance Workflow

Slow query
    ↓
EXPLAIN
    ↓
Understand plan
    ↓
EXPLAIN ANALYZE
    ↓
Compare estimated vs actual behavior
    ↓
Identify unnecessary work
    ↓
Optimize
    ↓
EXPLAIN ANALYZE again

## Key Idea

EXPLAIN tells you what PostgreSQL plans to do.

EXPLAIN ANALYZE tells you what PostgreSQL actually did.