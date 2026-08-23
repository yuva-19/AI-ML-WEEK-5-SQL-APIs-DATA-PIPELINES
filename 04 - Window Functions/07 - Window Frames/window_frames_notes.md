# Window Frames

Window frames control **which rows are included in a window calculation for the current row**.

They are used with window functions such as:

- SUM()
- AVG()
- COUNT()
- MIN()
- MAX()
- FIRST_VALUE()
- LAST_VALUE()

---

# 1. Basic Window Function Structure

A window function can contain:

```sql
function() OVER(
    PARTITION BY ...
    ORDER BY ...
    frame_definition
)
```

Example:

```sql
SUM(order_value) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
)
```

There are three important concepts:

```text
PARTITION BY
      ↓
Which rows belong together?

ORDER BY
      ↓
In what sequence are the rows processed?

WINDOW FRAME
      ↓
Which rows around the current row are included?
```

---

# 2. What is a Window Frame?

A window frame is the subset of rows used by the window function for the **current row**.

Example:

```text
Rows:

1
2
3
4
5
```

If the current row is:

```text
3
```

and the frame is:

```sql
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
```

the frame contains:

```text
2
3
4
```

So the calculation only uses those three rows.

---

# 3. ROWS

`ROWS` defines a frame based on the **physical rows** around the current row.

Example:

```sql
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
```

This means:

```text
2 rows before
+
current row
```

Therefore, at most 3 rows participate.

Example:

```text
Values:

10
20
30
40
50
```

For the row containing `30`:

```text
20
30
```

Wait — the frame is `2 PRECEDING`, so the correct frame is:

```text
10
20
30
```

For the row containing `40`:

```text
20
30
40
```

For the row containing `50`:

```text
30
40
50
```

---

# 4. CURRENT ROW

`CURRENT ROW` means the row currently being evaluated.

Example:

```sql
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
```

means:

```text
previous 2 rows
+
current row
```

Example:

```text
[10] [20] [30] [40] [50]
              ↑
         current row
```

Frame:

```text
[10] [20] [30]
```

---

# 5. PRECEDING

`PRECEDING` refers to rows before the current row.

Examples:

```sql
1 PRECEDING
```

means:

```text
one row before
```

```sql
2 PRECEDING
```

means:

```text
two rows before
```

```sql
5 PRECEDING
```

means:

```text
five rows before
```

---

# 6. FOLLOWING

`FOLLOWING` refers to rows after the current row.

Examples:

```sql
1 FOLLOWING
```

means:

```text
one row after
```

```sql
2 FOLLOWING
```

means:

```text
two rows after
```

---

# 7. UNBOUNDED PRECEDING

`UNBOUNDED PRECEDING` means:

> Start from the beginning of the partition.

Example:

```sql
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
```

means:

```text
Beginning of partition
        ↓
        ↓
        ↓
Current row
```

This is the classic **running total** frame.

Example:

```sql
SUM(order_value) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
)
```

---

# 8. UNBOUNDED FOLLOWING

`UNBOUNDED FOLLOWING` means:

> Continue until the end of the partition.

Example:

```sql
ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
```

means:

```text
Current row
    ↓
    ↓
    ↓
End of partition
```

---

# 9. Entire Partition

To include every row in the partition:

```sql
ROWS BETWEEN UNBOUNDED PRECEDING
         AND UNBOUNDED FOLLOWING
```

This means:

```text
Beginning
   ↓
ALL ROWS
   ↓
End
```

Example:

```sql
SUM(order_value) OVER(
    PARTITION BY customer_id
    ROWS BETWEEN UNBOUNDED PRECEDING
         AND UNBOUNDED FOLLOWING
)
```

Every row for that customer participates in the calculation.

---

# 10. Running Total Frame

A running total can explicitly be written as:

```sql
SUM(order_value) OVER(
    ORDER BY order_date
    ROWS BETWEEN UNBOUNDED PRECEDING
         AND CURRENT ROW
)
```

For:

```text
10
20
30
40
```

the calculation becomes:

```text
10
10 + 20
10 + 20 + 30
10 + 20 + 30 + 40
```

Result:

```text
10
30
60
100
```

---

# 11. Moving / Rolling Window

A 3-row moving calculation can be written:

```sql
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
```

For:

```text
10
20
30
40
50
```

the frames are:

```text
Row 1:
10

Row 2:
10, 20

Row 3:
10, 20, 30

Row 4:
20, 30, 40

Row 5:
30, 40, 50
```

This is useful for:

- Moving averages
- Rolling sums
- Recent customer behavior
- Time-series analysis
- Feature engineering

---

# 12. Following Window

A frame can also look forward.

Example:

```sql
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
```

For:

```text
10
20
30
40
50
```

the frames are:

```text
Row 1:
10, 20, 30

Row 2:
20, 30, 40

Row 3:
30, 40, 50

Row 4:
40, 50

Row 5:
50
```

This is useful when analysing future rows or upcoming events.

---

# 13. Previous + Current + Following

We can create a frame around the current row.

Example:

```sql
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
```

For:

```text
10
20
30
40
50
```

frames:

```text
Row 1:
10, 20

Row 2:
10, 20, 30

Row 3:
20, 30, 40

Row 4:
30, 40, 50

Row 5:
40, 50
```

This is useful for smoothing and local analysis.

---

# 14. Window Frame Visualisation

Think of the current row as a moving cursor:

```text
10   20   30   40   50
          ↑
       CURRENT ROW
```

If we use:

```sql
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
```

