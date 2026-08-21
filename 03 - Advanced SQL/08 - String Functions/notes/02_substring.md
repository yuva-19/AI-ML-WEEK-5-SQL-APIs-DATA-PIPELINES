# SUBSTRING

SUBSTRING() extracts a specific portion of a string.

## Syntax

SUBSTRING(text FROM start FOR length)

## Example

SELECT SUBSTRING('YUVANESH' FROM 1 FOR 4);

Result:

YUVA

## Starting Position

SELECT SUBSTRING('YUVANESH' FROM 5 FOR 4);

Result:

NESH

## Column Example

SELECT
    customer_name,
    SUBSTRING(customer_name FROM 1 FOR 3) AS first_three
FROM customers;

## Alternative Syntax

PostgreSQL also supports:

SUBSTRING(text, start, length)

Example:

SELECT SUBSTRING('YUVANESH', 1, 4);

## Important

String positions start from 1.

## Common Uses

- Extracting prefixes
- Extracting codes
- Extracting portions of text
- Cleaning data
- Creating features from text