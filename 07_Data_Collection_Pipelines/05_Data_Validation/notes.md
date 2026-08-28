# Data Validation

Data validation is the process of checking whether collected data is **correct, complete, consistent, and suitable for downstream processing or machine learning**.

It acts as a quality checkpoint between raw data collection and data processing.

```text
Raw Data
   ↓
Data Validation
   ↓
Valid Data ─────→ Processing / ML
   ↓
Invalid Data
   ↓
Fix / Reject
```

---

## 1. Missing-Value Detection

Missing-value detection identifies fields where data is absent.

### Check for missing values

```python
df.isna()
```

### Count missing values in each column

```python
df.isna().sum()
```

### Check whether a column contains any missing values

```python
df["age"].isna().any()
```

### Check for non-missing values

```python
df["age"].notna()
```

Example:

```text
name      0
age       2
salary    1
city      0
```

This indicates that `age` contains 2 missing values and `salary` contains 1.

---

# 2. Schema Validation

A schema defines the expected **structure of a dataset**.

It can specify:

- Required columns
- Column names
- Data types
- Required fields
- Expected formats

Example expected schema:

```text
customer_id → integer
name        → string
age         → integer
salary      → numeric
city        → string
status      → string
start_date  → datetime
end_date    → datetime
```

### Check column names

```python
df.columns
```

### Check data types

```python
df.dtypes
```

### Check for missing expected columns

```python
expected_columns = [
    "customer_id",
    "name",
    "age",
    "salary",
    "city",
    "status",
    "start_date",
    "end_date"
]

missing_columns = []

for column in expected_columns:
    if column not in df.columns:
        missing_columns.append(column)
```

### Check for unexpected columns

```python
extra_columns = []

for column in df.columns:
    if column not in expected_columns:
        extra_columns.append(column)
```

Schema validation helps detect unexpected changes in incoming API, CSV, or database data.

---

# 3. Data-Type Validation

Data must have the expected type.

Example:

```text
age       → integer
salary    → numeric
status    → string
start_date → datetime
```

Check current types:

```python
df.dtypes
```

An incorrect value such as:

```text
age
----
21
25
"thirty-two"
30
```

indicates a data-type problem.

### Important

Validation and cleaning are different processes.

```text
Validation
    ↓
Detect "thirty-two" as invalid
    ↓
Cleaning
    ↓
Convert / fix the value
```

Do not automatically modify invalid data when the objective is only to validate it.

---

# 4. Duplicate Detection

Duplicate records can occur when data comes from multiple sources or when a pipeline processes the same data more than once.

### Detect duplicates

```python
df.duplicated()
```

### Count duplicates

```python
df.duplicated().sum()
```

### Display duplicate records

```python
df[df.duplicated(keep=False)]
```

### Check duplicates using a specific identifier

```python
df["customer_id"].duplicated().sum()
```

For example:

```text
customer_id
1
2
3
3
4
```

The second `3` is a duplicate customer ID.

---

# 5. Range Validation

Range validation checks whether numerical values fall within an acceptable range.

Example:

```text
18 <= age <= 120
```

```python
age_filter = (
    (df["age"] >= 18) &
    (df["age"] <= 120)
)

invalid_ages = df.loc[~age_filter]
```

Another example:

```text
salary >= 0
```

```python
salary_filter = df["salary"] >= 0

invalid_salary = df.loc[~salary_filter]
```

A value can have the correct data type but still be invalid.

```text
age = 250
```

is an integer, but it violates the expected range.

---

# 6. Business Rules

Business rules validate whether data follows rules defined by the application or organization.

Examples:

```text
age >= 18
salary >= 0
order_amount >= 0
```

Example:

```python
invalid = df[df["salary"] < 0]
```

More complex business rules can combine multiple columns.

Example:

```python
invalid = df[
    (df["customer_type"] == "premium") &
    (df["total_spending"] < 10000)
]
```

Business rules ensure that data is not only technically valid but also **meaningful in the business context**.

---

# 7. Unexpected Values

Categorical columns should contain only expected values.

Example:

```python
allowed_status = [
    "active",
    "inactive",
    "premium"
]
```

Check for unexpected values:

```python
invalid_status = df[
    ~df["status"].isin(allowed_status)
]
```

Check unique values:

```python
df["status"].unique()
```

Example:

```text
active
inactive
premium
unknown
```

If `unknown` is not part of the allowed values, it is an unexpected value.

---

