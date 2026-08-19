# INSERT

INSERT is used to add records to a table.

Example:

INSERT INTO employees
(name, department, salary)
VALUES
('Yuva', 'EEE', 25000);

Multiple rows can be inserted:

INSERT INTO employees
(name, department, salary)
VALUES
('Arun', 'CSE', 30000),
('Priya', 'ECE', 28000);

When a column has an automatically generated value,
such as SERIAL PRIMARY KEY, it does not need to be
provided manually.