SELECT SUM(t.pttotalcount::integer) AS num 
FROM cc_ptrest t 
WHERE t.created::date >= ${fld:fdate} AND t.created::date <= ${fld:tdate} 
AND t.pttype != 5 AND t.org_id = ${def:org} 

