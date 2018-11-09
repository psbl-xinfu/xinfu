select
	concat('<input type="checkbox" class="publiccode" name="publiccode" value="', p.tuid, '" code="', p.datatype, '">') as application_id,
	(case when p.datatype=1 then '资源' else '会员' end) as datatype,
	(case when p.datatype=1 then p.guestcode else p.customercode end) as gc_code,
	p.entertime,
	(select name from hr_staff where userlogin = p.oldfollow and org_id = ${def:org}) as staff_name,
	p.grabtime,
	p.reason,
	p.remark
FROM cc_public p
left join cc_customer cust on p.customercode = cust.code and p.org_id = cust.org_id
left join cc_guest g on p.guestcode = g.code and p.org_id = g.org_id
where p.org_id = ${def:org} and p.status = 0
${filter}


${orderby}