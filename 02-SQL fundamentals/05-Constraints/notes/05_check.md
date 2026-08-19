# CHECK Constraint

CHECK ensures that values satisfy a specified condition.

Example:

age INTEGER CHECK (age >= 18)

Only values satisfying the condition are accepted.

Example:

marks INTEGER CHECK (marks >= 0 AND marks <= 100)

Valid:
85

Invalid:
120

Purpose:
- Prevent invalid values
- Enforce business rules
- Improve data quality

Examples:

age >= 18
marks BETWEEN 0 AND 100
salary > 0
quantity > 0