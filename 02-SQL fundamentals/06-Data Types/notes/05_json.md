# JSON

JSON stands for JavaScript Object Notation.

It is a structured format commonly used for exchanging
data between applications and APIs.

Example:

{
    "name": "Yuva",
    "department": "EEE",
    "age": 22
}

## PostgreSQL JSON Types

PostgreSQL supports:

- JSON
- JSONB

JSON stores JSON data while preserving its original
representation.

JSONB stores JSON in a decomposed binary format and is
generally more useful when querying and indexing JSON data.

## Querying JSONB

Example:

student_data->>'name'

The ->> operator returns the JSON value as text.

The -> operator returns a JSON value.

Remember:

->  → JSON
->> → text

## Use Cases

JSON is useful for:

- API responses
- Semi-structured data
- Flexible attributes
- Metadata
- Data whose structure may vary

## API / AI/ML Relevance

APIs commonly return JSON.

Typical pipeline:

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

JSON is therefore useful when building API-based data
collection pipelines.

## Important

Do not automatically store everything as JSON.

Frequently queried structured data is usually better stored
in normal relational columns.