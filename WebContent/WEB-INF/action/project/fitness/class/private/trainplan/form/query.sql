select 
	concat(p.preparedate, ' ', p.preparetime) as preparedate,
	(select name from hr_staff where userlogin = r.ptid and org_id = ${def:org}) as staff_name,
	pd.ptlevelname,
	pd.times,
	pd.code as pdcode,
	r.ptid,
	p.customercode as vc_customercode
from cc_ptprepare p
LEFT JOIN cc_ptrest r ON p.ptrestcode = r.code and p.org_id = r.org_id
left join cc_ptdef pd on r.ptlevelcode = pd.code and r.org_id = pd.org_id
where p.code = ${fld:vc_ptpreparecode} and p.org_id = ${def:org}