# Common Table Expressions (CTEs)

## 1. What is a CTE?

A **Common Table Expression (CTE)** is a temporary named result set that exists only during the execution of a SQL query.

It is created using the `WITH` clause.

A CTE allows us to **break a complex SQL query into smaller, logical steps**.

### Basic idea

Instead of writing:

```text
One huge query
      ↓
Difficult to understand
      ↓
Difficult to debug
```

we can write:

```text
Step 1 → CTE
   ↓
Step 2 → Main Query
```

This makes complex SQL much easier to read and maintain.

---

# 2. Basic CTE Syntax

```sql
WITH cte_name AS (
    SELECT
        column1,
        column2
    FROM table_name
)
SELECT *
FROM cte_name;
```

### Structure

```sql
WITH cte_name AS (
    -- Query that creates the temporary result
)
-- Main query
SELECT *
FROM cte_name;
```

---

# 3. Example

Suppose we want to find customers who have placed more than 2 orders.

Without a CTE:

```sql
SELECT
    customer_id,
    COUNT(*) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 2;
```

Using a CTE:

```sql
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
)
SELECT
    customer_id,
    order_count
FROM customer_orders
WHERE order_count > 2;
```

### What happened?

The CTE:

```sql
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
)
```

creates a temporary result called:

```text
customer_orders
```

Then the main query uses it like a table:

```sql
SELECT *
FROM customer_orders;
```

---

# 4. CTE is NOT a permanent table

A CTE does **not** permanently create a table in the database.

For example:

```sql
WITH customer_orders AS (
    SELECT *
    FROM orders
)
SELECT *
FROM customer_orders;
```

After this query finishes:

```text
customer_orders
```

no longer exists.

It is available only during that query.

### Important

```text
CTE
↓
Temporary query result
↓
Exists only for one SQL statement
```

---

# 5. Why Use CTEs?

CTEs are especially useful when SQL queries become complicated.

### Main advantages

#### 1. Readability

Instead of putting everything into one massive query:

```sql
SELECT ...
FROM (
    SELECT ...
    FROM (
        SELECT ...
        FROM ...
    ) sub1
) sub2;
```

we can separate the logic:

```sql
WITH step1 AS (
    ...
),
step2 AS (
    ...
)
SELECT ...
FROM step2;
```

---

#### 2. Breaking complex queries into steps

A complex data transformation can be divided into logical stages.

Example:

```text
Raw data
   ↓
Calculate order value
   ↓
Calculate customer spending
   ↓
Rank customers
   ↓
Final result
```

Each stage can become a CTE.

---

#### 3. Easier debugging

You can temporarily run the CTE by itself.

For example:

```sql
WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(order_value) AS total_spending
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM customer_spending;
```

You can check whether the intermediate result is correct **before building the next step**.

---

#### 4. Maintainability

If the query needs to be modified later, individual steps are easier to understand and change.

---

# 6. CTE vs Subquery

A CTE and a subquery can often perform similar operations.

### Subquery

```sql
SELECT *
FROM (
    SELECT
        customer_id,
        COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
) AS sub
WHERE order_count > 2;
```

### CTE

```sql
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM customer_orders
WHERE order_count > 2;
```

Both can produce the same result.

The major difference is **how the query is organized and expressed**.

---

# 7. CTE as a Named Query Step

Think of a CTE as giving a name to an intermediate query.

```sql
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
)
```

Here:

```text
customer_orders
```

is the name of the intermediate result.

You can think of it as:

```text
customer_orders
        ↓
temporary result
        ↓
used by the main query
```

---

# 8. CTE Can Contain Aggregation

A CTE can perform calculations and aggregations.

Example:

```sql
WITH product_revenue AS (
    SELECT
        product_id,
        SUM(quantity * unit_price) AS total_revenue
    FROM order_items
    GROUP BY product_id
)
SELECT *
FROM product_revenue;
```

The CTE calculates:

```text
product_id
total_revenue
```

The main query then works with that result.

---

# 9. CTE Can Be Joined

A CTE behaves like a query result that can be used in joins.

Example:

```sql
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.first_name,
    customer_orders.order_count
FROM customers AS c
LEFT JOIN customer_orders
    ON c.customer_id = customer_orders.customer_id;
```

Flow:

```text
customers
     +
customer_orders CTE
     ↓
   JOIN
     ↓
final result
```

---

# 10. CTE Can Be Used With Window Functions

CTEs are extremely useful when a window function needs to operate on an already-calculated result.

Example:

