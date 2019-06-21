select 
	pr.code,
	pd.ptlevelname,
	pr.ptleftcount,
	(
		case when pr.pttype != 5 then (select staff.name from hr_staff staff where staff.userlogin = pr.ptid) 
		else (
			select staff.name from hr_staff staff 
			inner join cc_customer c on staff.userlogin = c.pt
			where c.code = pr.customercode and c.org_id = pr.org_id
		) end
	) as staffname,
	pd.ptfee,
	(case when pr.ptenddate::date<'${def:date}'::date then '已过期' else '正常' end) as ptstatus
from cc_ptrest  pr
left join cc_ptdef pd on pr.ptlevelcode = pd.code and pr.org_id = pd.org_id
where 
	pr.customercode = (select customercode from cc_ptprepare where code = ${fld:id})
	and pr.org_id = ${def:org}