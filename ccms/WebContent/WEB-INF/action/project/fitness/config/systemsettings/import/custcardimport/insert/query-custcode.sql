SELECT concat(COALESCE((SELECT memberhead FROM hr_org WHERE org_id =${def:org}),''),
	lpad(nextval('seq_cc_customer')::varchar, 8, '0')) AS custcode FROM dual
