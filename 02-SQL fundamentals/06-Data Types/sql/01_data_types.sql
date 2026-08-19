-- ============================================
-- DATA TYPES
-- BLOCK 1: NUMERIC TYPES
-- ============================================

CREATE TABLE numeric_types (
    age INT,
    population BIGINT,
    temperature FLOAT,
    price DECIMAL(10,2)
);

INSERT INTO numeric_types
(age, population, temperature, price)
VALUES
(22, 1000000000, 36.5, 999.99);

SELECT *
FROM numeric_types;

-- ============================================
-- BLOCK 2: CHARACTER TYPES
-- ============================================

CREATE TABLE character_types (
    name VARCHAR(100),
    country_code CHAR(2),
    gender_code CHAR(1)
);

INSERT INTO character_types
(name, country_code, gender_code)
VALUES
('Yuva', 'IN', 'M'),
('Arun', 'IN', 'M'),
('Priya', 'IN', 'F');

SELECT *
FROM character_types;


-- ============================================
-- BLOCK 3: BOOLEAN + DATE/TIME TYPES
-- ============================================

CREATE TABLE date_time_types (
    is_active BOOLEAN,
    birth_date DATE,
    login_time TIME,
    created_at TIMESTAMP
);

INSERT INTO date_time_types
(is_active, birth_date, login_time, created_at)
VALUES
(
    TRUE,
    '2004-05-15',
    '09:30:00',
    '2026-08-18 21:30:45'
);

SELECT *
FROM date_time_types;


-- ============================================
-- BLOCK 4: JSON
-- ============================================

CREATE TABLE json_types (
    student_id INTEGER PRIMARY KEY,
    student_data JSONB
);

INSERT INTO json_types(student_id,student_data)
VALUES
(
    1,
    '{
        "name": "Yuva",
        "department": "EEE",
        "age" : 22
    }'
);

SELECT *
FROM json_types;

SELECT student_data->>'name'
FROM json_types;

SELECT student_data->>'age'
FROM json_types;

SELECT student_data->'age'
FROM json_types;

-- (->   → JSON)
-- (->>  → text)


-- ============================================
-- BLOCK 5: ARRAYS
-- ============================================

CREATE TABLE array_types (
    student_id INTEGER PRIMARY KEY,
    name VARCHAR(100),
    skills TEXT[]
);

INSERT INTO array_types
(student_id, name, skills)
VALUES
(
    1,
    'Yuva',
    ARRAY['Python', 'SQL', 'Machine Learning']
);

SELECT *
FROM array_types;

-- output will be Python since first element is Python
SELECT  skills[1]
FROM array_types;
