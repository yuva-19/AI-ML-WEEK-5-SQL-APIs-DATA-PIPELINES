# Incremental Data Loading

Incremental data loading is a data pipeline technique where only **new or changed records** are processed instead of loading the entire dataset every time.

It becomes especially important when datasets grow large.

---

## 1. Full Load

A **full load** processes the complete dataset every time the pipeline runs.

```text
Source
   ↓
All Records
   ↓
Destination
```

Example:

```text
Day 1 → 100,000 records
Day 2 → 100,500 records
Day 3 → 101,000 records
```

Each run processes all available records.

### Advantages

- Simple to implement
- Easy to understand
- Destination can be rebuilt from scratch

### Disadvantages

- Slower for large datasets
- Reprocesses unchanged data
- Higher CPU, memory, and network usage

---

# 2. Incremental Load

An **incremental load** processes only records that are new or have changed since the previous pipeline run.

```text
Source
   ↓
New / Changed Records
   ↓
Destination
```

Example:

```text
Existing records → 100,000
New records      → 500

Incremental load → 500 records
```

Instead of processing all 100,500 records, only the relevant changes are processed.

---

# 3. New-Record Loading

New-record loading identifies records that did not previously exist in the destination.

Example:

```text
Previous IDs:
101
102
103

Current IDs:
101
102
103
104
105
```

New records:

```text
104
105
```

Using Pandas:

```python
new_data = df[df["customer_id"] > last_processed_id]
```

---

# 4. Updated-Record Loading

Existing records can also change.

Example:

```text
Customer ID: 101

Before:
salary = 50,000

After:
salary = 55,000
```

The ID is not new, but the record has been modified.

A good incremental pipeline therefore needs to handle:

```text
NEW RECORDS
      +
UPDATED RECORDS
```

---

# 5. Timestamp-Based Loading

Timestamp-based loading uses a column such as:

```text
updated_at
```

to identify records that changed after the previous pipeline run.

Example:

```text
last_processed_time =
2026-08-27 00:00:00
```

Query/filter:

```python
df["updated_at"] > last_processed_time
```

Or in SQL:

```sql
SELECT *
FROM customers
WHERE updated_at > '2026-08-27 00:00:00';
```

This can detect both **new and updated records**, provided the `updated_at` value is correctly updated whenever a record changes.

---

# 6. ID-Based Loading

ID-based loading uses an increasing identifier to find new records.

Example:

```text
Last processed ID = 105
```

Filter:

```python
new_data = df[df["customer_id"] > last_processed_id]
```

SQL equivalent:

```sql
SELECT *
FROM customers
WHERE customer_id > 105;
```

Result:

```text
106
107
108
```

After processing:

```python
last_processed_id = max(new_data["customer_id"])
```

The ID becomes the new checkpoint.

---

# 7. ID-Based vs Timestamp-Based Loading

| Feature | ID-Based | Timestamp-Based |
|---|---|---|
| Main column | `id` | `updated_at` |
| Detects new records | Yes | Yes |
| Detects updated records | Usually no | Yes |
| Requires increasing IDs | Usually | No |
| Common use | New-record ingestion | New + updated records |

### Important limitation of ID-based loading

Suppose:

```text
Last processed ID = 105
```

Then customer `101` is updated.

Its ID is still:

```text
101
```

This filter:

```python
df["customer_id"] > 105
```

will not detect customer `101`.

Timestamp-based loading can detect it:

```python
df["updated_at"] > last_processed_time
```

---

# 8. Checkpoint

A **checkpoint** records the point up to which the pipeline has successfully processed data.

Common checkpoints include:

```text
last_processed_id
```

or:

```text
last_processed_time
```

### ID checkpoint

```text
Last processed ID
       ↓
      105
       ↓
Find IDs > 105
       ↓
106, 107, 108
       ↓
Process
       ↓
New checkpoint = 108
```

### Timestamp checkpoint

```text
Last processed timestamp
       ↓
2026-08-27 00:00:00
       ↓
Find records after timestamp
       ↓
Process
       ↓
Update checkpoint
```

---

# 9. New + Updated Record Detection

A timestamp-based pipeline can first identify all changed records:

```python
changed_data = df[
    df["updated_at"] > last_processed_time
]
```

Then compare their IDs with the old dataset.

### New records

```python
new_records = changed_data[
    ~changed_data["customer_id"].isin(old_ids)
]
```

### Updated records

```python
updated_records = changed_data[
    changed_data["customer_id"].isin(old_ids)
]
```

Conceptually:

```text
             Changed Records
                    ↓
          ┌─────────┴─────────┐
          ↓                   ↓
   ID exists in old     ID doesn't exist
       dataset              dataset
          ↓                   ↓
       UPDATED               NEW
```

---

# 10. Why Incremental Loading Matters for ML

Large ML datasets can contain millions or even billions of records.

Suppose:

```text
Existing data = 500 million records
Daily changes = 100,000 records
```

Full loading:

```text
500,100,000 records
```

Incremental loading:

```text
100,000 records
```

Incremental loading can therefore reduce:

- Processing time
- Database load
- Network usage
- Memory usage
- Compute cost

and makes data pipelines more scalable.

---

# Key Takeaways

```text
Full Load
→ Process everything every time

Incremental Load
→ Process only new/changed data

ID-Based
→ Good for detecting new records

Timestamp-Based
→ Can detect new + updated records

Checkpoint
→ Remembers where the previous pipeline run stopped
```

**Core idea:**

> Incremental loading avoids repeatedly processing data that has not changed.