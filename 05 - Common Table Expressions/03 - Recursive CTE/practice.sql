-- ============================================
-- RECURSIVE CTE PRACTICE DATABASE SETUP
-- ============================================

DROP TABLE IF EXISTS category_hierarchy;

CREATE TABLE category_hierarchy (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100),
    parent_category_id INT
);
INSERT INTO category_hierarchy
(category_id, category_name, parent_category_id)
VALUES
(1, 'Electronics', NULL),

(2, 'Computers', 1),
(3, 'Phones', 1),
(4, 'Accessories', 1),

(5, 'Laptops', 2),
(6, 'Desktops', 2),

(7, 'Smartphones', 3),
(8, 'Feature Phones', 3),

(9, 'Headphones', 4),
(10, 'Chargers', 4);

SELECT * FROM category_hierarchy;


-- If parent_category_id belongs to c → you're looking for CHILDREN.
-- If parent_category_id belongs to ct → you're looking for the PARENT.


-- Q1 — Category Tree 🟡
-- Using category_hierarchy, create a recursive CTE that returns:
-- category_id
-- category_name
-- parent_category_id
-- category_level
-- Root category should be level 1.
-- Sort the result so the hierarchy is easy to inspect.

WITH RECURSIVE category_tree AS(
    -- Anchor
    SELECT
         category_id,
         category_name,
         parent_category_id,
         1 AS category_level
    FROM category_hierarchy
    WHERE parent_category_id IS NULL

    UNION ALL

    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        ct.category_level + 1
    FROM category_hierarchy AS c
    JOIN category_tree AS ct
        ON c.parent_category_id = ct.category_id
         
)

SELECT * FROM category_tree;


-- Q3 — Find Descendants 🔥🔥
-- Starting from:
-- category_id = 2
-- which is Computers.
-- Use a recursive CTE to find Computers and everything underneath it.
-- Return:
-- category_id
-- category_name
-- parent_category_id
-- category_level
-- category_path


WITH RECURSIVE category_tree AS(
    -- Anchor
    SELECT
         category_id,
         category_name,
         parent_category_id,
         1 AS category_level,
         category_name::TEXT AS category_path
    FROM category_hierarchy
    WHERE category_id = 2

    UNION ALL

    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        ct.category_level + 1,
        ct.category_path || ' > ' || c.category_name
    FROM category_hierarchy AS c
    JOIN category_tree AS ct
        ON c.parent_category_id = ct.category_id
         
)

SELECT * FROM category_tree;


-- Q4 — 🔥🔥🔥 Find the Full Ancestry
-- Starting from:
-- category_id = 5
-- which is Laptops.
-- Use a recursive CTE to travel upward through the parents and return:
-- category_id
-- category_name
-- parent_category_id
-- hierarchy_level

WITH RECURSIVE category_tree AS(

    SELECT
        category_id,
        category_name,
        parent_category_id,
        1 AS hierarchy_level,
        category_name::TEXT AS category_path
    FROM category_hierarchy
    WHERE category_id = 5

    UNION ALL

    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        ct.hierarchy_level + 1,
        ct.category_path || ' > ' || c.category_name
    FROM category_hierarchy AS c
    JOIN category_tree AS ct 
         ON c.category_id = ct.parent_category_id
)

SELECT * FROM category_tree;


-- Q2 — Category Path 🟠
-- Build:
-- category_id
-- category_name
-- category_level
-- category_path
-- Example:
-- Electronics > Computers > Laptops

SELECT * FROM category_hierarchy;

WITH RECURSIVE category_tree AS(
    SELECT
        category_id,
        category_name,
        parent_category_id,
        1 AS category_level,
        category_name:: TEXT AS category_path
    FROM category_hierarchy
    WHERE parent_category_id IS NULL

    UNION ALL

    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        ct.category_level + 1,
        ct.category_path || '>' || c.category_name
    FROM category_hierarchy AS c 
    JOIN category_tree AS ct 
        ON c.parent_category_id = ct.category_id
)

SELECT * FROM category_tree;