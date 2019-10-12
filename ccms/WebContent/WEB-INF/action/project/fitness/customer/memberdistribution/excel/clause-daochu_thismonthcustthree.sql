and 
	--判断本月最后一条分配记录是否已跟进
	(select count(1) from cc_comm where status = 1 and pk_value = 
	(select code from cc_mcchange where customercode = r.code 
	and status = 1 and org_id = ${def:org} 
	and to_char(created, 'yyyy-MM') = to_char('${def:date}'::date, 'yyyy-MM') 
	order by created desc limit 1)
	and cust_type=1 and org_id = ${def:org})=0
and --本月是否有分配记录
	(select count(1) from cc_mcchange where customercode = r.code 
	and status = 1 and org_id = ${def:org}
	and to_char(created, 'yyyy-MM') = to_char('${def:date}'::date, 'yyyy-MM') )>0