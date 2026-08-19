CREATE TABLE crud_employees(
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2)
);

INSERT INTO crud_employees(name,department,salary)
VALUES
    ('Yuva', 'EEE', 25000),
    ('Arun', 'CSE', 30000),
    ('Priya', 'ECE', 28000),
    ('Karthik', 'EEE', 27000);

SELECT * FROM crud_employees;

-- select speicifc columns
SELECT name, department
FROM crud_employees;

-- select with WHERE
SELECT *
FROM crud_employees
WHERE department = 'EEE';

SELECT *
FROM crud_employees
WHERE salary >= 26000;

SELECT *
FROM crud_employees
WHERE name = 'Yuva';

-- UPDATE

-- UPDATE ONE ROW
UPDATE crud_employees
SET salary = 28000
WHERE name = 'Yuva';

SELECT *
FROM crud_employees
WHERE name = 'Yuva';


-- update multiple columns
UPDATE crud_employees
SET department = 'R&D',
    salary = 35000
WHERE name = 'Yuva';

SELECT *
FROM crud_employees
WHERE name = 'Yuva';

-- updating multiple rows

UPDATE crud_employees
SET salary = salary + 2000
WHERE department = 'EEE';

SELECT * FROM crud_employees;


-- DELETE

-- DELETE one specific row
DELETE FROM crud_employees
WHERE name = 'Priya';

SELECT * FROM crud_employees;

-- DELETE using the primary key
DELETE FROM crud_employees
WHERE employee_id = 4;

SELECT * FROM crud_employees;