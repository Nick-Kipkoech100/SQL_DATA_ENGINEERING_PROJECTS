-- Create Schema for Company Mart
DROP SCHEMA IF EXISTS company_mart CASCADE;

-- Creating Schema Company Mart
CREATE SCHEMA company_mart;

-- Step 2 Create dimensions table
CREATE TABLE company_mart.dim_company (
    company_id          INTEGER         PRIMARY KEY,
    company_name        VARCHAR

);

INSERT INTO company_mart.dim_company (company_id, company_name)
SELECT
    company_id,
    name AS company_name
FROM company_dim;

-- Job tittle short dimesnsions (distinct job_title_short values with IDS)
CREATE TABLE company_mart.dim_job_title_short (
    job_title_short_id      INTEGER     PRIMARY KEY,
    job_title_short         VARCHAR
);

INSERT INTO company_mart.dim_job_title_short (job_title_short_id, job_title_short)
WITH distinct_titles AS (
    SELECT DISTINCT job_title_short
    FROM job_postings_fact
    WHERE job_title_short IS NOT NULL
),
numbered_titles AS (
    SELECT
        t1.job_title_short,
        COUNT(t2.job_title_short) + 1 AS job_title_short_id
    FROM distinct_titles t1
    LEFT JOIN distinct_titles t2
        ON t2.job_title_short < t1.job_title_short
    GROUP BY t1.job_title_short
)
SELECT
    job_title_short_id,
    job_title_short
FROM numbered_titles
ORDER BY job_title_short;

-- Job title dimesion (distinct job_title values with IDs)
CREATE TABLE company_mart.dim_job_title (
    job_title_id        INTEGER     PRIMARY KEY,
    job_title           VARCHAR
);

INSERT INTO company_mart.dim_job_title (job_title_id, job_title)
WITH distinct_titles AS (
    SELECT DISTINCT job_title
    FROM job_postings_fact
    WHERE job_title IS NOT NULL
),
numbered_titles AS (
    SELECT
        t1.job_title,
        COUNT(t2.job_title) + 1 AS job_title_id
    FROM distinct_titles t1
    LEFT JOIN distinct_titles t2
        ON t2.job_title < t1.job_title
    GROUP BY t1.job_title
)
SELECT
    job_title_id,
    job_title
FROM numbered_titles
ORDER BY job_title;

-- 3. Location dimesnion (unique location/country combinations)
CREATE TABLE company_mart.dim_location (
    location_id         INTEGER     PRIMARY KEY,
    job_country         VARCHAR,
    job_location        VARCHAR
);

INSERT INTO company_mart.dim_location (location_id, job_country, job_location)
WITH distinct_locations AS (
    SELECT DISTINCT
        job_country,
        job_location,
    FROM job_postings_fact
    WHERE job_country IS NOT NULL
        AND job_location IS NOT NULL
),
numbered_locations AS (
    SELECT
        t1.job_country,
        t1.job_location,
        COUNT(t2.job_country) + 1 AS location_id
    FROM distinct_locations t1
    LEFT JOIN distinct_locations t2
        ON (t2.job_country < t1.job_country)
        OR (t2.job_country = t1.job_country AND t2.job_location < t1.job_location)
    GROUP BY t1.job_country, t1.job_location

)
SELECT 
    location_id,
    job_country,
    job_location
FROM numbered_locations
ORDER BY job_country, job_location;

-- 4. Month-level date dimension
CREATE TABLE company_mart.dim_date_month (
    mont_start_date     DATE    PRIMARY KEY,
    year                INTEGER,
    month               INTEGER
);

INSERT INTO company_mart.dim_date_month ( mont_start_date, year, month)
SELECT DISTINCT
    DATE_TRUNC('month', job_posted_date)::DATE AS mont_start_date,
    EXTRACT(year FROM job_posted_date) AS year,
    EXTRACT(month FROM job_posted_date) AS month
FROM job_postings_fact
WHERE job_posted_date IS NOT NULL;

-- 5. Bridge table; Company to Location (many to many)
-- Show which companies hire in which locations 
CREATE TABLE company_mart.bridge_company_location (
    company_id              INTEGER,
    location_id             INTEGER,
    PRIMARY KEY (company_id, location_id),
    FOREIGN KEY (company_id) REFERENCES company_mart.dim_company(company_id),
    FOREIGN KEY (location_id) REFERENCES company_mart.dim_location(location_id)
);

INSERT INTO company_mart.bridge_company_location (company_id, location_id)
SELECT DISTINCT 
    jpf.company_id,
    loc.location_id
FROM job_postings_fact jpf
INNER JOIN company_mart.dim_location loc
    ON jpf.job_country = loc.job_country
    AND jpf.job_location = loc.job_location
WHERE jpf.company_id IS NOT NULL;

--6. Bridge table; Job Title Short to Job Title (many to many)
-- Shows all job_title variations for each job_title_short
CREATE TABLE company_mart.bridge_job_title (
    job_title_short_id     INTEGER,
    job_title_id        INTEGER,
    PRIMARY KEY (job_title_short_id, job_title_id), 
    FOREIGN KEY (job_title_short_id) REFERENCES company_mart.dim_job_title(job_title_short_id),
    FOREIGN KEY (job_title_id) REFERENCES coma.dim_job_title(job_title_id)
);

INSERT INTO company_id.bridge_job_title (job_title_short_id, job_title_id)
SELECT DISTINCT
    djs.job_title_short_id,
    djt.job-job_title
FROM job_postings_fact jpf
INNER JOIN company_mart.dim_job_title_short djs
    ON jpf.job_title_short = djs.job_title_short
INNER JOIN company_mart.dim_job_title djt
    ON jpf.job_title = djt.job_title
WHERE jpf.job_title_short IS NOT NULL   
    AND jpf.job_title IS NOT NULL;