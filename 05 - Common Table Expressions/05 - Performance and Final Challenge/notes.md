# 05 — CTE Performance Considerations 📝

### CTE Performance

- CTEs mainly improve **readability and query organization**.
- A CTE is **not automatically faster** than a subquery.
- PostgreSQL decides how the CTE is executed.

### Materialization

**Materialized = calculate and temporarily store the CTE result.**

```sql
WITH customer_spending AS MATERIALIZED (
    SELECT ...
)
SELECT *
FROM customer_spending;
```

- Useful when an intermediate result can be reused.
- Can sometimes hurt performance if a huge intermediate result is created unnecessarily.
- It is **temporary**, not a permanent database table.

### NOT MATERIALIZED

```sql
WITH customer_spending AS NOT MATERIALIZED (
    SELECT ...
)
SELECT *
FROM customer_spending;
```

Allows PostgreSQL more freedom to optimize the CTE with the surrounding query.

### Query Performance Tools

```sql
EXPLAIN
SELECT ...;
```

→ Shows the planned execution.

```sql
EXPLAIN ANALYZE
SELECT ...;
```

→ Actually executes the query and shows the actual execution information.

### 🔑 Remember

```text
CTE
→ Organization / readability

MATERIALIZED
→ Calculate + temporarily store

NOT MATERIALIZED
→ Allow more optimization freedom

EXPLAIN
→ See execution plan

EXPLAIN ANALYZE
→ Execute + inspect actual performance
```