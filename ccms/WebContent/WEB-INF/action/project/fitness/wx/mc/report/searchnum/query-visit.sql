SELECT 
	COUNT(1) AS visitnum 
FROM cc_guest_visit t 
WHERE t.org_id = ${def:org} AND t.status != 0 
and (case when ${fld:type}='0' then t.visitdate::date='${def:date}'::date 
	else to_char(t.visitdate::date, 'yyyy-MM') = to_char('${def:date}'::date, 'yyyy-MM')
	end)


