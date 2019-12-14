-- Вывести среднюю величину предлагаемой зарплаты по каждому региону (area_id):
-- средняя нижняя граница, средняя верхняя граница и средняя средних. 
-- Нужно учесть поле compensation_gross, а также возможность отсутствия значения в обоих или 
-- одном из полей со значениями зарпаты.
SELECT 
	area_id, 
	compensation_gross,
	round(avg(compensation_from), 2) AS from,
	round(avg(compensation_to), 2) AS to,
	CASE 
	WHEN avg(compensation_from) IS NULL and avg(compensation_to) IS NOT NULL THEN round(avg(compensation_to), 2)
	WHEN avg(compensation_from) IS NOT NULL and avg(compensation_to) IS NULL THEN round(avg(compensation_from), 2)
	WHEN avg(compensation_from) IS NULL and avg(compensation_to) IS NULL THEN 0
	ELSE round((avg(compensation_from) + avg(compensation_to))/2, 2)
	END AS both
FROM vacancy_body 
GROUP BY area_id, compensation_gross
ORDER BY area_id;