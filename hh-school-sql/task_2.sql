-- 10000 вакансий, 100000 резюме и 50000 откликов
INSERT INTO vacancy_body(
    company_name, name, text, area_id, address_id, work_experience, 
    compensation_from, test_solution_required,
    work_schedule_type, employment_type, compensation_gross
)
SELECT 
    (SELECT string_agg(
        substr('      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
			(random() * 77)::integer + 1, 1), '') 
    FROM generate_series(1, 1 + (random() * 30 + i % 10)::integer)) AS company_name,

    (SELECT string_agg(
        substr('      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
			   (random() * 77)::integer + 1, 1), '') 
    FROM generate_series(1, 1 + (random() * 25 + i % 10)::integer)) AS name,

    (SELECT string_agg(
        substr('      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
			   (random() * 77)::integer + 1, 1), '') 
    FROM generate_series(1, 1 + (random() * 50 + i % 10)::integer)) AS text,

    (random() * 100)::int AS area_id,
    (random() * 50000)::int AS address_id,
    (random() * 10)::int AS work_experience,
    25000 + (random() * 150000)::int AS compensation_from,
    (random() > 0.5) AS test_solution_required,
    floor(random() * 4)::int AS work_schedule_type,
    floor(random() * 4)::int AS employment_type,
    (random() > 0.5) AS compensation_gross
FROM generate_series(1, 10000) AS g(i);

UPDATE vacancy_body SET compensation_to = compensation_from + (random() * 150000)::int;

INSERT INTO vacancy (creation_time, expire_time, employer_id, active, visible, area_id)
SELECT
    -- random in last 5 years
    now()-120 * 24 * 3600*(1+random()) * '1 second'::interval AS creation_time,
    now()-120 * 24 * 3600 *(random()) * '1 second'::interval AS expire_time,
    (random() * 1000)::int AS employer_id,
    (random() > 0.5) AS active,
    (random() > 0.5) AS visible,
    (random() * 100)::int AS area_id
FROM generate_series(1, 10000) AS g(i);

INSERT INTO resume (creation_time, last_change_time, person_id, active, visible, title, init_id, old_title)
SELECT
    -- random in last 5 years
    now()-120 * 24 * 3600*(1+random()) * '1 second'::interval AS creation_time,
    now()-120 * 24 * 3600*(1+random()) * '1 second'::interval AS last_change_time,
    (random() * 100000)::int AS person_id,
    (random() > 0.5) AS active,
    (random() > 0.5) AS visible,
	(SELECT string_agg(
		substr('      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
			   (random() * 77)::integer + 1, 1), '') 
    FROM generate_series(1, 1 + (random() * 50 + i % 10)::integer)) AS title,
    (random() * 100000)::int AS init_id,
	(SELECT string_agg(
		substr('      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
			   (random() * 77)::integer + 1, 1), '') 
    FROM generate_series(1, 1 + (random() * 50 + i % 10)::integer)) AS old_title
FROM generate_series(1, 100000) AS g(i);


INSERT INTO response (response_time, vacancy_id, resume_id)
SELECT
    now()-120 * 24 * 3600*(1+random()) * '1 second'::interval AS response_time,
    (random() * 10000)::int AS vacancy_id,
    (random() * 100000)::int AS resume_id
FROM generate_series(1, 50000) AS g(i);

