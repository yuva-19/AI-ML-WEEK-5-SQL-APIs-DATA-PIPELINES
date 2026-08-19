-- ============================================
-- DATABASE OBJECTS
-- Block 2: Views
-- ============================================

-- View
CREATE VIEW adult_students AS
SELECT
    student_id,
    name,
    department,
    age
FROM students
WHERE age >= 22;

-- Query the View
SELECT *
FROM adult_students;


-- ============================================
-- INDEX
-- ============================================

CREATE INDEX idx_students_name
ON students(name);

-- ============================================
-- INDEX PERFORMANCE / QUERY PLAN
-- ============================================

EXPLAIN
SELECT *
FROM students
WHERE name = 'Yuva';

-- PostgreSQL's query planner decides whether to use an index
-- based on the estimated cost of the query.

-- For very small tables, PostgreSQL may choose a Sequential
-- Scan even when an appropriate index exists.

-- ============================================
-- MATERIALIZED VIEW
-- ============================================

CREATE MATERIALIZED VIEW student_summary AS
SELECT
    department,
    COUNT(*) AS student_count
FROM students
GROUP BY department;

SELECT *
FROM student_summary;

INSERT INTO students(name,department,age)
VALUES('Karthik','EEE',23);

SELECT *
FROM student_summary;
-- without refreshing the materialized view u would still get as 1
-- to refresh

REFRESH MATERIALIZED  VIEW student_summary;

SELECT *
FROM student_summary;



-- Check the Sequence value
-- It will show the latest generated value.
SELECT last_value
FROM students_student_id_seq;



-- ============================================
-- SEQUENCE
-- ============================================
-- Create our own Sequence

CREATE SEQUENCE employee_id_seq
START 100
INCREMENT 1;

SELECT nextval('employee_id_seq');--RUN this query again you will get next numbers
