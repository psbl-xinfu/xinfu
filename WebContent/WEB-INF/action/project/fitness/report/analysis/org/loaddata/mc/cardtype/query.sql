SELECT 
	e.name AS descr, COUNT(1) AS num 
FROM cc_contract t 
INNER JOIN cc_cardtype e ON e.code = get_arr_value(t.relatedetail,3) 
WHERE t.createdate >= ${fld:fdate} AND t.createdate <= ${fld:tdate} 
AND t.contracttype = 0 AND (t.type = 0 OR t.type = 5) 
AND t.status >= 2 AND t.org_id = ${def:org} 
GROUP BY e.name 
ORDER BY COUNT(1) DESC