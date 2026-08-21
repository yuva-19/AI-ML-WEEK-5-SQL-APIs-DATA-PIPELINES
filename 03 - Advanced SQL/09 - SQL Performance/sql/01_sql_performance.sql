CREATE TABLE customers_index_demo (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50)
);

INSERT INTO customers_index_demo
(first_name, last_name, email, city)
VALUES
('Yuva', 'Kumar', 'yuva@gmail.com', 'Coimbatore'),
('Arun', 'Raj', 'arun@gmail.com', 'Chennai'),
('Priya', 'Sharma', 'priya@gmail.com', 'Bangalore'),
('Karthik', 'Mohan', 'karthik@gmail.com', 'Chennai'),
('Divya', 'Ravi', 'divya@gmail.com', 'Madurai'),
('Vijay', 'Kumar', 'vijay@gmail.com', 'Coimbatore'),
('Anu', 'Krishnan', 'anu@gmail.com', 'Chennai'),
('Rahul', 'Das', 'rahul@gmail.com', 'Bangalore'),
('Meena', 'Raj', 'meena@gmail.com', 'Madurai'),
('Suresh', 'Kumar', 'suresh@gmail.com', 'Coimbatore');


SELECT *
FROM customers_index_demo
WHERE email = 'yuva@gmail.com';

-- you will get something seq scan on customers
EXPLAIN
SELECT *
FROM customers_index_demo
WHERE email = 'yuva@gmail.com';



CREATE INDEX idx_customers_email
ON customers_index_demo(email);


-- now its created index for seraching email
-- for now it will again seq scan
-- since its only 10 rows
-- if its higher number fo rows it will use Index Scan
EXPLAIN
SELECT *
FROM customers_index_demo
WHERE email = 'yuva@gmail.com';


-- BLOCK -2 Query Optimization

CREATE TABLE orders_performance (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    amount NUMERIC(10,2),
    order_date DATE,
    status VARCHAR(20)
);

INSERT INTO orders_performance
(customer_id, product_name, category, amount, order_date, status)
VALUES
(1, 'Laptop', 'Electronics', 65000, '2026-01-10', 'Completed'),
(2, 'Mouse', 'Electronics', 1200, '2026-01-11', 'Completed'),
(3, 'Keyboard', 'Electronics', 2500, '2026-01-12', 'Pending'),
(4, 'Chair', 'Furniture', 8500, '2026-01-13', 'Completed'),
(5, 'Desk', 'Furniture', 15000, '2026-01-14', 'Cancelled'),
(6, 'Monitor', 'Electronics', 18000, '2026-01-15', 'Completed'),
(7, 'Phone', 'Electronics', 35000, '2026-01-16', 'Completed'),
(8, 'Notebook', 'Stationery', 300, '2026-01-17', 'Pending'),
(9, 'Pen', 'Stationery', 50, '2026-01-18', 'Completed'),
(10, 'Headphones', 'Electronics', 5000, '2026-01-19', 'Completed');



-- The basic idea: Don't process unnecessary rows
-- suppose when u only need electronics and status is completed
-- prefer

SELECT *
FROM orders_performance
WHERE category = 'Electronics'
    AND status ='Completed';


-- Avoid SELECT * when you don't need everything
-- suppose u only need product_name and status
SELECT
    product_name,
    status
FROM orders_performance
WHERE status = 'Completed';


--  Filter early
-- suppose ur calculating average amount of each category
--  but you only care about completed orders

-- instead of this
SELECT
    category,
    AVG(amount)
FROM orders_performance
GROUP BY category;

--you have to prefer
SELECT
    category,
    AVG(amount)
FROM orders_performance
WHERE status = 'Completed'
GROUP BY category;


