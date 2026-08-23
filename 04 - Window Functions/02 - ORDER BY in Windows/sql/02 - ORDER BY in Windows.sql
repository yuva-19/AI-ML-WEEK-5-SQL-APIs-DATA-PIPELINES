-- Part A — What does ORDER BY actually do

-- ORDER BY order_date -- >How should I display the final result?


-- OVER (
--     ORDER BY order_date
-- )  --> What order should the window calculation use?


SELECT
    order_id,
    order_date,
    SUM(order_id) OVER (
        ORDER BY order_date
    ) AS running_total
FROM orders
ORDER BY order_date;

-- supppose

-- order_id
-- --------
-- 10
-- 20
-- 30
-- 40

-- The window calculation works conceptually as:
-- 10
-- 10 + 20
-- 10 + 20 + 30
-- 10 + 20 + 30 + 40




-- Part B — PARTITION BY + ORDER BY

SELECT
    customer_id,
    order_id,
    order_date,
    SUM(order_id) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS customer_running_value
FROM orders
ORDER BY customer_id, order_date;

-- PostgreSQL conceptually does:

-- Customer A
--     Jan 1  → calculation
--     Jan 5  → calculation
--     Jan 10 → calculation

-- Customer B
--     Jan 2  → calculation
--     Jan 7  → calculation
--     Jan 15 → calculation


-- function() OVER (
--     PARTITION BY X
--     ORDER BY Y
-- )
-- This implies
-- For each X group, process the rows in Y order


-- Q1 — Sequential customer orders
-- customer_id
-- order_id
-- order_date
-- and assign a sequential position to each customer's orders based on order_date.

SELECT
    customer_id,
    order_id,
    order_date,
    COUNT(*) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS sequential
FROM orders
ORDER BY customer_id,order_date;


-- Q2 — Running quantity 🔥
-- Using order_items, display:
-- order_id
-- order_item_id
-- quantity
-- and calculate the cumulative quantity within each order

SELECT * FROM order_items;

SELECT
    order_id,
    order_item_id,
    quantity,
    SUM(quantity) OVER(
        PARTITION BY order_id
        ORDER BY order_item_id
    ) AS cumulative_quantity
FROM order_items
ORDER BY order_id,order_item_id;


-- Q3 — Customer spending progression 🔥
-- Using customers, orders, and order_items, display:
-- customer_id
-- order_id
-- order_date
-- order_value
-- and add:
-- customer_running_spending
-- The value should represent how much that customer has spent up to 
-- and including that order, ordered by order_date.

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_items;

SELECT
    c.customer_id,
    o.order_id,
    o.order_date,
    SUM(oi.quantity * oi.unit_price) OVER( 
        PARTITION BY oi.order_id
    ) AS order_value,
    SUM(oi.quantity * oi.unit_price) OVER(  
        PARTITION BY c.customer_id
        ORDER BY o.order_date
    ) AS customer_running_spending
FROM customers as c
LEFT JOIN orders as o
   ON c.customer_id = o.customer_id
LEFT JOIN order_items as oi
   ON o.order_id = oi.order_id
ORDER BY c.customer_id,customer_running_spending;


-- Q4 — Monthly sequence
-- Using orders, display:
-- order_id
-- order_date
-- and assign each order a sequential position within its month, 
-- based on order_date

SELECT * FROM orders;

SELECT
    order_id,
    order_date,
    RANK() OVER(
        PARTITION BY DATE_TRUNC('month', order_date)
        ORDER BY order_date
    ) AS order_sequence
FROM orders;

-- Q5 — 🔥 Challenge
-- For each customer, find their orders and display:
-- customer_id
-- order_id
-- order_date
-- plus:
-- customer_running_order_count

SELECT
    c.customer_id,
    o.order_id,
    o.order_date,
    COUNT(*) OVER(
        PARTITION BY c.customer_id
        ORDER BY o.order_id
    ) AS customer_running_order_count
FROM customers as c
LEFT JOIN orders as o 
    ON c.customer_id = o.customer_id;