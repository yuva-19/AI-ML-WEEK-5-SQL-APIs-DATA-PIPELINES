# Window Functions — ORDER BY in Windows

## 1. ORDER BY inside OVER()

ORDER BY inside the OVER() clause determines the order in which rows are processed within the window.

Syntax:

function() OVER (
    ORDER BY column
)

---

## 2. ORDER BY vs PARTITION BY

PARTITION BY:
Divides rows into logical groups.

ORDER BY:
Determines the order of rows inside the window.

They can be used together:

function() OVER (
    PARTITION BY customer_id
    ORDER BY order_date
)

---

## 3. Why ORDER BY Matters

ORDER BY enables calculations that depend on row sequence.

Examples:

- Running totals
- Cumulative calculations
- Previous/next row analysis
- Ranking
- Time-series analysis

---

## 4. Example

SELECT
    order_id,
    order_date,
    order_amount,
    SUM(order_amount) OVER (
        ORDER BY order_date
    ) AS running_total
FROM orders;

The calculation follows the order of order_date.

---

## 5. ORDER BY with PARTITION BY

Example:

SUM(order_amount) OVER (
    PARTITION BY customer_id
    ORDER BY order_date
)

This means:

1. Separate rows by customer.
2. Order each customer's rows by order_date.
3. Perform the calculation according to that order.

---

## 6. Important

There are two different ORDER BY concepts.

Query ORDER BY:

ORDER BY order_date;

Controls the final display order.

Window ORDER BY:

OVER (
    ORDER BY order_date
)

Controls the order used by the window calculation.

They are not the same thing.

---

## 7. Mental Model

PARTITION BY → WHO belongs together?

ORDER BY → IN WHAT SEQUENCE?

Window function → WHAT calculation?
