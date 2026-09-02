-- 1 - Total No. of trips
SELECT COUNT(*) AS total_trips
FROM taxi_trips;

-- 2 — Total Revenue & Average Trip Value
SELECT
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS average_trip_value
FROM taxi_trips;

-- 3 — Trips & Revenue by Payment Type
SELECT
    payment_type,
    COUNT(*) AS total_trips,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS average_trip_value
FROM taxi_trips
GROUP BY payment_type
ORDER BY total_trips DESC;

--4 — Trips & Revenue by Passenger Count
SELECT
    passenger_count,
    COUNT(*) AS total_trips,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS average_trip_value
FROM taxi_trips
GROUP BY passenger_count
ORDER BY passenger_count;


-- 5 — Vendor Performance
SELECT
    "VendorID",
    COUNT(*) AS total_trips,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS average_trip_value
FROM taxi_trips
GROUP BY "VendorID"
ORDER BY total_trips DESC;

-- 6 — Rate Code Distribution
SELECT
    "RatecodeID",
    COUNT(*) AS total_trips,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS average_trip_value
FROM taxi_trips
GROUP BY "RatecodeID"
ORDER BY total_trips DESC;

-- 7 - Average Trip Metrics by Payment Type

SELECT
    payment_type,
    COUNT(*) AS total_trips,
    ROUND(AVG(fare_amount)::numeric, 2) AS avg_fare,
    ROUND(AVG(trip_distance)::numeric, 2) AS avg_distance,
    ROUND(AVG(trip_duration)::numeric, 2) AS avg_duration,
    ROUND(AVG(total_amount)::numeric, 2) AS avg_total
FROM taxi_trips
GROUP BY payment_type
ORDER BY total_trips DESC;

-- 8 - Tip Analysis by Payment Type

SELECT
    payment_type,
    COUNT(*) AS total_trips,
    ROUND(SUM(tip_amount)::numeric, 2) AS total_tips,
    ROUND(AVG(tip_amount)::numeric, 2) AS avg_tip
FROM taxi_trips
GROUP BY payment_type
ORDER BY total_tips DESC;

-- 9 - Most Expensive Trips

SELECT
    fare_amount,
    trip_distance,
    trip_duration,
    total_amount,
    payment_type
FROM taxi_trips
ORDER BY total_amount DESC
LIMIT 10;

-- 10 - Trip Distance Categories

SELECT
    CASE
        WHEN trip_distance < 2 THEN 'Short (<2 miles)'
        WHEN trip_distance < 5 THEN 'Medium (2-5 miles)'
        WHEN trip_distance < 10 THEN 'Long (5-10 miles)'
        ELSE 'Very Long (10+ miles)'
    END AS distance_category,
    COUNT(*) AS total_trips,
    ROUND(AVG(total_amount)::numeric, 2) AS avg_trip_value,
    ROUND(SUM(total_amount)::numeric, 2) AS total_revenue
FROM taxi_trips
GROUP BY distance_category
ORDER BY total_trips DESC;

-- 11 - Trip Duration Categories

SELECT
    CASE
        WHEN trip_duration < 10 THEN 'Short (<10 min)'
        WHEN trip_duration < 20 THEN 'Medium (10-20 min)'
        WHEN trip_duration < 40 THEN 'Long (20-40 min)'
        ELSE 'Very Long (40+ min)'
    END AS duration_category,
    COUNT(*) AS total_trips,
    ROUND(AVG(total_amount)::numeric, 2) AS avg_trip_value,
    ROUND(SUM(total_amount)::numeric, 2) AS total_revenue
FROM taxi_trips
GROUP BY duration_category
ORDER BY total_trips DESC;


-- 12 - Revenue & Trip Metrics by Vendor

SELECT
    "VendorID",
    COUNT(*) AS total_trips,
    ROUND(SUM(total_amount)::numeric, 2) AS total_revenue,
    ROUND(AVG(total_amount)::numeric, 2) AS avg_trip_value,
    ROUND(AVG(trip_distance)::numeric, 2) AS avg_distance,
    ROUND(AVG(trip_duration)::numeric, 2) AS avg_duration
FROM taxi_trips
GROUP BY "VendorID"
ORDER BY total_revenue DESC;

-- 13 - Revenue & Trip Metrics by Rate Code

SELECT
    "RatecodeID",
    COUNT(*) AS total_trips,
    ROUND(SUM(total_amount)::numeric, 2) AS total_revenue,
    ROUND(AVG(total_amount)::numeric, 2) AS avg_trip_value,
    ROUND(AVG(trip_distance)::numeric, 2) AS avg_distance,
    ROUND(AVG(trip_duration)::numeric, 2) AS avg_duration
FROM taxi_trips
GROUP BY "RatecodeID"
ORDER BY total_trips DESC;

-- 14 - Store and Forward Flag Analysis

SELECT
    store_and_fwd_flag,
    COUNT(*) AS total_trips,
    ROUND(AVG(total_amount)::numeric, 2) AS avg_trip_value,
    ROUND(AVG(trip_distance)::numeric, 2) AS avg_distance,
    ROUND(AVG(trip_duration)::numeric, 2) AS avg_duration
FROM taxi_trips
GROUP BY store_and_fwd_flag
ORDER BY total_trips DESC;


-- 15 - Revenue per Mile

SELECT
    CASE
        WHEN trip_distance < 2 THEN 'Short (<2 miles)'
        WHEN trip_distance < 5 THEN 'Medium (2-5 miles)'
        WHEN trip_distance < 10 THEN 'Long (5-10 miles)'
        ELSE 'Very Long (10+ miles)'
    END AS distance_category,
    COUNT(*) AS total_trips,
    ROUND(
        (SUM(total_amount) / NULLIF(SUM(trip_distance), 0))::numeric,
        2
    ) AS revenue_per_mile
FROM taxi_trips
GROUP BY distance_category
ORDER BY revenue_per_mile DESC;

-- 16 - Revenue per Minute

SELECT
    CASE
        WHEN trip_duration < 10 THEN 'Short (<10 min)'
        WHEN trip_duration < 20 THEN 'Medium (10-20 min)'
        WHEN trip_duration < 40 THEN 'Long (20-40 min)'
        ELSE 'Very Long (40+ min)'
    END AS duration_category,
    COUNT(*) AS total_trips,
    ROUND(
        (SUM(total_amount) / NULLIF(SUM(trip_duration), 0))::numeric,
        2
    ) AS revenue_per_minute
FROM taxi_trips
GROUP BY duration_category
ORDER BY revenue_per_minute DESC;





