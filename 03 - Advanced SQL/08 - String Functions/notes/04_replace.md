# REPLACE

REPLACE() finds a specific piece of text and replaces
all occurrences with another value.

## Syntax

REPLACE(string, from, to)

## Basic Example

SELECT REPLACE('Hello World', 'World', 'Yuva');

Result:

Hello Yuva

## Multiple Occurrences

REPLACE() replaces all matching occurrences.

Example:

SELECT REPLACE('apple apple', 'apple', 'orange');

Result:

orange orange

## Removing Text

Replace the target with an empty string.

Example:

SELECT REPLACE('A B C', ' ', '');

Result:

ABC

## Column Example

SELECT
    customer_name,
    REPLACE(customer_name, 'Kumar', 'Raj') AS updated_name
FROM customers;

REPLACE() in a SELECT does not modify the stored
database value.

## Data Cleaning

REPLACE() can be used to:

- Remove unwanted characters
- Standardize text
- Clean phone numbers
- Clean identifiers
- Replace abbreviations

## Case Sensitivity

REPLACE() is case-sensitive.

'World' and 'world' are different strings.

## REPLACE vs TRIM

REPLACE() can remove or replace matching text
throughout the string.

TRIM() removes unwanted characters from the
beginning and end of a string.