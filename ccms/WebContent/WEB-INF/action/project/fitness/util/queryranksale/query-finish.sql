SELECT 
	c.salemember
	,(CASE WHEN c.salemember1 IS NOT NULL AND c.salemember1 != '' THEN c.normalmoney/2 ELSE c.normalmoney END) AS finishfee 
FROM cc_contract c 
WHERE c.createdate >= ${fld:fdate} AND c.createdate <= ${fld:tdate} 
AND c.status >= 2 and (c.contracttype in (1, 2, 9, 11) or c.type in (0, 2, 5, 7, 10))
AND c.org_id = ${def:org} 

UNION ALL

SELECT 
	c.salemember1 
	,c.normalmoney/2 AS finishfee 
FROM cc_contract c 
WHERE c.createdate >= ${fld:fdate} AND c.createdate <= ${fld:tdate} 
AND c.status >= 2 and (c.contracttype in (1, 2, 9, 11) or c.type in (0, 2, 5, 7, 10)) 
AND c.org_id = ${def:org} 
