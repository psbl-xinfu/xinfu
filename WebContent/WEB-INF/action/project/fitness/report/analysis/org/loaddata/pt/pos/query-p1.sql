select createdate,customercode,org_id
FROM cc_contract  
WHERE createdate >= ${fld:fdate} AND createdate <= ${fld:tdate} 
AND contracttype = 0 AND type = 2 
AND org_id = ${def:org} AND status >= 2