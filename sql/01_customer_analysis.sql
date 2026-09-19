--1.1 Gender distribution
-- Shows how many customers fall into each gender category

SELECT 
    COUNT(user_id),
    (EXTRACT(YEAR FROM AGE(DATE '2025-11-14', signup_date)) * 12) +
    EXTRACT(MONTH FROM AGE(DATE '2025-11-14', signup_date)) AS months_since_signup
FROM customers_detail
GROUP By months_since_signup
ORDER BY months_since_signup DESC

-- 1.2 Gender distribution
-- Shows how many customers fall into each gender category
SELECT 
    gender, 
    COUNT(user_id) AS users,
    ROUND(100.0 * COUNT(user_id) / SUM(COUNT(user_id)) OVER (), 2) AS percentage
FROM customers_detail
GROUP BY gender;


-- 1.3 Revenue tier distribution
-- Customers grouped by total value brought (total_value)

SELECT 
    WIDTH_BUCKET(total_value, 0, 12000, 10) AS bucket_number,
    COUNT(*) AS customer_count,
    MIN(total_value) AS min_val,
    MAX(total_value) AS max_val
FROM customer_analytics
GROUP BY bucket_number
ORDER BY bucket_number;
 
SELECT 
    WIDTH_BUCKET(total_value, 0, 2000, 10) AS bucket_number,
    COUNT(*) AS customer_count,
    MIN(total_value) AS min_val,
    MAX(total_value) AS max_val
FROM customer_analytics
GROUP BY bucket_number
ORDER BY bucket_number;

-- 1.4 Return rate distribution
-- Customers grouped by return rate tiers (return_rate)

SELECT COUNT(user_id),
CASE
WHEN return_rate<0.1 THEN '<10%'
WHEN return_rate BETWEEN 0.11 AND 0.2 THEN '10%-20%'
WHEN return_rate BETWEEN 0.21 AND 0.3 THEN '20%-30%'
WHEN return_rate BETWEEN 0.31 AND 0.4 THEN '30%-40%'
WHEN return_rate BETWEEN 0.41 AND 0.5 THEN '40%-50%'
WHEN return_rate BETWEEN 0.51 AND 0.6 THEN '50%-60%'
WHEN return_rate BETWEEN 0.61 AND 0.7 THEN '60%-70%'
WHEN return_rate BETWEEN 0.71 AND 0.8 THEN '70%-80%'
WHEN return_rate BETWEEN 0.81 AND 0.9 THEN '80%-90%'
WHEN return_rate BETWEEN 0.91 AND 1 THEN '90%-100%'
ELSE 'error'
END AS return_rate_group
FROM customer_analytics
GROUP BY return_rate_group
ORDER BY return_rate_group



