# E-commerce Customer Analytics: Cohort & Retention Analysis

## Overview

This project analyzes customer behavior and purchasing patterns for a synthetic e-commerce platform using SQL. The goal is to understand who the customers are, how they shop, which products and brands drive the most value, and how well the business retains customers over time.

**Key questions explored:**

- What does the customer base look like, and how does behavior vary across segments?
- How do customers shop — order size, order value, and purchase frequency?
- Which product categories and brands generate the most value and satisfaction?
- How well does the business retain customers month over month?


## Database Structure


The database consists of 5 interconnected tables:

- **customers_detail** — customer demographic information (name, email, gender, city, signup date)
- **customer_analytics** — pre-aggregated customer metrics (order count, total value, recency, churn/cancellation rates, customer segment)
- **orders** — individual order-level transactions (order date, status, total amount)
- **order_items** — line-item detail linking orders to specific products purchased
- **products** — product catalog (category, brand, price, rating)

**Relationships:**
- One customer → one analytics record (1:1)
- One customer → many transactions (1:N)
- One transaction → many order items (1:N)
- One product → many order items (1:N)
- One order → many order items (1:N)

<img width="996" height="792" alt="image" src="https://github.com/user-attachments/assets/7d6c91bd-cb4f-46a5-aa34-142e218002f5" />

## SQL Techniques Used

- **Aggregation functions** — `COUNT`, `SUM`, `AVG` for customer and order metrics
- **JOIN operations** — `INNER JOIN` across customers, orders, order items, and products tables
- **GROUP BY / HAVING** — segmenting customers and orders by category, brand, status, and demographic attributes
- **CASE WHEN** — bucketing continuous values into readable ranges (e.g., return rate tiers, order value ranges)
- **Date functions** — `DATE_TRUNC`, `EXTRACT` for calculating customer tenure and monthly cohorts
- **Common Table Expressions (CTEs)** — structuring multi-step queries for readability
- **Window functions** — `COUNT() OVER`, `FIRST_VALUE() OVER`, `PARTITION BY` for cohort retention analysis
- **Subqueries (correlated and non-correlated)** — comparing individual values against group averages
- **DDL / schema management** — `CREATE TABLE`, `ALTER TABLE` (renaming tables/columns, adding constraints, foreign keys)

## Repository Structure


```
ecommerce-customer-analytics/
├── README.md
├── LICENSE
├── sql/
│   ├── 01_customer_analysis.sql
│   ├── 02_purchase_behavior.sql
│   ├── 03_product_brand_analysis.sql
│   └── 04_retention_funnel.sql
├── schema/
│   └── database_schema.png
└── results/
    └── (screenshots or exports of key query outputs)
```

## Key Findings
[concluziile principale, scrise pentru un cititor non-tehnic]

## ANALYSIS 1: CUSTOMER ANALYSIS


The customer base is almost evenly split across the three gender categories, 
with less than 2 percentage points separating the highest and lowest groups. 
No single gender dominates, suggesting the platform's customer base is 
broadly balanced across this demographic dimension.

<img width="435" height="150" alt="image" src="https://github.com/user-attachments/assets/ad64693b-16ac-415b-9caa-681af28dd5a8" />

<br><br>

Customer signups have remained relatively steady over the past 21 months, 
consistently ranging between 400-490 new customers per month. The oldest 
cohort (22 months since signup) is notably smaller (~200 customers), likely 
reflecting a shorter observation window at the start of the tracked period 
rather than an actual drop in acquisition. No clear growth or decline trend 
is visible — customer acquisition appears stable rather than accelerating 
or slowing over time.

<img width="1000" height="310" alt="image" src="https://github.com/user-attachments/assets/aa3ae9d7-a7d3-4c04-9ca1-f3808c2d38f0" />

<br><br>

