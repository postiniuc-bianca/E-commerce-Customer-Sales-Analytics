--1.1 Gender distribution
-- Shows how many customers fall into each gender category



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


-- 1.4 Return rate distribution
-- Customers grouped by return rate tiers (return_rate)