# 8. Data Consistency

Data consistency checks whether related values agree with each other.

### Example: Date consistency

The end date should not occur before the start date.

```python
date_filter = (
    df["end_date"] >= df["start_date"]
)

invalid_dates = df.loc[~date_filter]
```

Example:

```text
start_date = 2026-08-20
end_date   = 2026-08-15
```

This is inconsistent because the end date occurs before the start date.

Other examples:

```text
country = India
city = New York
```

or:

```text
start_date > end_date
```

---

# 9. Required-Field Validation

Some fields must always contain values.

For example:

```text
customer_id → required
name        → required
```

Check:

```python
required_fields_invalid = (
    df["customer_id"].isna() |
    df["name"].isna()
)
```

Display invalid records:

```python
df.loc[required_fields_invalid]
```

Count them:

```python
required_fields_invalid.sum()
```

Using one combined condition prevents the same row from being counted twice when multiple required fields are missing.

---

# 10. Validation Report

A validation report summarizes all detected problems.

```python
print("========== DATA VALIDATION REPORT ==========")

print("\nMissing Values:")
print(df.isna().sum())

print("\nDuplicate Records:")
print(df.duplicated().sum())

print("\nInvalid Ages:")
print((~age_filter).sum())

print("\nInvalid Salaries:")
print((~salary_filter).sum())

print("\nUnexpected Status:")
print((~df["status"].isin(allowed_status)).sum())

print("\nInvalid Dates:")
print((~date_filter).sum())

required_fields_invalid = (
    df["customer_id"].isna() |
    df["name"].isna()
)

print("\nMissing Required Fields:")
print(required_fields_invalid.sum())
```

Example output:

```text
========== DATA VALIDATION REPORT ==========

Missing Values:
customer_id    0
name           1
age            1
salary         0

Duplicate Records:
1

Invalid Ages:
1

Invalid Salaries:
1

Unexpected Status:
1

Invalid Dates:
1

Missing Required Fields:
1
```

---

# 11. Overall Dataset Validity

A dataset can be considered valid only when all required validation rules pass.

Conceptually:

```text
Schema Valid
     AND
No Required Missing Values
     AND
No Duplicates
     AND
Correct Data Types
     AND
Valid Ranges
     AND
Valid Business Rules
     AND
Consistent Data
     ↓
Dataset Valid
```

A simple validity flag can be created:

```python
is_valid = (
    len(missing_columns) == 0
    and len(extra_columns) == 0
    and df["customer_id"].notna().all()
    and df["name"].notna().all()
    and df.duplicated().sum() == 0
    and age_filter.all()
    and salary_filter.all()
    and df["status"].isin(allowed_status).all()
    and date_filter.all()
)
```

---

# 12. Validation vs Data Cleaning

These concepts should not be confused.

### Validation

Determines whether data is valid.

```text
Is this data correct?
```

### Cleaning

Modifies invalid data.

```text
How can I fix this data?
```

Typical workflow:

```text
Raw Data
   ↓
Validation
   ↓
Identify Problems
   ↓
Data Cleaning
   ↓
Validation Again
   ↓
Valid Dataset
   ↓
ML / Storage / Analysis
```

---

# Key Functions

| Function | Purpose |
|---|---|
| `df.isna()` | Detect missing values |
| `df.notna()` | Detect non-missing values |
| `df.dtypes` | Inspect data types |
| `df.columns` | Inspect columns |
| `df.duplicated()` | Detect duplicates |
| `df.drop_duplicates()` | Remove duplicates |
| `df.isin()` | Check allowed values |
| `pd.to_datetime()` | Convert/check date values |
| `pd.to_numeric()` | Convert/check numeric values |
| Boolean filtering | Validate ranges and business rules |

---

# Data Validation Pipeline

```text
              Raw Data
                  ↓
          Schema Validation
                  ↓
        Missing-Value Check
                  ↓
         Duplicate Detection
                  ↓
        Data-Type Validation
                  ↓
          Range Validation
                  ↓
          Business Rules
                  ↓
        Unexpected Values
                  ↓
         Data Consistency
                  ↓
         Validation Report
                  ↓
        ┌─────────┴─────────┐
        ↓                   ↓
     Valid                Invalid
        ↓                   ↓
   Continue            Fix / Reject
        ↓
   ML / Storage
```

**Core idea:** Data validation ensures that data entering an ML or data pipeline is **structurally correct, complete, logically valid, and consistent**.