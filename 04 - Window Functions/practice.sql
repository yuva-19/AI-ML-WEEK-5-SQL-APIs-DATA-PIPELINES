-- Q4 — Product Revenue Ranking 🔥🔥🔥
-- Calculate total revenue for every product.
-- Return:
-- - product_id
-- - product_name
-- - category
-- - total_revenue
-- - category_revenue_rank
-- - overall_revenue_rank
-- - revenue_percentage_of_category

SELECT * FROM products;
SELECT * FROM order_items;

SELECT
    product_id,
    product_name,
    category,
    total_revenue,
    RANK() OVER(
        PARTITION BY category
        ORDER BY total_revenue DESC
    ) AS category_revenue_rank,
    RANK() OVER(
        ORDER BY total_revenue DESC
    ) AS overall_revenue_rank,
    (SUM(total_revenue) OVER (PARTITION BY product_name)/
    SUM(total_revenue)OVER(PARTITION BY category) * 100) AS revenue_percentage_of_category
FROM( 
    SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM products AS p
    LEFT JOIN order_items AS oi 
        ON p.product_id = oi.product_id
    GROUP BY p.product_id
)



-- Q5 — Customer First vs Latest Purchase 🔥🔥🔥
-- For every customer's order, return:
-- - customer_id
-- - order_id
-- - order_date
-- - order_value
-- - first_order_value
-- - latest_order_value
-- - change_from_first
-- - change_from_latest

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
    ) AS latest_order_value,
    (order_value - 
    FIRST_VALUE(order_value) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    )) AS change_from_first,
    (order_value -
    LAST_VALUE(order_value) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    )) AS change_from_latest
FROM(
    SELECT
        o.customer_id,
        o.order_id,
        o.order_date,
        SUM(oi.quantity * oi.unit_price) AS order_value
    FROM orders AS o
    LEFT JOIN order_items AS oi
        ON o.order_id = oi.order_id
    GROUP BY o.order_id
)



-- Q6 — Top Customers by City 🔥🔥🔥
-- First calculate each customer's total spending.
-- Then return:
-- - customer_id
-- - customer_name
-- - city
-- - total_spending
-- - city_rank
-- - city_spending_percentage

SELECT
     customer_id,
     customer_name,
     city,
     total_spending,
     RANK() OVER(
        PARTITION BY city 
        ORDER BY total_spending DESC
     ) AS city_rank,
     (total_spending /SUM(total_spending) OVER (PARTITION BY city) * 100) AS city_spending_percentage
FROM( 
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        c.city,
        SUM(oi.quantity * oi.unit_price) AS total_spending
    FROM customers AS c 
    LEFT JOIN orders AS o 
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items AS oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id
)
ORDER BY city;


-- Q7 — Customer Revenue Contribution 🔥🔥🔥
-- For every customer, calculate:
-- - customer_id
-- - customer_name
-- - total_spending
-- - running_spending
-- - overall_revenue
-- - revenue_percentage
-- - cumulative_revenue_percentage
-- Order customers from highest spending to lowest spending.



SELECT
     customer_id,
     customer_name,
     total_spending,
     SUM(total_spending) OVER(
        ORDER BY total_spending DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
     ) AS running_spending,
     SUM(total_spending) OVER() AS overall_revenue,
     (total_spending / SUM(total_spending) OVER() * 100) AS revenue_percentage,
     (SUM(total_spending) OVER(
        ORDER BY total_spending DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
     )* 100 /SUM(total_spending) OVER()  ) AS cumulative_revenue_percentage,
     (CASE
         WHEN(SUM(total_spending) OVER(
        ORDER BY total_spending DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        )* 100 /SUM(total_spending) OVER()) <=50 THEN 'Top Revenue Contributor'
         WHEN(SUM(total_spending) OVER(
        ORDER BY total_spending DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        )* 100 /SUM(total_spending) OVER()) <=80 THEN 'Core Customers'
        ELSE 'Long Tail'
        END) AS customer_segment
FROM( 
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        c.city,
        SUM(oi.quantity * oi.unit_price) AS total_spending
    FROM customers AS c 
    LEFT JOIN orders AS o 
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items AS oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id
)
ORDER BY total_spending DESC;


-- Q10 — 🔥🔥🔥🔥 Customer Journey Analysis
-- This is the final challenge.
-- For every customer's order, return:
-- - customer_id
-- - order_id
-- - order_date
-- - order_value
-- - order_number
-- - previous_order_date
-- - days_since_previous
-- - previous_order_value
-- - change_from_previous
-- - running_spending
-- - customer_lifetime_spending
-- - first_order_value
-- - latest_order_value
-- - customer_spending_rank
-- Then create:
-- customer_status
-- using:
-- New
-- Customer's first order.
-- Growing
-- Current order value is greater than previous order value.
-- Declining
-- Current order value is lower than previous order value.
-- Stable
-- Current order value equals previous order value.
-- Returning
-- Customer has placed at least 3 orders and the current order is not their first order.
-- Important: Design the logic carefully because some conditions overlap. Decide which condition should take priority.

SELECT
    customer_id,
    order_id,
    order_date,
    order_value,
    COUNT(*) OVER(PARTITION BY customer_id ORDER BY order_date) AS order_number,
    LAG(order_date) OVER(PARTITION BY customer_id ORDER BY order_date) AS previous_order_date,
    (order_date - LAG(order_date) OVER(PARTITION BY customer_id ORDER BY order_date)) AS days_since_previous,
    LAG(order_value) OVER(PARTITION BY customer_id ORDER BY order_date) AS previous_order_date,
    (order_value - LAG(order_value) OVER(PARTITION BY customer_id ORDER BY order_date)) AS days_since_previous,
    (SUM(order_value) OVER( 
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )) AS running_spending,
    (SUM(order_value) OVER(PARTITION BY customer_id)) AS customer_lifetime_spending,
    FIRST_VALUE(order_value) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS first_order_value,
    LAST_VALUE(order_value) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS latest_order_value,
    RANK() OVER(
        PARTITION BY customer_id
        ORDER BY order_value DESC
    ) AS customer_spending_rank
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
    ORDER BY o.customer_id,o.order_id
) AS sub
ORDER BY customer_id,order_id;



