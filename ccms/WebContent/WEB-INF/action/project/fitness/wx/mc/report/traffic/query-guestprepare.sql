SELECT 
	preparedate::date as createdate,
	count(1) as num
FROM cc_guest_prepare 
WHERE org_id = ${def:org} and status = 4
and to_char(preparedate::date, 'yyyy-MM') = to_char('${def:date}'::date, 'yyyy-MM')
group by preparedate::date order by preparedate::date asc
