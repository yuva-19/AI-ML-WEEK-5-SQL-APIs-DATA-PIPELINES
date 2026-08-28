# ETL vs ELT

ETL and ELT are data pipeline approaches used to extract data from sources, process it, and load it into a destination.

The main difference is **when and where transformation happens**.

---

## 1. ETL

**ETL = Extract → Transform → Load**

In ETL, data is transformed **before** it is loaded into the destination.

```text
Source
  ↓
Extract
  ↓
Transform
  ↓
Load
  ↓
Database / Data Warehouse
```

### Example

```python
df = extract_data()

df = clean_data(df)
df = validate_data(df)
df = transform_data(df)

load_to_database(df)
```

The destination receives processed data.

### ETL is useful when:

- Data needs significant preprocessing before storage
- Data must be validated before entering the destination
- The destination has limited processing capabilities
- Strict control over incoming data is required

---

# 2. ELT

**ELT = Extract → Load → Transform**

In ELT, raw data is loaded into the destination **before** transformation.

```text
Source
  ↓
Extract
  ↓
Load
  ↓
Database / Data Warehouse
  ↓
Transform
  ↓
Processed Data
```

### Example

```python
df = extract_data()

load_raw_data(df)

transform_data_inside_warehouse()
```

The raw data is stored first, and transformations are performed later.

### ELT is useful when:

- The destination has strong processing capabilities
- Large amounts of data are involved
- Raw data needs to be retained
- Different transformations may be required later

---

# 3. Main Difference

```text
ETL:
Extract → Transform → Load
                 ↑
       Transform BEFORE loading


ELT:
Extract → Load → Transform
                  ↑
        Transform AFTER loading
```

The fundamental difference is **the position of the transformation step**.

---

# 4. ETL vs ELT

| Feature | ETL | ELT |
|---|---|---|
| Order | Extract → Transform → Load | Extract → Load → Transform |
| Transformation | Before loading | After loading |
| Raw data | Less emphasis on retention | Usually retained |
| Processing | External processing system | Destination/warehouse |
| Flexibility | Lower | Higher |
| Common use | Traditional data pipelines | Modern cloud data platforms |

---

# 5. When to Use ETL

```text
Source
  ↓
Extract
  ↓
Heavy Processing / Validation
  ↓
Load
```

ETL is appropriate when data should be cleaned, validated, or transformed **before entering the destination**.

---

# 6. When to Use ELT

```text
Source
  ↓
Extract
  ↓
Load Raw Data
  ↓
Transform Later
```

ELT is appropriate when the destination has sufficient computing power and there is value in keeping the original raw data.

---

# 7. Relationship to Data Pipelines

A data ingestion workflow can follow either approach.

### ETL

```text
Extraction
    ↓
Transformation
    ↓
Validation
    ↓
Loading
    ↓
Monitoring
```

### ELT

```text
Extraction
    ↓
Loading
    ↓
Transformation
    ↓
Validation
    ↓
Monitoring
```

---

# Key Takeaway

```text
ETL = Extract → Transform → Load
      Transform BEFORE loading

ELT = Extract → Load → Transform
      Transform AFTER loading
```

The key difference is **when and where transformation occurs**.