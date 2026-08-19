# Foreign Key

A Foreign Key (FK) is a column that references a key in
another table.

Example:

CUSTOMERS
customer_id → Primary Key

ORDERS
customer_id → Foreign Key

The Foreign Key connects the two tables.

## Example

CUSTOMERS

customer_id | name
------------+-------
1           | Yuva
2           | Arun
3           | Priya

ORDERS

order_id | customer_id | amount
---------+-------------+-------
101      | 1           | 500
102      | 1           | 250
103      | 2           | 800

customer_id in ORDERS references customer_id in CUSTOMERS.

## Referential Integrity

A Foreign Key prevents records from referencing a
non-existent parent record.

For example:

customer_id = 99

is invalid if customer 99 does not exist in CUSTOMERS.

## Important Difference

Primary Key:
- Identifies a row
- Must be unique
- Cannot be NULL

Foreign Key:
- Connects tables
- Can contain duplicate values
- Can be NULL unless NOT NULL is specified

A customer can have multiple orders, so the same
customer_id can appear multiple times in ORDERS.

## PostgreSQL Syntax

CREATE TABLE key_orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    amount NUMERIC(10,2),

    FOREIGN KEY (customer_id)
        REFERENCES key_customers(customer_id)
);

## AI/ML Relevance

Foreign Keys help connect datasets.

Example:

CUSTOMERS
    ↓
customer_id
    ↓
ORDERS

This allows data from multiple tables to be combined
for analytics, feature engineering, and ML datasets.