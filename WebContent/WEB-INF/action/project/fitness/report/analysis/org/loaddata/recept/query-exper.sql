SELECT g.created::date AS createdate, g.code, g.customercode, g.org_id 
FROM cc_ptlog g 
INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
WHERE g.created >= concat(${fld:fdate}::varchar,' 00:00:00')::timestamp 
AND g.created <= concat(${fld:tdate}::varchar,' 00:00:00')::timestamp 
AND p.pttype = 5 AND g.org_id = ${def:org} 
