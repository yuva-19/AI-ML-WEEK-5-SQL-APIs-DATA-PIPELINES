CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10,2),
    stock INT
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    status VARCHAR(20)
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    unit_price NUMERIC(10,2)
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    payment_date DATE,
    amount NUMERIC(10,2),
    payment_method VARCHAR(30),
    payment_status VARCHAR(20)
);


INSERT INTO customers
(first_name, last_name, email, city, signup_date)
VALUES
('Yuva', 'Kumar', 'yuva@gmail.com', 'Coimbatore', '2024-01-15'),
('Arun', 'Raj', 'arun@gmail.com', 'Chennai', '2024-02-10'),
('Priya', 'Sharma', 'priya@gmail.com', 'Bangalore', '2024-02-18'),
('Karthik', 'S', 'karthik@gmail.com', 'Coimbatore', '2024-03-05'),
('Divya', 'R', 'divya@gmail.com', 'Chennai', '2024-03-22'),
('Rahul', 'K', 'rahul@gmail.com', 'Madurai', '2024-04-10'),
('Sneha', 'M', 'sneha@gmail.com', 'Bangalore', '2024-04-18'),
('Vijay', 'P', 'vijay@gmail.com', 'Trichy', '2024-05-01'),
('Anjali', 'N', 'anjali@gmail.com', 'Chennai', '2024-05-15'),
('Suresh', 'V', 'suresh@gmail.com', 'Coimbatore', '2024-06-01'),
('Meena', 'K', 'meena@gmail.com', 'Salem', '2024-06-20'),
('Ajay', 'R', 'ajay@gmail.com', 'Madurai', '2024-07-05'),
('Nithya', 'S', 'nithya@gmail.com', 'Trichy', '2024-07-20'),
('Ravi', 'M', 'ravi@gmail.com', 'Chennai', '2024-08-01'),
('Keerthi', 'P', 'keerthi@gmail.com', 'Bangalore', '2024-08-15');

INSERT INTO products
(product_name, category, price, stock)
VALUES
('Laptop', 'Electronics', 75000, 15),
('Monitor', 'Electronics', 12000, 25),
('Keyboard', 'Accessories', 2500, 50),
('Mouse', 'Accessories', 1200, 80),
('Headphones', 'Accessories', 3500, 40),
('Smartphone', 'Electronics', 45000, 20),
('Tablet', 'Electronics', 30000, 18),
('Webcam', 'Accessories', 5000, 30),
('Office Chair', 'Furniture', 15000, 10),
('Desk', 'Furniture', 12000, 12),
('Printer', 'Electronics', 18000, 8),
('USB Cable', 'Accessories', 500, 100),
('External SSD', 'Storage', 9000, 22),
('Hard Disk', 'Storage', 6500, 16),
('Router', 'Networking', 4500, 35);

INSERT INTO orders
(customer_id, order_date, status)
VALUES
(1, '2024-08-01', 'Completed'),
(2, '2024-08-03', 'Completed'),
(3, '2024-08-05', 'Completed'),
(1, '2024-08-10', 'Completed'),
(4, '2024-08-12', 'Cancelled'),
(5, '2024-08-15', 'Completed'),
(6, '2024-08-18', 'Completed'),
(7, '2024-08-20', 'Pending'),
(8, '2024-08-22', 'Completed'),
(9, '2024-08-25', 'Completed'),
(10, '2024-08-27', 'Cancelled'),
(2, '2024-09-01', 'Completed'),
(3, '2024-09-03', 'Completed'),
(11, '2024-09-05', 'Completed'),
(12, '2024-09-08', 'Pending'),
(13, '2024-09-10', 'Completed'),
(14, '2024-09-12', 'Completed'),
(15, '2024-09-15', 'Completed'),
(4, '2024-09-18', 'Completed'),
(5, '2024-09-20', 'Pending'),
(1, '2024-09-22', 'Completed'),
(6, '2024-09-25', 'Completed'),
(7, '2024-09-28', 'Cancelled'),
(8, '2024-10-01', 'Completed'),
(9, '2024-10-03', 'Completed'),
(10, '2024-10-05', 'Completed'),
(11, '2024-10-08', 'Pending'),
(12, '2024-10-10', 'Completed'),
(13, '2024-10-12', 'Completed'),
(14, '2024-10-15', 'Completed');


