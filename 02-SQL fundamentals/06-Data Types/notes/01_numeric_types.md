# Numeric Data Types

## INT

INT stores whole numbers.

Examples:

22
100
-5

Use for normal integer values such as age, quantity,
count, etc.

## BIGINT

BIGINT stores very large whole numbers.

Example:

population BIGINT

Use when the possible integer value is larger than the
range normally required by INT.

## FLOAT

FLOAT stores approximate decimal numbers.

Examples:

36.5
3.14159

Useful for measurements and scientific values where
approximation is acceptable.

## DECIMAL

DECIMAL stores exact decimal values.

Example:

price DECIMAL(10,2)

DECIMAL(10,2):
- 10 = total number of digits
- 2 = digits after the decimal point

DECIMAL is commonly used for money and values requiring
exact precision.

## Comparison

INT → normal whole numbers
BIGINT → very large whole numbers
FLOAT → approximate decimal values
DECIMAL → exact decimal values

## AI/ML Relevance

Common examples:

age → INT
population → BIGINT
temperature → FLOAT
price → DECIMAL