Customer value is heavily right-skewed: over half of all customers (5,031, ~52%) 
generate under 1,200 in total value, and the count drops off sharply with each 
higher tier. Fewer than 20 customers exceed 8,400 in total value — a small but 
potentially high-priority segment for retention efforts.

<img width="380" height="280" alt="image" src="https://github.com/user-attachments/assets/0b24c579-6427-4c98-b9ef-8bdf43ac74b5" />

Zooming into the largest tier reveals it isn't uniform either — customer count 
decreases steadily from 1,316 (under 200) down to 313 (1,800-2,000), 
following the same right-skewed pattern seen at the broader level. The final 
bucket (2,079 customers, 2,000+) captures everyone above this granular range, 
consistent with the "long tail" already visible in the overview.

<img width="380" height="280" alt="image" src="https://github.com/user-attachments/assets/ade1ef8a-695b-4d42-9444-aa7b1a14fb2c" />

<br><br>

Most customers (5,282, ~53%) have a return rate under 10%, indicating low 
return behavior overall. However, the distribution is irregular rather than 
smoothly decreasing — noticeable spikes appear at 40%-50% and 90%-100%, with 
unusually low counts at 50%-60% and 70%-80% (and zero customers in the 
80%-90% range).

<img width="220" height="270" alt="image" src="https://github.com/user-attachments/assets/e189dd97-442f-45d4-bb16-c6d4f50cafd2" />

## ANALYSIS 2: PURCHASE BEHAVIOR

Order values follow the same right-skewed pattern seen in customer total 
value (Analysis 1.3): the vast majority of orders (15,199, ~76%) fall under 
800, and order count drops sharply with each higher tier. Fewer than 70 
orders across the entire dataset exceed 5,600 — high-value orders are rare 
outliers rather than a meaningful segment size.

<img width="400" height="280" alt="image" src="https://github.com/user-attachments/assets/63e724b2-5e92-4132-92b2-8b87bfdc4d91" />

<br><br>

The number of items per order follows a clear declining pattern: single-item 
orders are the most common (5,592, ~28% of all orders), and order frequency 
drops steadily as basket size increases. Orders with more than 8 items are 
rare, together accounting for less than 3% of total orders. This suggests 
most customers purchase in small, focused baskets rather than bulk-buying 
across many products at once.

<img width="200" height="330" alt="image" src="https://github.com/user-attachments/assets/952ba6a8-eef6-4316-b849-cc0a0e51d575" />

<br><br>

To identify products that are typically bought in bulk rather than as single 
units, each product's average quantity per order was calculated, then filtered 
to those exceeding 1.5 (i.e., customers order more than one unit on average). 
Pet Supplies and Clothing have the highest number of such products (46 and 45), 
suggesting these categories see more multi-unit purchasing behavior — possibly 
due to items like pet food refills or clothing bought in multiple sizes/colors. 
Automotive has the fewest (33), consistent with typically being a lower-frequency, 
single-item purchase category.

<img width="240" height="240" alt="image" src="https://github.com/user-attachments/assets/5be8181a-8564-49ba-bae6-36ecc94f1b78" />

<br><br>
For each order, the average price of the products included in it was 
calculated (not the total order value, but the average price per product). 
Orders were then grouped into 10 equal-width buckets based on this average 
value.
Unlike the previous distributions in this analysis, order count doesn't peak 
in the lowest bucket — it peaks in the second one (50-100, with 4,881 orders), 
before declining steadily as expected. The final bucket is notably wide 
(500-2,338) and captures a comparatively large number of orders (1,770), 
consistent with the same right-skewed "long tail" pattern seen throughout 
this analysis, where a small number of orders contain unusually high-value 
items.
<img width="500" height="310" alt="image" src="https://github.com/user-attachments/assets/2a2c15e0-d14c-43ef-bf2d-ccf583f90d58" />
<img width="1000" height="300" alt="image" src="https://github.com/user-attachments/assets/346e1110-6eab-4241-bcce-40b04489125a" />

<br><br>

