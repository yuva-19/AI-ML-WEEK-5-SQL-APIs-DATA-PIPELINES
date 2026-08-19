# Unique Key

A UNIQUE constraint ensures that values in a column or
combination of columns cannot be duplicated.

Example:

CREATE TABLE unique_users (
    user_id INTEGER PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100) UNIQUE
);

Here:

user_id → Primary Key
username → UNIQUE
email → UNIQUE

## Primary Key vs UNIQUE

Primary Key:
- Identifies each row
- Cannot contain NULL
- Only one Primary Key constraint per table
- Cannot contain duplicate values

UNIQUE:
- Prevents duplicate values
- PostgreSQL allows NULL values
- A table can have multiple UNIQUE constraints
- Useful for values such as email, username, and phone

## Common Uses

UNIQUE constraints are useful for:

- Email addresses
- Usernames
- Phone numbers
- External IDs
- Transaction references

## AI/ML Relevance

UNIQUE constraints help prevent duplicate records and
maintain cleaner datasets for analytics, data pipelines,
feature engineering, and ML.