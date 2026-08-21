# CASE

CASE provides conditional logic in SQL.

It is similar to IF / ELSE logic in programming.

## Basic Syntax

CASE
    WHEN condition THEN result
    WHEN condition THEN result
    ELSE result
END

## Example

SELECT
    employee_name,
    performance_score,
    CASE
        WHEN performance_score >= 80 THEN 'Excellent'
        WHEN performance_score >= 60 THEN 'Good'
        WHEN performance_score >= 40 THEN 'Average'
        ELSE 'Poor'
    END AS performance_level
FROM case_employees;

## Important

CASE evaluates conditions from top to bottom.

The first condition that is TRUE determines the result.

Therefore, condition order matters.

## Feature Creation

CASE can transform existing data into useful
features.

Example:

CASE
    WHEN performance_score >= 60 THEN 1
    ELSE 0
END AS passed

This creates a binary feature.

CASE can also convert numerical values into categories.

Example:

CASE
    WHEN salary >= 60000 THEN 'High'
    WHEN salary >= 40000 THEN 'Medium'
    ELSE 'Low'
END AS salary_category

## Common Uses

- Conditional logic
- Data categorization
- Data cleaning
- Feature creation
- Creating derived columns