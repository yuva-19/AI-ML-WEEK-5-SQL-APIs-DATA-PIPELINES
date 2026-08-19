-- ============================================
-- SQL CLAUSES
-- BLOCK 1: SELECT + DISTINCT
-- ============================================

INSERT INTO products_crud(product_name,category,price)
VALUES ('Notebook','Stationery',100);


SELECT product_name, price
FROM products_crud;

SELECT category
FROM products_crud;

SELECT DISTINCT category
FROM products_crud;

-- WHERE & ORDER-BY

SELECT *
FROM products_crud
WHERE category = 'Electronics';

SELECT *
FROM products_crud
WHERE category = 'Electronics'
AND price > 1000;


SELECT *
FROM products_crud
ORDER BY price ASC;

SELECT *
FROM products_crud
ORDER BY price DESC;

SELECT product_name, price
FROM products_crud
WHERE category = 'Electronics'
ORDER BY price DESC;

-- LIMIT & OFFSET
-- LIMIT only shows the rows according to value
-- LIMIT =2 means it will only show two rows
-- OFFSET skips the rows according to the value
-- if OFFSET = 2 means it will skip first two rows

SELECT *
FROM products_crud
LIMIT 2;    

SELECT *
FROM products_crud
ORDER BY price DESC
LIMIT 2;

SELECT *
FROM products_crud
OFFSET 2;

SELECT *
FROM products_crud
LIMIT 2
OFFSET 2;

-- AS

SELECT
    product_name AS product,
    price AS cost
FROM products_crud;

SELECT *
FROM products_crud AS p;

SELECT p.product_name, p.price
FROM products_crud AS p;

-- FETCH
-- FETCH and LIMIT does the same thing

SELECT *
FROM products_crud
OFFSET 2
FETCH FIRST 2 ROWS ONLY;