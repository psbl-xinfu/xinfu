SELECT 
	COUNT(1) as inleftnum
FROM cc_inleft t 
WHERE t.org_id = ${def:org}
and (case when ${fld:type}='0' then t.intime::date='${def:date}'::date 
	else to_char(t.intime::date, 'yyyy-MM') = to_char('${def:date}'::date, 'yyyy-MM')
	end)
