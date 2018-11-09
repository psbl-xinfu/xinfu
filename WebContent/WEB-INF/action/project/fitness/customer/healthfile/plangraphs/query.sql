SELECT 
	plandate,
	COUNT(1) AS total_num 
FROM cc_trainplan 
WHERE 1=1 and org_id = ${def:org}
AND customercode = ${fld:vc_custcode} 
AND plandate >= (CASE WHEN ${fld:fdate} IS NULL OR ${fld:fdate} = '' THEN NULL ELSE ${fld:fdate} END)::date
GROUP BY plandate
ORDER BY plandate
