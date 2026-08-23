-- Q3 — Customer Revenue Segmentation 🔥🔥🔥
-- Build three CTEs.

-- CTE 1 — customer_spending
-- Calculate:
-- - customer_id
-- - total_spending

-- CTE 2 — customer_ranking
-- Using the first CTE, calculate:
-- - customer_id
-- - total_spending
-- - spending_rank
-- - cumulative_spending
-- Rank customers from highest spending to lowest.
-- cumulative_spending should represent the total spending accumulated from 
-- the highest-spending customer down to the current customer.

-- CTE 3 — customer_segment
-- Using the second CTE, calculate:
-- - customer_id
-- - total_spending
-- - spending_rank
-- - cumulative_spending
-- - customer_segment

-- Classification:
-- spending_rank <= 2  → High Value
-- spending_rank <= 5  → Medium Value
-- otherwise            → Regular
-- Return the final result ordered by spending_rank.


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

customer_ranking AS (
    SELECT
        customer_id,
        total_spending,
        RANK() OVER(
            ORDER BY total_spending DESC
        ) AS spending_rank,
        SUM(total_spending) OVER(
            ORDER BY total_spending DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumulative_spending
    FROM customer_spending
),

customer_segment AS (
    SELECT
        customer_id,
        total_spending,
        spending_rank,
        cumulative_spending,
        (CASE
            WHEN spending_rank<=2 THEN 'High Value'
            WHEN spending_rank<=5 THEN 'Medium Value'
            ELSE 'Regular'
            END) AS customer_segment
    FROM customer_ranking
    ORDER BY total_spending DESC
)

SELECT * FROM customer_segment;


-- Q4 — 🔥🔥🔥 Customer Revenue Contribution Pipeline
-- This is the challenge.
-- Build three CTEs.

-- CTE 1 — customer_revenue
-- Calculate each customer's:
-- - customer_id
-- - customer_name
-- - total_revenue

-- CTE 2 — revenue_analysis
-- Using CTE 1, calculate:
-- - customer_id
-- - customer_name
-- - total_revenue
-- - revenue_rank
-- - overall_revenue
-- - revenue_percentage
-- - cumulative_revenue_percentage
-- Where:
-- revenue_percentage
-- = customer's revenue / overall revenue × 100
-- and
-- cumulative_revenue_percentage
-- = cumulative revenue / overall revenue × 100

-- CTE 3 — customer_segment
-- Classify customers based on cumulative revenue:
-- cumulative_revenue_percentage <= 50
--     → Top Revenue Contributors

-- cumulative_revenue_percentage <= 80
--     → Core Customers

-- otherwise
--     → Long Tail
-- Final output:
-- - customer_id
-- - customer_name
-- - total_revenue
-- - revenue_rank
-- - revenue_percentage
-- - cumulative_revenue_percentage
-- - customer_segment
-- Sort by revenue_rank.


WITH customer_revenue AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM customers AS c
    LEFT JOIN orders AS o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items AS oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id
),

revenue_analysis AS (
    SELECT
        customer_id,
        customer_name,
        total_revenue,
        RANK() OVER(
            ORDER BY total_revenue DESC
        ) AS revenue_rank,
        SUM(total_revenue) OVER() AS overall_revenue,
        (total_revenue * 100 /SUM(total_revenue) OVER()) AS revenue_percentage,
        (SUM(total_revenue) OVER(
            ORDER BY total_revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        )*100/SUM(total_revenue) OVER()) AS cumulative_revenue_percentage
    FROM customer_revenue
),

customer_segment AS(
    SELECT
        customer_id,
        customer_name,
        total_revenue,
        revenue_rank,
        overall_revenue,
        revenue_percentage,
        cumulative_revenue_percentage,
        (CASE
            WHEN cumulative_revenue_percentage<=50 THEN 'Top Revenue Contributors'
            WHEN cumulative_revenue_percentage<=80 THEN 'Core Customers'
            ELSE 'Long Tail'
            END) AS customer_segment
    FROM revenue_analysis
    ORDER BY total_revenue DESC
)


SELECT * FROM customer_segment;






