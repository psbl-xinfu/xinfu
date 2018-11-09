SELECT 
	m.code,
	m.guestcode,
	m.customercode,
	COALESCE((CASE WHEN m.customercode IS NOT NULL AND m.customercode != '' THEN c.name ELSE g.name END),'未知') AS name,
	COALESCE((CASE WHEN m.customercode IS NOT NULL AND m.customercode != '' THEN c.mobile ELSE g.mobile END),'无') AS contactphone,
	m.nexttime,
	m.remark 
FROM cc_comm m 
LEFT JOIN cc_guest g ON g.code = m.guestcode AND g.org_id = m.org_id 
LEFT JOIN cc_customer c ON c.code = m.customercode AND c.org_id = m.org_id 
WHERE {d '${def:date}'} = m.nexttime::date AND m.createdby = '${def:user}' AND m.org_id = ${def:org} 
AND m.commresult = 1 AND m.status != 0 
ORDER BY m.nexttime
