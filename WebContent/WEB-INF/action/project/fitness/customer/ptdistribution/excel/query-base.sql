SELECT 
	(case when (${fld:daochu_period_day}::int-('${def:date}'::date -(select created from cc_ptchange where customercode = c.code and org_id = ${def:org} order by created desc limit 1)::date))<1 then 0 
 	else (${fld:daochu_period_day}::int-('${def:date}'::date -(select created from cc_ptchange where customercode = c.code and org_id = ${def:org} order by created desc limit 1)::date)) end) as num_days, --保护期
	(select staff.name from hr_staff staff where staff.userlogin=c.pt and staff.org_id = ${def:org}) as vc_pt,--私教
	(select staff.name from hr_staff staff where staff.userlogin=c.mc and staff.org_id = ${def:org}) as vc_mc,--会籍
	(select sum(ptleftcount)::int from cc_ptrest where customercode = c.code and org_id = ${def:org}) as ptleftcount,--剩余课时
	c.name,
	(case when c.sex=0 then '女' when c.sex=1 then '男' else '未知' end) as sex,
	c.mobile,
	(select created from cc_comm where customercode=c.code and cust_type='2' and org_id= ${def:org} order by created desc limit 1) as pt_date,-- 教练最后根据
	(select enddate from cc_card where customercode=c.code AND cc_card.isgoon = 0 and cc_card.status='1' and org_id = ${def:org} order by enddate limit 1) as member_end,--会员到期
	(select starttime from cc_ptlog where customercode=c.code and org_id = ${def:org} order by created desc limit 1) as come_date-- 最新到访   
FROM cc_customer c 
WHERE EXISTS(
	SELECT 1 FROM cc_card d 
	WHERE c.code = d.customercode AND d.isgoon = 0 AND d.org_id = c.org_id AND d.status != 0 AND d.status != 6
) 
AND EXISTS(
	SELECT 1 FROM cc_ptrest t 
	INNER JOIN cc_ptdef d ON d.code = t.ptlevelcode AND t.org_id = d.org_id 
	WHERE t.customercode = c.code AND t.ptleftcount > 0 AND d.reatetype = 1 AND t.org_id = c.org_id 
) 
AND c.org_id = ${def:org}
AND c.status != 0
and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else c.pt = '${def:user}' end)

${filter}
order by c.created desc

