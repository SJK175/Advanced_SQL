--Data Science Skills
SELECT can.candidate_id
--,count(distinct skill) as cnt_skill
FROM candidates as can
WHERE UPPER(can.skill) IN ('PYTHON','TABLEAU','POSTGRESQL')
GROUP BY can.candidate_id
HAVING count(distinct skill) = 3
