-- This is the part you need to remember.
-- PERCENT_RANK
-- "What is my relative rank?"

-- first → 0
-- last  → 1
-- CUME_DIST
-- "What percentage of rows are at or below me?"

-- first → 1/n
-- last  → 1



-- Q1 — Customer Spending Position 🔥🔥
-- Using your existing tables:
-- customers, orders, order_items
-- First calculate each customer's total spending.
-- Then return:
-- customer_id
-- customer_name
-- total_spending
-- spending_percent_rank
-- Calculate spending_percent_rank across all customers using:
-- PERCENT_RANK()

SELECT
    customer_id,
    customer_name,
    total_spending,
    PERCENT_RANK() OVER(
        ORDER BY total_spending
    ) AS spending_percent_rank
FROM( 
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        SUM(oi.quantity * oi.unit_price)  AS total_spending
    FROM customers AS c 
    LEFT JOIN orders AS o 
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items AS oi 
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id
) AS sub
ORDER BY spending_percent_rank;


-- Q2 — Product Price Distribution 🔥🔥
-- Using products, return:
-- product_name
-- category
-- price
-- price_cume_dist
-- Calculate CUME_DIST() based on price within each category.

SELECT * FROM products;

SELECT
    product_name,
    category,
    price,
    CUME_DIST() OVER(
        PARTITION BY category
        ORDER BY price
    )
FROM products;


-- Q3 — Customer Order Frequency 🔥🔥🔥
-- Using customers and orders:
-- First calculate the number of orders per customer, including customers with zero orders.
-- Then return:
-- customer_id
-- customer_name
-- order_count
-- order_count_percent_rank

SELECT
    customer_id,
    customer_name,
    order_count,
    PERCENT_RANK() OVER(
        ORDER BY order_count
    ) AS order_count_percent_rank
FROM(
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        COUNT(o.order_id) AS order_count
    FROM customers AS c 
    LEFT JOIN orders AS o 
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_id
)



-- Q4 — High-Value Customer Detection 🔥🔥🔥
-- This one is the most important.
-- First calculate each customer's total spending.
-- Then calculate:
-- customer_id
-- customer_name
-- total_spending
-- cume_distribution
-- using:
-- CUME_DIST()
-- Then classify customers:
-- CUME_DIST >= 0.90 → Top 10%
-- CUME_DIST >= 0.75 → Top 25%
-- otherwise          → Regular
-- Return:
-- customer_id
-- customer_name
-- total_spending
-- cume_distribution
-- customer_segment

SELECT
    customer_id,
    customer_name,
    total_spending,
    CUME_DIST() OVER(
        ORDER BY total_spending
    ) AS cume_distribution,
    (   CASE
        WHEN CUME_DIST() OVER(ORDER BY total_spending)>=0.90 THEN 'TOP 10%'
        WHEN CUME_DIST() OVER(ORDER BY total_spending)>=0.75 THEN 'TOP 25%'
        ELSE 'REGULAR'
        END
    ) AS customer_segment
FROM( 
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        SUM(oi.quantity * oi.unit_price)  AS total_spending
    FROM customers AS c 
    LEFT JOIN orders AS o 
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items AS oi 
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id
) AS sub
ORDER BY cume_distribution DESC;