SELECT 
	a.classdate AS c_idate,	-- 日期
	COUNT(1) AS br_num	-- BR名单数
FROM cc_classlist a 
INNER JOIN cc_classprepare b ON a.code = b.classlistcode and a.org_id = b.org_id 
INNER JOIN cc_card c ON b.cardcode = c.code AND c.isgoon = 0 and b.org_id = c.org_id
INNER JOIN cc_guest_visit d ON c.customercode = (SELECT r.customercode FROM cc_contract r WHERE r.code = d.contractcode and r.org_id = d.org_id) 
INNER JOIN cc_guest e ON d.guestcode = e.code and d.org_id = e.org_id
WHERE to_char(a.classdate, 'yyyy-MM') = ${fld:month} AND a.status != 0 AND e.type = 0 
and (case when ${fld:org_id} is null then a.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE f.userlogin = '${def:user}' AND so.org_id = g.org_id)) else a.org_id =${fld:org_id} end)
GROUP BY a.classdate