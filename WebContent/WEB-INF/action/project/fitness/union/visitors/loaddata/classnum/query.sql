SELECT 
	classdate as createdate,
	count(1) as num
FROM cc_classlist 
WHERE classdate >= ${fld:fdate} AND classdate <= ${fld:tdate} 
and status=1 and classdate<='${def:date}'
and (case when ${fld:org_id} is null then org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else org_id =${fld:org_id} end)
GROUP BY classdate order by classdate asc

