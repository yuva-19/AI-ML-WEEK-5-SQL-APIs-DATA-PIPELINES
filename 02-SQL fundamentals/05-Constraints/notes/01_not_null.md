# NOT NULL Constraint

NOT NULL ensures that a column cannot contain NULL values.

Example:

name VARCHAR(100) NOT NULL

Valid:

Yuva
Arun

Invalid:

NULL

Purpose:
- Ensures required data is present
- Prevents missing values in important columns
- Improves data quality

Example:

CREATE TABLE users (
    name VARCHAR(100) NOT NULL
);