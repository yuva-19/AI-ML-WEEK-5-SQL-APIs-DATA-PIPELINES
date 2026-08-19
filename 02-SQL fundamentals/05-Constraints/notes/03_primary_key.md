# PRIMARY KEY Constraint

A PRIMARY KEY uniquely identifies each row in a table.

A Primary Key automatically enforces:

- UNIQUE
- NOT NULL

Example:

CREATE TABLE departments (
    department_id INTEGER PRIMARY KEY,
    department_name VARCHAR(100)
);

Therefore:

department_id = 1 → valid
department_id = 2 → valid
duplicate ID      → invalid
NULL              → invalid

Only one Primary Key constraint can exist per table.