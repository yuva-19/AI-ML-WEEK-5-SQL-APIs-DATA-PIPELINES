# Value Functions

Value window functions return a value from a particular position within a window.

Main functions:

- FIRST_VALUE()
- LAST_VALUE()
- NTH_VALUE()

They are useful for comparing the current row with:

- The first value in a group
- The last value in a group
- A specific position in a group

---

# 1. FIRST_VALUE()

FIRST_VALUE() returns the first value according to the window's ORDER BY.

Syntax:

FIRST_VALUE(column) OVER(
    PARTITION BY group_column
    ORDER BY sequence_column
)

Example:

SELECT
    customer_id,
    order_id,
    order_date,
    FIRST_VALUE(order_date) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS first_order_date
FROM orders;

For every order belonging to the same customer,
FIRST_VALUE() returns that customer's earliest order date.

Example:

Customer 1:

Order 1  → 2024-01-10
Order 2  → 2024-02-15
Order 3  → 2024-04-20

Result:

2024-01-10
2024-01-10
2024-01-10

The value remains the first value for the entire partition.

---

# 2. FIRST_VALUE() vs LAG()

LAG():

Looks at a relative previous row.

LAG(value)

Example:

Row 1 → NULL
Row 2 → Row 1
Row 3 → Row 2

FIRST_VALUE():

Looks at the first value of the window.

Example:

Row 1 → Row 1
Row 2 → Row 1
Row 3 → Row 1

Think:

LAG()
→ "What was immediately before me?"

FIRST_VALUE()
→ "What was the first value?"

---

# 3. LAST_VALUE()

LAST_VALUE() returns the last value in the window frame.

Basic syntax:

LAST_VALUE(column) OVER(
    PARTITION BY group_column
    ORDER BY sequence_column
)

IMPORTANT:

LAST_VALUE() is more complicated than FIRST_VALUE()
because window frames affect which rows are included.

This is important to understand before using LAST_VALUE().

---

# 4. Window Frame and LAST_VALUE()

Consider:

LAST_VALUE(order_date) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
)

Depending on the default window frame,
LAST_VALUE() may return the current row's value rather than the final value of the entire customer partition.

To explicitly get the final value of the entire partition:

LAST_VALUE(order_date) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
    ROWS BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING
)

This means:

Start from the first row
and include all rows through the final row.

This makes LAST_VALUE() return the actual final value of the partition.

---

# 5. NTH_VALUE()

NTH_VALUE() returns the value at a specific position in the window.

Syntax:

NTH_VALUE(column, n) OVER(
    PARTITION BY group_column
    ORDER BY sequence_column
)

Example:

NTH_VALUE(order_date, 2) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
)

This asks for:

"The second order date."

NTH_VALUE() is less commonly used than
FIRST_VALUE(), LAST_VALUE(), LAG(), and LEAD().

For this roadmap, understand what it means and recognize it when you encounter it.

---

# 6. FIRST_VALUE() for Customer Analysis

FIRST_VALUE() can be used to find a customer's first:

- Purchase
- Login
- Activity
- Transaction
- Event

Example:

FIRST_VALUE(order_date) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
)

This can create a feature such as:

customer_first_purchase_date

---

# 7. Comparing Current Value with First Value

FIRST_VALUE() becomes especially useful when calculating change from a customer's first event.

Concept:

current_value - first_value

Example:

order_value -
FIRST_VALUE(order_value) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
)

This can represent how much the customer's spending has changed since their first purchase.

---

# 8. Key Mental Model

LAG()
→ previous row

LEAD()
→ next row

FIRST_VALUE()
→ first value in the window

LAST_VALUE()
→ last value in the window/frame

NTH_VALUE()
→ value at position N

---

# AI/ML and Analytics Applications

Value functions can help create features such as:

- First purchase date
- First purchase amount
- Final activity
- Value compared with first purchase
- Position-based sequence features

Example:

days_since_first_purchase

can be created using:

current_date - FIRST_VALUE(first_purchase_date)

---

# Important

LAST_VALUE() is strongly connected to window frames.

When using LAST_VALUE(), always understand:

ROWS BETWEEN
and
the boundaries of the window frame.

Window frames will be studied more deeply in a later block.