SELECT 
	t.domain_text_cn AS descr, count(1) AS num 
FROM cc_comm m 
LEFT JOIN t_domain t ON m.failreason = t.domain_value AND t.namespace = 'CommFailResaon' 
WHERE m.operatortype = 1 AND m.org_id = ${def:org} 
AND m.failreason IS NOT NULL AND m.failreason != '' AND m.status != 0 
and m.created::date >= ${fld:fdate} AND m.created::date <= ${fld:tdate} 
GROUP BY t.domain_text_cn
