SELECT 'Hello PostgreSQL!' AS message;


CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(100),
    age INTEGER
);

-- Insert students
INSERT INTO students (name, department, age)
VALUES
    ('Yuva', 'EEE', 22),
    ('Arun', 'CSE', 21),
    ('Priya', 'ECE', 22);

-- View all students
SELECT * FROM students;

INSERT INTO students(name,department,age)
VALUES
    ('Karthik','CSE',23)

SELECT * FROM students;

UPDATE students
SET department = 'AI&ML'
WHERE name = 'Karthik'

SELECT * FROM students;

DELETE FROM students
WHERE name = 'Karthik'

SELECT * FROM students;

CREATE TABLE users(
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    username VARCHAR(50) NOT NULL
);
-- this SERIAL will be automatically creates sequence 
-- 0 1 2 3 like this we dont need


INSERT INTO users(email,username)
VALUES
    ('yuva@gmail.com','yuva')


INSERT INTO users(email,username)
VALUES
    ('arun@gmail.com','arun')


-- This unique will throw error to this
-- coz email must be unique here
-- so inserting yuva@gmail will thorw an error

INSERT INTO users(email,username)
VALUES
    ('yuva@gmail.com','yuva2')