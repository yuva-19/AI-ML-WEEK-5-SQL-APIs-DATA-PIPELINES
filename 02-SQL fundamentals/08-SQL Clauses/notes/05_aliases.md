# SQL Aliases

An alias gives a temporary name to a column or table
within a query.

Aliases do not permanently rename database objects.

## Column Alias

Example:

SELECT product_name AS product,
       price AS cost
FROM products_crud;

The result will use:

product
cost

The actual database columns remain:

product_name
price

## Table Alias

A table can also have a temporary name.

Example:

SELECT *
FROM products_crud AS p;

The alias p can then be used to reference the table:

SELECT p.product_name, p.price
FROM products_crud AS p;

## AS

AS is used to define an alias.

Example:

column_name AS alias_name

AS can technically be omitted, but using AS makes
queries easier to read.

## Important

Aliases are temporary and only apply to the query.

They do not rename the actual table or column.