SELECT  ptdef.code,
        ptdef.ptlevelname
 FROM cc_ptrest ptrest
    LEFT JOIN cc_ptdef ptdef ON ptdef.code=ptrest.ptlevelcode and ptdef.org_id = ptrest.org_id 
 WHERE ptrest.customercode=${fld:customercode} and ptrest.org_id=${def:org} and ptdef.status=1
       and ptrest.ptid='${def:user}'
     
    
    
	