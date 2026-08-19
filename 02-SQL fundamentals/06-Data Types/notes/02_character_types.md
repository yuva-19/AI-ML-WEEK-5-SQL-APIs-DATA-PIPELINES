# Character Data Types

## VARCHAR

VARCHAR stores text with variable length.

Example:

name VARCHAR(100)

It is commonly used for:

- Names
- Cities
- Addresses
- Product names
- Descriptions

The stored text does not need to use the full declared
length.

## CHAR

CHAR stores text with a fixed length.

Example:

country_code CHAR(2)

Suitable for fixed-length values such as:

IN
US
UK

Another example:

gender_code CHAR(1)

## VARCHAR vs CHAR

VARCHAR:
- Variable-length text
- Commonly used for general text
- Example: VARCHAR(100)

CHAR:
- Fixed-length text
- Useful for fixed-size codes
- Example: CHAR(2)

## AI/ML Relevance

Text and categorical data such as names, cities,
departments, and product names are commonly stored as
VARCHAR in databases.

Before ML models use this data, text/categorical values
usually need preprocessing or encoding.