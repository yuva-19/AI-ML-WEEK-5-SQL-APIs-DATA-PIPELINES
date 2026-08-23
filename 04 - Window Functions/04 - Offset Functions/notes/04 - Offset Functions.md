# Offset Functions

Offset functions allow us to access values from another row relative to the current row without removing the current row.

They are especially useful for:

- Time-series analysis
- Customer behavior analysis
- Previous/next events
- Change detection
- Feature engineering
- Sequential data

Main offset functions:

- LAG()
- LEAD()

---

# 1. LAG()

LAG() retrieves a value from a previous row.

Basic syntax:

LAG(column) OVER(
    PARTITION BY group_column
    ORDER BY sequence_column
)

Example:

SELECT
    customer_id,
    order_id,
    order_date,
    LAG(order_date) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_date
FROM orders;

Concept:

Customer
    ↓
Separate each customer's rows

ORDER BY order_date
    ↓
Arrange orders chronologically

LAG()
    ↓
Look at the previous row

---

# 2. LEAD()

LEAD() retrieves a value from a following row.

Basic syntax:

LEAD(column) OVER(
    PARTITION BY group_column
    ORDER BY sequence_column
)

Example:

SELECT
    customer_id,
    order_id,
    order_date,
    LEAD(order_date) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS next_order_date
FROM orders;

Concept:

Customer
    ↓
Separate each customer's rows

ORDER BY order_date
    ↓
Arrange orders chronologically

LEAD()
    ↓
Look at the next row

---

# 3. LAG vs LEAD

LAG:

Current row ← Previous row

LEAD:

Current row → Next row

Example:

Order Date:

2024-01-01
2024-02-10
2024-03-20

Using LAG():

2024-01-01 → NULL
2024-02-10 → 2024-01-01
2024-03-20 → 2024-02-10

Using LEAD():

2024-01-01 → 2024-02-10
2024-02-10 → 2024-03-20
2024-03-20 → NULL

---

# 4. PARTITION BY with Offset Functions

PARTITION BY determines whose previous/next row we are looking at.

Example:

LAG(order_date) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
)

This means:

"For each customer, find their previous order."

Without PARTITION BY:

LAG(order_date) OVER(
    ORDER BY order_date
)

The previous row could belong to a completely different customer.

---

# 5. ORDER BY is Critical

ORDER BY determines what "previous" and "next" mean.

Example:

LAG(order_date) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
)

means:

"Previous order chronologically."

The ordering column must match the business requirement.

---

# 6. Offset Amount

By default:

LAG(column)

means:

Look 1 row backward.

We can specify the offset:

LAG(column, 2)

means:

Look 2 rows backward.

Similarly:

LEAD(column, 2)

means:

Look 2 rows forward.

Example:

LAG(order_date, 2) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
)

---

# 7. NULL Values

The first row has no previous row.

Therefore:

LAG()

returns NULL.

The last row has no next row.

Therefore:

LEAD()

returns NULL.

Example:

Order 1 → previous = NULL
Order 2 → previous = Order 1
Order 3 → previous = Order 2

---

# 8. Change Detection

LAG() is commonly used to compare the current value with the previous value.

Example:

Current value - Previous value

SELECT
    customer_id,
    order_id,
    order_value,
    order_value
        - LAG(order_value) OVER(
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS change_from_previous
FROM customer_orders;

Example:

Current order = ₹15,000
Previous order = ₹10,000

Change:

₹15,000 - ₹10,000 = ₹5,000

---

# 9. Time-Series Feature Engineering

Offset functions are very useful for creating ML features.

Examples:

- Previous purchase amount
- Previous purchase date
- Next purchase date
- Change from previous purchase
- Days since previous purchase
- Days until next purchase

Example feature:

previous_purchase_amount

Another feature:

days_since_previous_purchase

These features can be used in customer behavior and predictive models.

---

# 10. Important Mental Model

Remember:

LAG()
→ Look backward

LEAD()
→ Look forward

PARTITION BY
→ Which group?

ORDER BY
→ According to what sequence?

Example:

LAG(order_date) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
)

Read it as:

"For each customer, ordered chronologically, give me the previous order date."

---

# Key Difference from GROUP BY

GROUP BY collapses rows.

Window functions keep the original rows.

Example:

GROUP BY customer_id

can produce:

customer_id | total_spending

A window function can produce:

customer_id | order_id | order_value | running_value

The individual order rows remain visible.

---

# AI/ML Relevance

Offset functions are important for:

- Sequential features
- Time-series features
- Customer behavior
- Churn prediction
- Purchase behavior
- Event sequence analysis
- Change detection

Common ML features:

previous_purchase_amount
days_since_previous_purchase
change_in_purchase_amount
next_purchase_interval
previous_activity