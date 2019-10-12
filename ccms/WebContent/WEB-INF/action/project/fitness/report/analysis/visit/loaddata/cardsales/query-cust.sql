SELECT 
	(
		SELECT COUNT(1) FROM cc_guest 
		WHERE org_id = ${def:org} AND status != 0 AND status != 99
	) AS guestnum
	,(
		SELECT COUNT(1) FROM cc_customer c 
		WHERE c.status != 0 AND c.org_id = ${def:org} 
		AND EXISTS(
			SELECT 1 FROM cc_card d 
			WHERE c.code = d.customercode AND c.org_id = d.org_id 
			AND d.status != 0 AND d.status != 6
		)
	) AS custnum
	,(
		SELECT COUNT(1) FROM cc_customer c 
		WHERE c.status != 0 AND c.org_id = ${def:org} 
		AND NOT EXISTS(
			SELECT 1 FROM cc_card d 
			WHERE c.code = d.customercode AND c.org_id = d.org_id 
			AND d.status != 0 AND d.status != 6
		)
	) AS expirecustnum 
FROM dual