SELECT 
	(
		SELECT COUNT(1) FROM cc_customer c 
		WHERE c.sex = 0 AND c.status != 0 AND c.org_id = ${def:org} 
		AND EXISTS(
			SELECT 1 FROM cc_card d 
			WHERE c.code = d.customercode AND c.org_id = d.org_id 
			AND d.status != 0 AND d.status != 6
		) 
	) AS femalenum
	,(
		SELECT COUNT(1) FROM cc_customer c 
		WHERE c.sex = 1 AND c.status != 0 AND c.org_id = ${def:org} 
		AND EXISTS(
			SELECT 1 FROM cc_card d 
			WHERE c.code = d.customercode AND c.org_id = d.org_id 
			AND d.status != 0 AND d.status != 6
		) 
	) AS malenum
	,(
		SELECT COUNT(1) FROM cc_customer c 
		WHERE (c.sex IS NULL OR (c.sex != 0 AND c.sex != 1)) AND c.status != 0 AND c.org_id = ${def:org} 
		AND EXISTS(
			SELECT 1 FROM cc_card d 
			WHERE c.code = d.customercode AND c.org_id = d.org_id 
			AND d.status != 0 AND d.status != 6
		) 
	) AS unkownnum 
FROM dual