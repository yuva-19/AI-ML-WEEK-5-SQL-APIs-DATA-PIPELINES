````markdown
# Week 5 — SQL, APIs & Data Pipelines

## Overview

Week 5 focuses on SQL, relational databases, APIs, and data engineering fundamentals.

The week covers database concepts, SQL fundamentals, advanced SQL, window functions, Common Table Expressions (CTEs), REST APIs, API authentication and pagination, Python API consumption, data collection pipelines, and an end-to-end NYC Taxi Data Pipeline project.

---

# 01 — Relational Databases

## Topics Covered

- Relational Database Concepts
- Database Management Systems (DBMS)
- Database Design
- Database Objects
- Tables
- Rows and Columns
- Primary Keys
- Foreign Keys
- Relationships
- Database Schemas
- SQL Basics
- PostgreSQL

## Folder Structure

```text
01-relational-databases/
├── database/
├── diagrams/
├── notes/
└── sql/
````

---

# 02 — SQL Fundamentals

## Topics Covered

### DBMS

* Database Management Systems
* Relational Databases
* Database Concepts

### NoSQL Databases

* Introduction to NoSQL
* NoSQL Database Concepts
* Relational vs NoSQL Databases

### Database Objects

* Databases
* Schemas
* Tables
* Views
* Other Database Objects

### Keys

* Primary Keys
* Foreign Keys
* Candidate Keys
* Composite Keys

### Constraints

* NOT NULL
* UNIQUE
* PRIMARY KEY
* FOREIGN KEY
* CHECK
* DEFAULT

### Data Types

* Numeric Data Types
* Character Data Types
* Boolean
* Date and Time
* Other PostgreSQL Data Types

### CRUD Operations

* CREATE
* INSERT
* SELECT
* UPDATE
* DELETE

### SQL Clauses

* SELECT
* FROM
* WHERE
* GROUP BY
* HAVING
* ORDER BY
* LIMIT
* OFFSET
* DISTINCT

### Additional PostgreSQL Practice

* PostgreSQL Commands
* Database interaction through PostgreSQL

## Folder Structure

```text
02-SQL fundamentals/
├── 01-DBMS/
├── 02-NoSQL Databases/
├── 03-Database Objects/
├── 04-Keys/
├── 05-Constraints/
├── 06-Data Types/
├── 07-CRUD Operations/
├── 08-SQL Clauses/
└── postgres_commands.md
```

---

# 03 — Advanced SQL

## Topics Covered

### Aggregate Functions

* COUNT()
* SUM()
* AVG()
* MIN()
* MAX()
* GROUP BY
* HAVING

### Joins

* INNER JOIN
* LEFT JOIN
* RIGHT JOIN
* FULL OUTER JOIN
* CROSS JOIN
* Self Joins

### Set Operations and Subqueries

* UNION
* UNION ALL
* INTERSECT
* EXCEPT
* Subqueries
* Nested Queries
* Correlated Subqueries

### Conditional and NULL Handling

* CASE
* COALESCE
* NULLIF
* NULL Handling

### Data Type Conversion

* Type Casting
* Data Type Conversion

### Date and Time Functions

* Date Operations
* Time Operations
* Date Extraction
* Date Calculations

### String Functions

* String Manipulation
* String Searching
* String Formatting

### SQL Performance

* Query Performance
* Query Optimization Concepts
* Efficient SQL Queries

## Folder Structure

```text
03 - Advanced SQL/
├── 01 - Aggregate Functions/
├── 02 - Joins/
├── 03 - ...
├── 04 - Set Operations & Subqueries/
├── 05 - Conditional & NULL Handling/
├── 06 - Data Type Conversion/
├── 07 - Date & Time Functions/
├── 08 - String Functions/
└── 09 - SQL Performance/
```

---

# 04 — Window Functions

## Topics Covered

### OVER Clause

* Window Function Syntax
* OVER()
* PARTITION BY

### ORDER BY in Windows

* Ordering Rows
* Window Ordering

### Ranking Functions

* ROW_NUMBER()
* RANK()
* DENSE_RANK()

### Offset Functions

* LAG()
* LEAD()

### Value Functions

* FIRST_VALUE()
* LAST_VALUE()
* Related Value Functions

### Analytical Windows

* Running Calculations
* Partitioned Analysis
* Row-by-Row Analysis

### Window Frames

* Window Frame Concepts
* ROWS
* RANGE
* Frame Boundaries

### Statistical Window Functions

* Statistical Calculations
* Window-based Aggregations

## Folder Structure

```text
04 - Window Functions/
├── 01 - OVER Clause/
├── 02 - ORDER BY in Windows/
├── 03 - Ranking Functions/
├── 04 - Offset Functions/
├── 05 - Value Functions/
├── 06 - Analytical Windows/
├── 07 - Window Frames/
├── 08 - Statistical Window Functions/
└── practice.sql
```

---

# 05 — Common Table Expressions

## Topics Covered

### Basic CTE

* WITH Clause
* Basic CTE Syntax
* Query Simplification

### Multiple CTEs

* Multiple CTEs
* Combining Query Results
* Breaking Complex Queries into Steps

### Recursive CTE

* Recursive Queries
* Recursive CTE Structure
* Hierarchical Data

### CTE vs Subquery

* CTEs
* Subqueries
* Readability
* Query Organization

### Performance and Final Challenge

* CTE Performance
* Complex Query Construction
* Practical SQL Challenges

## Folder Structure

```text
05 - Common Table Expressions/
├── 01 - Basic CTE/
├── 02 - Multiple CTEs/
├── 03 - Recursive CTE/
├── 04 - CTE vs Subquery/
└── 05 - Performance and Final Challenge/
```

---

# 06 — APIs

## API Fundamentals

* What is an API?
* Client and Server
* API Architecture
* REST APIs
* API Requests
* API Responses

## REST APIs

* REST Principles
* Resources
* Endpoints
* REST API Structure

## HTTP Methods and Status Codes

* GET
* POST
* PUT
* PATCH
* DELETE
* 2xx Status Codes
* 3xx Status Codes
* 4xx Status Codes
* 5xx Status Codes

## Request Components

* URL
* Endpoint
* Path Parameters
* Query Parameters
* Headers
* Request Body

## JSON

* JSON Structure
* JSON Objects
* JSON Arrays
* Nested JSON
* JSON Parsing

## API Authentication

* Authentication Concepts
* API Keys
* Bearer Tokens
* Authorization Headers

## API Pagination

* Pagination Concepts
* Page-based Pagination
* Limit and Offset
* Handling Multiple API Pages

## API Error Handling

* API Errors
* HTTP Error Responses
* Handling Failed Requests

## Python Requests

* Python `requests`
* GET Requests
* POST Requests
* Query Parameters
* Headers
* JSON Responses
* API Authentication
* Pagination
* JSON to Pandas
* `pd.json_normalize()`

## API Documentation

* API Documentation
* Understanding API Documentation
* Working with API Specifications

## Modern API Technologies

* Modern API Concepts
* Current API Development Practices

## Practical API Work

The API practice focused on consuming REST APIs using Python.

Practical exercises included:

* GET requests
* Query parameters
* POST requests
* Request headers
* JSON responses
* Nested JSON
* JSON to Pandas conversion
* Bearer token authentication
* API key authentication
* Pagination
* Production-style API consumption

## Folder Structure

```text
06_APIs/
├── 01_API_Fundamentals/
├── 02_REST_APIs/
├── 03_HTTP_Methods_Status_Codes/
├── 04_Request_Components/
├── 05_JSON/
├── 06_API_Authentication/
├── 07_API_Pagination/
├── 08_API_Error_Handling/
├── 09_Python_Requests/
├── 10_API_Documentation/
├── 11_Modern_API_Technologies/
└── final_practice.py
```

---

# 07 — Data Collection Pipelines

## Topics Covered

### Reading Data Files

* CSV
* JSON
* Parquet
* Other Data Sources

### SQL Connections

* Connecting Python to SQL Databases
* Database Connections
* Executing SQL from Python

### Python Database Libraries

* Python Database Libraries
* Database Interaction
* SQLAlchemy

### Combining Multiple Sources

* Multiple Data Sources
* Data Integration
* Combining Data

### Data Validation

* Dataset Validation
* Schema Validation
* Data Type Validation
* Missing Values
* Invalid Values
* Data Quality Checks

### Data Ingestion Workflow

* Data Extraction
* Data Transformation
* Data Loading
* ETL Workflow

### Incremental Data Loading

* Incremental Processing
* Loading New Data
* Batch Processing

### Idempotent Pipelines

* Idempotency
* Batch Pipelines
* Streaming Concepts

### Data Storage Fundamentals

* Data Storage
* Database Storage
* File-based Storage

### Data Pipeline Reliability

* Error Handling
* Validation
* Pipeline Reliability
* Failure Handling

### Configuration Management

* Configuration
* Environment Variables
* `.env`
* Secure Configuration

### Metadata and Data Lineage

* Metadata
* Data Lineage
* Tracking Data Movement

### Automation

* Pipeline Automation
* Automated Data Workflows

## Folder Structure

```text
07_Data_Collection_Pipelines/
├── 01_Reading_Data_Files/
├── 02_SQL_Connections/
├── 03_Python_Database_Libraries/
├── 04_Combining_Multiple_Sources/
├── 05_Data_Validation/
├── 06_Data_Ingestion_Workflow/
├── 07_Incremental_Data_Loading/
├── 08_Idempotent_Pipelines_Batch_Streaming/
├── 09_Data_Storage_Fundamentals/
├── 10_Data_Pipeline_Reliability/
├── 11_Configuration_Management/
├── 12_Metadata_&_Data_Lineage/
└── 13_Automation/
```

---

# Major Project — NYC Taxi Data Pipeline

## Project Overview

The NYC Taxi Data Pipeline is an end-to-end data engineering project using NYC Taxi trip data.

The project combines:

* Python
* Pandas
* Parquet
* PostgreSQL
* SQLAlchemy
* SQL
* FastAPI
* Pydantic

The pipeline loads, validates, cleans, stores, analyzes, and exposes NYC Taxi data through REST API endpoints.

---

# Project Architecture

```text
NYC Taxi Parquet Data
        ↓
     Pandas
        ↓
