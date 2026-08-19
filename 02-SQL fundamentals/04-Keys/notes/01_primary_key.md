# Primary Key

A Primary Key (PK) is a column or combination of columns
that uniquely identifies each row in a table.

Example:

student_id | name  | department
-----------+-------+-----------
1          | Yuva  | EEE
2          | Arun  | CSE
3          | Priya | ECE

student_id can be the Primary Key.

## Rules

A Primary Key must be:

- UNIQUE
- NOT NULL

Therefore:

PRIMARY KEY
    ↓
UNIQUE + NOT NULL

Two rows cannot have the same Primary Key value.

A Primary Key cannot contain NULL.

## PostgreSQL Example

CREATE TABLE key_students (
    student_id INTEGER PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100)
);

The Primary Key prevents duplicate and NULL identifiers.

## AI/ML Relevance

Keys help identify records and connect datasets.

Example:

CUSTOMERS
customer_id → Primary Key

ORDERS
order_id → Primary Key
customer_id → used to connect orders to customers

Keys are important when combining datasets for
analytics and ML feature engineering.