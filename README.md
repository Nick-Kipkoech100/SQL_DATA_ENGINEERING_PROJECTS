# SQL Data Engineering Projects

A collection of SQL-based data analysis and data engineering projects focused on exploring real-world datasets, extracting insights, and demonstrating practical data skills.

---

## Projects

### 1. Exploratory Data Analysis (EDA) on Data Job Market

Analyzes job posting data to identify in-demand skills, salary trends, and optimal skill combinations for data science roles.

🔗 [EDA](./1_EDA) - Explaratory Data Analysis  

![Project 1 overview](/Images/1_1_Project1_EDA.png)

---

## Skills Demonstrated

- SQL (Joins, Aggregations, CTEs)
- Data Analysis
- Data Modeling
- Analytical Thinking 

### 2. DW & MARTS BUILD 
# 🏗️ Data Warehouse & Analytics Mart Engineering Pipeline 
[DW & MARTS BUILD](/2_DW_Mart_Build/README.md)

An end-to-end SQL data engineering project that transforms raw operational CSV datasets 
into a structured analytical ecosystem using dimensional modeling, ETL pipelines, and 
specialized analytical data marts. 
[DW ARCHITECTURE & PIPELINES](/Images/1_2_Project2_Data_Pipeline.png)

## What This Project Does

Raw job posting CSV datasets are extracted from Google Cloud Storage, transformed into 
a centralized star schema data warehouse, and optimized into four analytical marts 
designed for business intelligence and reporting.

## Tech Stack
DuckDB · SQL · Star Schema · Git & GitHub · Google Cloud Storage

## Analytical Marts Built
- **Flat Mart** — denormalized structure for fast ad-hoc querying
- **Skills Mart** — time-series skill demand trend analysis
- **Priority Mart** — incremental updates using MERGE/upsert patterns
- **Company Mart** — company-level hiring intelligence and location trends

## 📖 Full Project Documentation
For architecture diagrams, pipeline details, SQL file breakdown, and skills demonstrated, 
see the [detailed README](2_DW_Mart_Build/README.md).