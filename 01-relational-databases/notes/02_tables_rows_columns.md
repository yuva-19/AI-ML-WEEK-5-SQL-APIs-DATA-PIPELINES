# Tables, Rows and Columns

## 1. Table

A table is a structured collection of related data in a relational database.

Example:

customers

| customer_id | name | city |
|---|---|---|
| 1 | Arun | Chennai |
| 2 | Ravi | Trichy |

## 2. Column

A column represents an attribute/property of the data.

Example:

customer_id
name
city

Easy definition:

Column = what information are we storing?

## 3. Row

A row represents one complete record in a table.

Example:

1 | Arun | Chennai

This represents one customer.

Easy definition:

Row = one complete record.

## 4. Relationship Between Them

Table
→ contains rows

Row
→ contains values for columns

Column
→ defines an attribute/property

Example:

customers
├── customer_id → column
├── name → column
└── city → column

Each customer record → row

## 5. Basic SQL

### Create a table

CREATE TABLE customers (
    customer_id INTEGER,
    name TEXT,
    city TEXT
);

### Insert data

INSERT INTO customers (customer_id, name, city)
VALUES
    (1, 'Arun', 'Chennai');

### Retrieve data

SELECT * FROM customers;

## 6. Important Terms

Table = collection of related records

Row = one record

Column = one attribute/property

Value = actual piece of data stored in a cell

## 7. AI/ML Engineer Relevance

AI/ML engineers frequently retrieve structured datasets from relational databases.

Understanding tables, rows and columns is essential before learning:

- SQL queries
- Filtering
- Aggregation
- Joins
- Data preprocessing
- Feature engineering

## Must Remember

Column → attribute

Row → record

Table → collection of records

Database → collection of organized data structures such as tables