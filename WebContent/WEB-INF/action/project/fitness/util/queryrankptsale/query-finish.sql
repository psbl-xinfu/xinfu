SELECT 
	c.salemember
	,(CASE WHEN c.salemember1 IS NOT NULL AND c.salemember1 != '' THEN c.normalmoney/2 ELSE c.normalmoney END) AS finishfee 
FROM cc_contract c 
WHERE c.createdate >= ${fld:fdate} AND c.createdate <= ${fld:tdate} 
AND c.contracttype = 0 AND c.type = 2 AND c.status >= 2 
AND c.org_id = ${def:org} 

UNION ALL

SELECT 
	c.salemember1 
	,c.normalmoney/2 AS finishfee 
FROM cc_contract c 
WHERE c.createdate >= ${fld:fdate} AND c.createdate <= ${fld:tdate} 
AND c.contracttype = 0 AND c.type = 2 AND c.status >= 2 
AND c.org_id = ${def:org} 
