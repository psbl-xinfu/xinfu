SELECT 
	COUNT(1) AS newcardnum
FROM cc_contract g 
WHERE g.createdate >= ${fld:fdate} AND g.createdate <= ${fld:tdate} 
AND g.contracttype = 0 AND g.type IN (0,5) 
AND g.status >= 2 AND g.org_id = ${def:org} 

