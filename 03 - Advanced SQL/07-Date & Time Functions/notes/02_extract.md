# EXTRACT

EXTRACT is used to retrieve a specific component from
a date or timestamp.

## Syntax

EXTRACT(field FROM date_or_timestamp)

## Common Fields

- YEAR
- MONTH
- DAY
- HOUR
- MINUTE
- SECOND
- DOW
- DOY
- WEEK
- QUARTER

## Examples

SELECT EXTRACT(YEAR FROM TIMESTAMP '2026-08-19 14:35:27');

→ 2026

SELECT EXTRACT(MONTH FROM TIMESTAMP '2026-08-19 14:35:27');

→ 8

SELECT EXTRACT(DAY FROM TIMESTAMP '2026-08-19 14:35:27');

→ 19

## Day of Week

EXTRACT(DOW FROM date)

PostgreSQL uses:

0 → Sunday
1 → Monday
2 → Tuesday
3 → Wednesday
4 → Thursday
5 → Friday
6 → Saturday

## Quarter

EXTRACT(QUARTER FROM date)

Returns the quarter of the year:

1 → January-March
2 → April-June
3 → July-September
4 → October-December

## Date/Time Feature Engineering

EXTRACT can be used to create features such as:

- Purchase year
- Purchase month
- Day of week
- Hour of day
- Quarter
- Week number

## DATE_TRUNC vs EXTRACT

DATE_TRUNC returns the beginning of a specified
time period.

EXTRACT returns the numerical value of a specific
date/time component.

Example:

DATE_TRUNC('month', sale_time)
→ 2026-08-01 00:00:00

EXTRACT(MONTH FROM sale_time)
→ 8