# PostgreSQL — Practical Fundamentals

## 1. PostgreSQL Architecture

PostgreSQL is a **server-based relational DBMS**.

### Basic Hierarchy

```text
PostgreSQL Server
│
├── Database
│   │
│   ├── Schema
│   │   │
│   │   ├── Tables
│   │   ├── Views
│   │   └── Functions
│   │
│   └── ...
│
├── Database
└── Database
```

### Example

```text
PostgreSQL Server
│
└── aiml_learning
      │
      └── public
            │
            └── students
```

---

# 2. PostgreSQL Database

A **database** is a logical container for storing related data.

We created:

```text
aiml_learning
```

### Connect to a Database

```sql
\c aiml_learning
```

After connecting, the prompt changes to:

```text
aiml_learning=#
```

This means the current PostgreSQL session is connected to `aiml_learning`.

---

# 3. PostgreSQL Schemas

A **schema** is a namespace/container inside a database.

Default schema:

```text
public
```

### Hierarchy

```text
PostgreSQL Server
      ↓
aiml_learning
      ↓
public
      ↓
tables
```

### List Schemas

```sql
\dn
```

---

# 4. Important `psql` Commands

`psql` is PostgreSQL's command-line client.

These commands start with `\` and are **not normal SQL statements**.

| Command | Purpose |
|---|---|
| `\l` | List databases |
| `\c database_name` | Connect to a database |
| `\dn` | List schemas |
| `\dt` | List tables |
| `\d table_name` | Show table structure |
| `\q` | Exit `psql` |

### SQL vs `psql`

SQL:

```sql
SELECT * FROM students;
```

`psql` command:

```text
\dt
```

> They are different.

---

# 5. Creating a Table

Example:

```sql
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(100),
    age INTEGER
);
```

This creates a table called:

```text
students
```

### Columns

```text
student_id
name
department
age
```

---

# 6. `SERIAL`

`SERIAL` automatically generates sequential integer values.

Example:

```sql
student_id SERIAL PRIMARY KEY
```

When inserting:

```sql
INSERT INTO students (name, department, age)
VALUES ('Yuva', 'EEE', 22);
```

We don't provide `student_id`.

PostgreSQL generates it automatically:

```text
1
2
3
4
...
```

`SERIAL` uses a PostgreSQL sequence internally.

> **Important:** `SERIAL` generally produces increasing IDs, but IDs can have gaps. They should not be treated as guaranteed gap-free numbers.

---

# 7. PRIMARY KEY

A **Primary Key** uniquely identifies each row.

Example:

```sql
student_id SERIAL PRIMARY KEY
```

### Properties

- Must be unique
- Cannot be `NULL`
- Identifies a row

Example:

```text
student_id | name
-----------+------
1          | Yuva
2          | Arun
3          | Priya
```

Each student has a unique `student_id`.

---

# 8. NOT NULL

`NOT NULL` means a column **must contain a value**.

Example:

```sql
name VARCHAR(100) NOT NULL
```

This is not allowed:

```sql
INSERT INTO students (department, age)
VALUES ('EEE', 22);
```

Because `name` is required.

---

# 9. INSERT

`INSERT` adds new rows to a table.

### Single Row

```sql
INSERT INTO students (name, department, age)
VALUES ('Yuva', 'EEE', 22);
```

### Multiple Rows

```sql
INSERT INTO students (name, department, age)
VALUES
    ('Yuva', 'EEE', 22),
    ('Arun', 'CSE', 21),
    ('Priya', 'ECE', 22);
```

Multiple rows can be inserted in one statement.

---

# 10. SELECT

`SELECT` retrieves data.

### Select All Columns

```sql
SELECT * FROM students;
```

`*` means:

```text
Select all columns
```

### Select Specific Columns

```sql
SELECT name, department
FROM students;
```

This retrieves only the specified columns.

---

# 11. UPDATE

`UPDATE` modifies existing data.

Example:

```sql
UPDATE students
SET department = 'AI&ML'
WHERE name = 'Karthik';
```

> **Important:** Always be careful with `WHERE`.

Without `WHERE`:

```sql
UPDATE students
SET department = 'AI&ML';
```

Every row could be updated.

---

# 12. DELETE

`DELETE` removes rows.

Example:

```sql
DELETE FROM students
WHERE name = 'Karthik';
```

> **Important:** Always be careful with `WHERE`.

Without `WHERE`:

```sql
DELETE FROM students;
```

All rows in the table are deleted.

---

# 13. CRUD

The four basic database operations are called **CRUD**.

| Letter | Operation | SQL |
|---|---|---|
| C | Create | `INSERT` |
| R | Read | `SELECT` |
| U | Update | `UPDATE` |
| D | Delete | `DELETE` |

### Examples

#### CREATE

```sql
INSERT INTO students ...
```

#### READ

```sql
SELECT * FROM students;
```

#### UPDATE

```sql
UPDATE students
SET ...
```

#### DELETE

```sql
DELETE FROM students
WHERE ...;
```

> **Note:** `CREATE TABLE` is a DDL operation, while CRUD usually refers to manipulating records using `INSERT`, `SELECT`, `UPDATE`, and `DELETE`.

---

# 14. UNIQUE Constraint

`UNIQUE` prevents duplicate values.

Example:

```sql
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    username VARCHAR(50) NOT NULL
);
```

This is allowed:

```text
yuva@gmail.com
arun@gmail.com
```

But this is rejected:

```text
yuva@gmail.com
yuva@gmail.com
```

Because `email` has a `UNIQUE` constraint.

### Common Uses

- Email
- Username
- Phone number
- Product code
- Employee ID

---

# 15. Constraints — Overview

Constraints are rules that control what data can be stored in a table.

### Important PostgreSQL Constraints

| Constraint | Purpose |
|---|---|
| `PRIMARY KEY` | Uniquely identifies a row |
| `NOT NULL` | Value is required |
| `UNIQUE` | Prevents duplicate values |
| `DEFAULT` | Provides a value automatically |
| `CHECK` | Ensures a value satisfies a condition |
| `FOREIGN KEY` | Connects one table to another |

### PRIMARY KEY

Uniquely identifies a row.

### NOT NULL

Value is required.

### UNIQUE

Prevents duplicate values.

### DEFAULT

Provides a value automatically when one isn't supplied.

### CHECK

Ensures a value satisfies a condition.

### FOREIGN KEY

Connects one table to another.

---

# 16. PostgreSQL vs SQLite — Architecture

## SQLite

```text
Application
     ↓
