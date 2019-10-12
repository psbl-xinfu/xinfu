SELECT p.createdate, p.customercode, 1::integer AS num 
FROM cc_customer c 
INNER JOIN (
	SELECT min(t.createdate)::date AS createdate, t.customercode 
	FROM cc_contract t 
	WHERE t.createdate >= ${fld:fdate} AND t.createdate <= ${fld:tdate} 
	AND t.type = 2 AND t.contracttype = 0 AND t.status >= 2 AND t.org_id = ${def:org} 
	GROUP BY t.customercode
) AS p ON c.code = p.customercode 
WHERE c.org_id = ${def:org}
