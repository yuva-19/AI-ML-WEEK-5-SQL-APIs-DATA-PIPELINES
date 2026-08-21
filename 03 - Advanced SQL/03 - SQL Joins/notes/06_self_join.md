# SELF JOIN

A SELF JOIN is when a table is joined with itself.

It is useful when rows in the same table have
relationships with other rows in that table.

## Example

SELECT
    e.employee_name AS employee,
    m.employee_name AS manager
FROM join_employees AS e
LEFT JOIN join_employees AS m
    ON e.manager_id = m.employee_id;

The same table is referenced twice using different
aliases.

e represents the employee.

m represents the manager.

## Common Use Cases

- Employee-manager relationships
- Organizational hierarchies
- Parent-child relationships
- Related records within the same table