# Composite Key

A Composite Key is a key made from two or more columns
that together uniquely identify a row.

Example:

student_id | course_id | grade
-----------+-----------+------
1          | 101       | A
1          | 102       | B
2          | 101       | A

Neither student_id nor course_id is individually unique.

But the combination:

(student_id, course_id)

is unique.

## PostgreSQL Example

CREATE TABLE student_courses (
    student_id INTEGER,
    course_id INTEGER,
    grade VARCHAR(2),

    PRIMARY KEY (student_id, course_id)
);

The combination of student_id and course_id forms the
Primary Key.

Important:

A Composite Key does NOT require each individual column
to be unique.

The combination of all columns in the key must be unique.

## Common Uses

Composite Keys are useful for tables representing
many-to-many relationships.

Examples:

Student ↔ Course
User ↔ Product
User ↔ Movie
Customer ↔ Product

## AI/ML Relevance

Composite keys are common in interaction datasets such as:

user_id + item_id

They can uniquely identify user-item interactions and are
useful in recommendation systems and other ML datasets.