INSERT INTO order_items
(order_id, product_id, quantity, unit_price)
VALUES
(1, 1, 1, 75000),
(1, 3, 1, 2500),

(2, 2, 2, 12000),
(2, 4, 2, 1200),

(3, 6, 1, 45000),
(3, 5, 1, 3500),

(4, 7, 1, 30000),
(4, 8, 1, 5000),

(5, 9, 1, 15000),

(6, 10, 1, 12000),
(6, 3, 2, 2500),

(7, 11, 1, 18000),
(7, 12, 3, 500),

(8, 1, 1, 75000),

(9, 13, 2, 9000),
(9, 4, 1, 1200),

(10, 14, 1, 6500),
(10, 15, 1, 4500),

(11, 2, 1, 12000),

(12, 1, 1, 75000),
(12, 5, 1, 3500),

(13, 6, 2, 45000),

(14, 9, 1, 15000),
(14, 10, 1, 12000),

(15, 7, 1, 30000),

(16, 3, 2, 2500),
(16, 4, 2, 1200),

(17, 8, 1, 5000),
(17, 5, 2, 3500),

(18, 1, 1, 75000),

(19, 11, 1, 18000),
(19, 12, 5, 500),

(20, 2, 1, 12000),

(21, 13, 1, 9000),
(21, 14, 1, 6500),

(22, 6, 1, 45000),
(22, 4, 2, 1200),

(23, 15, 1, 4500),

(24, 10, 1, 12000),
(24, 9, 1, 15000),

(25, 7, 1, 30000),

(26, 3, 1, 2500),
(26, 8, 1, 5000),

(27, 1, 1, 75000),

(28, 5, 1, 3500),
(28, 4, 3, 1200),

(29, 13, 1, 9000),
(29, 12, 2, 500),

(30, 2, 2, 12000);

INSERT INTO payments
(order_id, payment_date, amount, payment_method, payment_status)
VALUES
(1, '2024-08-01', 77500, 'UPI', 'Paid'),
(2, '2024-08-03', 26400, 'Card', 'Paid'),
(3, '2024-08-05', 48500, 'UPI', 'Paid'),
(4, '2024-08-10', 35000, 'Card', 'Paid'),
(5, '2024-08-12', 15000, 'Card', 'Refunded'),
(6, '2024-08-15', 17000, 'UPI', 'Paid'),
(7, '2024-08-18', 19500, 'Cash', 'Paid'),
(8, '2024-08-20', 75000, 'Card', 'Pending'),
(9, '2024-08-22', 19200, 'UPI', 'Paid'),
(10, '2024-08-25', 11000, 'Card', 'Paid'),
(11, '2024-08-27', 12000, 'UPI', 'Refunded'),
(12, '2024-09-01', 78500, 'Card', 'Paid'),
(13, '2024-09-03', 90000, 'UPI', 'Paid'),
(14, '2024-09-05', 27000, 'Cash', 'Paid'),
(15, '2024-09-08', 30000, 'Card', 'Pending'),
(16, '2024-09-10', 7400, 'UPI', 'Paid'),
(17, '2024-09-12', 12000, 'Card', 'Paid'),
(18, '2024-09-15', 75000, 'UPI', 'Paid'),
(19, '2024-09-18', 20500, 'Card', 'Paid'),
(20, '2024-09-20', 12000, 'UPI', 'Pending'),
(21, '2024-09-22', 15500, 'Card', 'Paid'),
(22, '2024-09-25', 47400, 'UPI', 'Paid'),
(23, '2024-09-28', 4500, 'Cash', 'Refunded'),
(24, '2024-10-01', 27000, 'Card', 'Paid'),
(25, '2024-10-03', 30000, 'UPI', 'Paid'),
(26, '2024-10-05', 7500, 'Card', 'Paid'),
(27, '2024-10-08', 75000, 'UPI', 'Pending'),
(28, '2024-10-10', 7100, 'Cash', 'Paid'),
(29, '2024-10-12', 10000, 'Card', 'Paid'),
(30, '2024-10-15', 24000, 'UPI', 'Paid');

-- 1)Find customers from Chennai
SELECT 
    first_name || ' ' || last_name AS full_name,
    city
FROM customers
WHERE city = 'Chennai';

