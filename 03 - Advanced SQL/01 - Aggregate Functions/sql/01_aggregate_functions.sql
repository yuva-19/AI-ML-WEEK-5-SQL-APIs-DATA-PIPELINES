-- ============================================
-- ADVANCED SQL
-- AGGREGATE FUNCTIONS
-- BLOCK 1: COUNT + SUM
-- ============================================

SELECT COUNT(*) AS total_products
FROM products_crud;

SELECT SUM(price) AS total_value
FROM products_crud;

-- AVG
SELECT AVG(price) AS avg_electronics_price
FROM products_crud
WHERE category = 'Electronics';

-- MIN
SELECT MIN(price) AS lowest_electronics_price
FROM products_crud
WHERE category = 'Electronics';

-- MAX

SELECT MAX(price) AS highest_electronics_price
FROM products_crud
WHERE category = 'Electronics';

SELECT
    COUNT(*) AS total_products,
    SUM(price) AS total_value,
    AVG(price) AS average_price,
    MIN(price) AS lowest_price,
    MAX(price) AS highest_price
FROM products_crud;