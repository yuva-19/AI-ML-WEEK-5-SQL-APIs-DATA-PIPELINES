# NULLIF

NULLIF compares two values.

If the values are equal, NULLIF returns NULL.

If the values are different, NULLIF returns the
first value.

## Syntax

NULLIF(value1, value2)

## Examples

NULLIF(10, 10)
→ NULL

NULLIF(10, 5)
→ 10

## Preventing Division by Zero

A common pattern is:

value / NULLIF(denominator, 0)

Example:

SELECT
    revenue / NULLIF(units_sold, 0)
FROM nullif_sales;

If units_sold is 0:

NULLIF(0, 0)
→ NULL

This prevents a division-by-zero error.

## Data Cleaning

NULLIF can convert unwanted placeholder values
into NULL.

Example:

NULLIF(phone, '')

This converts an empty string into NULL.

## COALESCE + NULLIF

These functions can be combined.

Example:

COALESCE(
    NULLIF(phone, ''),
    'Not Provided'
)

The empty string is first converted to NULL,
then COALESCE provides a fallback value.

## Quick Difference

COALESCE:
NULL → replacement value

NULLIF:
unwanted value → NULL