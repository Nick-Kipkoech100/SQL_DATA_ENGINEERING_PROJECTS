# Exploratory Data Analysis with SQL : Job Market Analysis
![Project 1 Overview](../Images/1_1_Project1_EDA.png)  
  
  -  This SQL project explores a dataset of job postings collected from multiple hiring platforms, including Indeed and LinkedIn, focusing primarily on data science roles while also covering related positions in analytics and data engineering. The goal is to understand market trends, identify the most in-demand skills, analyze salary patterns, and discover optimal skill combinations for data science professionals.To turn businnes questions into data driven insights.  
  This project analyzes job posting data to identify in-demand skills, salary trends, and optimal skill combinations for data science roles. The analysis was extended to include additional queries exploring skill combinations and high-value skill sets.

---

### EXECUTIVE SUMMARY  

 - ✅  **Project Scope:** The analysis highlights the key skills sought by employers, the highest-paying skills, and the most common combinations of skills for data science roles. It provides actionable insights for professionals aiming to improve their marketability and for recruiters seeking to understand current talent requirements. By leveraging **SQL-based queries**, the project demonstrates practical data engineering and analytical capabilities with real-world hiring data.  
 - ✅ **Data Modelling:** The project utilizes **multi-table joins** and a structured job postings dataset, enabling efficient querying and aggregation using SQL.
 - ✅ **Analytics:** SQL queries were used to identify the most **in-demand skills**, the **highest-paying skills**, **optimal skills** that balance demand and salary, and **common skill combinations** in job postings.
 - ✅ **Outcomes:** The analysis highlights **key skills** that improve competitiveness in the data science job market while demonstrating **practical SQL-based data engineering** and **analytical techniques**.


  ---  
  If you only have a minute, review these:

  1. [Top Demanded Skills Query.sql](/1_EDA/01_top_demanded_skills.sql) - Demand analysis with multi-table joins  
  2. [Top Paying Skills.sql](/1_EDA/02_top_paying_skills.sql) - Salary analysis with aggregation  
  3. [Optimal Skills.sql](/1_EDA/03_optimal_skills.sql) - Combined demand/salary optimization query  
  4. [Skills in Highest Paying Jobs.sql](/1_EDA/04_skill_in_highest_paying_jobs.sql) – Uses joins and aggregations to find highest paying jobs   
  5. [Common Skill Combinations.sql](/1_EDA/05_most_common_skills_combination.sql) – Uses self-joins and grouping to identify the most frequent skill pair combinations appearing together in job postings.  

  
  
  ## 🧩 Problem And Context
  The data science job market is rapidly evolving, with employers demanding a diverse and changing set of technical skills. Aspiring data proffessionals need to know:
  - Whats skills are **most in demand** for data scientists?
  - **Highest paying skill** connected to the highest salaries?
  - **Optimal skills** to balance trade offs betwen demand and compensation.  
  
 ✅ This project analyses **data warehouse** based on star schema design. The structure of the warehouse consists of: 

 ![Data Warehouse](/Images/1_2_Data_Warehouse.png)

- **Fact table:** `job_posting_fact` - Central table containing job posting deatils (job titles, locations, salaries, dates, etc.)  
- **Dimension Tables:**  
  - `company_dim` - Company information linked to job postings
  - `Skills_dim` - Skilss catalog with skill names and types  
- **Bridge Tables:** `skills_job_dim` - Resolves the many-to-many relationship between job postings and skills  
Querying across the tables, enables extraction of insights about skills demand, salary patterns, and optimal skills combinations for data scientist roles.  

## Tech Stack  
- 🐤**Query Engine:** DuckDB for fast OLAP styled analytical querying  
- 🧮**LANGUAGE:** SQL(ANSI-style with analytical function)  
- 📊**DATA MODEL:** Star schema with fact + dimension + bridge tables  
- 🛠️**DEVELOPMENT:** VS Code for editting SQL + terminal for DuckDB CLI  
- 📦**VERSION CONTROL:** Git/Github for vesrioned SQL scripts


## Analysis Overview  
 1.[Top Demanded Skills](/1_EDA/01_top_demanded_skills.sql) - identifies top most in demand skilss for data scientists  
 2.[Top Paying Skills](/1_EDA/02_top_paying_skills.sql) - Analyze top 25 paying skillls with salary and demand metrics  
 3.[Optimal Skills](/1_EDA/03_optimal_skills.sql) - Calculates optimals scores using natural log of demand combined with median salary to identify the most valuable skills to learn.  
 4.[Skills in Highest Paying Jobs](/1_EDA/04_skill_in_highest_paying_jobs.sql) - Identifies the skills in the highest paying jobs  
 5.[Common Skills Combination](/1_EDA/05_most_common_skills_combination.sql) - Identifies the most sort after skills by employers in the job market  


### Key Insights  

- **SQL and Python are the most consistently demanded skills**, appearing across a majority of data science job postings.

- **Higher-paying roles tend to require specialized or advanced skills**, including cloud platforms and machine learning-related tools.

- **There is a strong relationship between skill combinations and employability**, with employers frequently requiring multiple complementary skills rather than a single technology.

- **Some skills offer both high demand and strong salary potential**, making them optimal targets for career development.

- **Top-paying roles typically include a broader and more advanced skill set**, indicating that depth and versatility increase earning potential.

> These insights were derived using SQL-based aggregation, joins, and analytical queries on real-world job posting data.

## SQL Skills Demostrated  

### Query Design And Optimiazation
- **Comple Joins:** Multi-table `INNER JOIN` operations across `job_postings_fact` , `skills_job_dim`  
- **Filtering:** Boolean logic with `WHERE` clauses and multiple conditions (`job_title_short`, `job_work_from_home` , `salary_year_avg IS NOT NULL`)  
- **Aggregations:** `COUNNT()`, `MEDIAN()`, `ROUND()` for statistical analysis  
- **Sorting & Limiting:** `ORDER BY` with `DESC` and `LIMIT` for top-N analysis  


### Data Analysis Techniques  
- **Grouping:** `GROUP BY` for categorical analysis by skill  
- **Conditional Logic:** `CASE WHEN` statements for derived metrics  
- **Mathematical Functions:** `LN()` for natural logarithm transformation to normalize demand metrics  
- **Calculated Metrics:** Derived optimal score combining log-transformed demand with median salary  
- **Having Clauses:** Filtering aggregated results (skills with >= 100 postings)  
- **Null Hanlding:** Proper filtering of incomplete records (`salary_year_avg IS NOT NULL`)