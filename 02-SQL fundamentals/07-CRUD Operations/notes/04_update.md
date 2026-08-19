# UPDATE

UPDATE is used to modify existing records in a table.

Basic syntax:

UPDATE table_name
SET column_name = new_value
WHERE condition;

Example:

UPDATE employees
SET salary = 30000
WHERE name = 'Yuva';

Multiple columns can be updated:

UPDATE employees
SET department = 'R&D',
    salary = 30000
WHERE name = 'Yuva';

Existing values can also be used:

UPDATE employees
SET salary = salary + 2000
WHERE department = 'EEE';

## Important

Always be careful with the WHERE clause.

Without WHERE:

UPDATE employees
SET salary = 50000;

Every row will be updated.

Therefore, always identify which rows should be
modified before executing UPDATE.