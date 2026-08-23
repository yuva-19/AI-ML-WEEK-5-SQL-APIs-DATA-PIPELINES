# Window Functions — OVER() + PARTITION BY

## 1. What is a Window Function?

A window function performs a calculation across a set of related rows while keeping every individual row in the result.

Unlike GROUP BY, a window function does NOT collapse multiple rows into one row.

Basic syntax:

function() OVER (
    [PARTITION BY column]
    [ORDER BY column]
)

---

## 2. Why Window Functions?

Window functions are useful for:

- Feature engineering
- Customer analytics
- Ranking
- Time-series analysis
- Sequential data
- Running calculations
- Comparing rows
- Calculations within groups

---

## 3. OVER()

OVER() tells PostgreSQL that a function should operate as a window function.

Example:

SELECT
    customer_id,
    order_id,
    SUM(order_value) OVER () AS total_revenue
FROM orders;

The total is calculated across all rows, but every order remains visible.

---

## 4. Window Function vs GROUP BY

GROUP BY collapses rows.

Example:

SELECT
    customer_id,
    SUM(order_value)
FROM orders
GROUP BY customer_id;

Result:
One row per customer.

Window function:

SELECT
    customer_id,
    order_id,
    SUM(order_value) OVER (
        PARTITION BY customer_id
    ) AS customer_total
FROM orders;

Result:
Every order remains visible, while the customer's total is shown beside each order.

---

## 5. PARTITION BY

PARTITION BY divides the rows into logical groups for the window calculation.

Important:

PARTITION BY does NOT collapse rows.

Example:

SUM(amount) OVER (
    PARTITION BY customer_id
)

This calculates the SUM separately for each customer.

---

## 6. Mental Model

GROUP BY:

Rows
  ↓
Group
  ↓
Collapse
  ↓
One result per group

Window Function:

Rows
  ↓
Create logical window
  ↓
Calculate
  ↓
Keep every original row

---

## 7. Important Difference

GROUP BY:
"Give me one result for each group."

PARTITION BY:
"Calculate separately within each group, but keep all rows."

---

## 8. Basic Syntax

SELECT
    column1,
    column2,
    function(column3) OVER (
        PARTITION BY column1
    ) AS result
FROM table;
