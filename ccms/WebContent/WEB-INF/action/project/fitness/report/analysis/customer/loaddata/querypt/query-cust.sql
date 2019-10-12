SELECT 
	COUNT(1) AS custnum
FROM cc_customer c 
WHERE c.status != 0 AND c.org_id = ${def:org} 
AND EXISTS(
	SELECT 1 FROM cc_card d 
	WHERE c.code = d.customercode AND c.org_id = d.org_id 
	AND d.status != 0 AND d.status != 6
)
