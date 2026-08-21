# Date Comparisons

Dates and timestamps can be compared using standard
comparison operators.

## Comparison Operators

=
<>
>
<
>=
<=

## Examples

SELECT *
FROM date_sales
WHERE sale_time > TIMESTAMP '2026-02-01 00:00:00';

This returns sales after the specified timestamp.

## Comparing Only the Date

When the time portion should be ignored:

SELECT *
FROM date_sales
WHERE sale_time::DATE = DATE '2026-02-19';

## BETWEEN

BETWEEN checks whether a value is within a range.

Example:

WHERE sale_time BETWEEN
    TIMESTAMP '2026-02-01'
    AND
    TIMESTAMP '2026-02-28';

BETWEEN is inclusive.

## Timestamp Range Best Practice

For timestamp ranges, a half-open range is often safer:

WHERE sale_time >= TIMESTAMP '2026-02-01'
  AND sale_time < TIMESTAMP '2026-03-01';

This includes all of February without needing
to specify the final second of the month.

## CURRENT_DATE

CURRENT_DATE returns the current date.

Example:

WHERE sale_time::DATE < CURRENT_DATE;

## ML / Feature Engineering

Date comparisons are useful for features such as:

- Recent purchase
- Old purchase
- Days since last purchase
- Customer inactivity
- Churn-related features