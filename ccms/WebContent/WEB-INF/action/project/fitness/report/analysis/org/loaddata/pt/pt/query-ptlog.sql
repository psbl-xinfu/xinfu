SELECT count(1) AS hknum
FROM cc_ptlog t 
WHERE t.created::date >= ${fld:fdate} AND t.created::date <= ${fld:tdate} 
AND t.org_id = ${def:org} AND t.status != 0 

