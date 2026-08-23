# Analytical Windows

Analytical window calculations allow us to perform calculations across related rows while keeping every individual row in the result.

They are heavily used in:

- Business analytics
- Time-series analysis
- Customer behavior
- Financial analysis
- Dashboards
- ML feature engineering

Main concepts:

- Running totals
- Cumulative sums
- Moving averages
- Rolling averages
- Running percentages

---

# 1. Running Total

A running total continuously adds values as we move through an ordered sequence.

Example:

Date        Revenue
2024-01-01  10000
2024-01-02   5000
2024-01-03   8000

Running total:

2024-01-01 → 10000
2024-01-02 → 15000
2024-01-03 → 23000

SQL:

SUM(revenue) OVER(
    ORDER BY date
)

The ORDER BY determines the sequence in which the values are accumulated.

---

# 2. Cumulative Sum

A cumulative sum is an accumulated value up to the current row.

Example:

Value:

10
20
30
40

Cumulative sum:

10
30
60
100

SQL:

SUM(value) OVER(
    ORDER BY sequence_column
)

The important idea is:

Current cumulative value
=
all previous values + current value

---

# 3. PARTITION BY with Running Totals

We can calculate a separate running total for each group.

Example:

SUM(revenue) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
)

This means:

"For each customer, calculate their running revenue in chronological order."

Example:

Customer 1:

10000
15000
20000

Running:

10000
25000
45000

Customer 2 starts a new calculation:

5000
8000

Running:

5000
13000

PARTITION BY resets the calculation for every group.

---

# 4. Running Total vs GROUP BY

GROUP BY collapses rows.

Example:

SELECT
    customer_id,
    SUM(order_value)
FROM orders
GROUP BY customer_id;

Result:

customer_id | total
1            | 45000
2            | 13000

Individual orders disappear.

Window function:

SUM(order_value) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
)

Result:

customer_id | order_id | order_value | running_total
1            | 101      | 10000       | 10000
1            | 102      | 15000       | 25000
1            | 103      | 20000       | 45000

The original rows remain.

---

# 5. Moving Average

A moving average calculates the average over a moving group of rows.

Example:

Values:

10
20
30
40

Three-row moving average:

10
15
20
30

Explanation:

Row 1:

10 / 1 = 10

Row 2:

(10 + 20) / 2 = 15

Row 3:

(10 + 20 + 30) / 3 = 20

Row 4:

(20 + 30 + 40) / 3 = 30

SQL:

AVG(value) OVER(
    ORDER BY sequence_column
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
)

---

# 6. Rolling Average

Rolling average and moving average are commonly used to describe the same general idea.

The calculation moves along the ordered data.

Example:

3-row rolling average:

Current row
+
2 previous rows

SQL:

AVG(value) OVER(
    ORDER BY date
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
)

The important part is:

ROWS BETWEEN 2 PRECEDING AND CURRENT ROW

This creates a window containing:

previous 2 rows + current row

---

# 7. Running Percentage

A running percentage tells us how much of the total has been accumulated so far.

Formula:

Running percentage
=
Running total / Grand total × 100

Example:

Revenue:

100
200
300

Running total:

100
300
600

Grand total:

600

Running percentage:

16.67%
50%
100%

SQL concept:

SUM(value) OVER(
    ORDER BY sequence_column
)
/
SUM(value) OVER()

The first window calculates the running total.

The second window calculates the overall total.

---

# 8. Running Percentage Example

SELECT
    date,
    revenue,

    SUM(revenue) OVER(
        ORDER BY date
    ) AS running_revenue,

    SUM(revenue) OVER(
        ORDER BY date
    )
    /
    SUM(revenue) OVER() * 100 AS running_percentage

FROM sales;

SUM(revenue) OVER()

without ORDER BY means:

"Calculate the total across the entire result."

---

# 9. Window ORDER BY

For analytical windows, ORDER BY is extremely important.

Example:

SUM(revenue) OVER(
    ORDER BY order_date
)

means:

Calculate the running total according to order_date.

Changing the ORDER BY changes the calculation sequence.

---

# 10. Window Frames

Analytical windows often use window frames.

Example:

ROWS BETWEEN 2 PRECEDING AND CURRENT ROW

means:

Current row
+
previous row
+
two rows before

Example:

Row 1 → rows 1
Row 2 → rows 1-2
Row 3 → rows 1-3
Row 4 → rows 2-4

Window frames will be studied in detail in the Window Frames block.

---

# 11. Common Analytical Patterns

Running total:

SUM(value) OVER(
    ORDER BY date
)

Partitioned running total:

SUM(value) OVER(
    PARTITION BY customer_id
    ORDER BY date
)

Moving average:

AVG(value) OVER(
    ORDER BY date
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
)

Running percentage:

SUM(value) OVER(
    ORDER BY date
)
/
SUM(value) OVER() * 100

---

# 12. AI/ML Feature Engineering

Analytical windows can create useful ML features.

Examples:

- Cumulative customer spending
- Running purchase count
- Rolling average purchase value
- Rolling activity
- Cumulative revenue
- Percentage of total revenue
- Recent behavior trends

Example feature:

customer_running_spending

Another:

rolling_3_order_average

These features can help models understand behavioral trends over time.

---

# Key Mental Model

Running total:

"How much have we accumulated so far?"

Moving average:

"What is the average around the current position?"

Running percentage:

"How much of the total have we accumulated so far?"

PARTITION BY:

"Do this separately for each group."

ORDER BY:

"What sequence should the calculation follow?"

ROWS BETWEEN:

"Which rows should participate in this calculation?"