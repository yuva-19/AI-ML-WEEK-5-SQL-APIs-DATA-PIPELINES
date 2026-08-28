# Idempotent Pipelines

An **idempotent pipeline** is a pipeline that can be run multiple times with the same input without producing incorrect duplicate or inconsistent results.

### Core Principle

```text
Run once  → Correct result
Run again → Same correct final result
```

---

## 1. Why Idempotency Is Important

Pipeline failures can happen during:

- Data extraction
- Transformation
- Loading
- Network communication
- Checkpoint updates

A pipeline should therefore be **safely rerunnable**.

Example:

```text
Extract       → ✅
Transform     → ✅
Load          → ✅
Checkpoint    → ❌
```

If the pipeline is restarted, the same records may be processed again.

Without idempotency:

```text
101
102
103
101
102
103
```

This creates duplicate records.

With idempotency:

```text
101
102
103
```

The final state remains correct.

---

# 2. Avoiding Duplicate Records

Common techniques for preventing duplicates include:

### Primary Keys

A primary key uniquely identifies a record.

```sql
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT,
    salary INTEGER
);
```

Attempting to insert another record with the same `customer_id` violates the uniqueness constraint.

---

### Duplicate Checks

Before inserting a record, check whether its unique identifier already exists.

```text
Record arrives
      ↓
Does ID exist?
   ↙       ↘
 YES       NO
 ↓          ↓
Skip      Insert
```

---

### Upsert

**Upsert = INSERT + UPDATE**

```text
Record arrives
      ↓
Does ID exist?
   ↙       ↘
 YES       NO
 ↓          ↓
UPDATE    INSERT
```

If the record does not exist, insert it.

If it already exists, update it.

---

# 3. Idempotency and Incremental Loading

Incremental loading processes new or changed records.

Suppose:

```text
Last processed ID = 105
```

The pipeline loads:

```text
106
107
108
```

If the pipeline fails before updating its checkpoint, the next run may attempt to process:

```text
106
107
108
```

again.

Without idempotency:

```text
106
107
108
106
107
108
```

With idempotency:

```text
106 → already exists
107 → already exists
108 → already exists
```

No unintended duplicates are created.

---

# 4. Handling Failed Pipeline Runs

A reliable pipeline should distinguish between:

```text
Successful Load
```

and

```text
Failed Load
```

A typical workflow is:

```text
Extract
   ↓
Transform
   ↓
Load
   ↓
Load successful?
   ↓
  YES
   ↓
Update Checkpoint
```

If loading fails:

```text
Load failed
    ↓
Do NOT advance checkpoint
    ↓
Retry
```

This prevents records from being accidentally skipped.

---

# 5. Checkpoint + Idempotency

Incremental pipelines commonly maintain a checkpoint such as:

```python
last_processed_id
```

or:

```python
last_processed_time
```

The general workflow is:

```text
Source
   ↓
Find new/changed records
   ↓
Transform
   ↓
Idempotent Load
   ↓
Successful?
   ↓
Update Checkpoint
```

The checkpoint should be advanced **only after successful processing/loading**.

---

# 6. Real-World Example

Suppose an API provides:

```text
order_id    amount
1001        500
1002        800
1003        300
```

The pipeline loads these orders and then crashes.

### Non-idempotent retry

The same records are inserted again:

```text
1001
1002
1003
1001
1002
1003
```

### Idempotent retry

The pipeline recognizes that the records already exist:

```text
1001
1002
1003
```

The final database state remains correct.

---

# 7. Key Concepts

| Concept | Purpose |
|---|---|
| **Idempotency** | Makes repeated pipeline runs safe |
| **Primary Key** | Uniquely identifies records |
| **Duplicate Check** | Prevents repeated records |
| **Upsert** | Inserts new records and updates existing ones |
| **Checkpoint** | Records how far processing has progressed |
| **Retry** | Allows failed pipeline runs to be executed again |

---

# Key Takeaways

```text
Idempotent Pipeline
        ↓
Safe to rerun
        ↓
No unintended duplicates
        ↓
Handles failures and retries
```

The core principle is:

> **A pipeline should produce the same correct final state even when it is safely rerun.**

