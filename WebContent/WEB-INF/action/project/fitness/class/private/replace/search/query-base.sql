select
	pr.code,
  cu.name,
	cu.mobile,
   ( select ptlevelname from cc_ptdef where code=(select ptlevelcode from cc_ptrest where code=pr.ylptrestcode)) as ylptdef ,
	 ( select ptlevelname from cc_ptdef where code=(select ptlevelcode from cc_ptrest where code=pr.xzptrestcode)) as xzptdef,
  pr.replacecount,
	pr.ptmoney,
  pr.ptfee,
 (select name from hr_staff where userlogin =  pr.ptid) as stname,
  pr.createdby,
  pr.created,
  pr.remark
	from cc_ptrest_replace pr
	LEFT JOIN cc_customer cu on cu.code=pr.customercode
where pr.org_id=${def:org}
${filter} 

order by pr.created desc
