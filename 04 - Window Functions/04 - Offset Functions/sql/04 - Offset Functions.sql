-- What are Offset Functions?
-- The two functions we need:
-- LAG()
-- LEAD()
-- They allow us to look at another row relative to the current row.

-- LAG()
-- LAG() looks at a previous row.

SELECT
    order_id,
    customer_id,
    order_date,
    LAG(order_date) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_date
FROM orders;


-- LEAD() does the opposite.
-- It looks at the next row.
SELECT
    order_id,
    customer_id,
    order_date,
    LEAD(order_date) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS next_order_date
FROM orders;

-- LAG/LEAD(column) OVER(
--     PARTITION BY group_column
--     ORDER BY sequence_column
-- )

-- Offset by more than 1 row
-- You can specify how many rows to look back/forward.
-- LAG(order_date, 2) OVER(
--     PARTITION BY customer_id
--     ORDER BY order_date
-- )


-- Q2 — Days Between Orders 🔥
-- Using orders, return:
-- customer_id
-- order_id
-- order_date
-- previous_order_date
-- days_since_previous_order
-- Calculate the number of days between the current order 
-- and the customer's previous order.

SELECT * FROM orders;

SELECT
    customer_id,
    order_id,
    order_date,
    LAG(order_date) OVER( 
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_date,
    (order_date - LAG(order_date) OVER(PARTITION BY customer_id ORDER BY order_date)) AS days_since_previous_order   
FROM orders;


-- Q3 — Purchase Change 🔥🔥
-- Using orders + order_items:
-- First calculate each order's total value.
-- Then return:
-- customer_id
-- order_id
-- order_date
-- order_value
-- previous_order_value
-- change_from_previous
-- Where:
-- change_from_previous =
-- current order value - previous order value
-- The comparison must be against the same customer's previous order.

SELECT * FROM orders;
SELECT * FROM order_items;


SELECT
     customer_id,
     order_id,
     order_date,
     order_value,
     LAG(order_value) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
     ) AS previous_order_value,
    (order_value - LAG(order_value) OVER(PARTITION BY customer_id ORDER BY order_date)) AS change_from_previous
FROM( 
    SELECT
        o.customer_id,
        o.order_id,
        o.order_date,
        SUM(oi.quantity * oi.unit_price) AS order_value
    FROM orders AS o
    LEFT JOIN order_items AS oi  
        ON o.order_id = oi.order_id
    GROUP BY o.customer_id, o.order_id, o.order_date
)AS sub


-- Q4 — Customer Purchase Journey 🔥🔥🔥
-- Using orders + order_items, return:
-- customer_id
-- order_id
-- order_date
-- order_value
-- previous_order_date
-- next_order_date
-- days_since_previous_order
-- days_until_next_order


SELECT * FROM orders;
SELECT * FROM order_items;

SELECT
    customer_id,
    order_id,
    order_date,
    order_value,
    LAG(order_date) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_date,
    LEAD(order_date) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS next_order_date,
    (order_date - LAG(order_date) 
    OVER(PARTITION BY customer_id ORDER BY order_date)) AS days_since_previous_order,
    (LEAD(order_date) 
    OVER(PARTITION BY customer_id ORDER BY order_date) - order_date) AS days_until_next_order 
FROM( 
    SELECT
        o.customer_id,
        o.order_id,
        o.order_date,
        SUM(oi.quantity * oi.unit_price) AS order_value
    FROM orders AS o 
    LEFT JOIN order_items as oi 
        ON o.order_id = oi.order_id
    GROUP BY o.customer_id,o.order_id
) AS sub
ORDER BY customer_id,order_id;