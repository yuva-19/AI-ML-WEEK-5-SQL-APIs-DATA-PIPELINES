# 02 — SQL Connections

SQL Connections allow Python programs to connect to databases, execute SQL queries, retrieve data, and use that data for analysis or Machine Learning.

The general workflow is:

```text
Database
   ↓
Python Connection
   ↓
Cursor
   ↓
SQL Query
   ↓
Fetch Results
   ↓
Pandas DataFrame
   ↓
Data Analysis / ML
```

---

# 1. SQLite

SQLite is a **lightweight, file-based relational database**.

Unlike PostgreSQL and MySQL, SQLite does not require a separate database server. The database is stored directly in a file.

Example:

```text
database.db
```

Python provides built-in SQLite support through the `sqlite3` module.

## Connecting to SQLite

```python
import sqlite3

connection = sqlite3.connect("database.db")
```

If `database.db` does not exist, SQLite will create it.

---

## Creating a Cursor

A cursor is used to execute SQL statements.

```python
cursor = connection.cursor()
```

---

## Creating a Table

```python
cursor.execute("""
CREATE TABLE IF NOT EXISTS employees (
    id INTEGER PRIMARY KEY,
    name TEXT,
    department TEXT,
    salary INTEGER
)
""")
```

### Important

`PRIMARY KEY` means that the value must uniquely identify each row.

For example:

```text
id
1
2
3
4
```

Two rows cannot have the same `id`.

---

# 2. Inserting Data

Multiple records can be inserted using `executemany()`.

```python
employees = [
    (1, "Yuva", "AI", 50000),
    (2, "Arun", "Data", 45000),
    (3, "Ravi", "AI", 60000),
    (4, "Karthik", "ML", 55000)
]

cursor.executemany(
    "INSERT INTO employees VALUES (?, ?, ?, ?)",
    employees
)
```

`?` acts as a placeholder for the values.

---

## Saving Changes

After inserting or modifying data:

```python
connection.commit()
```

`commit()` permanently saves the changes to the database.

---

# 3. Executing SQL Queries

A SQL query can be executed using:

```python
cursor.execute("""
SELECT *
FROM employees
WHERE salary > 50000
""")
```

The query result is available through the cursor.

---

# 4. Fetching Results

## `fetchone()`

Retrieves one row.

```python
row = cursor.fetchone()
```

Example:

```text
(3, 'Ravi', 'AI', 60000)
```

---

## `fetchmany()`

Retrieves a specified number of rows.

```python
rows = cursor.fetchmany(2)
```

---

## `fetchall()`

Retrieves all remaining rows from the current query result.

```python
rows = cursor.fetchall()
```

Example:

```python
[
    (3, "Ravi", "AI", 60000),
    (4, "Karthik", "ML", 55000)
]
```

### Important Concept

```text
execute()
   ↓
Run SQL query
   ↓
fetchall()
   ↓
Collect returned rows
```

If multiple queries are executed using the same cursor, fetch the results of a query before executing another query if you need to preserve them.

---

# 5. SQL Query with Conditions

Example:

```python
cursor.execute("""
SELECT *
FROM employees
WHERE salary > 50000
""")

high_salary = cursor.fetchall()
```

Another example:

```python
cursor.execute("""
SELECT *
FROM employees
WHERE department = 'AI'
""")

ai_department = cursor.fetchall()
```

Use `=` for SQL equality comparisons.

---

# 6. SQLite → Pandas DataFrame

Database results can be converted into a Pandas DataFrame.

```python
import pandas as pd

df = pd.DataFrame(
    high_salary,
    columns=["id", "name", "department", "salary"]
)

print(df)
```

The complete workflow becomes:

```text
SQLite
   ↓
SQL Query
   ↓
fetchall()
   ↓
Python List of Tuples
   ↓
Pandas DataFrame
```

---

# 7. Closing the Connection

After finishing database operations:

```python
connection.close()
```

This closes the **connection**, but does not delete the database or its data.

A new connection can later be created:

```python
connection = sqlite3.connect("database.db")
```

The existing data will still be available.

---

# 8. PostgreSQL

PostgreSQL is a **server-based relational database management system**.

Unlike SQLite:

```text
SQLite
→ Database stored in a file
```

PostgreSQL:

```text
PostgreSQL
→ Database runs on a server
```

