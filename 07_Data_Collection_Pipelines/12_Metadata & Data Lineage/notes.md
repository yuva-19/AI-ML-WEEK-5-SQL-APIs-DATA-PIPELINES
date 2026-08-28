# Metadata & Data Lineage

## 1. Metadata

**Metadata = data about data.**

It describes the properties and characteristics of a dataset.

Example:

```text
Dataset: customers.parquet
Format: Parquet
Rows: 100,000
Columns: 8
Size: 25 MB
Created: 2026-08-28
```

### Common Metadata

- Dataset name
- File format
- File size
- Number of rows
- Number of columns
- Column names
- Data types
- Created/modified time
- Data source
- Dataset version

### Column Metadata

```text
customer_id → integer
name        → string
salary      → float
```

---

# 2. Data Lineage

**Data lineage = the history and journey of data.**

It shows:

- Where the data came from
- What transformations were applied
- Where the data went
- What datasets depend on it

Example:

```text
API
 ↓
Raw JSON
 ↓
Cleaning
 ↓
customers.csv
 ↓
Validation
 ↓
customers.parquet
 ↓
ML Training Dataset
```

---

# 3. Data Source

Lineage helps identify the **original source** of data.

Example:

```text
customers.parquet
       ↑
customers.csv
       ↑
API
```

The API is the original source.

---

# 4. Data Transformations

Lineage tracks how data changes during a pipeline.

Example:

```text
Raw Data
   ↓
Remove duplicates
   ↓
Handle missing values
   ↓
Convert data types
   ↓
Join datasets
   ↓
Final Dataset
```

---

# 5. Data Dependencies

A dataset may depend on multiple other datasets.

Example:

```text
customers.csv ─────┐
                   ↓
                  JOIN
                   ↓
orders.csv ────────┘
                   ↓
            customer_orders
                   ↓
             ML Dataset
```

Here, `customer_orders` depends on:

- `customers.csv`
- `orders.csv`

If an input dataset changes, dependent datasets may also need to be updated.

---

# 6. Metadata vs Data Lineage

| Concept | Meaning |
|---|---|
| **Metadata** | Information about the data |
| **Data Lineage** | History and journey of the data |
| **Data Dependency** | Relationship between datasets |

### Easy way to remember

```text
Metadata → "What is this data?"

Lineage → "Where did it come from and what happened to it?"
```

---

# 7. ML Example

A machine-learning training dataset may have the following lineage:

```text
Customer API
      ↓
Raw Data
      ↓
Cleaning
      ↓
Validation
      ↓
Transactions Database
      ↓
Join
      ↓
Feature Engineering
      ↓
ML Training Dataset
      ↓
ML Model
```

Metadata for the final dataset might contain:

```text
Dataset: churn_training.parquet
Rows: 500,000
Features: 25
Format: Parquet
Source: Customer API + Transactions Database
Created: 2026-08-28
```

---

# Key Takeaways

- **Metadata** describes a dataset.
- **Data lineage** describes the journey of a dataset.
- Lineage identifies the **source** of data.
- Lineage tracks **transformations and changes**.
- Lineage shows **data dependencies**.
- Metadata helps understand and manage datasets.
- Data lineage is useful for **debugging, reproducibility, and ML data tracking**.
- Enterprise data-governance platforms are **not required at this stage**.

> **Core idea:** Metadata tells you **about the data**; lineage tells you **where the data came from and how it got to its current state**.