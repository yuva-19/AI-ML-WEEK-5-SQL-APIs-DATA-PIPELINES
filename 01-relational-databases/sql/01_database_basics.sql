SELECT 'Hello SQLite!' AS message;

CREATE TABLE customers (
    customer_id INTEGER,
    name TEXT,
    city TEXT
);

INSERT INTO customers (customer_id, name, city)
VALUES
    (1, 'Arun', 'Chennai'),
    (2, 'Ravi', 'Trichy'),
    (3, 'Priya', 'Coimbatore');

SELECT * FROM customers; 

INSERT INTO customers(customer_id,name,city)
VALUES
    (4,'Yuva','Trichy')

SELECT * FROM customers; 



CREATE TABLE customers_new (
    customer_id INTEGER PRIMARY KEY,
    name TEXT,
    city TEXT
);

INSERT INTO customers_new(customer_id,name,city)
SELECT customer_id,name,city
FROM customers

SELECT * FROM customers_new;

DROP TABLE customers;

ALTER TABLE customers_new
RENAME TO customers;

SELECT * FROM customers;

CREATE TABLE orders(
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    amount REAL,
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

INSERT INTO orders (order_id, customer_id, amount)
VALUES
    (101, 1, 450.00),
    (102, 2, 700.00),
    (103, 1, 250.00),
    (104, 4, 900.00);

SELECT * FROM orders;

-- Joining the customer_id

SELECT
    orders.order_id,
    customers.name,
    orders.amount
FROM orders
JOIN customers
    ON orders.customer_id = customers.customer_id;

-- insert new entity in orders

INSERT INTO orders(order_id,customer_id,amount)
VALUES(105,3,1200);

SELECT * FROM orders;

PRAGMA table_info(customers);

PRAGMA table_info(orders);

PRAGMA foreign_key_list(orders);