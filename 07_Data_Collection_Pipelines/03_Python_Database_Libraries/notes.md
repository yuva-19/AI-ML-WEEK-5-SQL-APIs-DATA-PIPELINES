# Python Database Libraries

Python database libraries allow Python programs to connect to databases, execute SQL queries, retrieve data, and transfer data between databases and Pandas DataFrames.

---

## 1. `sqlite3`

`sqlite3` is Python's built-in library for working with SQLite databases.

```python
import sqlite3
```

### Create a connection

```python
connection = sqlite3.connect("database.db")
```

### Create a cursor

```python
cursor = connection.cursor()
```

### Execute a query

```python
cursor.execute("SELECT * FROM employees")
```

### Fetch results

```python
rows = cursor.fetchall()
```

### Save changes

```python
connection.commit()
```

### Close connection

```python
connection.close()
```

---

# 2. SQLAlchemy

SQLAlchemy is a Python library for interacting with relational databases.

It provides a common interface for working with different database systems.

For this roadmap, the important SQLAlchemy concepts are:

- Engine
- Database connections
- SQL execution
- Parameterized queries
- Integration with Pandas

---

## 3. Creating a SQLAlchemy Engine

```python
from sqlalchemy import create_engine

engine = create_engine(
    "sqlite:///database.db"
)
```

The engine represents the main interface between Python and the database.

For SQLite:

```text
sqlite:///database.db
```

means that `database.db` is the SQLite database file.

---

# 4. Connecting Using the Engine

```python
with engine.connect() as connection:
    ...
```

Example:

```python
from sqlalchemy import create_engine, text

engine = create_engine("sqlite:///database.db")

with engine.connect() as connection:
    result = connection.execute(
        text("SELECT * FROM employees")
    )

    rows = result.fetchall()
```

Using `with` automatically handles the connection lifecycle.

---

# 5. Executing SQL Queries

SQLAlchemy can execute normal SQL statements using `execute()`.

```python
from sqlalchemy import text

with engine.connect() as connection:
    result = connection.execute(
        text("SELECT * FROM employees")
    )
```

`text()` represents a raw SQL statement.

---

# 6. Fetching SQL Results

After executing a query:

```python
result = connection.execute(
    text("SELECT * FROM employees")
)
```

Results can be retrieved using:

### `fetchone()`

Returns one row.

```python
row = result.fetchone()
```

### `fetchall()`

Returns all remaining rows.

```python
rows = result.fetchall()
```

Workflow:

```text
execute()
    ↓
Result
    ↓
fetchone() / fetchall()
    ↓
Python data
```

---

# 7. Parameterized Queries 🔥

Parameterized queries allow values to be passed separately from the SQL statement.

Example:

```python
salary_limit = 50000

with engine.connect() as connection:
    result = connection.execute(
        text("""
            SELECT *
            FROM employees
            WHERE salary > :salary
        """),
        {"salary": salary_limit}
    )

    rows = result.fetchall()
```

Here:

```sql
:salary
```

is a named parameter.

The value is supplied separately:

```python
{"salary": salary_limit}
```

Parameterized queries are safer than constructing SQL using string formatting.

Avoid:

```python
query = f"SELECT * FROM employees WHERE salary > {salary_limit}"
```

Prefer:

```python
text("""
SELECT *
FROM employees
WHERE salary > :salary
""")
```

with:

```python
{"salary": salary_limit}
```

---

# 8. Reading SQL Results into Pandas

Pandas can directly execute SQL queries and create a DataFrame.

```python
import pandas as pd

df = pd.read_sql(
    "SELECT * FROM employees",
    engine
)
```

This avoids manually doing:

```python
fetchall()
```

and then:

```python
pd.DataFrame()
```

### Parameterized `read_sql()`

```python
df = pd.read_sql(
    """
    SELECT *
    FROM employees
    WHERE department = :department
    """,
    engine,
    params={"department": "AI"}
)
```

The database performs the filtering before the data reaches Pandas.

---

# 9. Writing DataFrames to Databases

Pandas provides:

```python
df.to_sql()
```

to write a DataFrame into a database table.

Example:

```python
df.to_sql(
    "employees",
    engine,
    if_exists="replace",
    index=False
)
```

### Important arguments

#### Table name

```python
"employees"
```

Specifies the database table.

#### Engine

```python
engine
```

Specifies the database connection interface.

#### `if_exists`

Controls what happens if the table already exists.

```python
if_exists="replace"
```

Replaces the existing table.

```python
if_exists="append"
```

Adds the DataFrame rows to the existing table.

```python
if_exists="fail"
```

Raises an error if the table already exists.

#### `index=False`

Prevents the Pandas DataFrame index from being written as a database column.

---

# 10. Database → Pandas

```python
df = pd.read_sql(
    "SELECT * FROM employees",
    engine
)
```

Workflow:

```text
Database
    ↓
SQL Query
    ↓
SQLAlchemy
    ↓
pd.read_sql()
    ↓
Pandas DataFrame
```

---

# 11. Pandas → Database

```python
df.to_sql(
    "employees",
    engine,
    if_exists="replace",
    index=False
)
```

Workflow:

```text
Pandas DataFrame
    ↓
to_sql()
    ↓
SQLAlchemy
    ↓
Database Table
```

---

# 12. Complete Data Transfer Workflow

SQLAlchemy and Pandas can be used together to create a simple data pipeline.

```text
              Database
                  ↓
             SQLAlchemy
                  ↓
             SQL Query
                  ↓
             pd.read_sql()
                  ↓
             DataFrame
                  ↓
       Data Cleaning / Processing
                  ↓
             df.to_sql()
                  ↓
              Database
```

This pattern is commonly used when collecting and processing structured data for analytics and Machine Learning.

---

# 13. SQLite vs SQLAlchemy

### SQLite directly

```python
import sqlite3

connection = sqlite3.connect("database.db")
cursor = connection.cursor()

cursor.execute("SELECT * FROM employees")

rows = cursor.fetchall()

connection.close()
```

### SQLAlchemy

```python
from sqlalchemy import create_engine

engine = create_engine("sqlite:///database.db")

df = pd.read_sql(
    "SELECT * FROM employees",
    engine
)
```

SQLAlchemy becomes especially useful when applications need to work with different relational databases using a consistent interface.

---

# Key Functions

| Function | Purpose |
|---|---|
| `sqlite3.connect()` | Connect to SQLite |
| `create_engine()` | Create SQLAlchemy engine |
| `engine.connect()` | Create database connection |
| `text()` | Represent raw SQL |
| `execute()` | Execute SQL |
| `fetchone()` | Fetch one row |
| `fetchall()` | Fetch all rows |
| `pd.read_sql()` | SQL → DataFrame |
| `df.to_sql()` | DataFrame → SQL table |
| `commit()` | Save database changes |
| `close()` | Close connection |

---

# Key Mental Model

```text
Python
   ↓
Database Library
   ↓
Connection / Engine
   ↓
SQL Query
   ↓
Database
   ↓
Query Results
   ↓
Pandas DataFrame
```

For the Data Collection Pipeline, the most important concepts are:

**SQLAlchemy → Parameterized Queries → `pd.read_sql()` → DataFrame → `df.to_sql()`**.