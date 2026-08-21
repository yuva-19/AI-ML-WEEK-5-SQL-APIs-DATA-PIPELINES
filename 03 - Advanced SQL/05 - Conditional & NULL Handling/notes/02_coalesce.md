# COALESCE

COALESCE is used to handle NULL values.

It returns the first non-NULL value from the
provided expressions.

## Syntax

COALESCE(value1, value2, value3)

COALESCE checks values from left to right and returns
the first value that is not NULL.

## Example

SELECT
    customer_name,
    COALESCE(phone, 'Not Provided') AS phone
FROM coalesce_customers;

If phone is NULL, 'Not Provided' is returned.

## Multiple Values

COALESCE can provide fallback values.

Example:

COALESCE(phone, email, 'No Contact Information')

The function checks:

1. phone
2. email
3. fallback text

and returns the first non-NULL value.

## Numerical Example

COALESCE(discount, 0)

This can be used when NULL represents no discount.

Example:

price - COALESCE(discount, 0)

## Important

COALESCE does not modify the original table data
when used inside a SELECT query.

It only changes the value returned by the query.

## Common Uses

- Replacing NULL with default values
- Data cleaning
- Creating fallback values
- Handling missing numerical values
- Feature preparation