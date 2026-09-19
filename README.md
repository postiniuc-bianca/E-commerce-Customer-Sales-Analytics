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
[cum sunt organizate fișierele]

## Key Findings
[concluziile principale, scrise pentru un cititor non-tehnic]

## Analiza 1

## Analiza 2

## Analiza 3 

## Cocluzii generale 