```sql
WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(quantity * unit_price) AS total_spending
    FROM order_items
    GROUP BY customer_id
)
SELECT
    customer_id,
    total_spending,
    RANK() OVER(
        ORDER BY total_spending DESC
    ) AS spending_rank
FROM customer_spending;
```

### Why is this useful?

We first calculate:

```text
customer_id
total_spending
```

Then the outer query performs:

```sql
RANK()
```

on the calculated `total_spending`.

This is a very common real-world SQL pattern.

---

# 11. CTE Execution Structure

A CTE query can be mentally understood as:

```text
WITH
   ↓
Create intermediate result
   ↓
Main SELECT
   ↓
Use intermediate result
   ↓
Final output
```

Example:

```sql
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
)
SELECT
    customer_id,
    order_count
FROM customer_orders
WHERE order_count >= 3;
```

Execution logic:

```text
1. Create customer_orders result
              ↓
2. Main SELECT reads customer_orders
              ↓
3. WHERE filters the result
              ↓
4. Final output
```

---

# 12. CTE Naming Best Practices

Use meaningful names.

### ❌ Bad

```sql
WITH x AS (
    ...
)
```

### Better

```sql
WITH customer_orders AS (
    ...
)
```

### Even better for multi-step queries

```sql
WITH customer_order_counts AS (
    ...
)
```

The name should tell you **what the CTE contains**.

---

# 13. Important CTE Rules

### Rule 1 — CTE starts with `WITH`

```sql
WITH cte_name AS (
    ...
)
```

---

### Rule 2 — CTE must be followed by a main SQL statement

```sql
WITH customer_orders AS (
    ...
)
SELECT *
FROM customer_orders;
```

---

### Rule 3 — CTE exists only for that statement

```sql
WITH customer_orders AS (
    ...
)
SELECT *
FROM customer_orders;
```

You cannot later do:

```sql
SELECT *
FROM customer_orders;
```

because the CTE has already disappeared.

---

### Rule 4 — A CTE can be treated like a table

You can:

- `SELECT` from it
- `JOIN` it
- filter it
- aggregate it
- apply window functions to it

---

# 14. CTE vs Temporary Table

Do not confuse a CTE with a temporary table.

| CTE | Temporary Table |
|---|---|
| Exists for one SQL statement | Can exist for a session/transaction depending on definition |
| Created using `WITH` | Created using `CREATE TEMP TABLE` |
| Mainly for query organization | Stores intermediate data |
| No permanent table creation | Actual temporary table object |
| Excellent for multi-step queries | Useful when intermediate data needs repeated use |

For this module, focus primarily on **CTEs for query organization and transformation**.

---

# 15. CTE and Data Preprocessing

CTEs are very useful in **data preprocessing**.

Example workflow:

```text
orders
   ↓
Calculate order value
   ↓
Filter valid orders
   ↓
Calculate customer spending
   ↓
Rank customers
   ↓
Final dataset
```

This is very similar to how data pipelines are designed.

Example:

```sql
WITH order_values AS (
    SELECT
        order_id,
        SUM(quantity * unit_price) AS order_value
    FROM order_items
    GROUP BY order_id
)
SELECT *
FROM order_values;
```

The CTE creates a clean intermediate dataset that can be used for further processing.

---

# 16. CTE and Feature Engineering

CTEs are also useful for preparing features for **AI/ML datasets**.

For example, suppose we want:

```text
customer_id
total_orders
total_spending
average_order_value
```

We can calculate these as a preprocessing step:

```sql
WITH customer_features AS (
    SELECT
        o.customer_id,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(oi.quantity * oi.unit_price) AS total_spending,
        AVG(oi.quantity * oi.unit_price) AS average_value
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    GROUP BY o.customer_id
)
SELECT *
FROM customer_features;
```

The resulting CTE can represent a **feature table** for machine learning.

---

# 17. Mental Model 🧠

Whenever you see a complicated SQL query, think:

> **"Can I split this into logical steps?"**

For example:

```text
Step 1
Calculate order values

        ↓

Step 2
Calculate customer spending

        ↓

Step 3
Rank customers

        ↓

Step 4
Create final output
```

CTEs allow us to write exactly that structure.

---

# ⭐ Key Takeaways

Remember these:

```text
CTE = Common Table Expression

WITH name AS (
    query
)
SELECT ...
FROM name;
```

### CTE is mainly used for:

- ✅ Readability
- ✅ Breaking complex queries into steps
- ✅ Maintainability
- ✅ Intermediate calculations
- ✅ Aggregations
- ✅ Joins
- ✅ Window functions
- ✅ Data preprocessing
- ✅ Feature engineering

### Most important mental model:

```text
CTE
 ↓
Intermediate result
 ↓
Main query
 ↓
Final result
```