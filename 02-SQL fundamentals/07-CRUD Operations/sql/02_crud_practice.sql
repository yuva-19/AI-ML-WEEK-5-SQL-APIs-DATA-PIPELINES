CREATE TABLE products_crud(
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

INSERT INTO products_crud(product_name,category,price)
VALUES
     ('Laptop','Electronics',65000),
     ('Mouse','Electronics',800),
     ('Notebook','Stationery',100),
     ('Keyboar','Electronics',1500);

SELECT * FROM products_crud
WHERE price>=1000;

UPDATE products_crud
SET price = 900
WHERE product_name ='Mouse';

DELETE FROM products_crud
WHERE product_name = 'Notebook';

SELECT * FROM products_crud;