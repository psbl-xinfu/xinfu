SELECT 
	 t.classdate AS createdate, SUM(COALESCE(t.personcount,0)) AS num 
FROM cc_classlist t 
WHERE t.classdate >= ${fld:fdate} AND t.classdate <= ${fld:tdate} 
AND t.org_id = ${def:org} AND t.status != 0 
GROUP BY t.classdate
