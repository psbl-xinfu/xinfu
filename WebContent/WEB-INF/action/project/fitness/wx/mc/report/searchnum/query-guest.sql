SELECT 
	COUNT(1) AS guestnum 
FROM cc_guest 
WHERE org_id = ${def:org} AND status != 0 
and to_char(created::date, 'yyyy-MM') = to_char('${def:date}'::date, 'yyyy-MM')


