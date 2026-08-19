CREATE TABLE restaurants (
    restaurant_id INTEGER PRIMARY KEY,
    restaurant_name TEXT NOT NULL,
    restaurant_location TEXT,
    restaurant_rating REAL
);

INSERT INTO restaurants(
    restaurant_id,
    restaurant_name,
    restaurant_location,
    restaurant_rating
)
VALUES
    (1,'Annapoorna','Coimbatore',4.5),
    (2,'A2B','Chennai',4.3),
    (3,'Junior Kuppana','Coimbatore',4.4);

SELECT * FROM restaurants;

-- 3. FOOD ITEMS

CREATE TABLE food_items (
    food_id INTEGER PRIMARY KEY,
    food_name TEXT NOT NULL,
    restaurant_id INTEGER NOT NULL,
    price REAL NOT NULL,
    food_rating REAL,
    FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id)
);

-- 4. INSERT FOOD ITEMS

INSERT INTO food_items (
    food_id,
    food_name,
    restaurant_id,
    price,
    food_rating
)
VALUES
    (1, 'Idli', 1, 40.00, 4.2),
    (2, 'Masala Dosa', 1, 80.00, 4.5),
    (3, 'Pongal', 1, 70.00, 4.3),
    (4, 'Veg Meals', 2, 150.00, 4.1),
    (5, 'Paneer Dosa', 2, 120.00, 4.4),
    (6, 'Chicken Biryani', 3, 220.00, 4.6),
    (7, 'Parotta', 3, 60.00, 4.2);

SELECT * FROM food_items;


-- Three is no restaurant id with 999 so it will reject
-- coz of this PRAGMA

PRAGMA foreign_keys = ON;
INSERT INTO food_items (
    food_id,
    food_name,
    restaurant_id,
    price,
    food_rating
)
VALUES
    (99, 'Test Food', 999, 100.00, 3.0);

CREATE TABLE customers(
    customer_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    city TEXT
);

-- 6. INSERT CUSTOMERS

INSERT INTO customers (
    customer_id,
    name,
    city
)
VALUES
    (1, 'Yuva', 'Trichy'),
    (2, 'Arun', 'Chennai'),
    (3, 'Ravi', 'Coimbatore'),
    (4, 'Priya', 'Madurai');

SELECT * FROM customers;

-- 7. ORDERS

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    actual_amount REAL NOT NULL,
    discount_amount REAL DEFAULT 0,
    delivery_charge REAL DEFAULT 0,
    total_amount REAL NOT NULL,
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- 8. INSERT ORDERS

INSERT INTO orders (
    order_id,
    customer_id,
    actual_amount,
    discount_amount,
    delivery_charge,
    total_amount
)
VALUES
    (101, 1, 160.00, 10.00, 20.00, 170.00),
    (102, 2, 300.00, 20.00, 30.00, 310.00),
    (103, 1, 220.00, 0.00, 20.00, 240.00),
    (104, 4, 120.00, 10.00, 15.00, 125.00);

SELECT * FROM orders;

CREATE TABLE order_items(
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER NOT NULL,
    food_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price REAL NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)

    FOREIGN KEY (food_id)
        REFERENCES food_items(food_id)    
)

-- 10. INSERT ORDER ITEMS

INSERT INTO order_items (
    order_item_id,
    order_id,
    food_id,
    quantity,
    unit_price
)
VALUES
    (1, 101, 2, 2, 80.00),
    (2, 101, 1, 1, 40.00),
    (3, 102, 6, 1, 220.00),
    (4, 102, 7, 1, 60.00),
    (5, 103, 3, 2, 70.00),
    (6, 104, 5, 1, 120.00);

SELECT * FROM order_items;

SELECT
    customers.name,
    orders.order_id,
    orders.total_amount
FROM customers
JOIN orders
    ON customers.customer_id = orders.customer_id;

SELECT
    customers.name AS customer_name,
    orders.order_id,
    restaurants.restaurant_name,
    food_items.food_name,
    order_items.quantity,
    order_items.unit_price
FROM customers
JOIN orders
    ON customers.customer_id = orders.customer_id
JOIN order_items
    ON orders.order_id = order_items.order_id
JOIN food_items
    ON order_items.food_id = food_items.food_id
JOIN restaurants
    ON food_items.restaurant_id = restaurants.restaurant_id;


-- customers
--     │
--     │ customer_id
--     ▼
-- orders
--     │
--     │ order_id
--     ▼
-- order_items
--     │
--     │ food_id
--     ▼
-- food_items
--     │
--     │ restaurant_id
--     ▼
-- restaurants
