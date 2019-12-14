WITH resumeMonthly AS (
	SELECT DATE_TRUNC('month', creation_time) AS date, COUNT(resume_id) AS count FROM resume
	GROUP BY DATE_TRUNC('month', creation_time)
),
vacancyMonthly AS (
	SELECT DATE_TRUNC('month', creation_time) AS date, COUNT(vacancy_id) AS count FROM vacancy
	GROUP BY DATE_TRUNC('month', creation_time)
)

SELECT 'Resume' AS Table, * FROM resumeMonthly WHERE count = (SELECT MAX(count) FROM resumeMonthly)
UNION
SELECT 'Vacancy' AS Table, * FROM vacancyMonthly WHERE count = (SELECT MAX(count) FROM vacancyMonthly)

