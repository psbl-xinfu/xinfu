SELECT t.createdate::date AS createdate, count(1) AS num
FROM cc_contract t 
WHERE t.createdate >= ${fld:fdate} AND t.createdate <= ${fld:tdate} 
AND t.type = 2 AND t.contracttype = 0 AND t.status >= 2 AND t.org_id = ${def:org} 
AND EXISTS(
	SELECT 1 FROM cc_contract t2 
	WHERE t2.createdate >= ${fld:fdate} AND t2.createdate <= ${fld:tdate} 
	AND t2.type = 2 AND t2.contracttype = 0 AND t2.status >= 2 AND t2.org_id = ${def:org} 
	AND t2.code != t.code
)
GROUP BY t.createdate::date
