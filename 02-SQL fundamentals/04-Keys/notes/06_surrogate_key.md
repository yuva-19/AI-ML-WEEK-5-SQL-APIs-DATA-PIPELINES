# Surrogate Key

A Surrogate Key is an artificially generated identifier
used to uniquely identify a row.

It normally has no real-world or business meaning.

Example:

customer_id | name  | email
------------+-------+----------------
1           | Yuva  | yuva@gmail.com
2           | Arun  | arun@gmail.com
3           | Priya | priya@gmail.com

customer_id is a Surrogate Key.

The value 1 does not describe anything about Yuva.
It is simply an identifier.

## Natural Key vs Surrogate Key

Natural Key:
- Based on real-world/business data
- Examples: email, phone number, product code
- Can sometimes change

Surrogate Key:
- Artificially generated
- Usually has no business meaning
- Usually stable
- Examples: 1, 2, 3, 4...

## PostgreSQL Example

student_id SERIAL PRIMARY KEY

SERIAL generates sequential IDs using a sequence.

The generated student_id can act as a Surrogate Key.

## Why Use Surrogate Keys?

They provide stable identifiers even when real-world
information changes.

Example:

yuva@gmail.com
    ↓
yuva123@gmail.com

The customer's surrogate ID can remain:

customer_id = 1

## AI/ML Relevance

Surrogate keys are commonly used to connect records across
database tables.

Example:

CUSTOMERS
    ↓
customer_id
    ↓
ORDERS
    ↓
ML Dataset

A surrogate ID is generally an identifier, not a meaningful
numerical ML feature.