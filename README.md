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

## ANALYSIS 3: BRAND & PRODUCT CATEGORY ANALYSIS

## ANALYSIS 4: RETENTION FUNNEL

