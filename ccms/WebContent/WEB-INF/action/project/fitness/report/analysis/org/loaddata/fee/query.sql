SELECT t.createdate::date AS createdate, t.normalmoney AS fee, 1::integer AS num
FROM cc_contract t 
WHERE t.createdate >= ${fld:fdate} AND t.createdate <= ${fld:tdate} 
AND t.type = 2 AND t.contracttype = 0 AND t.status >= 2 AND t.org_id = ${def:org} 
