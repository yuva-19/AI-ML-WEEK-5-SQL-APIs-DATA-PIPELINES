# Combining Multiple Sources

Combining multiple data sources is an important part of data collection and ML dataset preparation.

Data can come from:

- CSV files
- APIs
- Databases
- Excel files
- Other datasets

The goal is to combine these sources into one clean and consistent dataset.

---

## 1. Merge

`pd.merge()` combines two DataFrames using a common column or key.

Example:

```python
result = pd.merge(
    customers,
    orders,
    on="customer_id"
)
```

Here, `customer_id` is the common key.

Conceptually:

```text
customers
customer_id | name
     ↓
    MATCH
     ↑
orders
customer_id | amount
```

Result:

```text
customer_id | name | amount
```

### SQL Equivalent

Pandas `merge()` is similar to a SQL `JOIN`.

---

## 2. Merge Types

Common merge types:

### Inner Merge

Returns only matching records.

```python
pd.merge(
    df1,
    df2,
    on="id",
    how="inner"
)
```

### Left Merge

Keeps all records from the left DataFrame.

```python
pd.merge(
    df1,
    df2,
    on="id",
    how="left"
)
```

### Right Merge

Keeps all records from the right DataFrame.

```python
pd.merge(
    df1,
    df2,
    on="id",
    how="right"
)
```

### Outer Merge

Keeps all records from both DataFrames.

```python
pd.merge(
    df1,
    df2,
    on="id",
    how="outer"
)
```

---

# 3. Join

`join()` combines DataFrames, commonly using their indexes.

Example:

```python
result = customers.set_index(
    "customer_id"
).join(
    orders.set_index("customer_id")
)
```

Here:

```text
customer_id
     ↓
  Index
     ↓
   JOIN
```

### Merge vs Join

```text
merge() → commonly column/key based
join()  → commonly index based
```

---

# 4. Union / Concatenation

Pandas uses `pd.concat()` to combine DataFrames vertically.

Example:

```python
result = pd.concat(
    [df1, df2],
    ignore_index=True
)
```

Example:

```text
df1

1  Yuva
2  Arun

df2

3  Ravi
4  Kumar
```

After concatenation:

```text
1  Yuva
2  Arun
3  Ravi
4  Kumar
```

### Mental Model

```text
Merge → combine columns / side-by-side

Concat → combine rows / one after another
```

---

# 5. Deduplication

When multiple sources are combined, duplicate records can appear.

Use:

```python
df.drop_duplicates()
```

This removes rows that are completely duplicated.

Example:

```python
df.drop_duplicates(
    inplace=True
)
```

---

## Deduplication Using a Key

When a specific column uniquely identifies a record, use `subset`.

```python
df.drop_duplicates(
    subset=["customer_id"],
    inplace=True
)
```

This ensures that each `customer_id` appears only once.

### Difference

```python
df.drop_duplicates()
```

Checks the entire row.

```python
df.drop_duplicates(
    subset=["customer_id"]
)
```

Checks only `customer_id`.

For real-world datasets, deduplication should usually be based on the correct **business key or unique identifier**.

---

# 6. Schema Alignment

Different sources may represent the same information using different column names.

Example:

### Source 1

```text
customer_id
name
city
```

### Source 2

```text
id
customer_name
city
```

Before combining them, align the schemas.

```python
customers_api = customers_api.rename(
    columns={
        "id": "customer_id",
        "customer_name": "name"
    }
)
```

Now both sources have:

```text
customer_id
name
city
```

They can safely be combined.

---

# 7. Why Schema Alignment Matters

Suppose:

```text
CSV:
customer_id

API:
id

Database:
cust_id
```

Although they represent the same concept, Pandas treats them as different columns.

Schema alignment standardizes them:

```text
CSV ─────────────┐
                 │
API ─────────────┼──→ Standard Schema
                 │
Database ────────┘
```

This makes downstream processing easier and more reliable.

---

# 8. Combining Multiple Sources

A common workflow is:

```text
Source 1 ───────┐
                │
Source 2 ───────┤
                ↓
        Schema Alignment
                ↓
             Concat
                ↓
        Deduplication
                ↓
         Clean Dataset
                ↓
          Merge / Join
                ↓
       Final ML Dataset
```

---

# 9. Example: Complete Workflow

```python
import pandas as pd

customers = pd.read_csv("customers.csv")
customers_api = pd.read_csv("customers_api.csv")
orders = pd.read_csv("orders.csv")

customers_api = customers_api.rename(
    columns={
        "id": "customer_id",
        "customer_name": "name"
    }
)

customers = pd.concat(
    [customers, customers_api],
    ignore_index=True
)

customers.drop_duplicates(
    subset=["customer_id"],
    inplace=True
)

result = pd.merge(
    customers,
    orders,
    on="customer_id"
)

print(result)
```

This combines multiple sources into a single dataset.

---

# 10. Important Pandas Functions

| Function | Purpose |
|---|---|
| `pd.merge()` | Combine DataFrames using a key |
| `.join()` | Combine DataFrames using indexes |
| `pd.concat()` | Stack/combine DataFrames |
| `.drop_duplicates()` | Remove duplicate rows |
| `.rename()` | Rename columns for schema alignment |
| `.set_index()` | Set a column as the DataFrame index |

---

# Key Mental Model

```text
MERGE
A + B
 ↓
Match using key
 ↓
Combine columns
```

```text
CONCAT
A
↓
B
↓
C
```

```text
SCHEMA ALIGNMENT
Different column names
        ↓
Standard column names
```

```text
DEDUPLICATION
Duplicate records
        ↓
Unique records
```

### Final Data Collection Pipeline

```text
CSV ────────┐
API ────────┤
Database ───┘
      ↓
Schema Alignment
      ↓
Merge / Join / Concat
      ↓
Deduplication
      ↓
Clean Dataset
      ↓
ML / Analytics
```