SELECT CHAR_LENGTH('SQL');

SELECT LOWER('SQL');

SELECT UPPER('sql');

SELECT LEFT('SQL',2);

SELECT RIGHT('SQL', 2);

SELECT SUBSTRING('SQL', 2,1);

SELECT TRIM(' SQL');

SELECT REPLACE('SQL', 'Q', 'L');

SELECT REGEXP_REPLACe;

-- Final Example - Clean  up this using Text Function
WITH title_lower AS (
    SELECT
        job_title,
        LOWER(TRIM(job_title)) AS job_title_clean
    FROM job_postings_fact
)
SELECT
    job_title,
    CASE
    WHEN job_title LIKE '%Data%'
     AND job_title LIKE '%Analyst%' THEN 'Data Analyst'
    WHEN job_title LIKE '%Data%'
     AND job_title LIKE '%Scientist%' THEN 'Data Scientist'
    WHEN job_title LIKE '%Data%' 
     AND job_title LIKE '%Engineer%' THEN 'Data Engineer'
    ELSE 'Other'
  END AS job_title_category
FROM job_postings_fact
ORDER BY RANDOM()
LIMIT 30;

SELECT NULLIF(10,20);

SELECT
    NULLIF(salary_year_avg,0),
    NULLIF(salary_hour_avg, 0)
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
LIMIT 10;

SELECT
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg,salary_hour_avg * 2080)
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
LIMIT 10;

-- Final Example simplify with coalesce
SELECT
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg,salary_hour_avg * 2080) AS standardized_salary,
    CASE
    WHEN COALESCE(salary_year_avg,salary_hour_avg * 2080) IS NOT NULL THEN 'Missing'
    WHEN COALESCE(salary_year_avg,salary_hour_avg * 2080) < 7500 THEN 'Low'
    WHEN COALESCE(salary_year_avg,salary_hour_avg * 2080) < 150000 THEN 'Mid'
    ELSE 'High'
    END AS salary_bucket
 FROM job_postings_fact
ORDER BY standardized_salary DESC;