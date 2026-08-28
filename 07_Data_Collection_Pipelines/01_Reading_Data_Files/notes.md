# Data Collection Pipelines

Data Collection Pipelines involve collecting data from different sources and preparing it for analysis and Machine Learning.

## Main Topics

- Reading Data Files
- API Data Collection
- Data Validation
- Data Cleaning & Transformation
- Data Storage
- Data Pipelines
- Automation & Reliability

## Common Data Sources

- CSV
- Excel
- JSON
- Parquet
- APIs
- Databases

## General Data Pipeline

```text
Data Source
     ↓
Data Collection
     ↓
Data Validation
     ↓
Data Cleaning
     ↓
Data Transformation
     ↓
Data Storage
     ↓
ML / Analysis
```

## Important

**Parquet** is particularly important for modern data and ML workflows because it is a **column-oriented, compressed data format** designed for efficient analytical processing.

---

# 01 — Reading Data Files

Reading data files means loading data stored in different file formats into Python for processing, analysis, and Machine Learning.

## Common File Formats

| Format | Pandas Function | Main Use |
|---|---|---|
| CSV | `pd.read_csv()` | Simple tabular data |
| Excel | `pd.read_excel()` | Spreadsheet data |
| JSON | `pd.read_json()` | Structured data |
| Parquet | `pd.read_parquet()` | Large analytical/ML datasets |
| Feather | `pd.read_feather()` | Fast DataFrame storage |

---

## CSV

CSV (Comma-Separated Values) stores tabular data in plain text.

```python
import pandas as pd

df = pd.read_csv("data.csv")
```

**CSV → DataFrame**

Advantages:

- Simple
- Human-readable
- Easy to share
- Common for small/simple datasets

---

## Excel

Excel files commonly use `.xlsx`.

```python
df = pd.read_excel("data.xlsx")
```

Read a specific sheet:

```python
df = pd.read_excel(
    "data.xlsx",
    sheet_name="Sheet1"
)
```

**Excel → DataFrame**

---

## JSON

JSON stores structured data and is commonly used by APIs.

```python
df = pd.read_json("data.json")
```

For nested JSON:

```python
df = pd.json_normalize(data)
```

Example:

```text
address
   └── city
```

can become:

```text
address.city
```

---

## Parquet ⭐

Parquet is a **binary, column-oriented data format** designed for efficient analytical workloads.

```python
df = pd.read_parquet("data.parquet")
```

### Why Parquet?

- Column-oriented
- Compressed
- Efficient storage
- Preserves data types
- Efficient for large datasets
- Useful for ML and data pipelines

### CSV vs Parquet

CSV is conceptually row-oriented:

```text
Row → id, name, age, city
Row → id, name, age, city
Row → id, name, age, city
```

Parquet is column-oriented:

```text
id   → 1, 2, 3
name → Yuva, Ravi, Arun
age  → 21, 22, 20
city → Chennai, Trichy, Madurai
```

If a large dataset has many columns but only a few are required, Parquet can efficiently work with the required columns.

---

## Feather

Feather is a fast binary format mainly used for storing and loading DataFrames.

```python
df = pd.read_feather("data.feather")
```

For this roadmap, only the basic concept is required.

---

## Key Pattern

```text
File
 ↓
Pandas Reader
 ↓
DataFrame
 ↓
Cleaning / Transformation
 ↓
ML / Analysis
```

### Functions to Remember

```python
pd.read_csv()
pd.read_excel()
pd.read_json()
pd.read_parquet()
pd.read_feather()
```

**Most important:** `Parquet` → efficient columnar storage for modern data/ML workflows.