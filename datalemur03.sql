--unfinished parts
SELECT t0.part
FROM parts_assembly as t0
LEFT JOIN
(SELECT part, max(assembly_step) as mx 
FROM parts_assembly
GROUP BY part) as t1
ON t0.part = t1.part
AND t0.assembly_step = t1.mx
WHERE mx is not null
AND t0.finish_date is null
ORDER BY t0.part
;
