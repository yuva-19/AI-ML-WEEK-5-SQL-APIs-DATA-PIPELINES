# Database Objects

## Database

A database is a logical container that stores database
objects such as schemas, tables, views, indexes, etc.

Example:

aiml_learning

---

## Schema

A schema is a namespace inside a database used to organize
database objects.

PostgreSQL commonly uses the default schema:

public

Example:

aiml_learning
    ↓
public
    ↓
tables / views / indexes

Schemas can also help organize objects and manage access.

---

## Table

A table stores structured data using rows and columns.

Example:

students

student_id | name  | department | age
-----------+-------+------------+----
1          | Yuva  | EEE        | 22
2          | Arun  | CSE        | 21
3          | Priya | ECE        | 22

---

## Database Object Hierarchy

PostgreSQL Server
    ↓
Database
    ↓
Schema
    ↓
Table
    ↓
Rows + Columns

Example:

PostgreSQL Server
    ↓
aiml_learning
    ↓
public
    ↓
students
    ↓
student_id, name, department, age

---

## Useful PostgreSQL Commands

Check current database:

SELECT current_database();

Check current schema:

SELECT current_schema();

List tables:

\dt

Describe a table:

\d students


# View

A View is a saved SQL query that behaves like a virtual table.

Example:

CREATE VIEW adult_students AS
SELECT
    student_id,
    name,
    department,
    age
FROM students
WHERE age >= 22;

Query the View:

SELECT * FROM adult_students;

Important:

Table → stores actual data.

View → stores a query and presents its result like a table.

Views are useful for:
- Reusing queries
- Simplifying complex queries
- Providing controlled datasets
- Preparing data for applications and ML pipelines

AI/ML example:

PostgreSQL
    ↓
View
    ↓
Python
    ↓
Pandas
    ↓
Feature Engineering
    ↓
ML Model


# Index

An Index is a database structure that can improve the
speed of data retrieval.

Example:

CREATE INDEX idx_students_name
ON students(name);

An index can help PostgreSQL find rows more efficiently.

Book analogy:

Without index → search through many pages.

With index → locate the relevant page more efficiently.

Indexes are useful for frequently queried columns.

Example:

SELECT *
FROM customer_events
WHERE user_id = 12345;

An index on user_id may improve lookup performance.

Important trade-off:

Indexes can improve read performance but consume storage
and add overhead to INSERT, UPDATE, and DELETE operations.

PostgreSQL's query planner decides whether an index should
be used for a particular query.

Do not create indexes on every column automatically.

### EXPLAIN

EXPLAIN shows the execution plan PostgreSQL intends to use.

Example:

EXPLAIN
SELECT *
FROM students
WHERE name = 'Yuva';

For a very small table, PostgreSQL may choose:

Seq Scan

even when an index exists.

This is because PostgreSQL's query planner chooses the
execution plan with the lowest estimated cost.

Index existence ≠ guaranteed index usage.

# Materialized View

A Materialized View stores the result of a query physically.

Unlike a normal View, the result does not need to be
calculated from scratch every time it is accessed.

Example:

CREATE MATERIALIZED VIEW student_summary AS
SELECT
    department,
    COUNT(*) AS student_count
FROM students
GROUP BY department;

Query:

SELECT *
FROM student_summary;

Materialized Views can become outdated when the underlying
tables change.

Refresh:

REFRESH MATERIALIZED VIEW student_summary;

Main difference:

View:
- Stores the query
- Does not normally store the result
- Always reflects current underlying data

Materialized View:
- Stores the query result
- Can become stale
- Must be refreshed to update the stored result

AI/ML use:
Useful for expensive aggregations and repeatedly accessed
datasets in data pipelines or feature generation.


# Sequence

A Sequence is a database object that generates sequential
numeric values.

Example:

CREATE SEQUENCE employee_id_seq
START 100
INCREMENT 1;

Generate the next value:

SELECT nextval('employee_id_seq');

Results:

100
101
102
103
...

## SERIAL and Sequence

When a column is defined as:

student_id SERIAL PRIMARY KEY

PostgreSQL creates and uses a sequence behind the scenes
to automatically generate IDs.

Therefore:

INSERT INTO students (name, department, age)
VALUES ('Karthik', 'EEE', 23);

does not require manually providing student_id.

SERIAL commonly starts generating IDs from 1.

Important:

Sequence → generates numbers
SERIAL → convenient older PostgreSQL syntax that uses a sequence
for automatic integer IDs.