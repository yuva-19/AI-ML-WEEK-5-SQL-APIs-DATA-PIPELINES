# Arrays and Database-Specific Complex Types

## PostgreSQL Arrays

PostgreSQL allows a column to store multiple values
using an array.

Example:

skills TEXT[]

Example value:

{"Python","SQL","Machine Learning"}

Arrays can be useful when a record naturally contains
multiple values.

Example:

Student
    ↓
skills
    ├── Python
    ├── SQL
    └── Machine Learning

## Array Access

PostgreSQL arrays are 1-indexed.

Example:

skills[1]

returns the first element of the array.

## Other Database-Specific Complex Types

PostgreSQL supports additional types such as:

- Arrays
- JSON / JSONB
- UUID
- Range types
- Geometric types
- Composite types

These provide capabilities beyond basic SQL data types.

## AI/ML Relevance

Complex types can appear in real-world API and
semi-structured data.

Example:

API
 ↓
JSON
 ↓
Python
 ↓
PostgreSQL
 ↓
Data processing
 ↓
ML

For this roadmap, understand their purpose rather than
mastering advanced database-specific types.