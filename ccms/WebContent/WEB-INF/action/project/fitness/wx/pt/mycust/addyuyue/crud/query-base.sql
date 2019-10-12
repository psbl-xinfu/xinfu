SELECT  ptrest.code as ptcode,
        ptdef.ptlevelname,
        ptrest.ptleftcount
 FROM cc_ptrest ptrest
    LEFT JOIN cc_ptdef ptdef ON ptdef.code=ptrest.ptlevelcode and ptdef.org_id = ptrest.org_id 
 WHERE ptrest.customercode=${fld:customercode} and ptrest.org_id=${def:org} and ptdef.status=1
and ptrest.pttotalcount>0
and  (case when  '${def:user}' = (select pt from cc_customer where code=${fld:customercode} and org_id=${def:org}  )
then (ptrest.ptlevelcode =( select df.code from cc_ptdef df where df.org_id=ptrest.org_id and df.reatetype=1) or ptrest.ptid='${def:user}')
else ptrest.ptid='${def:user}'
end ) 
    
	