# NoSQL Databases

## What is NoSQL?

NoSQL commonly means "Not Only SQL".

NoSQL databases use data models other than the traditional
relational table model and are often designed for flexible,
distributed, or high-scale workloads.

NoSQL does NOT mean that SQL is completely absent.

---

## Why NoSQL Exists

NoSQL databases became popular because some applications need:

- Flexible data structures
- Large-scale distributed storage
- High read/write throughput
- Horizontal scaling
- High availability
- Handling of semi-structured or rapidly changing data

Examples of workloads:

- Social media
- Real-time applications
- IoT
- Recommendation systems
- Large-scale event data

---

## SQL vs NoSQL

SQL databases:

- Use relational tables
- Usually have predefined schemas
- Strong support for relationships and JOINs
- Strong transaction support
- Good for structured relational data

NoSQL databases:

- Can use document, key-value, wide-column, or graph models
- Often provide flexible schemas
- Often designed for distributed/high-scale workloads
- Relationships and transactions depend on the database type

SQL and NoSQL are not competitors in every situation.
A real system may use both.

---

## Major NoSQL Database Types

### 1. Document Database

Stores data as documents, commonly JSON-like structures.

Example:

{
    "name": "Yuva",
    "city": "Trichy",
    "skills": ["Python", "SQL", "ML"]
}

Example:
MongoDB

---

### 2. Key-Value Database

Stores data as:

KEY → VALUE

Example:

"user:1001" → "Yuva"

Example:
Redis

---

### 3. Wide-Column Database

Stores data using a distributed wide-column model.

Example:
Cassandra

Useful for large-scale distributed workloads and high
write throughput.

---

### 4. Graph Database

Stores nodes and relationships.

Example:

Yuva → FRIEND_OF → Arun

Example:
Neo4j

Graph databases are outside the main scope of this module.

---

## Main NoSQL Systems in This Roadmap

MongoDB
→ Document database

Redis
→ Key-value database

Cassandra
→ Wide-column database

---

## AI/ML Relevance

NoSQL can be useful in AI/ML systems for:

- High-volume event data
- User activity
- Real-time feature/state retrieval
- Flexible semi-structured data
- Distributed applications

NoSQL does not replace SQL.

A production AI/ML system may use both SQL and NoSQL databases.

---

## Priority

PostgreSQL
→ Primary SQL database

SQLite
→ Lightweight/local database

MongoDB
→ Important NoSQL document database

Redis
→ Important for fast key-value access

Cassandra
→ Understand distributed wide-column concept

Database administration is not the focus.

# Document Databases

## MongoDB

MongoDB is a popular NoSQL document database.

MongoDB stores data as documents organized into collections.

Basic structure:

MongoDB
    ↓
Database
    ↓
Collection
    ↓
Documents
    ↓
Fields

## SQL vs MongoDB Structure

PostgreSQL:

Database
    ↓
Schema
    ↓
Table
    ↓
Rows
    ↓
Columns

MongoDB:

Database
    ↓
Collection
    ↓
Documents
    ↓
Fields

Rough mapping:

PostgreSQL Table → MongoDB Collection
PostgreSQL Row → MongoDB Document
PostgreSQL Column → MongoDB Field

## Document Example

{
    "name": "Yuva",
    "city": "Trichy",
    "skills": [
        "Python",
        "SQL",
        "Machine Learning"
    ]
}

Documents can contain nested objects and arrays.

## Embedded / Nested Data

Example:

{
    "name": "Yuva",
    "address": {
        "street": "Main Road",
        "pincode": 620001
    }
}

Related information can sometimes be stored inside
the same document.

## MongoDB CRUD

SQL INSERT → MongoDB insertOne()
SQL SELECT → MongoDB find()
SQL UPDATE → MongoDB updateOne()
SQL DELETE → MongoDB deleteOne()

For this roadmap, understand the CRUD concepts and
basic syntax rather than becoming a MongoDB administrator.

## AI/ML Use Cases

MongoDB can be useful for:

