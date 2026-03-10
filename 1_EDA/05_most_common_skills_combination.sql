/*Question

Which skills most frequently appear together in Data Scientist job postings?

This Analysis shows

Skills rarely appear alone in job postings. This query identifies common skill pairs, helping reveal the typical technology stacks employers expect from data scientists.*/

SELECT
    s1.skills AS skill_1,
    s2.skills AS skill_2,
    COUNT(*) AS combination_count
FROM skills_job_dim sj1
JOIN skills_job_dim sj2 
    ON sj1.job_id = sj2.job_id
    AND sj1.skill_id < sj2.skill_id
JOIN skills_dim s1 
    ON sj1.skill_id = s1.skill_id
JOIN skills_dim s2 
    ON sj2.skill_id = s2.skill_id
JOIN job_postings_fact j
    ON sj1.job_id = j.job_id
WHERE 
    j.job_title_short = 'Data Scientist'
    AND j.job_location = 'Anywhere'
GROUP BY
    skill_1,
    skill_2
ORDER BY
    combination_count DESC
LIMIT 15;

/* 
Key Insights (Most Common Skill Combinations):

- SQL + Python is the most frequent combination, showing that strong data querying + programming skills are core requirements for data roles.

- Python appears in most combinations, reinforcing its role as the central programming language in data science.

- Python + R and SQL + R combinations indicate that statistical analysis skills are still highly valued alongside data handling.

- Cloud and big data tools (AWS, Azure, Spark) often appear with Python, highlighting the growing importance of scalable data processing.

- Machine learning libraries (TensorFlow, PyTorch, Scikit-learn) frequently pair with Python, reflecting its dominance in ML and AI development.

┌─────────┬──────────────┬───────────────────┐
│ skill_1 │   skill_2    │ combination_count │
│ varchar │   varchar    │       int64       │
├─────────┼──────────────┼───────────────────┤
│ sql     │ python       │             12688 │
│ python  │ r            │              8422 │
│ sql     │ r            │              6124 │
│ python  │ aws          │              4694 │
│ python  │ tableau      │              3913 │
│ sql     │ tableau      │              3785 │
│ python  │ pandas       │              3709 │
│ python  │ tensorflow   │              3668 │
│ python  │ azure        │              3608 │
│ python  │ spark        │              3555 │
│ sql     │ aws          │              3325 │
│ python  │ pytorch      │              3248 │
│ pytorch │ tensorflow   │              2917 │
│ python  │ sas          │              2884 │
│ python  │ scikit-learn │              2755 │
├─────────┴──────────────┴───────────────────┤
│ 15 rows                          3 columns │
└────────────────────────────────────────────┘*/