Data Exploration
        ↓
 Data Cleaning
        ↓
 Data Validation
        ↓
   SQLAlchemy
        ↓
   PostgreSQL
        ↓
  SQL Analysis
        ↓
    FastAPI
        ↓
    REST API
```

---

# Project Structure

```text
01_NYC_Taxi_Data_Pipeline/
│
├── data/
│   ├── raw/
│   │   └── yellow_tripdata_2026-01.parquet
│   │
│   └── processed/
│       └── nyc_taxi_cleaned.parquet
│
├── notebooks/
│   └── 01_data_exploration.ipynb
│
├── sql/
│   └── analysis.sql
│
├── src/
│   ├── api.py
│   ├── database.py
│   └── load_data.py
│
├── .env
├── .gitignore
└── README.md
```

---

# Data Exploration and Cleaning

The NYC Taxi dataset was explored using Pandas and Jupyter Notebook.

The analysis included:

* Dataset shape
* Column names
* Data types
* Missing values
* Duplicate records
* Numerical distributions
* Passenger counts
* Trip distance
* Trip duration
* Fare amounts
* Total amounts
* Payment types
* Vendor information
* Rate codes
* Tips
* Derived metrics

The cleaning process identified invalid and suspicious records and produced a cleaned dataset.

Approximately:

```text
14.12%
```

of the original records were removed during cleaning.

Final cleaned dataset:

```text
3,199,038 rows
24 columns
```

---

# PostgreSQL Data Pipeline

The cleaned Parquet dataset was loaded into PostgreSQL.

## Pipeline Steps

1. Load Parquet data using Pandas
2. Validate that the dataset is not empty
3. Validate required columns
4. Validate important data types
5. Validate numeric values
6. Create the `taxi_trips` table
7. Load data in chunks
8. Verify the final row count

Data was loaded in batches of:

```text
50,000 rows
```

Final PostgreSQL row count:

```text
3,199,038
```

Pipeline verification confirms that the source DataFrame row count matches the PostgreSQL row count.

---

# SQL Analysis

The project contains 16 SQL analysis queries.

## Analysis Performed

1. Total Number of Trips
2. Total Revenue and Average Trip Value
3. Trips and Revenue by Payment Type
4. Trips and Revenue by Passenger Count
5. Vendor Performance
6. Rate Code Distribution
7. Average Trip Metrics by Payment Type
8. Tip Analysis by Payment Type
9. Most Expensive Trips
10. Trip Distance Categories
11. Trip Duration Categories
12. Revenue and Trip Metrics by Vendor
13. Revenue and Trip Metrics by Rate Code
14. Store-and-Forward Flag Analysis
15. Revenue per Mile
16. Revenue per Minute

SQL queries are stored in:

```text
sql/analysis.sql
```

---

# FastAPI — Project Implementation

FastAPI was introduced and implemented as part of the NYC Taxi project.

The API connects FastAPI to PostgreSQL through SQLAlchemy.

## Concepts Implemented

* FastAPI application
* Routes
* GET endpoints
* POST endpoints
* Path parameters
* Query parameters
* Request bodies
* Pydantic models
* Input validation
* HTTP status codes
* HTTPException
* SQL execution
* SQLAlchemy database connection
* PostgreSQL integration
* Pagination
* Filtering
* Date-range queries
* Analytical endpoints
* Swagger UI

## API Endpoints

| Method | Endpoint                 | Description                    |
| ------ | ------------------------ | ------------------------------ |
| GET    | `/`                      | API status                     |
| GET    | `/health`                | Health check                   |
| GET    | `/trips`                 | Retrieve trips with pagination |
| GET    | `/trips/filter`          | Filter trips by payment type   |
| GET    | `/trips/date`            | Retrieve trips by date range   |
| GET    | `/trips/summary`         | Overall trip statistics        |
| GET    | `/trips/payment-summary` | Trip counts by payment type    |
| GET    | `/trips/data`            | Retrieve sample taxi records   |
| POST   | `/trips`                 | Create a trip record           |

---

# Swagger API Documentation

The FastAPI application provides interactive API documentation through Swagger UI.

Run the application from the Week 5 root directory:

```powershell
uvicorn --app-dir projects/01_NYC_Taxi_Data_Pipeline/src api:app --reload
```

Swagger UI:

```text
http://127.0.0.1:8000/docs
```

---

# Technologies Used

* Python
* Pandas
* PostgreSQL
* SQLAlchemy
* FastAPI
* Pydantic
* Uvicorn
* Requests
* Jupyter Notebook
* SQL
* Parquet

---

# Skills Developed

## Database Skills

* Relational databases
* PostgreSQL
* Database design
* Database objects
* Keys
* Constraints
* Data types
* Database connections

## SQL Skills

* SQL fundamentals
* CRUD operations
* SQL clauses
* Aggregate functions
* Joins
* Subqueries
* Set operations
* Conditional expressions
* NULL handling
* Type conversion
* Date and time functions
* String functions
* Window functions
* CTEs
* SQL performance concepts

## API Skills

* REST APIs
* HTTP
* JSON
* API requests and responses
* Authentication
* API keys
* Bearer tokens
* Pagination
* Python Requests
* API error handling
* API documentation
* FastAPI implementation

## Data Engineering Skills

* Data ingestion
* Data validation
* Data cleaning
* Data transformation
* Batch processing
* Incremental loading concepts
* Database loading
* Pipeline reliability
* Configuration management
* Metadata and data lineage
* Data pipeline verification

---

# Week 5 Outcome

Week 5 provides a complete foundation for working with data from storage to application-level access.

The final NYC Taxi project demonstrates the complete workflow:

```text
Data Source
    ↓
Python
    ↓
Pandas
    ↓
Data Validation
    ↓
Data Cleaning
    ↓
PostgreSQL
    ↓
SQL Analysis
    ↓
SQLAlchemy
    ↓
FastAPI
    ↓
REST API
```

The week combines database engineering, SQL, API development, Python programming, and data pipeline concepts into a single practical workflow.

```
```
