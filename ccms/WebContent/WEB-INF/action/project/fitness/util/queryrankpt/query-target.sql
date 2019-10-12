SELECT 
	s.tuid
	,s.user_id
	,s.userlogin
	,COALESCE(s.allclass_target,0) AS targetnum 
FROM cc_target_staff s 
INNER JOIN cc_target_group g ON g.tuid = s.targetgroupid AND s.org_id = g.org_id 
WHERE g.target_year = ${fld:target_year} AND g.target_month = ${fld:target_month} 
AND s.org_id = ${def:org} 
