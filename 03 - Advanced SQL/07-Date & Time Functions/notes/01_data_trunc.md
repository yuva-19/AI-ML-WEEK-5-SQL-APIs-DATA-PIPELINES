# DATE_TRUNC

DATE_TRUNC truncates a date or timestamp to the
beginning of a specified time unit.

## Syntax

DATE_TRUNC('unit', date_or_timestamp)

## Common Units

- year
- month
- week
- day
- hour
- minute

## Examples

DATE_TRUNC(
    'year',
    TIMESTAMP '2026-08-19 14:35:27'
)

→ 2026-01-01 00:00:00

DATE_TRUNC(
    'month',
    TIMESTAMP '2026-08-19 14:35:27'
)

→ 2026-08-01 00:00:00

DATE_TRUNC(
    'day',
    TIMESTAMP '2026-08-19 14:35:27'
)

→ 2026-08-19 00:00:00

## Grouping by Month

SELECT
    DATE_TRUNC('month', sale_time) AS month,
    SUM(sale_amount) AS total_sales
FROM date_sales
GROUP BY DATE_TRUNC('month', sale_time)
ORDER BY month;

## ML / Data Engineering Use

DATE_TRUNC is useful for creating time-based features
and aggregations.

Examples:

- Monthly sales
- Weekly activity
- Daily transactions
- Hourly activity

It converts timestamps into consistent time periods,
making grouping and analysis easier.