```
| Frame | Meaning |
|---|---|
| `CURRENT ROW` | Current row |
| `1 PRECEDING` | Previous row |
| `2 PRECEDING` | Previous 2 rows |
| `1 FOLLOWING` | Next row |
| `2 FOLLOWING` | Next 2 rows |
| `UNBOUNDED PRECEDING` | Start of partition |
| `UNBOUNDED FOLLOWING` | End of partition |
```



```
Most important:
-- Running
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
-- Rolling 3 rows
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
-- Current + next 2
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
-- Previous + current + next
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
-- Entire partition
ROWS BETWEEN UNBOUNDED PRECEDING
         AND UNBOUNDED FOLLOWING

```
-- Q1 — Customer Lifetime Revenue 🔥🔥
-- Using orders + order_items, calculate each order's value.
-- Return:
-- customer_id
-- order_id
-- order_date
-- order_value
-- customer_total_revenue
-- customer_total_revenue must show the same total revenue for that customer on every one of their orders.


SELECT
    customer_id,
    order_id,
    order_date,
    order_value,
    SUM(order_value) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS customer_total_revenue
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




-- Q2 — 3-Order Revenue Window 🔥🔥
-- Using orders + order_items, calculate each order's value.
-- Return:
-- customer_id
-- order_id
-- order_date
-- order_value
-- previous_2_orders_revenue

SELECT
    customer_id,
    order_id,
    order_date,
    order_value,
    SUM(order_value) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN 2 PRECEDING  AND CURRENT ROW
    ) AS previous_2_orders_revenue
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


-- Q3 — Future Purchase Value 🔥🔥🔥
-- Using orders + order_items, calculate each order's value.
-- Return:
-- customer_id
-- order_id
-- order_date
-- order_value
-- next_2_orders_revenue



SELECT
    customer_id,
    order_id,
    order_date,
    order_value,
    SUM(order_value) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN  CURRENT ROW AND 2 FOLLOWING
    ) AS next_2_orders_revenue
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


-- Q4 — First and Last Purchase Analysis 🔥🔥🔥
-- Using orders + order_items, return:
-- customer_id
-- order_id
-- order_date
-- order_value
-- first_order_value
-- last_order_value
-- Every order belonging to the same customer should show:
-- first_order_value = customer's first order value
-- last_order_value  = customer's last order value


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
    LAST_VALUE(order_value) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS last_order_value
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

