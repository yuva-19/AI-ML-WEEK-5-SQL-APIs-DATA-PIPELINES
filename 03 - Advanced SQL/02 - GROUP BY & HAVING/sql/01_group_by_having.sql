-- groupby
SELECT
    category,
    AVG(price) AS average_price
FROM products_crud
GROUP BY category;

CREATE TABLE groupby_employees(
    employee_id SERIAL PRIMARY KEY,
    department VARCHAR(50),
    job_role VARCHAR(100),
    salary INTEGER 
);

INSERT INTO groupby_employees(department,job_role,salary)
VALUES
    ('EEE','Power Electronics',25000),
    ('ECE','VLSI',30000),
    ('EEE','Power System',40000),
    ('ECE','Embedded',30000),
    ('EEE','Power System',40000),
    ('EEE','Power Electronics',15000),
    ('ECE','Embedded',10000),
    ('ECE','VLSI',12000),
    ('ECE','VLSI',13000),
    ('EEE','Power System',50000);

SELECT * FROM groupby_employees;

SELECT
     department,
     job_role,
     AVG(salary) AS average_salary
FROM groupby_employees
GROUP BY department,job_role;


-- WHERE  → filters rows BEFORE grouping(used for indivudal rows)
-- HAVING → filters groups AFTER grouping(used for groups after groupby)
-- HAVING is used to filter the results of aggregate/grouped queries.

SELECT
    job_role,
    AVG(salary) AS average_salary
FROM groupby_employees
WHERE salary>=15000 --this will filter out salaries >=15000 going through each rows
GROUP BY job_role
HAVING AVG(salary) > 20000; -- this will filter out average job_role salries which are greater than 20000



