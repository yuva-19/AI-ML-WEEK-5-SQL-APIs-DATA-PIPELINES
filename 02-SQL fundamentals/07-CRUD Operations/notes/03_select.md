# SELECT

SELECT is used to retrieve/read data from a table.

## Select all columns

SELECT *
FROM table_name;

The * means all columns.

## Select specific columns

SELECT name, salary
FROM employees;

Only the specified columns are returned.

## WHERE

WHERE filters rows based on a condition.

Example:

SELECT *
FROM employees
WHERE department = 'EEE';

## Comparison Operators

=   equal
>   greater than
<   less than
>=  greater than or equal
<=  less than or equal
<>  not equal

## Multiple Conditions

AND requires all conditions to be true.

Example:

SELECT *
FROM employees
WHERE department = 'EEE'
AND salary > 25000;

OR requires at least one condition to be true.

Example:

SELECT *
FROM employees
WHERE department = 'EEE'
OR department = 'CSE';

## Basic Structure

SELECT columns
FROM table
WHERE condition;