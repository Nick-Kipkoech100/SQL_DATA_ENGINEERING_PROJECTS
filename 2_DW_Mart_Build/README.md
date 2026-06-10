# 🏗️ Data Warehouse & Analytics Mart Engineering Pipeline

An end-to-end SQL data engineering and analytics engineering project that transforms raw operational CSV datasets into a structured analytical ecosystem using dimensional modeling, ETL pipelines, and specialized analytical data marts.  
  
![Pipeline Architecture](../Images/1_2_Project2_Data_Pipeline.png)

This project simulates a real-world modern data workflow where raw source data is ingested from cloud storage, transformed into a centralized star schema warehouse, and optimized into analytical marts designed for business intelligence, reporting, and scalable decision-making.

Rather than focusing only on data movement alone, this project emphasizes the analytical purpose behind warehouse systems:

* transforming fragmented operational data into reliable analytical assets
* enabling scalable business intelligence workflows
* optimizing analytical queries through dimensional modeling
* creating reusable datasets for downstream analytics and reporting

---

# 🧾 Executive Summary (For Hiring Managers)

✅ Built a complete ETL pipeline from raw CSV datasets into a dimensional data warehouse and analytical marts

✅ Designed a star schema architecture using fact, dimension, and bridge tables for scalable analytical querying

✅ Implemented production-style SQL transformation workflows with idempotent loading patterns and data validation practices

✅ Developed specialized analytical marts optimized for:

* ad-hoc analysis
* trend analysis
* skill demand reporting
* hiring intelligence
* incremental update workflows

✅ Applied modern warehouse engineering and analytics engineering concepts including:

* dimensional modeling
* surrogate keys
* additive measures
* many-to-many relationship handling
* incremental update patterns
* analytical aggregation design

---

# 🧩 Problem & Context

Raw datasets are commonly stored in flat CSV files that are not optimized for analytical workloads. While these files may contain valuable operational information, directly querying them becomes inefficient, inconsistent, and difficult to scale as analytical requirements grow.

Analysts and stakeholders need to answer business questions such as:

* Which skills are most in demand over time?
* What hiring patterns emerge across companies and locations?
* How do salary trends vary across job roles and skill combinations?
* Which business segments are driving the highest activity?
* How can reporting queries be optimized for performance and consistency?

However, relying directly on raw datasets introduces several challenges:

* duplicated or inconsistent records
* complex joins and repeated transformations
* slow analytical queries
* poor scalability
* lack of centralized business logic
* inconsistent reporting outputs

To solve this, this project implements a warehouse-oriented ETL architecture that transforms raw source data into a centralized analytical system.

The solution includes:

* extraction of CSV datasets from Google Cloud Storage
* staging and transformation pipelines
* dimensional warehouse modeling using fact and dimension tables
* bridge tables for many-to-many relationships
* specialized analytical marts optimized for reporting and trend analysis

The final architecture provides a scalable single source of truth capable of supporting business intelligence workflows, analytical reporting, and future dashboarding or machine learning applications.

---

# 🧰 Tech Stack

| Category                | Technology              |
| ----------------------- | ----------------------- |
| Database                | DuckDB                  |
| Language                | SQL                     |
| Data Modeling           | Star Schema             |
| Development Environment | VS Code + DuckDB CLI    |
| Version Control         | Git + GitHub            |
| Cloud Storage           | Google Cloud Storage    |
| Pipeline Orchestration  | Master SQL Build Script |

---

# 📂 Repository Structure

```text
2_DW_Mart_Build/
├── 01_create_tables_dw.sql
├── 02_load_schema_dw.sql
├── 03_create_flat_mart.sql
├── 04_create_skills_mart.sql
├── 05_create_priority_mart.sql
├── 06_update_priority_mart.sql
├── 07_create_company_mart.sql
├── build_dw_marts.sql
└── README.md
```

---

# 🏗️ Pipeline Architecture  
![Pipeline Architecture](../Images/1_2_Project2_Data_Pipeline.png)  

The pipeline transforms raw job posting CSV datasets from Google Cloud Storage into a normalized dimensional warehouse before building specialized analytical marts for downstream analytics consumption.

The architecture follows a layered analytical workflow:

1. Raw Data Ingestion
2. Staging & Transformation
3. Dimensional Warehouse Modeling
4. Analytical Mart Construction
5. Downstream BI & Reporting Consumption

The resulting warehouse and marts can support tools such as:

* Power BI
* Tableau
* Excel
* Python analytics workflows

---

# 🏢 Data Warehouse Layer  
![Data Warehouse](../Images/1_2_Data_Warehouse.png)

