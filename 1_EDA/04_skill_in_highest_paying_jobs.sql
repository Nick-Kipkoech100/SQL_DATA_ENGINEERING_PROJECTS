/*Question

What skills are most commonly required in the highest paying remote Data Scientist jobs?*/

WITH top_paying_jobs AS (
    SELECT 
        job_id,
        salary_year_avg
    FROM job_postings_fact
    WHERE 
        job_title_short = 'Data Scientist'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT
    skills_dim.skills,
    COUNT(skills_job_dim.skill_id) AS skill_count
FROM top_paying_jobs
JOIN skills_job_dim 
    ON top_paying_jobs.job_id = skills_job_dim.job_id
JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY skills_dim.skills
ORDER BY skill_count DESC;

/*Key Insights

- Python and SQL dominate the market, making them the most important foundational skills.

- Machine learning frameworks like TensorFlow and PyTorch are associated with higher-paying roles.

- Cloud and big data tools (AWS, Azure, Spark, Hadoop) highlight the need for scalable data systems expertise.

- Top-paying jobs require diverse skill sets, combining analytics, machine learning, and infrastructure technologies.┌──────────────┬─────────────┐

│    skills    │ skill_count │
│   varchar    │    int64    │
├──────────────┼─────────────┤
│ sql          │           5 │
│ python       │           5 │
│ r            │           2 │
│ java         │           2 │
│ cassandra    │           1 │
│ aws          │           1 │
│ hadoop       │           1 │
│ datarobot    │           1 │
│ scikit-learn │           1 │
│ tensorflow   │           1 │
│ keras        │           1 │
│ azure        │           1 │
│ spark        │           1 │
│ pytorch      │           1 │
│ tableau      │           1 │
│ c++          │           1 │
├──────────────┴─────────────┤
│ 16 rows          2 columns │
└────────────────────────────┘*/