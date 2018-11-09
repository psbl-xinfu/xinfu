select 
	p.code,
	p.contractcode,
	p.ptlevelcode,
	d.ptlevelname,
	p.ptid,
	p.ptleftcount,
	p.created::date as startdate,
	p.ptenddate,
	f.name as ptname,
	p.created,
	p.ptenddate 
from cc_ptrest p 
left join hr_staff f on f.userlogin = p.ptid and p.org_Id = f.org_id 
left join cc_ptdef d on d.code = p.ptlevelcode and d.org_id = p.org_id 
where p.customercode = ${fld:customercode} 
and p.ptleftcount > 0 and p.pttype != 5 
and p.org_id = ${def:org} 
