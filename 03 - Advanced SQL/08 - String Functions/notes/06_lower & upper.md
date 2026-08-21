# LOWER

LOWER() converts a string to lowercase.

## Syntax

LOWER(text)

## Basic Example

SELECT LOWER('YUVANESH');

Result:

yuvanesh

## Column Example

SELECT
    customer_name,
    LOWER(customer_name) AS lowercase_name
FROM customers;

## Data Cleaning

LOWER() can standardize text with inconsistent
capitalization.

Examples:

- Emails
- Usernames
- Categories
- Names
- Search terms

## Case-Insensitive Comparison

SELECT *
FROM customers
WHERE LOWER(email) = 'yuva@gmail.com';

This allows comparison without depending on
the capitalization stored in the database.

## Combining Functions

LOWER(TRIM(email))

can remove surrounding whitespace and then
convert the value to lowercase.

## Important

LOWER() in a SELECT does not permanently modify
the stored database value.

## Common Uses

- Text normalization
- Data cleaning
- Case-insensitive comparison
- Feature preparation
- Standardizing categorical data


# UPPER

UPPER() converts a string to uppercase.

## Syntax

UPPER(text)

## Basic Example

SELECT UPPER('yuvanesh');

Result:

YUVANESH

## Column Example

SELECT
    customer_name,
    UPPER(customer_name) AS uppercase_name
FROM customers;

## Data Cleaning

UPPER() can standardize text with inconsistent
capitalization.

Example:

SELECT UPPER(category)
FROM products;

## Combining Functions

UPPER(TRIM(category))

This removes surrounding whitespace and then
converts the value to uppercase.

## LOWER vs UPPER

LOWER() converts text to lowercase.

UPPER() converts text to uppercase.

## Important

UPPER() in a SELECT does not permanently modify
the stored database value.

## Common Uses

- Text normalization
- Data cleaning
- Standardizing categories
- Case-insensitive data processing
- Feature preparation