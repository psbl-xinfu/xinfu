and 
	--判断本月最后一条分配分配记录是否已跟进
	(select count(1) from cc_comm where status = 1 and pk_value = 
		(select code from cc_mcchange where guestcode = g.code 
		and status = 1 and org_id = ${def:org} 
		and to_char(created, 'yyyy-MM') = to_char('${def:date}'::date, 'yyyy-MM') 
		order by created desc limit 1)
		and cust_type=0 and org_id = ${def:org})=0
and		--判断是否有分配记录
	(select count(1) from cc_mcchange where guestcode = g.code 
		and to_char(created, 'yyyy-MM') = to_char('${def:date}'::date, 'yyyy-MM') 
		and status = 1 and org_id = ${def:org})>0
		