- User profiles
- Product catalogs
- Content metadata
- Semi-structured data
- Application/event metadata

MongoDB can provide data to Python/ML pipelines.

MongoDB does not replace PostgreSQL. The choice depends
on the application's data model, query patterns, scale,
and consistency requirements.

# Key-Value Databases

## Key-Value Model

A key-value database stores data as:

KEY → VALUE

Example:

"user:101" → "Yuva"

The key identifies the stored value.

The model is conceptually similar to a Python dictionary.

---

## Redis

Redis is a popular key-value data store optimized for
very fast data access.

Basic model:

Redis
  ↓
KEY → VALUE

Redis supports data structures such as:

- Strings
- Lists
- Sets
- Hashes
- Sorted sets

---

## Why Redis is Fast

Redis is designed primarily around in-memory data access.

RAM-based access is extremely fast.

Redis also provides persistence mechanisms, so it is not
simply "data that disappears when the program stops."

---

## Redis as a Cache

Redis is commonly used as a cache.

Example:

User requests recommendation
        ↓
Check Redis
        ↓
Cached result available?
    YES → return quickly
    NO  → run model/database query
             ↓
          store result in Redis
             ↓
          return result

Caching reduces repeated expensive computation or database
access.

---

## Redis in AI/ML

Redis can be useful for:

- Real-time feature/state retrieval
- Caching model predictions
- Caching frequently requested data
- Session/state management
- Low-latency applications

Example:

"user:101:prediction" → 0.87

---

## Redis Basic Operations

SET → create/update

Example:

SET user:101 "Yuva"

GET → read

Example:

GET user:101

DEL → delete

Example:

DEL user:101

For this roadmap, understand the concepts rather than
learning Redis administration.

---

## Database Comparison

PostgreSQL
→ Relational database
→ Tables and relationships
→ Structured persistent data

MongoDB
→ Document database
→ Flexible documents
→ Semi-structured data

Redis
→ Key-value data store
→ Very fast access
→ Caching, state, and real-time workloads


# Cassandra

Cassandra is a distributed wide-column NoSQL database.

It is designed for:

- High availability
- Horizontal scalability
- High write throughput
- Distributed workloads
- Large datasets

Cassandra can operate across multiple nodes in a cluster.

Basic idea:

Node 1
Node 2
Node 3
   ↓
Cassandra Cluster
   ↓
Distributed Data

For this roadmap:
Understand the concept and use cases.
Do not spend significant time on Cassandra administration.

---

# When AI/ML Systems Use NoSQL

NoSQL should not be selected simply because a project
uses AI/ML.

Database selection depends on:

- Data structure
- Query patterns
- Scale
- Latency requirements
- Availability requirements
- Consistency requirements

## PostgreSQL

Use when data is structured and relational.

Examples:
- Customers
- Orders
- Products
- Payments
- Relational ML datasets

## MongoDB

Useful for:
- User profiles
- Product metadata
- Content metadata
- Semi-structured data
- Flexible document data

## Redis

Useful for:
- Caching
- Real-time state
- Low-latency data access
- Cached ML predictions
- Frequently accessed features/state

## Cassandra

Useful for:
- Massive distributed datasets
- High write throughput
- Large-scale event data
- High availability

---

# NoSQL CRUD

MongoDB:

INSERT → insertOne()
SELECT → find()
UPDATE → updateOne()
DELETE → deleteOne()

Redis:

CREATE/UPDATE → SET
READ → GET
DELETE → DEL

Cassandra:

Uses CQL (Cassandra Query Language), which has SQL-like
syntax, but its data modeling is designed for distributed
workloads.

---

# Final NoSQL Mental Model

MongoDB
→ Document database
→ Flexible documents

Redis
→ Key-value database
→ Very fast access / caching

Cassandra
→ Wide-column database
→ Distributed large-scale workloads

PostgreSQL
→ Relational database
→ Structured relational data

NoSQL does not replace SQL.

A production system may use multiple databases for
different workloads. This is sometimes called
polyglot persistence.