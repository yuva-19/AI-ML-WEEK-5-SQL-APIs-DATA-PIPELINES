-- ============================================
-- CONSTRAINTS
-- BLOCK 1: NOT NULL + UNIQUE
-- ============================================

CREATE TABLE constraint_users (
    user_id INTEGER,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

INSERT INTO constraint_users(user_id,name,email)
VALUES
    (1, 'Yuva', 'yuva@gmail.com'),
    (2, 'Arun', 'arun@gmail.com');

SELECT * FROM constraint_users;

-- if we insert name as NULL it will thrown an error
INSERT INTO constraint_users (user_id, name, email)
VALUES (3, NULL, 'priya@gmail.com');

-- and email id must be unique so if we use same 
-- it will return error
INSERT INTO constraint_users (user_id, name, email)
VALUES (3, 'Priya', 'yuva@gmail.com');

-- PRIMARY AND FOREIGN KEYS as constraints

--PRIMARY KEYS cannot have duplicate 
-- 1 2 3 1-->this one is not valid coz its duplicate
-- And we cannot use the NULL values

CREATE TABLE departments (
    department_id INTEGER PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

INSERT INTO departments (department_id, department_name)
VALUES
    (1, 'EEE'),
    (2, 'CSE'),
    (3, 'ECE');

CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INTEGER,
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

--as FOREIGN KEY we cannot create something new that does not exist
-- It will run c0z department_id = 1 is present
INSERT INTO employees
(employee_id, employee_name, department_id)
VALUES
(1, 'Yuva', 1);

-- it will throw an error coz coz department_id = 99 is not present
INSERT INTO employees
(employee_id, employee_name, department_id)
VALUES
(2, 'Karthik', 99);


-- CHECK + DEFAULT
CREATE TABLE students_check (
    student_id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INTEGER CHECK (age >= 18),
    marks INTEGER CHECK (marks >= 0 AND marks <= 100)
);
-- This will run coz age is in limit
INSERT INTO students_check
(student_id, name, age, marks)
VALUES
(1, 'Yuva', 22, 85);

-- it will fail coz age not in limit
INSERT INTO students_check
(student_id, name, age, marks)
VALUES
(2, 'Arun', 16, 85);

-- department will be always EEE for every entity
CREATE TABLE students_default (
    student_id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50) DEFAULT 'EEE',
    status VARCHAR(20) DEFAULT 'active'
);

INSERT INTO students_default
(student_id, name)
VALUES
(1, 'Yuva');

SELECT *
FROM students_default;

-- Default should not be null