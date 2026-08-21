CREATE TABLE set_customers_a (
    customer_id INT,
    customer_name VARCHAR(100)
);

CREATE TABLE set_customers_b (
    customer_id INT,
    customer_name VARCHAR(100)
);

INSERT INTO set_customers_a (customer_id, customer_name)
VALUES
    (1, 'Yuva'),
    (2, 'Arun'),
    (3, 'Priya'),
    (4, 'Karthik');

INSERT INTO set_customers_b (customer_id, customer_name)
VALUES
    (3, 'Priya'),
    (4, 'Karthik'),
    (5, 'Rahul'),
    (6, 'Vijay');

-- Priya and Karthik are duplicates here

-- UNION Removes the duplicates
SELECT customer_name
FROM set_customers_a

UNION

SELECT customer_name
FROM set_customers_b;

-- UNION ALL does not remove duplicates and it usually faster than UNION
SELECT customer_name
FROM set_customers_a

UNION ALL

SELECT customer_name
FROM set_customers_b;

-- INTERSECT returns only rows that exist in both query results.
SELECT customer_name
FROM set_customers_a

INTERSECT

SELECT customer_name
FROM set_customers_b;

-- EXCEPT returns rows from the first query that don't exist in the second query.
SELECT customer_name
FROM set_customers_a

EXCEPT

SELECT customer_name
FROM set_customers_b;




-- SCALAR SUBQUERIES
-- A subquery is simply a query inside another query.

CREATE TABLE subquery_products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

INSERT INTO subquery_products (product_name, price)
VALUES
    ('Laptop', 65000),
    ('Mouse', 900),
    ('Keyboard', 1500),
    ('Monitor', 12000);

SELECT AVG(price)
FROM subquery_products;

SELECT
    product_name,
    price
FROM subquery_products
WHERE price >(
    SELECT AVG(price)
    FROM subquery_products
);

-- MULTI-ROW SUBQUERIES
-- A multi-row subquery returns more than one row.

SELECT
    product_name,
    price
FROM subquery_products
WHERE price IN (
    SELECT price
    FROM subquery_products
    WHERE price >= 1500
);


-- Multi-row subquery with another table
CREATE TABLE subquery_categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50)
);

INSERT INTO subquery_categories (category_name)
VALUES
    ('Electronics'),
    ('Stationery'),
    ('Furniture');

ALTER TABLE subquery_products
ADD COLUMN category VARCHAR(50);

UPDATE subquery_products
SET category = 'Electronics'
WHERE product_name IN ('Laptop', 'Mouse', 'Keyboard', 'Monitor');

CREATE TABLE preferred_categories (
    category_name VARCHAR(50)
);

INSERT INTO preferred_categories
VALUES
    ('Electronics'),
    ('Furniture');

SELECT
    product_name,
    category
FROM subquery_products
WHERE category IN (
    SELECT category_name
    FROM preferred_categories
);


-- ANY compares a value against each value returned by the subquery.
-- it can also use mulitple values
SELECT * FROM subquery_products

-- now subquery will return 900
-- so now again price will be compared
-- price >(900)
-- it can also have price > (900,1000,1500)
-- even if one get trues ryt
-- any(TRUE,TRUE,FALSE)-->TRUE so value will be returned


SELECT
    product_name,
    price
FROM subquery_products
WHERE price > ANY (
    SELECT price
    FROM subquery_products
    WHERE price < 1500
);

-- FOR ALL everything needed to be satisfied
-- all(TRUE,TRUE,FALSE)-->FALSE so value will be returned

SELECT
    product_name,
    price
FROM subquery_products
WHERE price > ALL (
    SELECT price
    FROM subquery_products
    WHERE price < 1500
);



-- MULTI-COLUMN SUBQUERIES
CREATE TABLE subquery_product_targets (
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);
INSERT INTO subquery_product_targets
    (product_name, category, price)
VALUES
    ('Laptop', 'Electronics', 65000),
    ('Mouse', 'Electronics', 900);

SELECT
     product_name,
     category,
     price
FROM subquery_products
WHERE(product_name,category,price) IN (
    SELECT
        product_name,
        category,
        price
        FROM subquery_product_targets
);

-- CORRELATED SUBQUIERY
CREATE TABLE correlated_products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

INSERT INTO correlated_products
    (product_name, category, price)
VALUES
    ('Laptop', 'Electronics', 65000),
    ('Mouse', 'Electronics', 900),
    ('Keyboard', 'Electronics', 1500),
    ('Monitor', 'Electronics', 12000),
    ('Notebook', 'Stationery', 100),
    ('Pen', 'Stationery', 50),
    ('Chair', 'Furniture', 5000),
    ('Table', 'Furniture', 8000);

-- suppose
-- Find products whose price is greater than the average price of their own category.

-- the subquery will find average price of each category
SELECT
p.product_name,
p.category,
p.price
FROM correlated_products as p
WHERE p.price > (
    SELECT AVG(p2.price)
    FROM correlated_products as p2
    WHERE p2.category = p.category --("Only calculate the average for the same category as the current outer product.)
);

-- returning average of each category
SELECT
    p.product_name,
    p.category,
    p.price,
    (
        SELECT AVG(p2.price)
        FROM correlated_products AS p2
        WHERE p2.category = p.category
    ) AS category_average
FROM correlated_products AS p;