-- 2)Find products costing between ₹5,000 and ₹20,000

SELECT
    product_name,
    category,
    price
FROM products
WHERE price >= 5000
    AND price <=20000;


-- 3)Display the 5 most expensive products.
SELECT *
FROM products
ORDER BY price DESC
LIMIT 5;

-- 4)Display all unique customer cities.

SELECT DISTINCT city
FROM customers;

-- 5) Find customers who signed up after 2024-04-01
SELECT * FROM customers
LIMIT 1;

SELECT * 
FROM customers
WHERE signup_date > '2024-04-01';


-- 6) Find orders placed during August 2024
SELECT * FROM orders
LIMIT 1;

ALTER TABLE orders
ALTER COLUMN order_date TYPE DATE
USING order_date :: DATE;

SELECT 
    EXTRACT(MONTH FROM order_date) AS month
FROM orders;

SELECT *
FROM orders
WHERE EXTRACT(MONTH FROM order_date) = 8;

-- 7)Find products whose name contains the letter o

SELECT * FROM products;

SELECT *
FROM products
WHERE product_name LIKE '%o%';

-- 8)Find the total number of customers.

SELECT COUNT(*)
FROM customers;

-- 9)Find the cheapest product.
-- this will return value alone
SELECT MIN(price)
FROM products;

SELECT *
FROM products
ORDER BY price ASC
LIMIT 1;

-- 10)Find the number of products in each category.

SELECT
    category,
    COUNT(*) AS product_count
FROM products
GROUP BY category;

-- 11)Find the average price grater than 10000 of products in each category

SELECT
    category,
    AVG(price) AS average_price
FROM products
GROUP BY category
HAVING AVG(price)>=10000;

-- 12) Find cities having more than 2 customers.
SELECT
    city,
    COUNT(city) AS Count
FROM customers
GROUP BY city
HAVING COUNT(city)>2;

-- 13) Find payment methods where total payment exceeds ₹100,000.

SELECT *
FROM payments
LIMIT 1;

SELECT DISTINCT payment_status FROM payments;

SELECT
     payment_method,
     SUM(amount)
FROM payments
WHERE payment_status = 'Paid'
GROUP BY payment_method
HAVING SUM(amount) >= 100000;


-- 14) Display every order along with the customer's first name.

SELECT * FROM customers;

SELECT * FROM orders;

SELECT
     c.first_name,
     o.*
FROM customers as c
INNER JOIN orders as o
    ON o.customer_id = c.customer_id

-- 15) Display every order item with:
-- product_name
-- quantity
-- unit_price
-- total price

SELECT * FROM order_items;
SELECT * FROM products;

SELECT
    o.order_item_id,
    o.quantity,
    p.product_name,
    o.unit_price,
    (o.quantity * o.unit_price) AS total_price
FROM order_items as o
INNER JOIN products as p
     ON o.product_id = p.product_id;


-- 16) Display each order's total value.
SELECT * FROM orders;
SELECT * FROM order_items;

SELECT 
    o.order_id,
    SUM(oi.quantity * oi.unit_price) AS total_value
FROM orders AS o
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY o.order_id
ORDER BY order_id;

-- 17)Display customers who have placed at least one order.

SELECT * FROM orders;
SELECT * FROM customers;

SELECT
    c.*,
    COUNT(o.order_id) AS Count   
FROM customers AS c
INNER JOIN orders AS o
     ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(o.order_id) >= 1
ORDER BY c.customer_id;

-- 18) Display products that have never been ordered.
SELECT * FROM order_items;
SELECT * FROM products;

SELECT p.*
FROM products AS p
LEFT JOIN order_items AS o
    ON p.product_id = o.product_id
WHERE o.order_id IS NULL;

-- 19) Find the total amount spent by each customer.

SELECT * FROM customers
LIMIT 5;
SELECT * FROM orders
LIMIT 5;
SELECT * FROM order_items
LIMIT 5;

SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spend
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN order_items as oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id
ORDER BY c.customer_id;

-- 20) Total Revenue Generated by Each product

SELECT * FROM products;
SELECT * FROM order_items;

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS Total_Revenue
FROM products AS p
LEFT JOIN order_items AS oi 
     ON p.product_id = oi.product_id
GROUP BY p.product_id
ORDER BY p.product_id;

