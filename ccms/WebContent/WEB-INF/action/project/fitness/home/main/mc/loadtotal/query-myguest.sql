SELECT COUNT(1) AS myguestnum  
FROM cc_guest g 
WHERE g.mc = '${def:user}' AND g.org_id = ${def:org} 
AND g.status != 0 AND g.status != 99 
