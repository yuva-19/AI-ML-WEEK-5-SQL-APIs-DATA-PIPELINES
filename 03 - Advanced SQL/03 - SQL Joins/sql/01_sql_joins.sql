-- ============================================
-- ADVANCED SQL
-- SQL JOINS
-- PRACTICE TABLES
-- ============================================

CREATE TABLE join_customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL
);

CREATE TABLE join_orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(100),
    amount DECIMAL(10,2)
);

INSERT INTO join_customers (customer_name)
VALUES
    ('Yuva'),
    ('Arun'),
    ('Priya'),
    ('Karthik');

INSERT INTO join_orders (customer_id, product_name, amount)
VALUES
    (1, 'Laptop', 65000),
    (1, 'Mouse', 900),
    (2, 'Keyboard', 1500),
    (3, 'Notebook', 100);

SELECT * FROM join_customers;

SELECT * FROM join_orders;

-- INNER JOIN
-- INNER JOIN returns rows where there is a matching value in both tables.
SELECT
    c.customer_name,
    o.product_name,
    o.amount
FROM join_customers AS c
INNER JOIN join_orders AS o
    ON c.customer_id = o.customer_id;

SELECT
    c.customer_name,
    o.product_name,
    o.amount
FROM join_customers AS c
INNER JOIN join_orders AS o
    ON c.customer_id = o.customer_id
WHERE o.amount > 1000;

-- 2)LEFT JOIN
-- All rows from the left table + matching rows from the right table.
SELECT
    c.customer_name,
    o.product_name,
    o.amount
FROM join_customers AS c
LEFT JOIN join_orders AS o
    ON c.customer_id = o.customer_id;

-- can be used to find customers with no orders
SELECT
    c.customer_name,
    o.product_name,
    o.amount
FROM join_customers AS c
LEFT JOIN join_orders AS o
    ON c.customer_id = o.customer_id
WHERE o.product_name is NULL;

-- also used price filtering too
SELECT
    c.customer_name,
    o.product_name,
    o.amount
FROM join_customers AS c
LEFT JOIN join_orders AS o
    ON c.customer_id = o.customer_id
WHERE o.amount > 1000;



-- RIGHT JOIN
-- All rows from the right table + matching rows from the left table.

SELECT * FROM join_orders;

SELECT
    c.customer_name,
    o.product_name,
    o.amount
FROM join_customers AS c
RIGHT JOIN join_orders AS o
    ON c.customer_id = o.customer_id;


    

-- FULL OUTER JOIN
SELECT
    c.customer_name,
    o.product_name,
    o.amount
FROM join_customers AS c
FULL OUTER JOIN join_orders AS o
    ON c.customer_id = o.customer_id;

INSERT INTO join_orders(customer_id,product_name,amount)
VALUES(99,'Monitor',12000);

-- now if run the same full outer join the 
-- customer id with 99 name is not present
-- so it will generrate NULL for it

SELECT
    c.customer_name,
    o.product_name,
    o.amount
FROM join_customers AS c
FULL OUTER JOIN join_orders AS o
    ON c.customer_id = o.customer_id;

-- if we need find records that don't have a match on either side.
SELECT
    c.customer_name,
    o.product_name,
    o.amount
FROM join_customers AS c
FULL OUTER JOIN join_orders AS o
    ON c.customer_id = o.customer_id
WHERE c.customer_id is NULL
   OR o.order_id is NULL;



-- CROSS JOIN
-- Rows in table A × Rows in table B

CREATE TABLE join_products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100)
);

INSERT INTO join_products (product_name)
VALUES
    ('Laptop'),
    ('Mouse'),
    ('Keyboard');

SELECT
    c.customer_name,
    p.product_name
FROM join_customers AS c
CROSS JOIN join_products AS p;

-- SELF JOIN

CREATE TABLE join_employees (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(100),
    manager_id INT
);
INSERT INTO join_employees (employee_name, manager_id)
VALUES
    ('Arun', NULL),
    ('Yuva', 1),
    ('Priya', 1),
    ('Karthik', 2);

SELECT * FROM join_employees;

SELECT
    e.employee_name AS employee,
    m.employee_name AS manager
FROM join_employees AS e
LEFT JOIN join_employees AS m
    ON e.manager_id = m.employee_id;

-- SEMI JOIN & ANTI JOIN

-- A Semi Join means:
-- Return rows from the left table only when a matching row exists in the right table.

SELECT * FROM join_customers;
SELECT * FROM join_orders;

SELECT
    c.customer_name
FROM join_customers AS c
WHERE EXISTS(
    SELECT 1
    FROM join_orders AS o
    WHERE o.customer_id = c.customer_id
)

-- ANTI JOIN
-- Return rows from the left table only when a matching row  does not exists in the right table.

SELECT
    c.customer_name
FROM join_customers AS c
WHERE NOT EXISTS(
    SELECT 1
    FROM join_orders AS o
    WHERE o.customer_id = c.customer_id
)

-- SEMI JOIN using IN
SELECT
    customer_name
FROM join_customers
WHERE customer_id IN (
    SELECT customer_id
    FROM join_orders
);

-- ANTI JOIN using NOT IN
SELECT
    customer_name
FROM join_customers
WHERE customer_id NOT IN(
    SELECT customer_id
    FROM join_orders
);


-- NATURAL JOIN
SELECT
    customer_name,
    product_name,
    amount
FROM join_customers
NATURAL JOIN join_orders;







