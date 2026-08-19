# FOREIGN KEY Constraint

A FOREIGN KEY creates a relationship between two tables.

It ensures that a value in the child table refers
to an existing value in the parent table.

Example:

CREATE TABLE departments (
    department_id INTEGER PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    employee_name VARCHAR(100),
    department_id INTEGER,
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

departments = Parent table
employees = Child table

The employee's department_id must exist in
departments.department_id.

This maintains referential integrity.

Example:

department_id = 1 → valid if department 1 exists
department_id = 99 → invalid if department 99 doesn't exist

## AI/ML Relevance

Foreign Keys help maintain valid relationships between
tables before data is joined and used for analytics,
feature engineering, and ML datasets.