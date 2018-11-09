SELECT 
	COALESCE((
		SELECT d.param_text FROM cc_config d 
		WHERE d.category = 'GuestType' AND d.param_value = g.type::varchar LIMIT 1
	),'未知') AS descr, 
	count(1) AS num 
FROM cc_contract t 
INNER JOIN cc_customer c ON c.code = t.customercode AND c.org_id = t.org_id 
INNER JOIN cc_guest g ON g.code = c.guestcode AND g.org_id = c.org_id 
WHERE t.createdate >= ${fld:fdate} AND t.createdate <= ${fld:tdate} 
AND t.contracttype = 0 AND (t.type = 0 OR t.type = 5) 
AND t.status >= 2 AND t.org_id = ${def:org} 
GROUP BY g.type
