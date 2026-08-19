# Schema and ER Model

## Schema

A database schema describes the structure/design of a database.

It includes:
- Tables
- Columns
- Data types
- Primary keys
- Foreign keys
- Relationships
- Constraints

Schema = database blueprint.

## Schema vs Data

Schema = structure

Example:

customers
- customer_id
- name
- city

Data = actual stored values

1 | Arun | Chennai
2 | Ravi | Trichy

## ER Model

ER = Entity-Relationship.

An ER model is a conceptual/visual representation of a database.

It shows:
- Entities
- Attributes
- Relationships

## Entity

An entity is something we store information about.

Examples:
- Customer
- Order
- Restaurant
- Product

An entity commonly becomes a table.

## Attribute

An attribute describes an entity.

Customer:
- customer_id
- name
- city

Attributes commonly become columns.

## Relationship

A relationship describes how entities are connected.

Example:

Customer → places → Order

One customer can have many orders.

This is a One-to-Many relationship.

## Important Mapping

Entity → Table

Attribute → Column

Relationship → Foreign Key

## Useful SQLite Commands

Check table structure:

PRAGMA table_info(customers);

Check foreign keys:

PRAGMA foreign_key_list(orders);

## AI/ML Relevance

Understanding schema helps an AI/ML Engineer:
- Find relevant data
- Understand relationships between datasets
- Write JOIN queries
- Build data pipelines
- Prepare training datasets