-- 21) Find average order value for each customer.

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_items;

SELECT
     c.customer_id,
     c.first_name || ' ' || c.last_name AS customer_name,
     (SUM(oi.quantity * oi.unit_price) / COUNT( DISTINCT oi.order_id)) AS Average_order_value
FROM customers AS c
LEFT JOIN orders AS o 
    ON c.customer_id = o.customer_id
LEFT JOIN order_items as oi 
    ON o.order_id = oi.order_id
GROUP BY c.customer_id
ORDER BY c.customer_id;


-- 22)Classify customers based on number of orders:
-- 0 orders → No Orders
-- 1–2 orders → Regular
-- 3+ orders → Frequent

SELECT * FROM customers;
SELECT * FROM orders;

SELECT
     c.customer_id ,
     c.first_name || ' ' || c.last_name AS customer_name,
     (COUNT(o.order_id)) AS Number_of_orders,
     CASE
         WHEN COUNT(o.order_id) >= 3 THEN 'Frequent'
         WHEN COUNT(o.order_id) >= 1 THEN 'Regular'
         WHEN COUNT(o.order_id) = 0 THEN 'NO orders'
     END AS FREQUENCY
    
FROM customers AS c 
LEFT JOIN orders AS o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY c.customer_id


-- 23)Calculate order value and classify:
-- >= 50000 → High Value
-- >= 20000 → Medium Value
-- otherwise → Low Value

SELECT * FROM orders;
SELECT * FROM order_items;

SELECT
     o.order_id,
     (SUM(oi.quantity * oi.unit_price )) AS order_value,
     CASE
         WHEN SUM(oi.quantity * oi.unit_price) >= 50000 THEN 'High Value'
         WHEN SUM(oi.quantity * oi.unit_price) >= 20000 THEN 'Medium Value'
         ELSE 'Low Value'
    END AS order_value_category
FROM orders as o
LEFT JOIN order_items AS oi 
    ON o.order_id = oi.order_id
GROUP BY o.order_id
ORDER BY o.order_id;



-- 24) Find customers who have placed an order using IN.

SELECT * FROM customers;
SELECT * FROM orders;

SELECT
    customer_id,
    first_name || ' ' || last_name AS Name
FROM customers 
WHERE customer_id IN (
      SELECT customer_id
      FROM orders
);

-- 25) Find products that have been ordered using EXISTS.

SELECT * FROM products;
SELECT * FROM order_items;

SELECT
    p.product_id,
    p.product_name
FROM products  AS p 
WHERE EXISTS(
     SELECT 1
     FROM order_items as oi 
     WHERE p.product_id = oi.product_id
)


-- 26) Find customers who ordered a Laptop.

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM products;

SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS full_name,
    p.product_name
FROM customers AS c 
LEFT JOIN orders as o
    ON c.customer_id = o.customer_id
LEFT JOIN order_items as oi 
    ON o.order_id = oi.order_id
LEFT JOIN products as p 
    ON oi.product_id = p.product_id
WHERE p.product_name = 'Laptop';

-- 27) Find products whose price is greater than the average product price.

SELECT * FROM products;

SELECT
    product_id,
    product_name,
    price
FROM products 
WHERE price > (
    SELECT AVG(price)
    FROM products 
);


-- 28) Find customers who purchased products from the Electronics category.

SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS full_name,
    p.product_name
FROM customers AS c 
LEFT JOIN orders as o
    ON c.customer_id = o.customer_id
LEFT JOIN order_items as oi 
    ON o.order_id = oi.order_id
LEFT JOIN products as p 
    ON oi.product_id = p.product_id
WHERE category IN(
    SELECT category
    FROM products  
    WHERE category = 'Electronics'
);


-- 29) Find customers who have placed more orders than the average number of orders per customer.


SELECT * FROM customers;
SELECT * FROM orders;

SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(o.order_id) AS order_count
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(o.order_id) >
(
    SELECT AVG(order_count)
    FROM (
        SELECT COUNT(o2.order_id) AS order_count
        FROM customers AS c2
        LEFT JOIN orders AS o2
            ON c2.customer_id = o2.customer_id
        GROUP BY c2.customer_id
    ) AS sub
);

-- 30)Find monthly revenue.

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM products;

