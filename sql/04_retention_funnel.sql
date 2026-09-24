-- 4.1 Monthly cohort retention
-- Customers grouped by signup month; percentage who kept ordering every month
-- without a break (unbroken chain), using CTEs, window functions and a pivot

-- Note: orders placed before signup_date are excluded (data quality issue)

WITH monthly_activity AS (
    SELECT DISTINCT
        cd.user_id,
        DATE_TRUNC('month', cd.signup_date)::date AS cohort_month,
        (EXTRACT(YEAR FROM o.order_date) - EXTRACT(YEAR FROM cd.signup_date)) * 12
      + (EXTRACT(MONTH FROM o.order_date) - EXTRACT(MONTH FROM cd.signup_date)) AS month_number
    FROM customers_detail AS cd
    JOIN orders AS o ON o.user_id = cd.user_id
    WHERE o.order_date >= cd.signup_date
),
continuity AS (
    SELECT
        user_id,
        cohort_month,
        month_number,
        COUNT(*) OVER (
            PARTITION BY user_id
            ORDER BY month_number
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS active_months_so_far
    FROM monthly_activity
),
retained AS (
    SELECT
        cohort_month,
        month_number,
        COUNT(DISTINCT user_id) AS retained_customers
    FROM continuity
    WHERE active_months_so_far = month_number + 1
    GROUP BY cohort_month, month_number

),
retention_pct AS (
    SELECT
        cohort_month,
        month_number,
        retained_customers,
        ROUND(
            100.0 * retained_customers /
            FIRST_VALUE(retained_customers) OVER (
                PARTITION BY cohort_month
                ORDER BY month_number
            ),
        2) AS retention_rate_pct
    FROM retained
)
SELECT
    cohort_month,
    MAX(CASE WHEN month_number = 0 THEN retained_customers END) AS cohort_size,
    MAX(CASE WHEN month_number = 0 THEN retention_rate_pct END) AS month_0,
    MAX(CASE WHEN month_number = 1 THEN retention_rate_pct END) AS month_1,
    MAX(CASE WHEN month_number = 2 THEN retention_rate_pct END) AS month_2,
    MAX(CASE WHEN month_number = 3 THEN retention_rate_pct END) AS month_3,
    MAX(CASE WHEN month_number = 4 THEN retention_rate_pct END) AS month_4,
    MAX(CASE WHEN month_number = 5 THEN retention_rate_pct END) AS month_5
FROM retention_pct
GROUP BY cohort_month
ORDER BY cohort_month;
