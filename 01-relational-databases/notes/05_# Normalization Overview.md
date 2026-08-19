# Normalization Overview

## What is Normalization?

Normalization is the process of organizing relational data into well-structured tables to reduce redundancy and improve consistency.

Main goals:
- Reduce duplicate data
- Avoid data inconsistencies
- Make data easier to maintain
- Separate different types of information

## Poor Design Example

orders
- order_id
- customer_name
- customer_city
- food1
- food2
- food3

Problems:
- Repeated customer information
- Repeating food columns
- Difficult to update
- Difficult to extend

## Better Design

customers
- customer_id
- name
- city

orders
- order_id
- customer_id

foods
- food_id
- name
- price

order_items
- order_id
- food_id
- quantity

## 1NF — First Normal Form

Core idea:
Each column should contain atomic/single values and there should be no repeating groups.

Remember:

1NF → Atomic values

## 2NF — Second Normal Form

Core idea:
The table must be in 1NF and non-key attributes must depend on the whole primary key.

Important when using composite primary keys.

Remember:

2NF → 1NF + no partial dependency

## 3NF — Third Normal Form

Core idea:
The table must be in 2NF and non-key attributes should not depend on other non-key attributes.

Remember:

3NF → 2NF + no transitive dependency

## Quick Memory

1NF → Atomic values
2NF → Whole key
3NF → Only the key

## Database Normalization vs ML Normalization

Database normalization:
- Database design
- Reduces redundancy
- Uses concepts such as 1NF, 2NF, 3NF

ML normalization:
- Feature preprocessing
- Scales/transforms numerical features

They are different concepts.

## AI/ML Engineer Relevance

Normalization helps create clean, maintainable relational databases that are easier to query and use in data pipelines.