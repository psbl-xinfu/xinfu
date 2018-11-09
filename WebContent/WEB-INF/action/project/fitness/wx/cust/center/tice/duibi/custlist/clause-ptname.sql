 and
 exists(
 			 	select 1 from cc_ptrest t
 			 	left join cc_ptprepare p  on p.ptrestcode=t.code and p.org_id=${def:org}
 			 	where p.code=ptpreparecode  and t.ptid=${fld:ptname} and t.org_id=${def:org}
 			 	)
