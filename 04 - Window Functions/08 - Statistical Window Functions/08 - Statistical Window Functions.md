# Statistical Window Functions

Statistical window functions help us understand the **relative position of a row within a group**.

They are useful in:

- Ranking customers
- Comparing products
- Percentile-style analysis
- Customer segmentation
- Feature engineering
- Analytics
- ML preprocessing

The two functions we need to understand are:

```sql
PERCENT_RANK()
CUME_DIST()
```

---

## 1. PERCENT_RANK()

`PERCENT_RANK()` tells us the **relative rank position** of a row within its window.

Syntax:

```sql
PERCENT_RANK() OVER(
    PARTITION BY ...
    ORDER BY ...
)
```

The result is always between:

```text
0 and 1
```

### Formula

Conceptually:

```text
(rank - 1)
--------------
(total_rows - 1)
```

For example:

| value | rank | percent_rank |
|---:|---:|---:|
| 100 | 1 | 0 |
| 200 | 2 | 0.25 |
| 300 | 3 | 0.50 |
| 400 | 4 | 0.75 |
| 500 | 5 | 1 |

So:

```text
0    → first position
0.25 → 25% position
0.50 → 50% position
0.75 → 75% position
1    → last position
```

### Important

`PERCENT_RANK()` is based on **rank**, not simply the row number.

So ties can affect the result.

---

# 2. Example

Suppose products have these prices:

```text
1000
2000
3000
4000
5000
```

We can write:

```sql
SELECT
    product_name,
    price,
    PERCENT_RANK() OVER(
        ORDER BY price
    ) AS price_percent_rank
FROM products;
```

The cheapest product gets:

```text
0
```

and the most expensive gets:

```text
1
```

---

# 3. PARTITION BY with PERCENT_RANK()

We can calculate the relative position **inside each category**.

```sql
SELECT
    product_name,
    category,
    price,
    PERCENT_RANK() OVER(
        PARTITION BY category
        ORDER BY price
    ) AS category_percent_rank
FROM products;
```

Now each category has its **own ranking scale**.

Example:

```text
Electronics
    Laptop     → 0
    Monitor    → 0.5
    TV         → 1

Accessories
    Mouse      → 0
    Keyboard   → 1
```

The ranking restarts for every partition.

---

# 4. CUME_DIST()

`CUME_DIST()` means:

> **Cumulative distribution**

It tells us:

> **What proportion of rows have a value less than or equal to the current row?**

Syntax:

```sql
CUME_DIST() OVER(
    ORDER BY ...
)
```

The result is between:

```text
0 and 1
```

---

## Example

Suppose:

| price |
|---:|
| 100 |
| 200 |
| 300 |
| 400 |

Then:

| price | CUME_DIST |
|---:|---:|
| 100 | 0.25 |
| 200 | 0.50 |
| 300 | 0.75 |
| 400 | 1.00 |

Interpretation:

### Price = 200

```text
2 out of 4 products
have price <= 200
```

Therefore:

```text
2 / 4 = 0.50
```

---

# 5. The Main Difference

This is the most important part of this block.

### `PERCENT_RANK()`

Asks:

> **Where is this row positioned in the ranking?**

### `CUME_DIST()`

Asks:

> **What percentage of rows are at or below this row?**

---

## Example

Suppose:

```text
10
20
30
40
50
```

Using ascending order:

| value | PERCENT_RANK | CUME_DIST |
|---:|---:|---:|
| 10 | 0 | 0.20 |
| 20 | 0.25 | 0.40 |
| 30 | 0.50 | 0.60 |
| 40 | 0.75 | 0.80 |
| 50 | 1.00 | 1.00 |

Notice:

```text
PERCENT_RANK starts at 0
CUME_DIST does not
```

---

# 6. What Happens With Ties?

This is where `CUME_DIST()` becomes especially interesting.

Suppose:

| score |
|---:|
| 50 |
| 70 |
| 70 |
| 90 |

Using:

```sql
CUME_DIST() OVER(
    ORDER BY score
)
```

The two `70` values are peers.

Both will receive the same cumulative distribution because both represent the same position in the ordered value distribution.

Conceptually:

```text
50 → 1/4
70 → 3/4
70 → 3/4
90 → 4/4
```

Why `70 → 3/4`?

Because **3 rows have values ≤ 70**.

---

# 7. AI/ML Relevance 🧠

These functions are useful when creating features based on **relative position** rather than absolute values.

For example, suppose customers spend:

```text
₹5,000
₹10,000
₹20,000
₹50,000
₹1,00,000
```

Instead of feeding only raw spending into a model, you could derive a feature representing the customer's relative position among customers.

For example:

```text
customer_spending_percentile
```

This can help answer:

> Is this customer a relatively high-value customer compared with the rest?

---

# 8. When Would You Use Them?

### `PERCENT_RANK()`

Useful when you care about:

- Relative ranking
- Position within a population
- Ranking-based features
- Comparing products/customers

### `CUME_DIST()`

Useful when you care about:

- Proportion below/at a value
- Distribution analysis
- Threshold analysis
- Identifying how much of a population falls below a value

---

# 🧠 Quick Memory Trick

Remember:

```text
PERCENT_RANK
     ↓
"WHERE AM I?"

CUME_DIST
     ↓
"HOW MANY ARE BELOW/AT ME?"
```

Or even simpler:

```text
PERCENT_RANK → Position
CUME_DIST    → Distribution
```

---

# ⚠️ One Important Edge Case

If a partition contains only **one row**, `PERCENT_RANK()` returns:

```text
0
```

because there is no meaningful distance between a first and last rank.

Don't worry about memorizing the mathematical edge cases beyond recognizing this behavior.

---

# 🔥 Block 8 Summary

You should now recognize:

```sql
PERCENT_RANK() OVER(...)
```

and:

```sql
CUME_DIST() OVER(...)
```

### `PERCENT_RANK()`

```text
0 → first
1 → last
```

based on relative rank.

### `CUME_DIST()`

```text
0 < result <= 1
```

based on the proportion of rows whose ordered value is **≤ current value**.

### Both support:

```sql
PARTITION BY
ORDER BY
```

and are therefore useful for **group-level statistical analysis**.

---
