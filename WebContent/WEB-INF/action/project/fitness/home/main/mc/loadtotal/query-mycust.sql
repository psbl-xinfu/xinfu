SELECT COUNT(1) AS mycustnum  
FROM cc_customer g 
WHERE g.mc = '${def:user}' AND g.org_id = ${def:org} 
AND g.status != 0 
