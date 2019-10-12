WITH weekdays AS (
	SELECT ({ts '${def:timestamp}'} + (
		concat(
			case when extract(dow from {ts '${def:timestamp}'}) = 0 
			then (extract(dow from {ts '${def:timestamp}'}) - 6) 
			else (extract(dow from {ts '${def:timestamp}'}) - 1) end, ' day')
	)::interval)::date AS firstday
) 
SELECT COUNT(1) AS birthremindnum 
FROM cc_customer c 
WHERE c.mc = '${def:user}' 
AND c.birth IS NOT NULL AND c.birth != '' 
AND c.birthday IS NOT NULL AND c.birthday != '' 
AND (SELECT firstday FROM weekdays) <= concat(to_char({ts '${def:timestamp}'},'yyyy-'), c.birth, '-', c.birthday)::date 
AND (SELECT firstday + interval ' 7 day' FROM weekdays) >= concat(to_char({ts '${def:timestamp}'},'yyyy-'), c.birth, '-', c.birthday)::date 