SELECT
     EXTRACT(MONTH FROM o.order_date) AS month,
     TO_CHAR(o.order_date, 'Month') AS month_name,
     SUM(oi.quantity * oi.unit_price) AS Revenue
FROM orders AS o
LEFT JOIN order_items AS oi 
     ON o.order_id = oi.order_id
GROUP BY EXTRACT(MONTH FROM o.order_date),TO_CHAR(o.order_date, 'Month')
ORDER BY month;

-- 31) Days between first order date and signup date

SELECT * FROM customers;
SELECT * FROM orders;

SELECT
     c.customer_id,
     c.first_name || ' ' || c.last_name AS customer_name,
     (MIN(o.order_date) -  c.signup_date) AS Days_To_First_order
FROM customers AS c 
LEFT JOIN orders AS o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY c.customer_id;

-- 31) Find customers who:
-- - placed at least 2 orders
-- - have total spending above ₹50,000
-- - have at least one completed order

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM products;

SELECT
     c.customer_id,
     c.first_name || ' ' || c.last_name AS customer_name,
     COUNT(DISTINCT o.order_id) AS number_of_orders,
     SUM(oi.quantity * oi.unit_price)  AS total_spending,
     COUNT(DISTINCT CASE WHEN o.status = 'Completed' THEN o.order_id END) AS number_of_completed_orders
FROM customers AS c 
LEFT JOIN orders AS o 
    ON c.customer_id = o.customer_id
LEFT JOIN order_items AS oi
    ON o.order_id = oi.order_id
LEFT JOIN products AS p
    ON oi.product_id = p.product_id
GROUP BY c.customer_id
HAVING (
    COUNT(DISTINCT o.order_id)>=2 
    AND SUM(oi.quantity * oi.unit_price)>=50000
    AND COUNT(DISTINCT CASE WHEN o.status = 'Completed' THEN o.order_id END) >=1
)
ORDER BY c.customer_id;


-- 32)Find the city with:
-- - highest number of customers
-- - highest number of orders
-- - highest total revenue
-- Return all three metrics.

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM products;

SELECT
     c.city,
     COUNT(c.customer_id) AS number_of_customers,
     COUNT(DISTINCT o.order_id) AS number_of_orders,
     SUM(oi.quantity * oi.unit_price) AS Revenue
FROM customers AS c 
LEFT JOIN orders AS o 
    ON c.customer_id = o.customer_id
LEFT JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY c.city;


-- 33)customer_name
-- city
-- total_orders
-- total_spending
-- average_order_value
-- first_order_date
-- last_order_date

-- have at least 2 orders
-- AND
-- total spending > average customer spending
-- AND
-- have at least one completed order
-- AND
-- have never cancelled an order



SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM products;

SELECT
     c.customer_id,
     c.first_name || ' ' || c.last_name AS customer_name,
     c.city,
     COUNT(DISTINCT o.order_id) AS number_of_orders,
     SUM(oi.quantity * oi.unit_price)  AS total_spending,
     MIN(o.order_date) AS first_order_date,
     MAX(o.order_date) AS last_order_date,
     COUNT(DISTINCT CASE WHEN o.status = 'Completed' THEN o.order_id END) AS number_of_completed_orders
FROM customers AS c 
LEFT JOIN orders AS o 
    ON c.customer_id = o.customer_id
LEFT JOIN order_items AS oi
    ON o.order_id = oi.order_id
LEFT JOIN products AS p
    ON oi.product_id = p.product_id
GROUP BY c.customer_id
HAVING (
    COUNT(DISTINCT o.order_id)>=2 
    AND SUM(oi.quantity * oi.unit_price)>=(
        SELECT AVG(customer_total)
        FROM (
                SELECT SUM(oi2.quantity * oi2.unit_price) AS customer_total
                FROM customers AS c2
                LEFT JOIN orders AS o2 ON c2.customer_id = o2.customer_id
                LEFT JOIN order_items AS oi2 ON o2.order_id = oi2.order_id
                GROUP BY c2.customer_id
        ) sub
    )
    AND COUNT(DISTINCT CASE WHEN o.status = 'Completed' THEN o.order_id END) >=1
    AND COUNT(DISTINCT CASE WHEN o.status = 'Cancelled' THEN o.order_id END) =0
)







