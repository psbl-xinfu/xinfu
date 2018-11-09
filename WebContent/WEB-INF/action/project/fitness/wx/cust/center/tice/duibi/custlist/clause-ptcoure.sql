 and
 exists(
 			 	select 1 from cc_ptdef d 
 			 	left join cc_ptrest t  on d.code=t.ptlevelcode and t.org_id=${def:org}
 			 	left join cc_ptprepare p  on p.ptrestcode=t.code and p.org_id=${def:org}
 			 	where p.code=ptpreparecode
 			 	and d.code=${fld:ptcoure} and d.org_id=${def:org}
 			 	)
