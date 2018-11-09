SELECT 
	(case when c.name is null or c.name='' then '未知' else c.name end) as name,
	(case when c.mobile is null or c.mobile='' then '未知' else c.mobile end) as mobile,
	(select t.tuid from t_attachment_files t where t.pk_value = c.code and t.table_code = 'cc_customer' and t.org_id= ${def:org} order by t.tuid desc limit 1) as imgid
FROM cc_customer c 
WHERE EXISTS(
	SELECT 1 FROM cc_card d 
	WHERE c.code = d.customercode AND d.org_id = c.org_id 
	AND d.isgoon = 0 AND d.status != 0 AND d.status != 6
) AND NOT EXISTS(
	SELECT 1 FROM cc_ptrest t 
	INNER JOIN cc_ptdef f ON f.code = t.ptlevelcode AND f.org_id = t.org_id 
	WHERE c.code = t.customercode AND c.org_id = t.org_id 
	AND f.reatetype = 0 AND t.ptleftcount > 0 
) AND c.org_id = ${def:org}
and exists(
	select 1 from cc_ptchange pc 
	where pc.ptid = (
		select e.ptid from cc_ptchange e where e.customercode = pc.customercode and e.org_id = pc.org_id 
		and e.status > 0
		order by e.created desc LIMIT 1
	) and pc.ptid = '${def:user}' and pc.org_id = ${def:org}
	and pc.customercode = c.code
)