# Indexes

An index is a data structure that PostgreSQL can use
to locate rows more efficiently.

## Basic Example

CREATE INDEX idx_customers_email
ON customers(email);

This creates an index on the email column.

## Why Indexes?

Indexes can improve read performance for queries
that frequently search, join, or sort using
indexed columns.

Common situations:

- WHERE
- JOIN
- ORDER BY

## Primary Keys

A PRIMARY KEY automatically has a unique index
created by PostgreSQL to enforce uniqueness.

Example:

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY
);

A separate manual index on the same primary key
is normally unnecessary.

## Unique Index

CREATE UNIQUE INDEX idx_customers_email
ON customers(email);

A UNIQUE constraint can also be used when uniqueness
is a business rule.

## Index Trade-offs

Indexes can:

- Improve certain read queries
- Consume storage
- Increase INSERT cost
- Increase UPDATE maintenance
- Increase DELETE maintenance

Therefore, indexes should not be created blindly.

## Important

An index does not guarantee that PostgreSQL will
use it.

The PostgreSQL query planner decides whether an
index is beneficial for a particular query.

## Common Uses

Indexes are commonly considered for columns used
frequently in:

- WHERE
- JOIN
- ORDER BY

## Key Idea

An index provides another possible access path
to data.

The query planner decides which access path is
most efficient.