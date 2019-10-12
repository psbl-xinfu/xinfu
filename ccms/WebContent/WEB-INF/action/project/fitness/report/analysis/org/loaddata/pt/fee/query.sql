SELECT 
	t.createdate::date AS createdate, t.factmoney AS fee, 
	(select pttotalcount::integer from cc_ptrest where contractcode = t.code and org_id = t.org_id) AS num
FROM cc_contract t 
WHERE t.createdate >= ${fld:fdate} AND t.createdate <= ${fld:tdate} 
AND t.type = 2 AND t.contracttype = 0 AND t.status >= 2 AND t.org_id = ${def:org} 
