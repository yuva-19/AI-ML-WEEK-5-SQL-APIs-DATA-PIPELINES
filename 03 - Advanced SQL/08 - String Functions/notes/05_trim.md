# TRIM

TRIM() removes unwanted characters from the beginning
and end of a string.

## Syntax

TRIM(text)

## Basic Example

SELECT TRIM('   Yuva   ');

Result:

Yuva

## TRIM with Specific Character

SELECT TRIM('*' FROM '***Yuva***');

Result:

Yuva

## LTRIM

LTRIM() removes characters from the left side.

Example:

SELECT LTRIM('   Yuva');

## RTRIM

RTRIM() removes characters from the right side.

Example:

SELECT RTRIM('Yuva   ');

## Important

TRIM() does not remove characters from the middle
of a string.

Example:

TRIM('  Yuva Kumar  ')

Result:

Yuva Kumar

The space between Yuva and Kumar remains.

## TRIM vs REPLACE

TRIM() removes matching characters from the edges.

REPLACE() can remove or replace matching characters
throughout the string.

## Data Cleaning

TRIM() is commonly used to:

- Remove unwanted whitespace
- Clean user input
- Standardize text
- Prepare data for comparisons
- Detect data-quality problems

## Combining Functions

LENGTH(TRIM(column_name))

can be used to detect leading or trailing whitespace.