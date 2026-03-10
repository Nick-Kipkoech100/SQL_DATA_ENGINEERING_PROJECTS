/*What are the highest paying skills for data scientist?
- Calculate the median salary for each skill required in data scientist position
- Focus on remote positions with specified salaries
- Include skills frequency yo identify both salary and demand
- Why? Helps identify which skills are, providing a more complete picture for skills development priority
  how common those skills are, providing a more complete picture for skills deelopment priorities
  */

SELECT
    sd.skills,
    ROUND (MEDIAN(jpf.salary_year_avg), 0) As median_salary,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf 
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
    WHERE job_title_short = 'Data Scientist'
    AND jpf.job_work_from_home = TRUE
GROUP BY    sd.skills
HAVING 
    COUNT(JPF.*) > 100
ORDER BY 
   median_salary DESC
LIMIT 25;

/*Key Findings from the Salary and Skills Data

- The table shows the skills associated with the highest median salaries in data-related roles along with how often they appear in job postings.

- Atlassian-related tools appear with the highest median salary, suggesting professionals working in well-structured tech environments tend to earn more.

- Several cloud and infrastructure technologies such as Amazon DynamoDB, Redis, and Terraform are among the top-paying skills, indicating strong demand for scalable data systems.

- Programming languages like Go, C, and Scala also command high salaries due to their use in high-performance data processing.

- Machine learning frameworks such as PyTorch and TensorFlow remain valuable, reflecting the importance of AI and advanced analytics.

Overall insight:
High-paying data roles often combine infrastructure, programming, and machine learning expertise, showing that companies value professionals who can build and scale data systems while also applying advanced analytics.
    skills    │ median_salary │ demand_count │
│   varchar    │    double     │    int64     │
├──────────────┼───────────────┼──────────────┤
│ atlassian    │      217500.0 │          133 │
│ slack        │      175000.0 │          148 │
│ dynamodb     │      174500.0 │          106 │
│ neo4j        │      165000.0 │          146 │
│ c            │      163500.0 │          654 │
│ go           │      163500.0 │         1261 │
│ redis        │      162500.0 │          127 │
│ gdpr         │      162500.0 │          271 │
│ zoom         │      161250.0 │          150 │
│ terraform    │      160500.0 │          230 │
│ hugging face │      160500.0 │          213 │
│ opencv       │      160000.0 │          214 │
│ sheets       │      152500.0 │          150 │
│ scala        │      151250.0 │         1280 │
│ airflow      │      150000.0 │         1009 │
│ php          │      150000.0 │          109 │
│ flow         │      150000.0 │          847 │
│ bigquery     │      150000.0 │          841 │
│ pytorch      │      149288.0 │         3546 │
│ kubernetes   │      149000.0 │          849 │
│ redshift     │      146000.0 │          893 │
│ snowflake    │      146000.0 │         1520 │
│ jira         │      145250.0 │          577 │
│ tensorflow   │      145000.0 │         3905 │
│ matplotlib   │      145000.0 │         1249 │
├──────────────┴───────────────┴──────────────┤
│ 25 rows                           3 columns │
└─────────────────────────────────────────────*/