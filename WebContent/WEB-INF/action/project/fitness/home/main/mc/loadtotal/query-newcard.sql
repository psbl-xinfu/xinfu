SELECT COUNT(1) AS newcardnum 
FROM cc_contract t 
WHERE t.createdate = {d '${def:date}'} AND t.org_id = ${def:org} 
AND (t.salemember = '${def:user}' OR t.salemember1 = '${def:user}') 
AND t.contracttype != 3 AND t.status >= 2 
