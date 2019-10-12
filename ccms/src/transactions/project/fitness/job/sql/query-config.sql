SELECT 
	c.tuid,
	c.param_value,
	c.param_text 
FROM cc_config c 
WHERE c.category = '${category}' 
AND c.org_id = (
	CASE WHEN NOT EXISTS(SELECT 1 FROM cc_config c2 WHERE c.category = c2.category AND c2.org_id = ${fld:org_id}) 
	THEN (SELECT org_id FROM hr_org WHERE pid IS NULL OR pid = 0) ELSE ${fld:org_id} END
) 
