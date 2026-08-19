# DELETE

DELETE is used to remove records from a table.

Basic syntax:

DELETE FROM table_name
WHERE condition;

Example:

DELETE FROM employees
WHERE employee_id = 4;

The WHERE clause determines which rows are deleted.

## Important

Always be careful with WHERE.

Without WHERE:

DELETE FROM employees;

All rows in the table will be deleted.

The table itself will remain.

## DELETE vs TRUNCATE vs DROP

DELETE:
Removes selected rows.

TRUNCATE:
Removes all rows from a table.

DROP:
Removes the entire table.

Examples:

DELETE FROM employees
WHERE employee_id = 4;

TRUNCATE TABLE employees;

DROP TABLE employees;

## Good Practice

Before deleting an important record:

1. SELECT the row
2. Verify the row
3. DELETE the row
4. SELECT again to verify