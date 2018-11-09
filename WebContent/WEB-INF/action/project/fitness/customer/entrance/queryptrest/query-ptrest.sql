select 
	pttotalcount::int,
	ptleftcount::int,
	(
		case when cc_ptrest.pttype = 5 then (
			select staff.name from hr_staff staff 
			inner join cc_customer cust on staff.userlogin = cust.pt 
			where cust.code = cc_ptrest.customercode and cust.org_id = cc_ptrest.org_id 
		)
		else (select staff.name from hr_staff staff where staff.userlogin = cc_ptrest.ptid) end
	) as name,
	(select ptlevelname from cc_ptdef where code = ptlevelcode 
		and org_id = ${fld:unionorgid}) as ptlevelname,
	(select count(1) from cc_ptlog where ptrestcode = cc_ptrest.code 
		and customercode = ${fld:custall} and org_id = ${fld:unionorgid}) as num
from cc_ptrest
where pttype in (1,3,4,5) and (ptenddate::date>='${def:date}'::date or ptenddate is null)
and org_id = ${fld:unionorgid} and customercode = ${fld:custall}

