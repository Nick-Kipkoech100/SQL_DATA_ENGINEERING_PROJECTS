SELECT UNNEST([1, 1, 1, 2])
UNION 
SELECT UNNEST([1, 1, 3]);

SELECT UNNEST([1, 1, 1, 2])
UNION ALL
SELECT UNNEST([1, 1, 3]);

SELECT UNNEST([1, 1, 1, 2])
INTERSECT
SELECT UNNEST([1, 1, 3]);

SELECT UNNEST([1, 1, 1, 2])
INTERSECT ALL
SELECT UNNEST([1, 1, 3]);

SELECT UNNEST([1, 1, 1, 2])
EXCEPT
SELECT UNNEST([1, 1, 3]);

SELECT UNNEST([1, 1, 1, 2])
EXCEPT ALL
SELECT UNNEST([1, 1, 3]);

-- Final APPLICATION example with data jobs postibgs
CREATE TEMP TABLE IF NOT EXISTS jobs_2023 AS
SELECT * EXCLUDE (job_id, job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2023;

SELECT * FROM jobs_2023;

CREATE TEMP TABLE IF NOT EXISTS jobs_2024 AS
SELECT * EXCLUDE (job_id, job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2024;

SELECT * FROM jobs_2024;


-- Which Unique job postings appeared in  2023 or 2024?
SELECT
    'jobs_2023' AS table_name,
    COUNT(*) AS record_count
FROM jobs_2023
UNION
SELECT 
    'jobs_2024' AS table_name,
    COUNT(*) 
FROM jobs_2024;

SELECT * FROM jobs_2023
UNION ALL
SELECT * FROM jobs_2024;

-- Which job postings appearded in 2023 but not in 2024?
SELECT * FROM jobs_2023
EXCEPT
SELECT * FROM jobs_2024;

-- Which job poatings from 2023 remain after subtracting matching from 2024 postings, one-for-one?
SELECT * FROM jobs_2023
EXCEPT ALL
SELECT * FROM jobs_2024;

-- Which job postings appeared in both 2023 and 2023?
SELECT * FROM jobs_2023
INTERSECT
SELECT * FROM jobs_2024;

-- Which job postings appeared in both years,preserving duplicate counts?
SELECT * FROM jobs_2023
INTERSECT ALL
SELECT * FROM jobs_2024;