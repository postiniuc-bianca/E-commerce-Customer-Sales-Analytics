-- 2.1 Order value distribution
-- Orders grouped by value ranges

SELECT 
	WIDTH_BUCKET (total_amount, 0, 8000, 10) AS bucket_number,
	COUNT(order_id) AS order_count,
	MIN(total_amount) AS min_amount,
	MAX(total_amount) AS max_amount
	FROM orders
GROUP BY bucket_number
ORDER BY bucket_number 


-- 2.2 Products per order distribution
-- Orders grouped by number of items purchased
  
SELECT COUNT(order_id) AS orders, total_quantity
FROM(
SELECT order_id, SUM(quantity) AS total_quantity
FROM order_items
GROUP BY order_id
ORDER BY total_quantity DESC
)
GROUP BY total_quantity
ORDER BY orders DESC


-- 2.3 Bulk-Purchase Tendency by Product Category
-- Products with average order quantity > 1.5, grouped by category
-- Identifies which categories tend to be purchased in multiple units per order
  
SELECT COUNT(pq.product_id) AS count_products, pp.category AS category
FROM(
	SELECT product_id, COUNT(order_id) AS total_order, ROUND(AVG(quantity),2) AS avg_quantity
	FROM order_items
	GROUP BY product_id) AS pq
JOIN products AS pp ON pp.product_id=pq.product_id
WHERE avg_quantity>1.5
GROUP BY pp.category
ORDER BY count_products DESC


  
-- 2.4 Orders by average product value in cart
-- Number of orders grouped by average item price within the order
  
SELECT COUNT(order_id) AS total_order,
WIDTH_BUCKET(avg_price,0,500,10) AS price_category,
MIN(avg_price) AS min_avg_price,
MAX(avg_price) AS max_avg_price
FROM (
    SELECT order_id, ROUND(AVG(item_price),2) AS avg_price
    FROM order_items
    GROUP BY order_id
) AS sub
GROUP BY price_category
ORDER BY price_category

-- 2.5 Monthly sales trend
-- Number of orders and total value per month, with month-over-month growth (%)

WITH monthly AS (
    SELECT
        DATE_TRUNC('month', order_date)::date AS order_month,
        COUNT(order_id) AS total_orders,
        SUM(total_amount) AS total_value
    FROM orders
    GROUP BY 1
),
with_previous AS (
    SELECT
        order_month,
        total_orders,
        total_value,
        LAG(total_value) OVER (ORDER BY order_month) AS previous_month_value
    FROM monthly
)
SELECT
    order_month,
    total_orders,
    total_value,
    previous_month_value,
    ROUND(100.0 * (total_value - previous_month_value)
          / NULLIF(previous_month_value, 0), 2) AS mom_growth_pct
FROM with_previous
ORDER BY order_month;
