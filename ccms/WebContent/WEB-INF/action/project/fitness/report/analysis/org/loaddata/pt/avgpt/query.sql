SELECT t.created::date AS createdate, count(1) AS num
FROM cc_ptlog t 
WHERE t.created::date >= ${fld:fdate} AND t.created::date <= ${fld:tdate} 
AND t.org_id = ${def:org} AND t.status != 0 
GROUP BY t.created::date
