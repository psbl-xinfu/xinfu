SELECT 
	COALESCE((
		SELECT d.domain_text_cn 
		FROM t_domain d 
		WHERE d.namespace = 'CommFailResaon' AND d.domain_value = m.failreason 
		LIMIT 1
	),'未知') AS domain_text_cn, count(1) AS num 
FROM cc_comm m 
WHERE m.created::date >= ${fld:fdate} AND m.created::date <= ${fld:tdate} 
AND m.org_id = ${def:org} 
AND m.commtarget = 1 AND m.commresult != 3 AND m.status != 0 
GROUP BY m.failreason 
		