/*
Question: What are the most optimal skills for data scientists balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Scientist positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/

SELECT
    sd.skills,
    ROUND (MEDIAN(jpf.salary_year_avg), 0) As median_salary,
    COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*)))/1_000_000, 2)  AS optimal_score,
FROM job_postings_fact AS jpf 
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
    WHERE job_title_short = 'Data Scientist'
    AND jpf.job_work_from_home = TRUE
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY    sd.skills
HAVING 
    COUNT(JPF.*) > 100
ORDER BY 
   optimal_score DESC
LIMIT 25;

/*Key Insights:
* Python + SQL dominate the data science market

-They combine the highest demand and strong salaries.

* Machine learning frameworks increase salary

-Skills like PyTorch, TensorFlow, and Scikit-learn correlate with higher pay.

* Big data tools add strong value

-Spark, Hadoop, Databricks are highly valuable in large-scale systems.

* Cloud skills are increasingly required

AWS, Azure, and GCP show that data science is tightly integrated with cloud computing.

┌──────────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│    skills    │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
│   varchar    │    double     │    int64     │     double      │    double     │
├──────────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ python       │      134500.0 │         1545 │             7.3 │          0.99 │
│ sql          │      135000.0 │         1140 │             7.0 │          0.95 │
│ r            │      134500.0 │          772 │             6.6 │          0.89 │
│ aws          │      134500.0 │          423 │             6.0 │          0.81 │
│ tableau      │      135000.0 │          398 │             6.0 │          0.81 │
│ pytorch      │      149288.0 │          213 │             5.4 │           0.8 │
│ tensorflow   │      145000.0 │          241 │             5.5 │           0.8 │
│ spark        │      140000.0 │          280 │             5.6 │          0.79 │
│ azure        │      128659.0 │          310 │             5.7 │          0.74 │
│ pandas       │      139042.0 │          188 │             5.2 │          0.73 │
│ snowflake    │      146000.0 │          137 │             4.9 │          0.72 │
│ scikit-learn │      141006.0 │          150 │             5.0 │          0.71 │
│ hadoop       │      138750.0 │          162 │             5.1 │          0.71 │
│ sas          │      123000.0 │          314 │             5.7 │          0.71 │
│ scala        │      151250.0 │          102 │             4.6 │           0.7 │
│ numpy        │      141000.0 │          122 │             4.8 │          0.68 │
│ looker       │      135000.0 │          136 │             4.9 │          0.66 │
│ java         │      129750.0 │          148 │             5.0 │          0.65 │
│ databricks   │      120000.0 │          172 │             5.1 │          0.62 │
│ excel        │      121000.0 │          153 │             5.0 │          0.61 │
│ gcp          │      120000.0 │          166 │             5.1 │          0.61 │
│ power bi     │      122750.0 │          138 │             4.9 │           0.6 │
│ git          │      127390.0 │          101 │             4.6 │          0.59 │
│ jupyter      │       74744.0 │          116 │             4.8 │          0.36 │
├──────────────┴───────────────┴──────────────┴─────────────────┴───────────────┤
│ 24 rows                                                             5 columns │
*/