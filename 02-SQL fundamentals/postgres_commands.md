# PostgreSQL Practice Database — Setup Guide

This database is used for practicing SQL from **Fundamentals → Advanced SQL → Window Functions**.

Database name:

```text
practice_sql
```

---

## 1. Open PostgreSQL

From PowerShell:

```powershell
psql -U postgres
```

Enter the PostgreSQL password when prompted.

You should see:

```text
postgres=#
```

---

## 2. List Databases

Inside PostgreSQL:

```sql
\l
```

> `\l` works inside `psql`, not directly in PowerShell.

---

## 3. Create the Practice Database

```sql
CREATE DATABASE practice_sql;
```

---

## 4. Connect to the Practice Database

```sql
\c practice_sql
```

Expected:

```text
You are now connected to database "practice_sql".
```

The prompt should now be:

```text
practice_sql=#
```

---

## 5. Verify the Current Database

```sql
SELECT current_database();
```

Expected:

```text
practice_sql
```

You can also use:

```sql
\conninfo
```

---

# Database Structure

Our practice database will contain:

```text
practice_sql
│
├── customers
│
├── products
│
├── orders
│
├── order_items
│
└── payments
```

Relationships:

```text
customers
    │
    │ customer_id
    ↓
orders
    │
    ├──────────────→ payments
    │
    │ order_id
    ↓
order_items
    │
    │ product_id
    ↓
products
```

---

# 6. Create Tables

## Customers

```sql
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
);
```

## Products

```sql
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10,2),
    stock INT
);
```

## Orders

```sql
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    status VARCHAR(20)
);
```

## Order Items

```sql
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    unit_price NUMERIC(10,2)
);
```

## Payments

```sql
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    payment_date DATE,
    amount NUMERIC(10,2),
    payment_method VARCHAR(30),
    payment_status VARCHAR(20)
);
```

---

# 7. Check Tables

List tables:

```sql
\dt
```

View a table structure:

```sql
\d customers
```

Detailed structure:

```sql
\d+ customers
```

---

# 8. Insert Data

Example:

```sql
INSERT INTO customers
(first_name, last_name, email, city, signup_date)
VALUES
('Yuva', 'Kumar', 'yuva@gmail.com', 'Coimbatore', '2025-01-10'),
('Arun', 'Raj', 'arun@gmail.com', 'Chennai', '2025-01-15');
```

---

# 9. View Data

```sql
SELECT *
FROM customers;
```

---

# VS Code Usage

The database is stored in PostgreSQL.

The `.sql` files in VS Code contain the SQL code used to work with the database.

Recommended structure:

```text
SQL Practice
│
├── README.md
│
├── 01 - Setup
│   └── setup.sql
│
├── 02 - Joins
│   └── joins.sql
│
├── 03 - Aggregation
│   └── aggregation.sql
│
├── 04 - Subqueries
│   └── subqueries.sql
│
├── 05 - Conditional & NULL
│   └── conditional.sql
│
├── 06 - Date & Time
│   └── date_time.sql
│
├── 07 - String Functions
│   └── string_functions.sql
│
├── 08 - SQL Performance
│   └── performance.sql
│
└── 09 - Window Functions
    └── window_functions.sql
```

All files can work with the same:

```text
practice_sql
```

database.

---

# Important: `\c` vs `+ Connect`

### `\c practice_sql`

Switches the current `psql` session to the database:

```sql
\c practice_sql
```

### `+ Connect`

In a VS Code PostgreSQL extension, `+ Connect` is used to add/create a connection.

**You do not need to create a new connection every time you create a database.**

For this practice database:

```text
Create database
       ↓
\c practice_sql
       ↓
Use practice_sql
```

---

# Important PostgreSQL Commands

| Command | Purpose |
|---|---|
| `psql -U postgres` | Open PostgreSQL |
| `\l` | List databases |
| `CREATE DATABASE practice_sql;` | Create database |
| `\c practice_sql` | Connect/switch database |
| `SELECT current_database();` | Check current database |
| `\conninfo` | Show connection information |
| `\dt` | List tables |
| `\d table_name` | Show table structure |
| `\d+ table_name` | Detailed table structure |
| `SELECT * FROM table_name;` | View table data |
| `\q` | Exit PostgreSQL |

---

# Complete Setup — Quick Version

If PostgreSQL is already installed:

```powershell
psql -U postgres
```

Then:

```sql
CREATE DATABASE practice_sql;
```

```sql
\c practice_sql
```

```sql
SELECT current_database();
```

Expected:

```text
practice_sql
```

Then create the tables and start practicing.

---

# ⚠️ Important

`\l`, `\c`, `\dt`, `\d`, and `\q` are **psql commands**.

They are different from normal SQL.

Example:

```sql
\c practice_sql
```

is a PostgreSQL client command.

Whereas:

```sql
SELECT current_database();
```

is standard SQL.

---

# 🎯 Practice Goal

This database will be used to strengthen:

```text
SQL Fundamentals
      ↓
JOINs
      ↓
GROUP BY / HAVING
      ↓
Set Operations
      ↓
Subqueries
      ↓
CTEs
      ↓
CASE / NULL Handling
      ↓
Date & Time
      ↓
String Functions
      ↓
SQL Performance
      ↓
🔥 Window Functions
```

**Goal:** Become comfortable solving medium → hard SQL problems before moving to Window Functions.