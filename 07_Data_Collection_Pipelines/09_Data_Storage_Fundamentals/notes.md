# Data Storage Fundamentals

Data storage is the process of storing collected and processed data so that it can be accessed, analyzed, and used by applications or ML systems.

---

## 1. Local Storage

**Local storage** means storing data directly on a local computer or server.

Examples:

```text
data.csv
customers.parquet
images/
database.db
```

Example:

```python
import pandas as pd

df = pd.read_csv("data.csv")
```

### Suitable for

- Learning
- Small datasets
- Development
- Experiments
- Local ML projects

### Limitation

Local storage is limited by the computer's:

- Storage capacity
- Memory
- Computing resources

---

# 2. Relational Databases

A **relational database** stores structured data in tables consisting of rows and columns.

Example:

```text
customers

customer_id | name | age | salary
------------|------|-----|-------
101         | Yuva | 22  | 50000
102         | Arun | 25  | 45000
103         | Ravi | 24  | 60000
```

Data is commonly accessed using SQL.

```sql
SELECT *
FROM customers
WHERE salary > 50000;
```

### Examples

- SQLite
- PostgreSQL
- MySQL

### Suitable for

- Structured data
- Transactions
- Relationships between tables
- Applications
- Frequently queried data

---

# 3. Object Storage

**Object storage** stores data as objects rather than traditional database rows and tables.

Objects can include:

```text
dataset.csv
dataset.parquet
image.jpg
video.mp4
model.pkl
logs.json
```

Object storage is designed to store very large amounts of data at scale.

---

# 4. AWS S3

**Amazon S3 (Simple Storage Service)** is a cloud-based object-storage service.

Example structure:

```text
S3
│
├── datasets/
│   ├── customers.parquet
│   ├── orders.parquet
│   └── transactions.parquet
│
├── images/
│   ├── image001.jpg
│   └── image002.jpg
│
└── models/
    └── model.pkl
```

Different machines and services can access the stored data through the cloud.

---

# 5. Data Lake

A **data lake** is a storage architecture designed to store large amounts of data, often in raw or semi-processed form.

A data lake can contain:

- CSV
- JSON
- Parquet
- Images
- Audio
- Video
- Logs

Example:

```text
Data Lake
    │
    ├── Raw Data
    ├── Processed Data
    └── ML Data
```

### Important

**S3 is a storage service.**

**Data lake is an architectural concept.**

Object storage such as S3 can be used as the foundation of a data lake.

---

# 6. Data Warehouse

A **data warehouse** is designed mainly for storing structured, organized data for analytical queries.

Typical data:

- Sales
- Customers
- Products
- Orders
- Revenue

General workflow:

```text
Raw Sources
     ↓
ETL / ELT
     ↓
Data Warehouse
     ↓
Analytics / BI
```

### Common uses

- Business analytics
- Reporting
- Dashboards
- Aggregations
- SQL analysis

---

# 7. Data Lake vs Data Warehouse

| Feature | Data Lake | Data Warehouse |
|---|---|---|
| Data | Raw + processed | Mostly structured |
| Formats | CSV, JSON, Parquet, images, etc. | Structured tables |
| Main purpose | Large-scale data storage | Analytics |
| Flexibility | High | More structured |
| ML usage | Very common | Also useful |
| Typical foundation | Object storage | Specialized warehouse |

---

# 8. Why ML Systems Use Object Storage

ML systems often work with very large datasets containing different types of data:

```text
Images
Videos
Text
Audio
Parquet datasets
Training files
Model artifacts
```

Object storage is well suited for storing these large files at scale.

Example:

```text
Object Storage
      ↓
Large Dataset
      ↓
Data Preparation
      ↓
ML Training
      ↓
Trained Model
```

Instead of storing massive datasets directly inside a relational database, ML systems commonly keep datasets in object storage and process them when needed.

---

# 9. Typical ML Data Architecture

```text
             DATA SOURCES
                  ↓
        ┌──────────────────┐
        │ APIs / Databases │
        │ Files / Sensors  │
        └──────────────────┘
                  ↓
           Data Pipeline
                  ↓
          Object Storage
                  ↓
             Data Lake
                  ↓
        Data Preparation
                  ↓
           ML Training
                  ↓
        Trained Model
```

Example:

```text
API
 ↓
Python Pipeline
 ↓
Parquet
 ↓
Object Storage / S3
 ↓
ML Training
 ↓
Model
```

---

# 10. Storage Types — Mental Model

### Local Storage

> Data stored on your computer or server.

```text
Computer → Files / Database
```

### Relational Database

> Structured data stored in tables and queried using SQL.

```text
Database → Tables → Rows / Columns
```

### Object Storage

> Large files and datasets stored as objects in scalable storage.

```text
Object Storage → Objects → Large Datasets / Files
```

---

# Key Takeaways

- **Local storage** → Suitable for development, learning, and smaller datasets.
- **Relational databases** → Best suited for structured data, relationships, transactions, and SQL queries.
- **Object storage** → Designed for large-scale storage of files and datasets.
- **AWS S3** → A widely used cloud object-storage service.
- **Data lake** → Architecture for storing large amounts of raw and processed data.
- **Data warehouse** → Structured storage optimized for analytics.
- ML systems commonly use **object storage for large datasets** because it is scalable and can handle many different data formats.

> **Core idea:** Relational databases organize structured data into tables, while object storage provides scalable storage for large and diverse datasets commonly used in modern ML systems.