select 
	f.cardcode,
	(case when f.item=36 and cust.name is null
	then guest.name
	else cust.name
 end)  as  name,
	(case when f.item=36 and cust.mobile is null
	then guest.mobile
	else cust.mobile
 end)  as mobile,
	f.detail,
	f.premoney,
	f.money,
	f.moneyleft,
	f.remark,
	(select name from hr_staff where userlogin = f.salesman) as salesman,
	f.created
from cc_finance f
left join cc_customer cust on f.customercode = cust.code and f.org_id = cust.org_id
left join cc_guest guest on guest.code=f.customercode and f.org_id=guest.org_id
where f.org_id = ${def:org} and f.item=${fld:item} and f.type = ${fld:type}
${filter}
and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where hs.org_id = ${def:org} and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else f.salesman = '${def:user}' end)
and
	f.created::date >= ${fld:startdate}
and
	f.created::date <= ${fld:enddate}

${orderby}