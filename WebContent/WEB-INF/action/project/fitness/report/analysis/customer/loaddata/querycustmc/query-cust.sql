SELECT 
	(
		SELECT COUNT(1) FROM cc_guest 
		WHERE org_id = ${def:org} AND status != 0 AND status != 99
		and created::date>=${fld:fdate} and created::date<=${fld:tdate}
	) AS guestnum
	,(
		SELECT COUNT(1) FROM cc_customer c 
		WHERE c.status != 0 AND c.org_id = ${def:org} 
		and c.created::date>=${fld:fdate} and c.created::date<=${fld:tdate}
		AND EXISTS(
			SELECT 1 FROM cc_card d 
			WHERE c.code = d.customercode AND c.org_id = d.org_id 
			AND d.status != 0 AND d.status != 6
		)
	) AS custnum
	,(
		SELECT COUNT(1) FROM cc_customer c 
		WHERE c.status != 0 AND c.org_id = ${def:org} 
		and c.created::date>=${fld:fdate} and c.created::date<=${fld:tdate}
		AND NOT EXISTS(
			SELECT 1 FROM cc_card d 
			WHERE c.code = d.customercode AND c.org_id = d.org_id 
			AND d.status != 0 AND d.status != 6
		)
	) AS expirecustnum 
FROM dual