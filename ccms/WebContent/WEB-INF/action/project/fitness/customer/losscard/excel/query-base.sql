select
	card.code,
	(select name from cc_cardtype where code = card.cardtype and org_id = ${def:org}) as cardtype,
	cust.name,
	(case when (select count(1) from cc_fillcard where cardcode = lc.cardcode and org_id = ${def:org}
		and created>lc.startdate)=1 then '已补卡'
		else (case when lc.status=1 then '挂失中' when lc.status=2 then '挂失中' end)
	end) as status,
	lc.startdate,
	(case when (select count(1) from cc_fillcard where cardcode = lc.cardcode and org_id = ${def:org}
		and created>lc.startdate)=1 then (select created from cc_fillcard where cardcode = lc.cardcode and org_id = ${def:org}
		and created>lc.startdate)
		else lc.enddate end) as enddate,
	staff.name as staff_name,
	lc.created,
	lc.remark
from cc_losscard lc
left join hr_staff staff on staff.userlogin = lc.createdby 
left join cc_customer cust on lc.customercode = cust.code and lc.org_id = cust.org_id
left join cc_card card on lc.cardcode = card.code and lc.org_id = card.org_id
where 1=1 and card.isgoon = 0 and lc.org_id = ${def:org}
${filter} 
order by lc.startdate desc
