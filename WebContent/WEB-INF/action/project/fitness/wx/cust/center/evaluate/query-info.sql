select
starttime,
endtime,
preparedate,
(select name from  hr_staff where userlogin=ptid  and org_id=${def:org}) as ptname,

(SELECT ptdef.ptlevelname
 FROM cc_ptrest ptrest
 LEFT JOIN cc_ptdef ptdef ON ptdef.code=ptrest.ptlevelcode  and ptdef.org_id=${def:org} 
 where ptrest.code=${fld:ptrestcode}  and ptrest.org_id=${def:org}
 ) as ptlevelname,
 customercode,
 ptid
from
cc_ptprepare
where
code=
(select preparecode from  cc_ptlog where  ptrestcode=${fld:ptrestcode} and  cc_ptlog.org_id=${def:org}  
	and customercode=
				(select code from cc_customer where mobile=
					(select mobile  from hr_staff where userlogin='${def:user}' and hr_staff.org_id=${def:org})
					and cc_customer.org_id=${def:org}
				)
order by 	code desc)
and org_id=${def:org}