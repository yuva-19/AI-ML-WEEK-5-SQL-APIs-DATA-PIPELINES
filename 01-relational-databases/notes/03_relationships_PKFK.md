# Relationships, Primary Keys and Foreign Keys

## Primary Key (PK)

A Primary Key uniquely identifies each row in a table.

Example:

customer_id INTEGER PRIMARY KEY

Properties:
- Unique
- Cannot be NULL
- Identifies one record

## Foreign Key (FK)

A Foreign Key is a column that references a key in another table.

Example:

orders.customer_id
        ↓
customers.customer_id

## Relationship

A relationship connects records between tables.

Example:

One customer can have many orders.

This is a One-to-Many relationship.

## Example

customers

| customer_id | name |
|---|---|
| 1 | Arun |
| 2 | Ravi |
| 3 | Priya |

orders

| order_id | customer_id | amount |
|---|---|---|
| 101 | 1 | 450 |
| 102 | 2 | 700 |
| 103 | 1 | 250 |

Customer 1 (Arun) has two orders.

## JOIN

A JOIN combines related data from multiple tables.

Example:

SELECT
    orders.order_id,
    customers.name,
    orders.amount
FROM orders
JOIN customers
    ON orders.customer_id = customers.customer_id;

## AI/ML Relevance

ML datasets often require data from multiple related tables.

Primary Key
→ Foreign Key
→ Relationship
→ JOIN
→ Combined dataset
→ Feature Engineering
→ ML Model