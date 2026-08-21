# Data Type Conversion

Data type conversion changes a value from one
data type to another.

---

# CAST

CAST converts a value to a specified data type.

## Syntax

CAST(value AS data_type)

## Examples

SELECT CAST('100' AS INTEGER);

SELECT CAST('125.75' AS DECIMAL(10,2));

SELECT CAST('2026-08-19' AS DATE);

## PostgreSQL Shorthand

PostgreSQL also supports:

value::data_type

Example:

SELECT '100'::INTEGER;

This is equivalent to:

SELECT CAST('100' AS INTEGER);

CAST is standard SQL, while :: is PostgreSQL-specific.

## Integer Division

Integer division can produce an integer result.

Example:

SELECT 5 / 2;

Result:

2

Converting one value to a decimal type produces a
decimal result.

Example:

SELECT CAST(5 AS DECIMAL) / 2;

Result:

2.5

## Important

Type conversion can fail when the value cannot be
converted to the requested type.

Example:

SELECT CAST('hello' AS INTEGER);

This produces a conversion error.

## Common Uses

- Converting imported text data
- Preparing data for analysis
- Converting API/CSV values
- Controlling arithmetic behavior
- Converting dates and times