The warehouse implements a dimensional star schema architecture designed to support scalable analytical queries while separating measurable business events from descriptive dimensions.

### Core Tables

### Fact Table

* `job_postings_fact`

### Dimension Tables

* `company_dim`
* `skills_dim`

### Bridge Tables

* `skills_job_dim`

### Purpose

Acts as the centralized analytical source of truth for downstream reporting and business intelligence workflows.

### Grain

One row per job posting in the fact table.

### SQL Files

* [`01_create_tables_dw.sql`](/2_DW_Mart_Build/01_create_tables_dw.sql)
* [`02_load_schema_dw.sql`](/2_DW_Mart_Build/02_load_schema_dw.sql)

---

# 📊 Flat Mart

A denormalized analytical mart designed for simplified ad-hoc querying and rapid business analysis.
![Flat Mart](../Images/1_2_Flat_Mart.png) 


### Purpose

Provides analysts with a simplified structure where dimensions are pre-joined for faster exploratory analysis.

### Grain

One row per job posting with all dimensions joined.

### SQL File

*[ `03_create_flat_mart.sql`](/2_DW_Mart_Build/03_create_flat_mart.sql)

---

# 📈 Skills Mart

A time-series analytical mart focused on measuring skill demand trends across job postings.
![Skills Mart](../Images/1_2_Skills_Mart.png) 

### Purpose

Supports longitudinal trend analysis and demand forecasting for technical skills.

### Grain

`skill_id + month_start_date + job_title_short`

### Key Features

* additive measures
* time-series aggregation
* trend-oriented dimensional analysis
* safe re-aggregation patterns

### SQL File

* [`04_create_skills_mart.sql`](/2_DW_Mart_Build/04_create_skills_mart.sql)

---

# 🚀 Priority Mart

An analytical mart focused on tracking priority job roles using incremental warehouse update patterns.  
![Priority Mart](../Images/1_2_Priority_Mart.png) 

### Purpose

Supports operational monitoring and priority role tracking with production-style update workflows.

### Grain

One row per job posting with assigned priority classifications.

### Key Features

* incremental updates using MERGE
* INSERT / UPDATE / DELETE workflows
* upsert pattern implementation
* production-style warehouse maintenance

### SQL Files

* [`05_create_priority_mart.sql`](/2_DW_Mart_Build/05_create_priority_mart.sql)
* [`06_update_priority_mart.sql`](/2_DW_Mart_Build/06_update_priority_mart.sql)

---

# 🏢 Company Mart 

An analytical mart designed to evaluate hiring trends across companies, locations, and job categories. 
![Priority Mart](../Images/1_2_Company_Mart.png)

### Purpose

Supports organizational hiring intelligence and trend-based workforce analysis.

### Grain

`company_id + job_title_short_id + location_id + month_start_date`

### Key Features

* company-level trend analysis
* location intelligence
* bridge table relationships
* hierarchical dimensional modeling
* surrogate key generation

### SQL File

* [`07_create_company_mart.sql`](/2_DW_Mart_Build/07_company_mart.sql)

---

# 💻 Data Engineering & Analytics Skills Demonstrated

## ETL Pipeline Engineering

* Extracting CSV data directly from Google Cloud Storage
* Transformation and normalization workflows
* Data validation and quality checks
* Idempotent loading patterns
* Pipeline orchestration using master SQL scripts
* Incremental warehouse update strategies

## Dimensional Modeling

* Star schema design
* Fact and dimension separation
* Many-to-many relationship modeling
* Bridge table implementation
* Grain definition and analytical consistency
* Additive measure design for scalable aggregation

## Advanced SQL Engineering

* DDL and DML operations
* CTE-driven transformations
* MERGE operations for upserts
* Temporal modeling with date functions
* Aggregation pipelines
* String manipulation and boolean logic
* Analytical query optimization patterns

## Analytics Engineering Thinking

* Designing data structures for downstream BI consumption
* Pre-aggregating data for analytical efficiency
* Optimizing reporting workflows
* Building reusable analytical datasets
* Creating centralized business logic through dimensional modeling
* Structuring marts around analytical use cases rather than raw storage

---

# 🔍 Key Analytical Focus

This project was designed not only as a warehouse engineering exercise, but also as a demonstration of analytical system design.

The primary focus was understanding how raw operational datasets are transformed into business-ready analytical assets capable of supporting:

* executive reporting
* hiring trend analysis
* skill demand analytics
* ad-hoc querying
* dashboarding workflows
* scalable business intelligence systems

The project reflects principles commonly used in modern analytics engineering and data platform development workflows.

---

