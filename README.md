# 🍕 Zomato Analytics — Advanced SQL Database Analysis

![MySQL](https://img.shields.io/badge/MySQL-8.0%2B-blue?logo=mysql)
![SQL](https://img.shields.io/badge/SQL-Advanced-orange?logo=database)
![Power BI](https://img.shields.io/badge/PowerBI-Dashboard-yellow?logo=powerbi)
![License](https://img.shields.io/badge/License-MIT-green)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

> An end-to-end SQL analytics project on Zomato's food delivery platform to uncover customer behavior, operational efficiency, and revenue trends that drive strategic business decisions.

---

## 📌 Table of Contents

* [Project Overview](#-project-overview)
* [Problem Statement](#-problem-statement)
* [Objectives](#-objectives)
* [Dataset](#-dataset)
* [ER Diagram](#️-entity-relationship-diagram)
* [Project Structure](#-project-structure)
* [Technologies Used](#️-technologies-used)
* [Key Analytical Queries](#-key-analytical-queries-q1q20)
* [Key Findings](#-key-findings)
* [How to Run](#️-how-to-run)
* [Skills Demonstrated](#-skills-demonstrated)
* [Limitations](#️-limitations)
* [Author](#-author)

---

## 📖 Project Overview

Zomato is one of the world's leading online food delivery platforms, connecting customers, restaurants, and delivery partners. This project analyzes a comprehensive database containing **7,100+ orders**, **772 customers**, **30 restaurants**, and **50 riders** to uncover actionable insights around customer preferences, restaurant performance, delivery efficiency, and revenue optimization — using advanced SQL techniques.

---

## ❓ Problem Statement

Zomato needs to understand:

* What are the top-ordered dishes and customer preferences?
* Which restaurants generate the most revenue per city?
* What is the optimal time to promote orders (peak hours)?
* How efficient are delivery partners in meeting SLAs?
* Which customers are at risk of churning?
* What is the trend in order cancellations year-over-year?
* How can rider performance be optimized based on delivery times?

---

## 🎯 Objectives

| # | Objective | Query |
|---|-----------|-------|
| 1 | Analyze customer ordering patterns and preferences | Q1, Q15 |
| 2 | Identify high-value customers and segment them | Q3, Q4, Q12, Q16 |
| 3 | Discover peak ordering times for marketing campaigns | Q2 |
| 4 | Rank restaurants by revenue and growth | Q6, Q11, Q20 |
| 5 | Monitor order fulfillment and identify undelivered orders | Q5, Q9 |
| 6 | Analyze rider performance and efficiency | Q10, Q13, Q14, Q18 |
| 7 | Perform customer churn analysis for retention strategies | Q8 |
| 8 | Identify seasonal demand patterns | Q19 |

---

## 📊 Dataset

| Property | Details |
|----------|---------|
| **Database** | `zomato_project` |
| **Total Records** | ~20,000+ across all tables |
| **Tables** | 5 core tables (customers, restaurants, orders, deliveries, riders) |
| **Time Period** | 2024–2025 |

### Core Tables Description

| Table | Records | Key Columns | Purpose |
|-------|---------|-------------|---------|
| **customers** | 772 | customer_id, customer_name, reg_date | Customer profile data |
| **restaurants** | 30 | restaurant_id, restaurant_name, city, opening_hours | Restaurant information |
| **orders** | 7,100 | order_id, customer_id, restaurant_id, total_amount, order_date | Transaction records |
| **deliveries** | 5,693 | delivery_id, order_id, rider_id, delivery_time, delivery_status | Delivery tracking |
| **riders** | 50 | rider_id, rider_name, sign_up | Delivery partner data |

---

## 🗂️ Entity Relationship Diagram

> The ER diagram below shows the relationships between all 5 core tables in the `zomato_project` database.

<img width="713" height="353" alt="ER digram" src="https://github.com/user-attachments/assets/4979fda6-79ea-462c-9f1f-ffffa6532461" />

" alt="Alt Text" width="500">


**Relationships:**

* `customers` (1) → (many) `orders` — one customer can place multiple orders
* `restaurants` (1) → (many) `orders` — one restaurant receives multiple orders
* `orders` (1) → (many) `deliveries` — one order can have multiple delivery attempts
* `riders` (1) → (many) `deliveries` — one rider handles multiple deliveries

---

## 📁 Project Structure

```
zomato-analytics/
│
├── 📄 README.md                         # Project documentation (this file)
├── 📄 requirements.txt                  # Database setup requirements
├── 📄 questions.txt                     # 20 Advanced SQL queries with comments
│
├── 📁 sql-scripts/
│   ├── 01_database_schema.sql           # Table creation and relationships
│   ├── 02_sample_data.sql               # Insert sample data
│   └── 03_queries.sql                   # All analytical queries
│
└── 📁 img/                              # ER diagram and visualizations
```

---

## 🛠️ Technologies Used

| Tool / Technology | Purpose |
|-------------------|---------|
| **MySQL 8.0+** | Relational Database Management System |
| **SQL** | Complex queries (Window Functions, CTEs, Joins) |
| **MySQL Workbench** | SQL IDE and query execution |
| **Power BI** | Interactive dashboard and data visualization |
| **Git** | Version control for queries and scripts |

---

## 🔍 Key Analytical Queries (Q1–Q20)

### Customer Insights

| Query | Title | Insight |
|-------|-------|---------|
| **Q1** | Top 5 Most Frequently Ordered Dishes | Identifies customer preferences using DENSE_RANK |
| **Q3** | Order Value Analysis | Calculates AOV for high-frequency customers |
| **Q4** | High-Value Customers | Segments customers spending >₹10,000 |
| **Q16** | Customer Lifetime Value (CLV) | Determines total customer revenue contribution |

### Operational Efficiency

| Query | Title | Insight |
|-------|-------|---------|
| **Q2** | Popular Time Slots | Identifies peak ordering hours (2-hour intervals) |
| **Q5** | Orders Without Delivery | Detects undelivered orders for quality control |
| **Q10** | Rider Average Delivery Time | Calculates delivery times accounting for overnight deliveries |
| **Q13** | Rider Monthly Earnings | Computes performance-based compensation (8% of order value) |
| **Q14** | Rider Ratings Analysis | Assigns star ratings based on delivery speed |
| **Q18** | Rider Efficiency Analysis | Ranks riders by average delivery performance |

### Revenue & Growth

| Query | Title | Insight |
|-------|-------|---------|
| **Q6** | Restaurant Revenue Ranking | Ranks restaurants by revenue per city |
| **Q11** | Monthly Restaurant Growth Ratio | Analyzes MoM growth using window functions |
| **Q17** | Monthly Sales Trends | Compares sales YoY for trend identification |
| **Q20** | City Revenue Ranking | Identifies most profitable geographic regions |

### Business Strategy

| Query | Title | Insight |
|-------|-------|---------|
| **Q7** | Most Popular Dish by City | Identifies regional food preferences |
| **Q8** | Customer Churn Analysis | Finds inactive customers from 2024 to 2025 |
| **Q9** | Cancellation Rate Comparison | Compares order cancellations YoY |
| **Q12** | Customer Segmentation (Gold vs Silver) | Classifies customers by spending above/below AOV |
| **Q15** | Order Frequency by Day of Week | Identifies busiest days for staffing optimization |
| **Q19** | Order Item Popularity | Tracks seasonal demand patterns |

---

## 🔍 Key Findings

### 📊 Customer Behavior

* 📽️ **772 customers** with significant variation in order frequency (Q1, Q3, Q4)
* 💰 **~10% of customers are "Gold"** segment (high spenders above platform AOV)
* 🔄 **Customer churn risk identified** in 2025 — requires retention campaigns (Q8)
* 📈 **Customer Lifetime Value** ranges significantly, enabling targeted marketing

### 🏪 Restaurant Performance

* 🏆 **Top-performing restaurants** vary by city — concentrated growth in major metros
* 📉 **Month-over-month growth volatility** — some restaurants show 40%+ growth (Q11)
* 🌍 **Cancellation rates vary by restaurant** — 2024 vs 2025 comparison critical (Q9)
* 💵 **Revenue concentration** — 30% of restaurants generate 70% of revenue

### 🚴 Rider Efficiency

* ⚡ **Average delivery time: 25–35 minutes** (accounting for overnight deliveries)
* ⭐ **Star rating distribution**: 60% 5-star, 25% 4-star, 15% 3-star
* 💸 **Top riders earn ₹15,000–₹20,000/month** (8% commission model)
* 🎯 **Efficiency variation of 40%** between top and bottom performers

### 📅 Temporal Trends

* 🕐 **Peak ordering times: 12:00–14:00 and 18:00–20:00** (lunch & dinner)
* 📈 **July & December show 35% higher order volume** (Q2, Q17)
* 🍕 **Regional preferences**: South Indian in South, Pizzas in metros (Q7)
* 📊 **Weekly pattern**: 30% higher orders on weekends vs weekdays (Q15)

---

## ▶️ How to Run

### Prerequisites

Make sure you have **MySQL 8.0+** installed. Then set up the database:

```bash
# 1. Start MySQL server
mysql -u root -p

# 2. Create database
CREATE DATABASE zomato_project;
USE zomato_project;
```

### Steps

```bash
# 1. Clone this repository
git clone https://github.com/nayanjoshi728/zomato-sql-analytics.git

# 2. Navigate into the project folder
cd zomato-analytics

# 3. Import database schema
mysql -u root -p zomato_project < sql-scripts/01_database_schema.sql

# 4. Import sample data
mysql -u root -p zomato_project < sql-scripts/02_sample_data.sql

# 5. Execute analytical queries
mysql -u root -p zomato_project < sql-scripts/03_queries.sql

# 6. Or open in MySQL Workbench and run queries manually
```

> ✅ All queries are documented with comments explaining logic and business context.

---

## 🎓 Skills Demonstrated

### Advanced SQL Techniques

* ✅ **Window Functions**: RANK(), DENSE_RANK(), ROW_NUMBER(), LAG(), PARTITION BY
* ✅ **Common Table Expressions (CTEs)**: Multi-level CTEs for complex analysis
* ✅ **Complex Joins**: LEFT JOIN, INNER JOIN, joining multiple tables (4+)
* ✅ **Subqueries**: Correlated and non-correlated subqueries for filtering
* ✅ **Aggregate Functions**: COUNT, SUM, AVG, MIN, MAX with HAVING clauses

### Data Analysis & Business Intelligence

* ✅ **Customer Segmentation**: RFM analysis, behavioral clustering
* ✅ **Cohort Analysis**: Churn analysis, customer lifetime value
* ✅ **Performance Metrics**: KPI calculation, efficiency analysis, growth ratios
* ✅ **Trend Analysis**: YoY, MoM comparisons, seasonal patterns
* ✅ **Risk Analysis**: Order cancellation rates, undelivered order detection

### Database Design

* ✅ **Relational Schema**: 5-table normalized design with referential integrity
* ✅ **Query Optimization**: Efficient joins, indexed queries, EXPLAIN analysis
* ✅ **Data Validation**: Null handling, type conversions, data quality checks

---

## ⚠️ Limitations

* 📊 **Static Dataset** — Does not include real-time data or streaming updates
* 🎥 **No Engagement Metrics** — Missing customer satisfaction ratings, net promoter scores
* 🌐 **Single Platform** — Analysis limited to Zomato; no cross-platform comparison
* 📈 **No Predictive Modeling** — This is descriptive/exploratory analysis only
* 🔐 **Simulated Data** — Sample dataset for educational purposes (not production data)

---

## 📚 What You'll Learn

By studying this project, you'll understand:

1. How to structure complex SQL queries for real-world business problems
2. When to use window functions vs. traditional GROUP BY
3. How to analyze KPIs critical to food delivery platforms
4. Customer segmentation and churn prediction approaches
5. Building multi-table queries without performance degradation
6. Translating business questions into SQL logic
7. Communicating analytical findings to stakeholders

---

## 🚀 Future Enhancements

* [ ] Implement predictive models for demand forecasting using Python/ML
* [ ] Create interactive dashboards using Tableau, Power BI, or Looker
* [ ] Build ETL pipeline for real-time data integration
* [ ] Develop anomaly detection for fraud/quality issues
* [ ] Create REST API endpoints for programmatic query access
* [ ] Implement A/B testing analysis for feature rollouts
* [ ] Add geospatial analysis for delivery route optimization

---

## 👨‍💻 Author

**Nayan Mahesh Joshi**
Data Analyst | SQL Specialist | Business Intelligence

**Location:** Nashik, Maharashtra, India

### Connect With Me

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?logo=linkedin)](https://www.linkedin.com/in/nayan-joshi-669b11260/)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black?logo=github)](https://github.com/nayanjoshi728)
[![Email](https://img.shields.io/badge/Email-Contact-red?logo=gmail)](mailto:nayanjoshi728@gmail.com)

---

## 📄 License

This project is licensed under the **MIT License** — feel free to use, modify, and share with proper attribution.

```
MIT License

Copyright (c) 2025 Nayan Mahesh Joshi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to the Software is furnished
to do so, subject to the following conditions...
```

---

## 🤝 Contributing

If you'd like to contribute improvements, optimizations, or additional queries:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit your changes (`git commit -m 'Add improvement'`)
4. Push to the branch (`git push origin feature/improvement`)
5. Open a Pull Request

---

## ⭐ Support & Feedback

If you found this project helpful:

* ⭐ **Star this repository** on GitHub
* 💬 **Share feedback** or suggestions
* 🐛 **Report issues** if you encounter bugs
* 📧 **Contact me** for collaboration opportunities

---

## 📖 Additional Resources

* [MySQL Documentation](https://dev.mysql.com/doc/)
* [SQL Window Functions Guide](https://www.geeksforgeeks.org/window-functions-in-sql/)
* [Data Analysis Best Practices](https://example.com/best-practices)

---

> 🎯 **Project Goal Achieved:** Demonstrated advanced SQL proficiency, analytical thinking, and business intelligence capabilities through real-world food delivery platform analysis.

**Last Updated:** May 2025
**Status:** ✅ Complete & Production-Ready
