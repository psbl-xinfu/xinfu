SELECT 
	(
		SELECT COUNT(1) FROM cc_contract t 
		WHERE t.createdate >= ${fld:fdate} AND t.createdate <= ${fld:tdate} 
		AND t.contracttype = 0 AND t.type = 2 
		AND (f.userlogin = t.salemember OR f.userlogin = t.salemember1) 
		AND t.org_id = f.org_id AND t.status >= 2
	) as ckzongnum,
	(
		SELECT COUNT(1) FROM cc_contract t 
		WHERE t.createdate >= ${fld:fdate} AND t.createdate <= ${fld:tdate}   
		AND t.contracttype = 0 AND t.type = 2 
		AND (f.userlogin = t.salemember OR f.userlogin = t.salemember1) 
		AND t.org_id = f.org_id AND t.status >= 2
		AND t.source = '3'
	) as cknum,--场开量
	(
		SELECT COUNT(1) FROM cc_contract t 
		WHERE t.createdate::date >= (${fld:fdate} - interval '1 year') AND t.createdate::date <= (${fld:tdate} - interval '1 year')
		AND t.contracttype = 0 AND t.type = 2 
		AND (f.userlogin = t.salemember OR f.userlogin = t.salemember1) 
		AND t.org_id = f.org_id AND t.status >= 2
	) as ckyearzongnum,
	(
		SELECT COUNT(1) FROM cc_contract t 
		WHERE t.createdate::date >= (${fld:fdate} - interval '1 year') AND t.createdate::date <= (${fld:tdate} - interval '1 year')  
		AND t.contracttype = 0 AND t.type = 2 
		AND (f.userlogin = t.salemember OR f.userlogin = t.salemember1) 
		AND t.org_id = f.org_id AND t.status >= 2
		AND t.source = '3'
	) as ckyearnum,--同比量
	(
		SELECT COUNT(1) FROM cc_contract t 
		WHERE t.createdate::date >= (${fld:fdate} - interval '1 month') AND t.createdate::date <= (${fld:tdate} - interval '1 month')
		AND t.contracttype = 0 AND t.type = 2 
		AND (f.userlogin = t.salemember OR f.userlogin = t.salemember1) 
		AND t.org_id = f.org_id AND t.status >= 2
	) as ckmonthzongnum,
	(
		SELECT COUNT(1) FROM cc_contract t 
		WHERE t.createdate::date >= (${fld:fdate} - interval '1 month') AND t.createdate::date <= (${fld:tdate} - interval '1 month')  
		AND t.contracttype = 0 AND t.type = 2 
		AND (f.userlogin = t.salemember OR f.userlogin = t.salemember1) 
		AND t.org_id = f.org_id AND t.status >= 2
		AND t.source = '3'
	) as ckmonthnum--环比量
from hr_staff f
where (case when ${fld:org_id} is null then f.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else f.org_id =${fld:org_id} end)
AND EXISTS(
	SELECT 1 FROM hr_staff_skill fk 
	INNER JOIN hr_skill k ON k.skill_id = fk.skill_id 
	WHERE f.user_id = fk.user_id AND k.skill_scope IN ('1','4') 
)