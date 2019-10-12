SELECT 
	(
		SELECT COUNT(1) FROM cc_comm g 
		WHERE to_char(g.created,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 
		AND g.operatortype = 0 AND g.createdby = '${def:user}' AND g.org_id = ${def:org} 
		AND g.status != 0 
	) AS guestnum
	,(
		select 
			count(1)
		from cc_inleft 
		where org_id = ${def:org} 
		and to_char(indate,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 
	) AS visitnum
	,(
		select 
			count(1) 
		from cc_contract 
		where org_id = ${def:org} and type = 0 and status!=0
		and to_char(createdate,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 
	) as newcustnum --新增会员
	,(
		select 
			count(1) 
		from cc_guest 
		where org_id = ${def:org} 
		and to_char(created,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 
	) as newguestnum --新增资源
FROM dual