SQLite
     ↓
database.db
```

SQLite stores the database primarily as a file.

## PostgreSQL

```text
Application / VS Code
        ↓
PostgreSQL Client
        ↓
PostgreSQL Server
        ↓
Database
        ↓
Schema
        ↓
Tables
```

PostgreSQL runs as a **database server** and handles connections from clients.

---

# 17. VS Code + PostgreSQL Workflow

Our practical workflow:

```text
VS Code
   ↓
SQLTools
   ↓
PostgreSQL Driver
   ↓
localhost:5432
   ↓
aiml_learning
   ↓
SQL queries
```

### Connection Details

| Setting | Value |
|---|---|
| Host | `localhost` |
| Port | `5432` |
| Database | `aiml_learning` |
| Username | `postgres` |
| Password | Private |

---

# 18. Running SQL in VS Code

Our workflow:

### Step 1 — Open the `.sql` file

Example:

```text
02-SQL fundamentals
└── 01-DBMS
    └── sql
        └── 01_postgresql_basics.sql
```

### Step 2 — Write the Query

```sql
SELECT * FROM students;
```

### Step 3 — Select/Highlight the Query

### Step 4 — Click SQLTools Run

### Step 5 — Check the Result Panel

> **Important:** Run only the query you're currently practicing.

Don't blindly execute the entire file, especially when it contains:

```sql
CREATE TABLE
INSERT
```

Otherwise, you may get errors such as:

```text
relation "students" already exists
```

or accidentally insert duplicate data.

---

# 19. Our PostgreSQL Learning Database

We created:

```text
PostgreSQL Server
│
└── aiml_learning
      │
      └── public
            │
            ├── students
            │
            └── users
```

## `students`

Contains:

```text
student_id
name
department
age
```

## `users`

Contains:

```text
user_id
email
username
```

---

# 20. Important Mental Model 🧠

Remember this hierarchy:

```text
SERVER
  ↓
DATABASE
  ↓
SCHEMA
  ↓
TABLE
  ↓
ROWS + COLUMNS
```

### Our Example

```text
PostgreSQL Server
       ↓
aiml_learning
       ↓
public
       ↓
students
       ↓
1 | Yuva  | EEE | 22
2 | Arun  | CSE | 21
3 | Priya | ECE | 22
```

---

# Quick Revision 🔥

```text
PostgreSQL
│
├── Server
│
├── Database
│     └── aiml_learning
│
├── Schema
│     └── public
│
└── Tables
      ├── students
      └── users
```

### Core Commands

```sql
CREATE TABLE
INSERT
SELECT
UPDATE
DELETE
```

### Core Constraints

```text
PRIMARY KEY
NOT NULL
UNIQUE
DEFAULT
CHECK
FOREIGN KEY
```

### Core Mental Model

```text
SERVER
  ↓
DATABASE
  ↓
SCHEMA
  ↓
TABLE
  ↓
ROWS + COLUMNS
```

### Practical Workflow

```text
VS Code
   ↓
SQLTools
   ↓
PostgreSQL
   ↓
aiml_learning
   ↓
Write SQL
   ↓
Run Query
   ↓
Inspect Result
```

# Other Relational Database Systems

## MySQL

MySQL is a popular open-source relational DBMS that uses SQL.

Commonly used for:
- Web applications
- Backend systems
- E-commerce
- SaaS applications

For this roadmap:
Basic awareness is enough.

---

## Microsoft SQL Server

SQL Server is Microsoft's enterprise relational DBMS.

Commonly used in:
- Enterprise applications
- Banking
- Business applications
- Microsoft/.NET ecosystems
- Business intelligence

SQL Server uses T-SQL (Transact-SQL).

For this roadmap:
Introduction level is enough.

---

## Oracle Database

Oracle Database is a major enterprise relational DBMS.

Commonly used in:
- Large enterprises
- Banking
- Telecommunications
- Government systems
- Enterprise applications

Oracle has its own procedural language called PL/SQL.

For this roadmap:
Introduction level is enough.

---

## MariaDB

MariaDB is an open-source relational DBMS that originated as a fork of MySQL.

Relationship:

MySQL
  ↓
MariaDB (fork)

MariaDB remains compatible with many MySQL concepts,
although the two systems have diverged over time.

For this roadmap:
Introduction level is enough.

---

## Database Priority for AI/ML

PostgreSQL → Primary SQL learning database
SQLite → Lightweight/local projects
MySQL → Basic awareness
SQL Server → Introduction
Oracle → Introduction
MariaDB → Introduction

AI/ML engineers do not need to become experts in multiple
database systems. Strong SQL fundamentals and practical
PostgreSQL knowledge are more important.