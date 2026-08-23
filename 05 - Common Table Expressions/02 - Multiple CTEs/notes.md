### Multiple CTEs

A **Multiple CTE** query uses more than one CTE in the same `WITH` clause.

Basic structure:

```sql
WITH first_cte AS (
    SELECT ...
),

second_cte AS (
    SELECT ...
    FROM first_cte
)

SELECT ...
FROM second_cte;
```

Think of it as a **pipeline**:

```text
Raw Tables
    ↓
CTE 1 — Prepare data
    ↓
CTE 2 — Analyze data
    ↓
CTE 3 — Further transform
    ↓
Final Result
```

---

## 1. Chaining CTEs

The second CTE can directly use the first CTE.

Example:

```sql
WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(order_value) AS total_spending
    FROM customer_orders
    GROUP BY customer_id
),

customer_analysis AS (
    SELECT
        customer_id,
        total_spending,
        RANK() OVER(
            ORDER BY total_spending DESC
        ) AS spending_rank
    FROM customer_spending
)

SELECT *
FROM customer_analysis;
```

Here:

- `customer_spending` → calculates spending
- `customer_analysis` → ranks customers
- Final query → displays the result

---

## 2. Why Multiple CTEs are useful

Instead of creating one giant query:

```text
JOIN
 ↓
GROUP BY
 ↓
Window Function
 ↓
CASE
 ↓
Filtering
```

we can break it into logical stages:

```text
CTE 1 → Prepare
CTE 2 → Aggregate
CTE 3 → Analyze
Final → Filter / Display
```

This is especially useful in **AI/ML data preprocessing**.

For example:

```text
Raw transactions
       ↓
Customer features
       ↓
Customer statistics
       ↓
Customer segmentation
```

---

## 3. A CTE can use another CTE

This is the most important concept.

```sql
WITH sales AS (
    SELECT ...
),

customer_totals AS (
    SELECT ...
    FROM sales
),

customer_ranking AS (
    SELECT ...
    FROM customer_totals
)

SELECT *
FROM customer_ranking;
```

The order matters:

```text
sales
  ↓
customer_totals
  ↓
customer_ranking
```

You **cannot normally reference a CTE before it has been defined**.

---

## 4. Multiple CTEs vs one huge CTE

### ❌ Difficult to maintain

```sql
WITH customer_analysis AS (
    SELECT
        ... huge calculation ...
        ... another calculation ...
        ... another calculation ...
        ... another calculation ...
)
SELECT ...
```

### ✅ Better

```sql
WITH customer_spending AS (
    -- Step 1
),

customer_ranking AS (
    -- Step 2
),

customer_segment AS (
    -- Step 3
)

SELECT *
FROM customer_segment;
```

Each CTE should ideally have **one clear responsibility**.

---

## 5. Multiple CTEs for Feature Engineering 🔥

This is particularly important for your AI/ML roadmap.

Imagine we want customer features.

### Step 1 — Customer spending

```sql
WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(order_value) AS total_spending
    FROM customer_orders
    GROUP BY customer_id
),
```

### Step 2 — Add order frequency

```sql
customer_features AS (
    SELECT
        cs.customer_id,
        cs.total_spending,
        COUNT(o.order_id) AS order_count
    FROM customer_spending AS cs
    LEFT JOIN orders AS o
        ON cs.customer_id = o.customer_id
    GROUP BY
        cs.customer_id,
        cs.total_spending
)
```

### Step 3 — Final dataset

```sql
SELECT *
FROM customer_features;
```

Now the output itself becomes an **ML-ready feature table**:

```text
customer_id | total_spending | order_count
------------+----------------+------------
1           | 4500           | 8
2           | 1200           | 3
3           | 7800           | 12
```

That's one of the major reasons CTEs are valuable for **data preprocessing and feature engineering**.

---

## 🧠 Key takeaway

Remember this pattern:

```sql
WITH
    step_1 AS (...),

    step_2 AS (
        SELECT ...
        FROM step_1
    ),

    step_3 AS (
        SELECT ...
        FROM step_2
    )

SELECT ...
FROM step_3;
```