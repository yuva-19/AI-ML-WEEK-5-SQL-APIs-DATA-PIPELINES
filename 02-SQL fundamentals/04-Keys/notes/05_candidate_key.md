# Candidate Key

A Candidate Key is a column or combination of columns that
can uniquely identify each row and is eligible to become
the Primary Key.

Example:

users

user_id | email           | username
--------+-----------------+---------
1       | yuva@gmail.com  | yuva
2       | arun@gmail.com  | arun
3       | priya@gmail.com | priya

If user_id, email, and username are all unique and
non-null, each can be a Candidate Key.

One Candidate Key is selected as the Primary Key.

Candidate Keys
    ↓
Possible choices
    ↓
One chosen
    ↓
Primary Key

## Candidate Key vs Primary Key

Candidate Key:
- Can uniquely identify a row
- Multiple candidate keys can exist
- Must be unique and non-null
- One can be selected as the Primary Key

Primary Key:
- The selected main identifier
- Only one Primary Key constraint per table
- Must be unique and non-null

## Example

customer_id → Candidate Key
email       → Candidate Key

Choose:

customer_id → Primary Key

email → can remain UNIQUE

## AI/ML Relevance

Candidate Keys help identify possible unique identifiers
when designing datasets and database schemas.