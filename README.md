# E-commerce Customer Analytics: Cohort & Retention Analysis

## Overview
[o scurtă descriere - de ce ai făcut acest proiect, ce întrebare de business rezolvi]

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



## Repository Structure
[cum sunt organizate fișierele]

## Key Findings
[concluziile principale, scrise pentru un cititor non-tehnic]

## Analiza 1

## Analiza 2

## Analiza 3 

## Cocluzii generale 
