# UNIQUE Constraint

UNIQUE ensures that duplicate values are not allowed
in a column or combination of columns.

Example:

email VARCHAR(100) UNIQUE

Valid:

yuva@gmail.com
arun@gmail.com

Invalid:

yuva@gmail.com
yuva@gmail.com

Purpose:
- Prevent duplicate values
- Maintain data integrity
- Useful for emails, usernames, phone numbers, etc.

UNIQUE is different from PRIMARY KEY because a table
can have multiple UNIQUE constraints.