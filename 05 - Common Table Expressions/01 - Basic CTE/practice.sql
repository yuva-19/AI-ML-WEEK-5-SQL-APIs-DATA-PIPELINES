-- Q1 — Product Sales Summary 🟡
-- Using products and order_items:
-- Create a CTE called product_sales.
-- Inside the CTE calculate:
-- - product_id
-- - total_quantity_sold
-- - total_revenue
-- Then use the CTE to return:
-- - product_id
-- - total_quantity_sold
-- - total_revenue
-- Sort by total_revenue descending.
-- Goal: Practice creating a basic CTE from an aggregation.


WITH product_sales AS(
    SELECT
        p.product_id,
        SUM(oi.quantity) AS total_quantity_sold,
        SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM products as p 
    LEFT JOIN order_items AS oi 
        ON p.product_id = oi.product_id
    GROUP BY p.product_id
    ORDER BY total_revenue DESC
)

SELECT * FROM product_sales;

-- Q2 — Customers Above Average Spending 🟠
-- First create a CTE called customer_spending.
-- Calculate each customer's:
-- - customer_id
-- - total_spending
-- Then using the CTE, return only customers whose spending is greater than the average customer spending.
-- Return:
-- - customer_id
-- - total_spending
-- Sort highest spending first.
-- 🔥 Hint: You'll need to use the CTE result to calculate the average.


WITH customer_spending AS (
    SELECT
        c.customer_id,
        SUM(oi.quantity * oi.unit_price) AS total_spending
    FROM customers AS c
    LEFT JOIN orders AS o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items AS oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id
)
SELECT
    customer_id,
    total_spending
FROM customer_spending
WHERE total_spending > (
    SELECT AVG(total_spending)
    FROM customer_spending
)
ORDER BY total_spending DESC;



-- Q4 — Customer Spending Classification 🔴🔥
-- Build this in two steps using CTEs.
-- CTE 1 — customer_spending
-- Calculate:
-- - customer_id
-- - total_spending
-- CTE 2 — customer_analysis
-- Using the first CTE, calculate:
-- - customer_id
-- - total_spending
-- - spending_rank
-- - total_customers
-- Then the final query should classify customers:
-- Rank 1–2       → High Value
-- Rank 3–5       → Medium Value
-- Everyone else  → Regular

WITH customer_spending AS (
    SELECT
        c.customer_id,
        SUM(oi.quantity * oi.unit_price) AS total_spending
    FROM customers AS c
    LEFT JOIN orders AS o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items AS oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id
),

customer_analysis AS (
    SELECT
        customer_id,
        total_spending,
        RANK() OVER(
            ORDER BY total_spending DESC
        ) AS spending_rank,
        COUNT(customer_id) OVER() AS total_customers
    FROM customer_spending
)

SELECT * FROM customer_analysis;