Sales remain broadly stable over the period, with 814-956 orders and roughly
460K-587K in value per month. Month-over-month changes mostly stay within ±10%,
with a peak in July 2024 (587K) and the lowest value in February 2025 (460K).
A similar pattern appears in both years, with a rise in December followed by a
drop in January-February. Comparing January-October across the two years, 2025
shows about 4.7% lower value but only 1.8% fewer orders, meaning the average
order value decreased (from about 601 to 583).

**Note:** November 2025 contains only partial data (389 orders), so its -46.67%
drop reflects an incomplete month rather than a real decline, and it is
excluded from the comparisons above.

<img width="400" height="400" alt="image" src="https://github.com/user-attachments/assets/8106f94e-fc71-4aa2-8c6d-c1019a5813a4" />

<img width="800" height="400" alt="image" src="https://github.com/user-attachments/assets/1eedb61e-69fe-4dbe-9c99-5034cea40e28" />


## ANALYSIS 3: BRAND & PRODUCT CATEGORY ANALYSIS

Revenue is distributed fairly evenly across the 12 brands, with no single 
brand dominating the market — the gap between the highest (Willow, 1.33M) 
and lowest (NeoTech, 741K) performing brand is roughly 44%, a moderate 
spread rather than an extreme one. This suggests a competitive, well-balanced 
brand portfolio rather than reliance on one or two flagship brands.

<img width="300" height="380" alt="image" src="https://github.com/user-attachments/assets/b59ec8be-0c10-4b1d-b3b6-4694d52f29a7" />

<br><br>


Unlike the balanced distribution seen across brands, product categories show 
a sharp concentration of revenue: Electronics alone generates nearly 5M, more 
than the combined value of the bottom 7 categories together. Electronics and 
Automotive together account for roughly 60% of total revenue, while Groceries 
generates barely 1.6% of that total — a 55x difference between the top and 
bottom category. This suggests category (likely tied to typical unit price) 
is a far stronger driver of revenue than brand choice.

<img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/881243a7-e8e6-49b3-84a8-d6598abf3dd0" />

<br><br>

Drilling into Electronics, the top revenue category (Analysis 3.2), shows that
all 12 brands contribute to its 4.96M total, but less evenly than across the
platform as a whole: Willow generates about 3 times the value of Everest, and
the top three brands (Willow, Acme, Orion) account for roughly 35% of the
category. Willow leads on orders, value and average value per order, while
Pulse ranks 7th in orders but 4th in value thanks to a higher average order
value. Values include cancelled orders and represent ordered, not collected,
revenue.

<img width="400" height="370" alt="image" src="https://github.com/user-attachments/assets/09c39804-23ca-4312-9494-9b92ff6d5585" />

<br><br>

Unlike total revenue (Analysis 3.2), order counts are remarkably even across 
all categories, ranging only from 3,866 to 4,729 — less than a 22% spread, 
compared to the 55x spread seen in revenue. This confirms that Electronics 
and Automotive dominate revenue not because they're ordered more often, but 
because of significantly higher price per item. Conversely, Pet Supplies and 
Toys are ordered the most frequently, yet contribute relatively little to 
total revenue — likely lower-priced, high-frequency purchases.

<img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/4314dd5c-5136-4ac9-9e01-1e1b420f4133" />

<br><br>

Cancelled orders are fairly evenly distributed across brands, ranging from 
549 to 741 — a spread of roughly 35%, similar in scale to the total revenue 
spread seen in Analysis 3.1. Notably, Zenith has both the highest average 
rating (Analysis 3.4) and the highest number of cancelled orders, while Pulse 
has the fewest cancellations. No brand stands out as having a disproportionate 
cancellation problem relative to its overall sales volume.

<img width="300" height="340" alt="image" src="https://github.com/user-attachments/assets/fc096d69-e0d5-4bf1-8393-d143453bc5f2" />


## ANALYSIS 4: RETENTION FUNNEL

