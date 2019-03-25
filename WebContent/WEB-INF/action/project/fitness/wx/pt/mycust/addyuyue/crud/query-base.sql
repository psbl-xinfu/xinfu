SELECT  ptdef.code as ptcode,
        ptdef.ptlevelname,
        ptrest.ptleftcount
 FROM cc_ptrest ptrest
    LEFT JOIN cc_ptdef ptdef ON ptdef.code=ptrest.ptlevelcode and ptdef.org_id = ptrest.org_id 
 WHERE ptrest.customercode=${fld:customercode} and ptrest.org_id=${def:org} and ptdef.status=1
      and (case when ptdef.reatetype=1 then 1=1 else ptrest.ptid='${def:user}' end)
    
    
	