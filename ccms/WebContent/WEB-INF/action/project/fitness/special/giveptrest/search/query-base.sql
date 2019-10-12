with giveclass as(
	select 
		get_arr_value(relatedetail, 7) as ptrest_code,
		get_arr_value(relatedetail, 4) as pt_name,
		remark
	from cc_operatelog 
	where opertype = '41' and get_arr_value(relatedetail, 7) !='' and org_id = ${def:org}
)
select 
	cust.code as cust_code,
	cust.name as cust_name,
	p.pttotalcount::integer,
	(select ptlevelname from cc_ptdef where cc_ptdef.code=p.ptlevelcode and cc_ptdef.org_id = ${def:org}) as ptlevelname,
	(select h.name from hr_staff h where h.userlogin=
	(select (case when pd.reatetype=1 then cust.pt else p.ptid end)
	 from cc_ptdef pd where  pd.code=p.ptlevelcode and pd.org_id=${def:org}
	)) as pt_name,
	p.scale,
	(select h.name from hr_staff h where h.userlogin=p.createdby) as staff_name,
	p.created,
	g.remark,
	p.ptnormalmoney,
	p.ptmoney
from cc_ptrest p
left join cc_customer cust on p.customercode = cust.code and p.org_id = cust.org_id
inner join giveclass g on g.ptrest_code=p.code
where 1=1 and p.org_id = ${def:org}
${filter}
${orderby}

