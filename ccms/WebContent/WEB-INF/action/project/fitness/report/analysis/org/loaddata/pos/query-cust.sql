SELECT createdate::date AS createdate, t.code, t.customercode, t.org_id 
FROM cc_contract t 
WHERE t.createdate >= ${fld:fdate} AND t.createdate <= ${fld:tdate} 
AND t.type = 2 AND t.contracttype = 0 AND t.status >= 2 AND t.org_id = ${def:org} 

