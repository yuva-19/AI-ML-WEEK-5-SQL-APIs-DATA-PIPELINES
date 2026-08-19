# CREATE

CREATE is used to create database objects such as tables.

Example:

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

CREATE TABLE defines the table structure and its columns.