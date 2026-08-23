# 🧠 CTE vs Subquery — Explanation
## 1. Same problem, two approaches

Suppose we want:

> Find customers whose total spending is above the average customer spending.

### Using a subquery

```sql
SELECT
    customer_id,
    total_spending
FROM (
    SELECT
        c.customer_id,
        SUM(oi.quantity * oi.unit_price) AS total_spending
    FROM customers AS c
    LEFT JOIN orders AS o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items AS oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id
) AS customer_spending
WHERE total_spending > (
    SELECT AVG(total_spending)
    FROM (
        SELECT
            c.customer_id,
            SUM(oi.quantity * oi.unit_price) AS total_spending
        FROM customers AS c
        LEFT JOIN orders AS o
            ON c.customer_id = o.customer_id
        LEFT JOIN order_items AS oi
            ON o.order_id = oi.order_id
        GROUP BY c.customer_id
    ) AS customer_spending
);
```

😵 Notice the problem?

We're repeating the same customer-spending calculation.

---

## 2. Same thing using a CTE

```sql
WITH customer_spending AS (
    SELECT
        c.customer_id,
        SUM(oi.quantity * oi.unit_price) AS total_spending
    FROM customers AS c
    LEFT JOIN orders AS o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items AS oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id
)

SELECT
    customer_id,
    total_spending
FROM customer_spending
WHERE total_spending > (
    SELECT AVG(total_spending)
    FROM customer_spending
);
```

Much cleaner.

The CTE gives the intermediate result a name:

```text
customer_spending
       ↓
customer_id | total_spending
```

Then we can work with that result.

---

# 3. Why CTEs are useful

Think of a CTE as creating a **temporary named step inside your query**.

For example:

```text
Raw tables
    ↓
customer_spending
    ↓
customer_ranking
    ↓
customer_segment
    ↓
Final result
```

This is why CTEs are extremely useful for **data preprocessing and feature engineering**.

Instead of writing one giant query, we break the transformation into logical stages.

---

# 4. Multiple CTEs vs deeply nested subqueries

### 😵 Nested subquery approach

```sql
SELECT *
FROM (
    SELECT *
    FROM (
        SELECT *
        FROM (
            ...
        ) AS step1
    ) AS step2
) AS step3;
```

This becomes difficult to read.

### 😎 CTE approach

```sql
WITH step1 AS (
    ...
),

step2 AS (
    ...
),

step3 AS (
    ...
)

SELECT *
FROM step3;
```

The actual data-processing logic is the same idea, but the CTE version clearly shows the **pipeline**.

---

# 5. Reusability inside the same query

This is one of the biggest advantages.

Suppose:

```sql
WITH customer_spending AS (
    SELECT
        c.customer_id,
        SUM(oi.quantity * oi.unit_price) AS total_spending
    FROM customers AS c
    LEFT JOIN orders AS o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items AS oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id
)
```

Now the later query can reference:

```sql
customer_spending
```

multiple times.

For example:

```sql
SELECT *
FROM customer_spending
WHERE total_spending > 1000;
```

and:

```sql
SELECT AVG(total_spending)
FROM customer_spending;
```

The important idea:

> **A CTE gives a complex intermediate result a name that can be referenced by later parts of the same SQL statement.**

---

# 6. CTE vs Subquery

| | CTE | Subquery |
|---|---|---|
| Readability | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| Complex transformations | Excellent | Can become messy |
| Multiple stages | Excellent | Difficult |
| Naming intermediate result | Yes | Usually aliases |
| Reuse within query | Very useful | Often requires repetition |
| Simple one-off calculation | Sometimes unnecessary | Excellent |
| Performance | Depends on query/DB | Depends on query/DB |

### Simple rule

Use a **subquery** when the operation is small and local:

```text
"I just need this one intermediate calculation."
```

Use a **CTE** when the query has a meaningful processing stage:

```text
"I want to calculate something, then transform it,
then analyze it, then classify it."
```

---

# 7. CTEs don't automatically mean faster SQL ⚠️

This is important.

Don't think:

> CTE = faster.

❌ Not necessarily.

A CTE is primarily a **query-organization tool**.

Performance depends on things like:

- Query structure
- Joins
- Indexes
- Aggregations
- PostgreSQL's execution plan
- Whether a CTE is materialized

So:

```text
CTE → better organization
```

does **not** automatically mean:

```text
CTE → better performance
```

---

# 8. PostgreSQL materialization — introduction

A CTE can, depending on PostgreSQL version and query structure, be **inlined** into the surrounding query or **materialized** as an intermediate result.

You don't need to deeply study the optimizer behavior right now.

Just understand:

```text
CTE
 ↓
PostgreSQL decides how it should be executed
 ↓
may inline / may materialize
```

You can explicitly influence this with:

```sql
WITH customer_spending AS MATERIALIZED (
    ...
)
```

or:

```sql
WITH customer_spending AS NOT MATERIALIZED (
    ...
)
```

For your current roadmap, **recognize these keywords; don't memorize optimizer internals.**

---

# 🎯 The key takeaway

When you see a problem like:

```text
Calculate A
      ↓
Use A to calculate B
      ↓
Use B to calculate C
      ↓
Classify the result
```

think:

```sql
WITH A AS (...),

B AS (...),

C AS (...)

SELECT ...
FROM C;
```

That's the real reason we're learning CTEs for AI/ML work.

It lets you build a clean **data transformation pipeline** instead of one giant unreadable query. 🔥

---

