-- ============================================
-- KEYS
-- Topic 1: PRIMARY KEY
-- ============================================

CREATE TABLE key_students(
    student_id INTEGER PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100)
);

INSERT INTO key_students(
    student_id,
    name,
    department
)
VALUES
    (1, 'Yuva', 'EEE'),
    (2, 'Arun', 'CSE'),
    (3, 'Priya', 'ECE');

SELECT * FROM key_students;

-- lets try insert new with same student_id = 1
-- postgre must reject coz thres already student_id =1
INSERT INTO key_students (student_id, name, department)
VALUES (1, 'Karthik', 'EEE');

-- postgre rejects this too
-- coz primary key cannot be NULL
INSERT INTO key_students (student_id, name, department)
VALUES (NULL, 'Karthik', 'EEE');


-- ============================================
-- FOREIGN KEY
-- ============================================

CREATE TABLE key_customers (
    customer_id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO key_customers (customer_id, name)
VALUES
    (1, 'Yuva'),
    (2, 'Arun'),
    (3, 'Priya');


-- Create Orders
CREATE TABLE key_orders(
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    amount NUMERIC(10,2),

    FOREIGN KEY(customer_id)
        REFERENCES key_customers(customer_id)
);

INSERT INTO key_orders (order_id, customer_id, amount)
VALUES
    (101, 1, 500),
    (102, 1, 250),
    (103, 2, 800);

-- Testing the Foreign Key Intentionally
-- customer_id is not present
-- so it will throw an error
INSERT INTO key_orders (order_id, customer_id, amount)
VALUES
    (104, 99, 1000);



-- ============================================
-- COMPOSITE KEY
-- ============================================

CREATE TABLE student_courses (
    student_id INTEGER,
    course_id INTEGER,
    grade VARCHAR(2),

    PRIMARY KEY (student_id,course_id)
);

INSERT INTO student_courses (student_id, course_id, grade)
VALUES
    (1, 101, 'A'),
    (1, 102, 'B'),
    (2, 101, 'A');

SELECT * FROM student_courses;

-- inserting value (1,101)
-- it will throw an error coz (1,101) already present
INSERT INTO student_courses(student_id,course_id,grade)
VALUES(1,101,'C')

-- inserting something unique
INSERT INTO student_courses(student_id,course_id,grade)
VALUES(2,102,'B')


-- ============================================
-- UNIQUE KEY
-- ============================================

CREATE TABLE unique_users (
    user_id INTEGER PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100) UNIQUE
);

INSERT INTO unique_users (user_id, username, email)
VALUES
    (1, 'yuva', 'yuva@gmail.com'),
    (2, 'arun', 'arun@gmail.com'),
    (3, 'priya', 'priya@gmail.com');

SELECT * FROM unique_users;

-- Testing with duplicate username
-- it will throw an error
-- coz username and email mustbe unique
INSERT INTO unique_users (user_id, username, email)
VALUES
    (4, 'yuva', 'karthik@gmail.com');

INSERT INTO unique_users (user_id, username, email)
VALUES
    (5, 'karthik', 'yuva@gmail.com');


SELECT * FROM unique_users;

