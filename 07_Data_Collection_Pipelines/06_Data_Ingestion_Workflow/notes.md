# Data Ingestion Workflow

A **data ingestion workflow** is the process of collecting data from different sources, transforming it into a usable form, storing it, and monitoring the entire process.

It is a fundamental part of data engineering and ML pipelines.

```text
Data Sources
     ↓
Extraction
     ↓
Transformation
     ↓
Loading
     ↓
Monitoring
```

---

# 1. Extraction

**Extraction** is the process of collecting raw data from different sources.

Common sources include:

- APIs
- Databases
- Files

### APIs

Data can be collected from REST APIs or other API services.

```python
response = requests.get(url)
data = response.json()
```

### Databases

Data can be extracted using SQL queries.

```sql
SELECT *
FROM customers;
```

Python can then retrieve the query results using libraries such as `sqlite3`, `psycopg`, or SQLAlchemy.

### Files

Data can be collected from files such as:

```text
CSV
Excel
JSON
Parquet
```

Example:

```python
df = pd.read_parquet("data.parquet")
```

The extracted data is generally considered **raw data** at this stage.

---

# 2. Transformation

**Transformation** converts raw data into a clean, consistent, and usable format.

Common transformation operations include:

- Cleaning
- Formatting
- Joining
- Validation
- Feature preparation

### Cleaning

Handle problems such as:

- Missing values
- Duplicates
- Invalid values
- Incorrect formats

### Formatting

Convert data into the required format.

Example:

```python
df["date"] = pd.to_datetime(df["date"])
```

### Joining

Combine data from multiple sources.

```python
result = pd.merge(
    customers,
    orders,
    on="customer_id"
)
```

### Validation

Check whether the data satisfies required rules.

Examples:

```text
age >= 18
salary >= 0
status ∈ allowed values
```

### Feature Preparation

Transform data into features that can be used by ML models.

Examples:

```text
Raw Data
   ↓
Date of Birth
   ↓
Age
```

or:

```text
Raw Category
   ↓
Encoding
   ↓
Numerical Feature
```

---

# 3. Loading

**Loading** means storing the transformed data in a destination where it can be used later.

Common destinations include:

- Database
- Data warehouse
- Object storage
- Data lake

### Database

Structured data can be stored in databases such as PostgreSQL.

```text
Application
     ↓
PostgreSQL
```

### Data Warehouse

A **data warehouse** is designed primarily for storing and analyzing large amounts of structured data.

It is commonly used for:

- Analytics
- Reporting
- Business intelligence

### Object Storage

Object storage stores files/objects rather than traditional database rows.

Examples include:

```text
CSV
JSON
Parquet
Images
Model files
```

### Data Lake

A **data lake** stores large amounts of raw and processed data in different formats.

A simplified structure:

```text
Data Lake
├── Raw Data
├── Cleaned Data
└── Processed Data
```

---

# 4. Monitoring

A production pipeline should be monitored continuously.

Monitoring helps detect failures and data-quality problems.

Important monitoring areas include:

- Logs
- Errors
- Pipeline status
- Data quality

### Logs

Logs record what happened during pipeline execution.

Example:

```text
Pipeline started
API data extracted
5000 records received
Transformation completed
Data loaded successfully
Pipeline completed
```

### Errors

Errors should be recorded so that failures can be investigated.

Example:

```text
API request failed
Database connection failed
Invalid schema
Data validation failed
```

### Pipeline Status

Track whether the pipeline:

```text
SUCCESS
RUNNING
FAILED
```

### Data Quality

Monitor whether the incoming data continues to meet quality requirements.

Examples:

```text
Missing values
Duplicate records
Unexpected values
Invalid data types
Unexpected row counts
```

---

# 5. Complete Data Ingestion Workflow

```text
                    DATA SOURCES
                         │
          ┌──────────────┼──────────────┐
          ↓              ↓              ↓
        APIs          Databases        Files
          └──────────────┼──────────────┘
                         ↓
                    EXTRACTION
                         ↓
                  RAW DATA
                         ↓
                 TRANSFORMATION
                         ↓
        ┌────────────────┼────────────────┐
        ↓                ↓                ↓
     Cleaning         Joining         Validation
        ↓                ↓                ↓
        └────────────────┼────────────────┘
                         ↓
                Feature Preparation
                         ↓
                      LOADING
                         ↓
       ┌─────────────────┼─────────────────┐
       ↓                 ↓                 ↓
   Database       Data Warehouse     Object Storage
                         │
                         ↓
                    Data Lake
                         ↓
                    MONITORING
                         ↓
          Logs / Errors / Status /
              Data Quality
```

---

# 6. ETL Concept

The workflow can also be understood as **ETL**:

```text
E → Extract
T → Transform
L → Load
```

### Extract

Collect raw data.

```text
API / Database / Files
        ↓
      Extract
```

### Transform

Clean and prepare the data.

```text
Raw Data
   ↓
Cleaning
   ↓
Formatting
   ↓
Joining
   ↓
Validation
   ↓
Feature Preparation
```

### Load

Store the transformed data.

```text
Transformed Data
       ↓
Database / Warehouse / Storage / Lake
```

So:

```text
Extract → Transform → Load
```

is the core idea behind an **ETL pipeline**.

---

# 7. Where Data Validation Fits

The previous block is directly connected to this workflow.

```text
Extraction
    ↓
Transformation
    ↓
Data Validation
    ↓
    ├── Valid → Continue
    │
    └── Invalid → Reject / Fix
                     ↓
                Validate Again
```

This prevents bad data from reaching the final storage or ML model.

---

# 8. Data Ingestion vs Data Collection

These terms are related but not identical.

### Data Collection

Focuses primarily on **obtaining data**.

```text
API
 ↓
Data
```

### Data Ingestion

Covers the broader process of bringing data into a system and making it usable.

```text
Extract
   ↓
Transform
   ↓
Validate
   ↓
Load
   ↓
Monitor
```

Therefore, **data collection is one part of a complete data ingestion workflow**.

---

# Key Mental Model

```text
EXTRACT
"Where do I get the data?"
        ↓
TRANSFORM
"How do I make the data usable?"
        ↓
LOAD
"Where do I store it?"
        ↓
MONITOR
"Is the pipeline and data still working correctly?"
```

For AI/ML engineering, this workflow is important because **ML models are only as reliable as the data pipeline feeding them**.