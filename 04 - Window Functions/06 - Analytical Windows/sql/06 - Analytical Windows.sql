-- Q1 — Customer spending progression 🔥
-- Using your existing customers, orders, and order_items tables:
-- Return:
-- customer_id
-- order_id
-- order_date
-- order_value
-- running_customer_spending

SELECT
    customer_id,
    order_id,
    order_date,
    order_value,
    SUM(order_value) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS running_customer_spending
FROM(
    SELECT
        o.customer_id,
        o.order_id,
        o.order_date,
        SUM(oi.quantity * oi.unit_price) AS order_value
    FROM orders as o
    LEFT JOIN order_items as oi 
       ON o.order_id = oi.order_id
    GROUP BY o.customer_id,o.order_id,o.order_date
) AS sub
ORDER BY customer_id,order_id,order_date;


-- Q2 — Running order count 🔥
-- Using orders, return:
-- customer_id
-- order_id
-- order_date
-- running_order_count
-- For each customer, 
-- show the number of orders they have placed up to that order.


SELECT
    customer_id,
    order_id,
    order_date,
    COUNT(*) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    )
FROM orders
ORDER BY customer_id,order_date;


-- Q3 — Recent purchase behavior 🔥🔥
-- First calculate each order's value.
-- Then return:
-- customer_id
-- order_id
-- order_date
-- order_value
-- rolling_3_order_average
-- Calculate the average of the
-- current order + previous 2 orders for each customer.


SELECT
    customer_id,
    order_id,
    order_date,
    order_value,
    AVG(order_value) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_3_order_average
FROM(
    SELECT
        o.customer_id,
        o.order_id,
        o.order_date,
        SUM(oi.quantity * oi.unit_price) AS order_value
    FROM orders as o
    LEFT JOIN order_items as oi 
       ON o.order_id = oi.order_id
    GROUP BY o.customer_id,o.order_id,o.order_date
) AS sub
ORDER BY customer_id,order_id,order_date;


-- Q4 — Revenue contribution 🔥🔥🔥
-- Calculate each order's value and return:
-- order_id
-- order_date
-- order_value
-- running_revenue
-- running_revenue_percentage

SELECT
    order_id,
    order_date,
    order_value,
    SUM(order_value) OVER(
        ORDER BY order_date
    ) AS running_revenue,
    (SUM(order_value) OVER( 
        ORDER BY order_date
    ) /SUM(order_value) OVER()* 100) AS running_revenue_percentage
FROM(
    SELECT
        o.order_id,
        o.order_date,
        SUM(oi.quantity * oi.unit_price) AS order_value
    FROM orders as o
    LEFT JOIN order_items as oi 
       ON o.order_id = oi.order_id
    GROUP BY o.order_id,o.order_date
) AS sub
ORDER BY order_date,order_id;