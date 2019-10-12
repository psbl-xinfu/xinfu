select
	cust.name,
	cust.mobile,
	p.ptlevelname,
	(select name from hr_staff where userlogin = pr.ptid) as ptid,-- 私教
	pr.ptenddate,--结束日期
	(select sum(delayday) from cc_ptrest_delay where ptrestcode=pr.code and org_id = pr.org_id) as delayday --已延期天数
from cc_ptrest pr 
left join cc_customer cust on pr.customercode = cust.code and pr.org_id = cust.org_id
left join cc_ptdef p on p.code = pr.ptlevelcode and p.org_id = pr.org_id
where pr.org_id = ${def:org} and pr.code = ${fld:code}
