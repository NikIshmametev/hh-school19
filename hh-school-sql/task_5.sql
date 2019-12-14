WITH vacancyReduced AS (
	SELECT vacancy_id, creation_time FROM vacancy),

responseForWeek AS (
	SELECT * FROM response T1 LEFT JOIN vacancyReduced T2 USING (vacancy_id)
 	WHERE response_time > creation_time AND AGE(response_time, creation_time) <= interval '1 week'),

responseCount AS (SELECT vacancy_id, count(response_id) from responseForWeek group by vacancy_id)

SELECT * FROM responseCount order by vacancy_id;


select count(vacancy_id) FROM responseCount;



-- select * from 
SELECT response_id, count(vacancy_id) from response group by response_id order by response_id;
SELECT vacancy_id, count(response_id) from responseForWeek group by vacancy_id order by vacancy_id Desc;
SELECT count(response_id) from responseForWeek;
responseCount AS (
	SELECT vacancy_id, COUNT(resume_id) FROM responseForWeek GROUP BY vacancy_id),

vacancyWithResponseForWeek AS (
	SELECT vacancy_id, CASE WHEN count is NULL then 0 else count end
	FROM vacancy LEFT JOIN responseCount USING (vacancy_id)),

vacancyName AS (
	SELECT vacancy_id, name FROM vacancy_body LEFT JOIN vacancy USING (vacancy_body_id))

SELECT * FROM responseCount;
SELECT * FROM vacancyWithResponseForWeek WHERE count < 5 order by vacancy_id;

-- SELECT * FROM vacancyName;

SELECT vacancy_id, name from vacancyName AS T
	WHERE T.vacancy_id IN (SELECT vacancy_id FROM vacancyWithResponseForWeek WHERE count < 5)
	order by vacancy_id;
-- 	ORDER BY name ASC;
