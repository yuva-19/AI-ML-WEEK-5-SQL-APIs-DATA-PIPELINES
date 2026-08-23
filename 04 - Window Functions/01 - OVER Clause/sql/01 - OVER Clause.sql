-- OVER()

-- Normally if u use GROUPBY
-- You got one row per customer.
-- The individual orders disappeared. 
SELECT
    customer_id,
    COUNT(*) AS order_count
FROM orders
GROUP BY customer_id;

-- If we use windows function
-- COUNT(*) OVER() 
-- calculates the count across the window without removing the original rows.
SELECT
    order_id,
    customer_id,
    COUNT(*) OVER () AS total_orders
FROM orders;


-- SUM() OVER()

SELECT
    order_id,
    customer_id,
    SUM(order_id) OVER () AS total_order_id_sum
FROM orders;

-- PARTITION BY

-- Suppose we want:
-- Every order + total number of orders made by that customer's customer.
-- With GROUP BY, we'd get one row per customer.

SELECT
    order_id,
    customer_id,
    COUNT(*) OVER (
        PARTITION BY customer_id
    ) AS customer_order_count
FROM orders
ORDER BY customer_id, order_id;


-- 1) order_id
-- customer_id
-- customer_order_count

SELECT
    order_id,
    customer_id,
    COUNT (*) OVER(
        PARTITION BY customer_id
    ) AS customer_order_count
FROM orders
ORDER BY customer_id,order_id;

-- 2)order_item_id
-- order_id
-- quantity
-- total_quantity_for_order

SELECT * FROM order_items;

SELECT
     order_item_id,
     order_id,
     quantity,
     SUM (quantity) OVER(
        PARTITION BY order_id
     ) AS total_quantity_for_order
FROM order_items
ORDER BY order_id;


-- 3)customer_id
-- order_id
-- customer_order_count

SELECT * FROM orders;

SELECT
     customer_id,
     order_id,
     COUNT(*) OVER( 
        PARTITION BY customer_id
     ) AS customer_order_count
FROM orders
ORDER BY customer_id,order_id;
