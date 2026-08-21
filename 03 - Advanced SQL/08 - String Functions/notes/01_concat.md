# CONCAT

CONCAT() is used to combine two or more values into
a single string.

## Syntax

CONCAT(value1, value2, value3, ...)

## Basic Example

SELECT CONCAT('Hello', ' ', 'Yuva');

Result:

Hello Yuva

## CONCAT with Columns

SELECT
    CONCAT(first_name, ' ', last_name) AS full_name
FROM employees;

## CONCAT with Numbers

SELECT CONCAT('Product ID: ', 101);

Result:

Product ID: 101

## NULL Handling

CONCAT() treats NULL arguments as empty strings.

Example:

SELECT CONCAT('Yuva', NULL, 'Raj');

Result:

YuvaRaj

## PostgreSQL Concatenation Operator

PostgreSQL also supports ||.

Example:

SELECT 'Hello' || ' ' || 'Yuva';

CONCAT() is a function.

|| is the PostgreSQL string concatenation operator.

## Common Uses

- Combining first and last names
- Creating display strings
- Combining columns
- Creating labels
- Creating derived fields
- Formatting text