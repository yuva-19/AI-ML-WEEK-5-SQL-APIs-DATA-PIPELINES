# NYC Taxi Data Pipeline

## Overview

This project builds an end-to-end data pipeline for NYC Taxi trip data.

The pipeline loads processed Parquet data using Pandas, validates the dataset, loads the data into PostgreSQL in chunks using SQLAlchemy, and verifies the final row count.

A FastAPI application is also provided to expose the taxi data and analytical results through REST API endpoints.

## Architecture

Parquet
   ↓
Pandas
   ↓
Data Validation
   ↓
SQLAlchemy
   ↓
PostgreSQL
   ↓
FastAPI
   ↓
REST API


## Technologies Used

- Python
- Pandas
- PostgreSQL
- SQLAlchemy
- FastAPI
- Pydantic
- Uvicorn
- Parquet

## Project Structure

```text
01_NYC_Taxi_Data_Pipeline/
│
├── data/
│   └── processed/
│       └── NYC Taxi Parquet data
│
├── sql/
│   └── SQL analysis queries
│
├── src/
│   ├── api.py
│   ├── database.py
│   └── load_data.py
│
├── .env
└── README.md


## Pipeline Workflow

The data pipeline follows these steps:

### 1. Load Data

The processed NYC Taxi Parquet dataset is loaded into a Pandas DataFrame.

### 2. Validate Data

The pipeline checks:

- Dataset is not empty
- Required columns are present
- Important columns contain numeric data
- Important numeric values are not negative

### 3. Create PostgreSQL Table

The `taxi_trips` table is created based on the DataFrame structure.

### 4. Load Data in Chunks

The dataset is inserted into PostgreSQL in batches of 50,000 rows.

This avoids attempting to insert the entire dataset in a single operation.

### 5. Verify Data

After loading, the pipeline counts the rows in PostgreSQL and compares the result with the original DataFrame.

Expected rows:

```text
3,199,038


## API Endpoints

The FastAPI application provides the following endpoints:

| Method | Endpoint | Description |
|---|---|---|
| GET | `/` | Check that the API is running |
| GET | `/health` | Health check |
| GET | `/trips` | Retrieve taxi trips with pagination |
| GET | `/trips/filter` | Filter trips by payment type |
| GET | `/trips/date` | Retrieve trips within a date range |
| GET | `/trips/summary` | Get overall trip statistics |
| GET | `/trips/payment-summary` | Get trip counts by payment type |
| GET | `/trips/{trip_id}` | Retrieve a specific trip |
| POST | `/trips` | Create a new trip |

### API Documentation

FastAPI automatically provides interactive API documentation through Swagger UI:

```text
http://127.0.0.1:8000/docs
```

## How to Run

### 1. Install Dependencies

Install the required Python packages:

```bash
pip install pandas pyarrow sqlalchemy psycopg2-binary python-dotenv fastapi uvicorn
````

### 2. Configure Environment Variables

Create a `.env` file inside the project directory:

```text
DB_HOST=localhost
DB_PORT=5432
DB_NAME=nyc_taxi
DB_USER=postgres
DB_PASSWORD=your_password
```

Do not commit the `.env` file to GitHub.

### 3. Load Data into PostgreSQL

From the Week 5 project root, run:

```bash
python projects/01_NYC_Taxi_Data_Pipeline/src/load_data.py
```

The pipeline validates the dataset, creates the `taxi_trips` table, loads the data in chunks, and verifies the final row count.

### 4. Start the FastAPI Application

Run:

```bash
uvicorn --app-dir projects/01_NYC_Taxi_Data_Pipeline/src api:app --reload
```

### 5. Open API Documentation

Open Swagger UI:

```text
http://127.0.0.1:8000/docs
```
## SQL Analysis

SQL was used to analyze the NYC Taxi dataset and extract operational and revenue-related insights.

The project contains 16 SQL analysis queries covering:

### 1. Total Number of Trips
Calculates the total number of taxi trips in the dataset.

### 2. Total Revenue & Average Trip Value
Calculates total revenue and the average value of a taxi trip.

### 3. Trips & Revenue by Payment Type
Analyzes trip count, total revenue, and average trip value for each payment type.

### 4. Trips & Revenue by Passenger Count
Analyzes trip volume, revenue, and average trip value based on passenger count.

### 5. Vendor Performance
Compares taxi vendors based on trip count, revenue, and average trip value.

### 6. Rate Code Distribution
Analyzes trip volume, revenue, and average trip value across different rate codes.

### 7. Average Trip Metrics by Payment Type
Compares payment types using:
- Average fare
- Average trip distance
- Average trip duration
- Average total amount

### 8. Tip Analysis by Payment Type
Analyzes total tips and average tips across payment types.

### 9. Most Expensive Trips
Identifies the top 10 trips with the highest total amount.

### 10. Trip Distance Categories
Groups trips into:
- Short (<2 miles)
- Medium (2–5 miles)
- Long (5–10 miles)
- Very Long (10+ miles)

The analysis calculates trip count, average trip value, and total revenue for each category.

### 11. Trip Duration Categories
Groups trips into:
- Short (<10 minutes)
- Medium (10–20 minutes)
- Long (20–40 minutes)
- Very Long (40+ minutes)

The analysis calculates trip count, average trip value, and total revenue for each category.

### 12. Revenue & Trip Metrics by Vendor
Compares vendors using:
- Total trips
- Total revenue
- Average trip value
- Average distance
- Average duration

### 13. Revenue & Trip Metrics by Rate Code
Compares rate codes using:
- Total trips
- Total revenue
- Average trip value
- Average distance
- Average duration

### 14. Store-and-Forward Flag Analysis
Analyzes trips based on the store-and-forward flag and compares:
- Trip count
- Average trip value
- Average distance
- Average duration

### 15. Revenue per Mile
Calculates revenue generated per mile across different trip-distance categories.

### 16. Revenue per Minute
Calculates revenue generated per minute across different trip-duration categories.

The SQL queries are stored in the `sql/` directory.

## Project Outcome

This project demonstrates an end-to-end data workflow:

- Loading Parquet data using Pandas
- Validating data before ingestion
- Loading 3.2M+ records into PostgreSQL
- Performing SQL-based data analysis
- Building REST APIs with FastAPI
- Connecting FastAPI to PostgreSQL using SQLAlchemy
- Implementing filtering, pagination, date-range queries, and analytical endpoints
- Validating API inputs and handling HTTP responses
- Verifying the data pipeline after ingestion

The project combines data engineering, SQL, API development, and Python into a single end-to-end workflow.
