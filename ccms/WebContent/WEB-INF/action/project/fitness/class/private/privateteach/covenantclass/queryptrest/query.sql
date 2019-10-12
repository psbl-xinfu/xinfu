select 
	pr.code,
	pd.ptlevelname,
	(pr.ptleftcount::int-(select count(1) from cc_ptprepare where ptrestcode = pr.code and status = 1 and org_id = ${def:org})) as ptleftcount,
	(case when pr.pttype = 5 and pd.reatetype=1 then (
			select staff.name from hr_staff staff 
			inner join cc_customer cust on staff.userlogin = cust.pt 
			where cust.code = pr.customercode and cust.org_id = pr.org_id) else
		 (select staff.name from hr_staff staff where staff.userlogin = pr.ptid)
		 end)
	 as staffname,
	pd.ptfee,
	(case when pr.ptenddate::date<'${def:date}'::date then '已过期' else '正常' end) as ptstatus
from cc_ptrest  pr
left join cc_ptdef pd on pr.ptlevelcode = pd.code and pr.org_id = pd.org_id
where pr.customercode = ${fld:custcode}
and pr.org_id = ${def:org} 
and (
	case when exists(
		select 1 from hr_staff_skill sk 
		inner join hr_skill k on sk.skill_id = k.skill_id 
		where sk.userlogin = '${def:user}' and k.data_limit = 1
	) then true else pr.ptid = '${def:user}' end
)
and (pr.ptleftcount::int-(select count(1) from cc_ptprepare where ptrestcode = pr.code and status = 1 and org_id = ${def:org}))>0