Python can communicate with PostgreSQL using a PostgreSQL driver such as `psycopg`.

---

## Installing Psycopg

```powershell
python -m pip install "psycopg[binary]"
```

---

## Connecting to PostgreSQL

```python
import psycopg

connection = psycopg.connect(
    host="localhost",
    dbname="practice_sql",
    user="postgres",
    password="YOUR_PASSWORD",
    port=5432
)
```

### Connection Parameters

| Parameter | Meaning |
|---|---|
| `host` | Location of PostgreSQL server |
| `dbname` | Database name |
| `user` | PostgreSQL username |
| `password` | PostgreSQL password |
| `port` | PostgreSQL network port |

The default PostgreSQL port is:

```text
5432
```

For a PostgreSQL server running on the same computer:

```python
host="localhost"
```

---

# 9. PostgreSQL Cursor

Create a cursor:

```python
cursor = connection.cursor()
```

Execute SQL:

```python
cursor.execute("""
SELECT *
FROM customers
""")
```

Fetch the results:

```python
customers = cursor.fetchall()
```

Print:

```python
print(customers)
```

Close the connection:

```python
connection.close()
```

---

# 10. PostgreSQL → Pandas

PostgreSQL query results can also be converted into a DataFrame.

```python
import pandas as pd

df = pd.DataFrame(
    customers,
    columns=["id", "name", "email", "city"]
)

print(df)
```

The general workflow is:

```text
PostgreSQL
    ↓
psycopg
    ↓
Connection
    ↓
Cursor
    ↓
SQL Query
    ↓
fetchall()
    ↓
Pandas DataFrame
```

---

# 11. MySQL — Introduction

MySQL is another **server-based relational database management system**.

Conceptually:

```text
Python
   ↓
MySQL Driver
   ↓
MySQL Server
   ↓
Database
   ↓
Tables
```

Python can connect to MySQL using appropriate database drivers.

For this roadmap, MySQL only requires an introductory understanding.

---

# 12. SQLite vs PostgreSQL vs MySQL

| Feature | SQLite | PostgreSQL | MySQL |
|---|---|---|---|
| Database type | Relational | Relational | Relational |
| Architecture | File-based | Server-based | Server-based |
| Server required | No | Yes | Yes |
| Setup | Simple | More involved | More involved |
| Best suited for | Local/small applications | Production systems | Production systems |
| Python connection | `sqlite3` | `psycopg` | MySQL drivers |

### Simple way to remember

```text
SQLite
→ Database = File

PostgreSQL
→ Database = Server

MySQL
→ Database = Server
```

---

# 13. Complete SQLite Example

```python
import sqlite3
import pandas as pd

connection = sqlite3.connect("database.db")
cursor = connection.cursor()

cursor.execute("""
CREATE TABLE IF NOT EXISTS employees (
    id INTEGER PRIMARY KEY,
    name TEXT,
    department TEXT,
    salary INTEGER
)
""")

employees = [
    (1, "Yuva", "AI", 50000),
    (2, "Arun", "Data", 45000),
    (3, "Ravi", "AI", 60000),
    (4, "Karthik", "ML", 55000)
]

cursor.executemany(
    "INSERT INTO employees VALUES (?, ?, ?, ?)",
    employees
)

connection.commit()

cursor.execute("""
SELECT *
FROM employees
WHERE salary > 50000
""")

rows = cursor.fetchall()

df = pd.DataFrame(
    rows,
    columns=["id", "name", "department", "salary"]
)

print(df)

connection.close()
```

---

# 14. Important Concepts to Remember

### Database

Stores structured data.

### Connection

Creates communication between Python and the database.

### Cursor

Used to execute SQL statements and access query results.

### `execute()`

Executes a SQL statement.

```python
cursor.execute("SELECT * FROM employees")
```

### `fetchall()`

Retrieves all rows returned by the current query.

```python
rows = cursor.fetchall()
```

### `commit()`

Saves database modifications.

```python
connection.commit()
```

### `close()`

Closes the database connection.

```python
connection.close()
```

---

# Key Workflow

```text
Connect
   ↓
Create Cursor
   ↓
Execute SQL
   ↓
Fetch Results
   ↓
Convert to DataFrame
   ↓
Process Data
   ↓
Close Connection
```

This is the foundation for collecting data from **SQL databases into Python-based data and ML pipelines**.