SELECT 
	to_char(indate,'yyyy')::integer AS year,
	to_char(indate,'MM')::integer AS month,
	COUNT(1) AS visit_num 
FROM cc_inleft 
WHERE 1=1 and org_id = ${def:org}
AND customercode = ${fld:vc_custcode} 
AND indate >= (CASE WHEN ${fld:fdate} IS NULL OR ${fld:fdate} = '' THEN NULL ELSE ${fld:fdate}||' 00:00:00' END)::timestamp
GROUP BY to_char(indate,'yyyy')::integer, to_char(indate,'MM')::integer
ORDER BY to_char(indate,'yyyy')::integer, to_char(indate,'MM')::integer
