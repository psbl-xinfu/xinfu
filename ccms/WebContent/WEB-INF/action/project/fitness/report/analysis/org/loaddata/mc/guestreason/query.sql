SELECT descr, COUNT(1) AS num FROM (
	SELECT 
		COALESCE((
			SELECT 
				(
					SELECT d.domain_text_cn 
					FROM t_domain d 
					WHERE d.namespace = 'CommFailResaon' AND d.domain_value = m.failreason 
					LIMIT 1
				) 
			FROM cc_comm m 
			WHERE m.guestcode = g.code AND m.org_id = g.org_id AND m.status != 0 
			ORDER BY m.created DESC LIMIT 1
		),'未知') AS descr,
		g.code,
		g.org_id
	FROM cc_guest g 
	WHERE g.created::date >= ${fld:fdate} AND g.created::date <= ${fld:tdate} 
	AND g.status != 0 AND g.status != 99 AND g.org_id = ${def:org}
) AS tp GROUP BY descr