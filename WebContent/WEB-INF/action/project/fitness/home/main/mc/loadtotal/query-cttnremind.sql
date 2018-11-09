SELECT COUNT(1) AS cttnremindnum 
FROM cc_customer c 
WHERE c.mc = '${def:user}' 
AND to_char({ts '${def:timestamp}'},'yyyy-MM') = to_char((
	SELECT max(d.enddate) FROM cc_card d 
	WHERE c.code = d.customercode AND c.org_id = d.org_id AND status != 0 
),'yyyy-MM') 
AND NOT EXISTS(
	SELECT 1 FROM cc_card d 
	WHERE c.code = d.customercode AND c.org_id = d.org_id AND isgoon = 0 
)
