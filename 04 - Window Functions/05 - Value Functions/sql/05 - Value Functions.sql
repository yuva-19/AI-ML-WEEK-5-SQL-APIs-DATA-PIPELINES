-- Q1 — First Order 🔥
-- Using orders, display:
-- customer_id
-- order_id
-- order_date
-- first_order_date
-- last_order_date

SELECT * FROM orders;

SELECT
    customer_id,
    order_id,
    order_date,
    FIRST_VALUE(order_date) OVER( 
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS first_order_date,
    LAST_VALUE(order_date) OVER( 
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS last_order_date
FROM orders
ORDER BY customer_id,order_id,order_date;


-- Q3 — First Purchase Amount 🔥
-- Using orders + order_items:
-- Calculate each order's value first.
-- Then display:
-- customer_id
-- order_id
-- order_date
-- order_value
-- first_order_value
-- change_from_first_order

SELECT
    customer_id,
    order_id,
    order_date,
    order_value,
    FIRST_VALUE(order_value) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS first_order_value,
    (order_value - FIRST_VALUE(order_value) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    )) AS change_from_first_order
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





