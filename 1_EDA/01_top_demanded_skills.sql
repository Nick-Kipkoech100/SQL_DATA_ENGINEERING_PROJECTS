/*What are the most in-demand skills for data scientist?
identify top 10 in-demand skills for data scientist
Focus on remote jobs*/,
SELECT
    sd.skills,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf 
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
    WHERE job_title_short = 'Data Scientist'
    AND jpf.job_work_from_home = TRUE
GROUP BY    sd.skills
ORDER BY 
    demand_count DESC
LIMIT 10;

/*
Overview

The table shows the top technical skills most frequently required in data scientist job postings.

Key Skills

*Python and SQL lead the list, highlighting their importance for data analysis, manipulation, and database querying.

*R remains important for statistical analysis.

*Cloud platforms like AWS and Azure show the growing need for scalable data infrastructure.

*Tools such as Pandas, Spark, and TensorFlow reflect the demand for data processing and machine learning.

*Tableau indicates the importance of data visualization and communicating insights.

Conclusion

The results show that modern data scientists need a mix of programming, database, cloud, and visualization skills to effectively analyze and communicate data insights.
┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ python     │        20669 │
│ sql        │        14676 │
│ r          │         8873 │
│ aws        │         5715 │
│ tableau    │         4784 │
│ azure      │         4336 │
│ spark      │         4042 │
│ pandas     │         3982 │
│ tensorflow │         3905 │
│ sas        │         3560 │
├────────────┴──────────────┤
│ 10 rows         2 columns │
*/