the frame becomes:

```text
10  [20  30  40]  50
          ↑
       CURRENT
```

As the current row moves:

```text
[10 20] 30 40 50

10 [20 30 40] 50

10 20 [30 40 50]
```

The frame moves with the current row.

---

# 15. ROWS BETWEEN Syntax

General syntax:

```sql
ROWS BETWEEN start AND end
```

Examples:

```sql
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
```

```sql
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
```

```sql
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
```

```sql
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
```

```sql
ROWS BETWEEN UNBOUNDED PRECEDING
         AND UNBOUNDED FOLLOWING
```

---

# 16. RANGE

`RANGE` is different from `ROWS`.

`ROWS` considers **physical rows**.

`RANGE` considers **values in the ORDER BY expression**.

This becomes especially important when there are duplicate ORDER BY values.

Example:

```text
order_date
----------
2024-01-01
2024-01-01
2024-01-02
2024-01-03
```

There are two rows with:

```text
2024-01-01
```

With `ROWS`, those are still two separate physical rows.

With `RANGE`, rows with the same ORDER BY value can be treated as peers.

---

# 17. ROWS vs RANGE

## ROWS

Think:

> "How many physical rows?"

Example:

```sql
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
```

Means:

```text
Exactly up to 2 physical rows before me
+
me
```

---

## RANGE

Think:

> "Which rows have ORDER BY values within the frame?"

Rows with the same ORDER BY value can belong to the same peer group.

---

# 18. Why Duplicate ORDER BY Values Matter

Suppose:

```text
employee   salary
A          50000
B          50000
C          60000
```

If we order by:

```sql
ORDER BY salary
```

employees A and B have the same ordering value.

They are peers.

This can cause `RANGE` and `ROWS` to produce different results.

Therefore:

> When duplicate ORDER BY values exist, always understand whether you need physical-row behaviour (`ROWS`) or value/peer-based behaviour (`RANGE`).

---

# 19. FIRST_VALUE and LAST_VALUE

Window frames are especially important for:

```sql
FIRST_VALUE()
LAST_VALUE()
```

Example:

```sql
FIRST_VALUE(order_date) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
)
```

Usually, finding the first value is straightforward.

But `LAST_VALUE()` can be surprising.

Example:

```sql
LAST_VALUE(order_date) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
)
```

The default frame may end at the **current row**.

So it can return the current row's value rather than the final value of the partition.

To get the actual last value:

```sql
LAST_VALUE(order_date) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
    ROWS BETWEEN UNBOUNDED PRECEDING
         AND UNBOUNDED FOLLOWING
)
```

Now the frame covers the entire partition.

---

# 20. Why Window Frames Matter

Window frames allow us to answer questions such as:

### Running revenue

```text
How much revenue have we generated so far?
```

### Rolling average

```text
What is the average of the last 3 purchases?
```

### Recent activity

```text
How many events happened in the previous 5 rows?
```

### Future activity

```text
What is the total of the next 3 events?
```

### Customer lifetime calculations

```text
What was the customer's first purchase?
What was the customer's final purchase?
```

---

# 21. AI/ML Applications

Window frames are especially useful for feature engineering.

Examples:

```text
rolling_7_day_sales
rolling_30_day_sales
rolling_3_order_average
previous_5_event_count
running_customer_spending
future_3_day_revenue
```

These can become features for machine-learning models.

Example:

```text
Customer
   ↓
Previous purchases
   ↓
Rolling average
   ↓
Feature
   ↓
ML model
```

---

# 22. Important Mental Model

Always think about a window function in this order:

```text
1. PARTITION BY
       ↓
Which group?

2. ORDER BY
       ↓
What sequence?

3. FRAME
       ↓
Which rows around the current row?

4. FUNCTION
       ↓
What calculation?
```

Example:

```sql
AVG(order_value) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
)
```

Read it as:

> For each customer, order their purchases by date, take the current order and previous two orders, and calculate their average value.

---

# 23. Most Important Frames to Know

You do NOT need to memorize every possible combination.

Understand these extremely well:

```sql
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
```

→ Running calculation

```sql
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
```

→ Current + previous 2 rows

```sql
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
```

→ Current + next 2 rows

```sql
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
```

→ Previous + current + next

```sql
ROWS BETWEEN UNBOUNDED PRECEDING
         AND UNBOUNDED FOLLOWING
```

→ Entire partition

---

# 24. Quick Reference

| Frame | Meaning |
|---|---|
| `CURRENT ROW` | Current row |
| `1 PRECEDING` | One physical row before |
| `2 PRECEDING` | Two physical rows before |
| `1 FOLLOWING` | One physical row after |
| `2 FOLLOWING` | Two physical rows after |
| `UNBOUNDED PRECEDING` | Beginning of partition |
| `UNBOUNDED FOLLOWING` | End of partition |
| `ROWS` | Physical rows |
| `RANGE` | ORDER BY value / peer-based frame |

---

# 25. Golden Rule 🧠

Remember:

```text
PARTITION BY
    ↓
WHO?

ORDER BY
    ↓
IN WHAT ORDER?

FRAME
    ↓
HOW MUCH OF THAT ORDERED DATA?

FUNCTION
    ↓
WHAT DO I CALCULATE?
```

Example:

```sql
SUM(order_value) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
)
```

Means:

```text
WHO?
→ Each customer

ORDER?
→ Order date

HOW MUCH?
→ Previous 2 + current

CALCULATION?
→ SUM
```

This is the core of Window Frames.
```

