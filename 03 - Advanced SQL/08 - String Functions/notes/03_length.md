# LENGTH

LENGTH() returns the number of characters in a string.

## Syntax

LENGTH(text)

## Example

SELECT LENGTH('YUVANESH');

Result:

8

## Spaces

Spaces are counted as characters.

Example:

SELECT LENGTH(' YUVA ');

The spaces are included in the length.

## Column Example

SELECT
    customer_name,
    LENGTH(customer_name) AS name_length
FROM customers;

## Filtering

LENGTH() can be used to find values based on
their character count.

Example:

SELECT *
FROM customers
WHERE LENGTH(customer_name) > 5;

## Combining with TRIM

LENGTH(TRIM(column_name))

TRIM removes leading and trailing spaces before
LENGTH counts the characters.

## Common Uses

- Data validation
- Checking string length
- Detecting abnormal values
- Data cleaning
- Feature engineering