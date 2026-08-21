-- BLOCK 1 — CONCAT

SELECT CONCAT ('Yuvanesh',' ','J');

-- CONCAT ignores the NULL value treat as empyty string
SELECT CONCAT ('Yuvanesh',' ',NULL,'J');

SELECT * FROM students;

SELECT
    CONCAT('Name: ', name ,' ','Department: ',department) AS Details
FROM students;

-- CONCAT with numbers
SELECT CONCAT('Product ID: ',101)

-- PostgreSQL has  || for concat function

SELECT 'Yuvanesh' || ' ' || 'J' AS Name;

SELECT 'Name: ' || name ||' '|| 'Department: ' || department AS Details
FROM students;


-- BLOCK 2 — SUBSTRING

-- syntax
-- SUBSTRING(text FROM start FOR length)

SELECT SUBSTRING('YUVANESH' FROM 1 FOR 4);


-- if u go beyond limit it will run til the final
SELECT SUBSTRING('YUVANESH' FROM 5 FOR 9);

SELECT * FROM students;

-- we can also use it in tabels
SELECT
     SUBSTRING(name FROM 1 FOR 4)
FROM students;

-- BLOCK 3 — LENGTH

SELECT LENGTH('Yuvanesh');

-- use it in tabels
SELECT LENGTH(name) as length_of_name
FROM students;

-- filtering
SELECT *
FROM students
WHERE LENGTH(name)<=4;

-- BLOCK 4 — REPLACE

SELECT REPLACE('Hello World','World','Yuva!');

-- NESTED METHOD
SELECT REPLACE(REPLACE('+91-98765-43210','+91',''), '-','') AS cleaned;

-- BLOCK 5 — TRIM

SELECT TRIM('   Yuvanesh J   ');

-- difference between trim and replace
-- if use replace for above it will remove all the spaces
-- so it will return as YuvaneshJ


-- we can also perform Left trim and right trim
-- and we can also remove the specific to trim
SELECT TRIM('-' FROM '---*Yuvanesh J*----');

SELECT LTRIM(    'Yuvanesh J'    );
SELECT RTRIM(    'Yuvanesh J    ');

-- BLOCK 6 — LOWER & UPPER

SELECT LOWER(TRIM('    Yuvanesh J   '));

SELECT * FROM students;

SELECT
    name,
    SUBSTRING(UPPER(name) FROM 1 FOR 3) || ' ' || department  AS ID
FROM students;

