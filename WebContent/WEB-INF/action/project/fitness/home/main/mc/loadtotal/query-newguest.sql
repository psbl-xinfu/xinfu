SELECT COUNT(1) AS newguestnum  
FROM cc_guest g 
WHERE g.mc = '${def:user}' AND g.org_id = ${def:org} 
AND g.status != 0 AND EXISTS(
	SELECT 1 FROM cc_mcchange m 
	WHERE g.code = m.guestcode AND g.org_id = m.org_id 
	AND to_char(m.created,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 
	AND m.newmc = g.mc AND m.status != 0 
) 
