CREATE TABLE case_employees (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(100),
    salary DECIMAL(10,2),
    performance_score INT
);

INSERT INTO case_employees
    (employee_name, salary, performance_score)
VALUES
    ('Arun', 60000, 90),
    ('Yuva', 45000, 75),
    ('Priya', 35000, 60),
    ('Karthik', 25000, 40),
    ('Rahul', 70000, 95);

-- Order is sensitive here
-- first we have to give top prior one followed by others
-- if we start with 60 >= Good
-- Even for 90+ marks it will return as Good
SELECT
    employee_name,
    performance_score,
    CASE 
        WHEN performance_score >= 80 THEN 'Excellent'
        WHEN performance_score >= 60 THEN 'Good'
        WHEN performance_score >= 40 THEN 'Average'
        ELSE 'Poor'
    END AS performance_level
FROM case_employees;


SELECT
    employee_name,
    salary,
    CASE
        WHEN salary >= 60000 THEN 'High'
        WHEN salary >= 40000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_category
FROM case_employees;


-- COALESCE
-- COALESCE is one of the most useful SQL functions for handling NULL values.

CREATE TABLE coalesce_customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    city VARCHAR(50)
);

INSERT INTO coalesce_customers
    (customer_name, phone, email, city)
VALUES
    ('Yuva', '9876543210', 'yuva@email.com', 'Chennai'),
    ('Arun', NULL, 'arun@email.com', 'Coimbatore'),
    ('Priya', '9123456780', NULL, 'Madurai'),
    ('Karthik', NULL, NULL, 'Trichy'),
    ('Rahul', '9988776655', 'rahul@email.com', NULL);

SELECT * FROM coalesce_customers;

SELECT
    customer_name,
    COALESCE(phone, 'Not Provided') AS phone
FROM coalesce_customers;

-- using multiple things
-- it will return first if present(phone)
-- if phone not present it will try to return email
-- if email is NULL it will finally it will return the message u gave
SELECT
    customer_name,
    COALESCE(phone, email, 'No Contact Information') AS contact
FROM coalesce_customers;



CREATE TABLE coalesce_orders (
    order_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    discount DECIMAL(10,2)
);

INSERT INTO coalesce_orders
    (product_name, price, discount)
VALUES
    ('Laptop', 65000, 5000),
    ('Mouse', 900, NULL),
    ('Keyboard', 1500, 100),
    ('Monitor', 12000, NULL);

SELECT
    product_name,
    price,
    COALESCE(discount,0) AS discount,
    price - COALESCE(discount,0) AS final_price
FROM coalesce_orders;



-- NULLIF
-- If two values are equal → return NULL. Otherwise → return the first value.
SELECT NULLIF(10, 10);
SELECT NULLIF(10, 5);


CREATE TABLE nullif_sales (
    product_name VARCHAR(100),
    revenue DECIMAL(10,2),
    units_sold INT
);

INSERT INTO nullif_sales
    (product_name, revenue, units_sold)
VALUES
    ('Laptop', 650000, 10),
    ('Mouse', 90000, 100),
    ('Keyboard', 0, 0),
    ('Monitor', 120000, 10);

-- keyboard unit_sold is 0
-- (0,0)--> NULL so anything which is divided by NULL will return NULL

SELECT
    product_name,
    revenue,
    units_sold,
    revenue / NULLIF(units_sold, 0) AS revenue_per_unit
FROM nullif_sales;



-- IN & NOT IN
CREATE TABLE filtering_products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

INSERT INTO filtering_products
    (product_name, category, price)
VALUES
    ('Laptop', 'Electronics', 65000),
    ('Mouse', 'Electronics', 900),
    ('Keyboard', 'Electronics', 1500),
    ('Notebook', 'Stationery', 100),
    ('Pen', 'Stationery', 50),
    ('Chair', 'Furniture', 5000);

SELECT * FROM filtering_products;

SELECT *
FROM filtering_products
WHERE category IN ('Electronics','Stationery');

SELECT
    product_name,
    category
FROM filtering_products
WHERE category NOT IN ('Electronics', 'Furniture');

-- IN with a subquery

SELECT * FROM preferred_categories;

SELECT
     product_name,
     category
FROM filtering_products 
WHERE category IN(
    SELECT category_name
    FROM preferred_categories
);


-- EXISTS & NOT EXISTS
-- EXISTS
-- Does at least one matching row exist?

-- NOT EXISTS
-- Does no matching row exist?

CREATE TABLE exists_customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100)
);

CREATE TABLE exists_orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(100),
    amount DECIMAL(10,2)
);

INSERT INTO exists_customers (customer_name)
VALUES
    ('Yuva'),
    ('Arun'),
    ('Priya'),
    ('Karthik'),
    ('Rahul');

INSERT INTO exists_orders
    (customer_id, product_name, amount)
VALUES
    (1, 'Laptop', 65000),
    (1, 'Mouse', 900),
    (2, 'Keyboard', 1500),
    (4, 'Monitor', 12000);

SELECT
    c.customer_id,
    c.customer_name
FROM exists_customers as c
WHERE EXISTS(
    SELECT 1
    FROM exists_orders as o
    WHERE c.customer_id = o.customer_id
);

SELECT
    c.customer_id,
    c.customer_name
FROM exists_customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM exists_orders AS o
    WHERE o.customer_id = c.customer_id
);




-- ANY & ALL

SELECT *
FROM filtering_products;

-- Find products whose price is greater than ANY price in Stationery
-- now this sub query will return (100,50)
-- now if  price greater than 100 OR 50 it will return that
SELECT
    product_name,
    price
FROM filtering_products
WHERE price > ANY (
    SELECT price
    FROM filtering_products
    WHERE category = 'Stationery'
);

-- Find products whose price is greater than ALL price in Stationery
-- now this sub query will return (100,50)
-- now if  price greater than 100 AND 50 it will return that
-- now notebook will note be returned here coz its not greater than all the values from sub query
SELECT
    product_name,
    price
FROM filtering_products
WHERE price > ALL (
    SELECT price
    FROM filtering_products
    WHERE category = 'Stationery'
);

