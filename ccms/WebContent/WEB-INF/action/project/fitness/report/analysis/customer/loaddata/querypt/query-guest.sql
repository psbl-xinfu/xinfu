SELECT 
	COUNT(1) AS guestnum
FROM cc_customer c 
WHERE c.status != 0 AND c.org_id = ${def:org} 
AND EXISTS(
	SELECT 1 FROM cc_card d 
	WHERE c.code = d.customercode AND c.org_id = d.org_id 
	AND d.status != 0 AND d.status != 6
) 
AND NOT EXISTS(
	SELECT 1 FROM cc_ptrest t 
	WHERE c.code = t.customercode AND c.org_id = t.org_id 
	AND t.ptleftcount > 0 AND t.pttype != 5
)
