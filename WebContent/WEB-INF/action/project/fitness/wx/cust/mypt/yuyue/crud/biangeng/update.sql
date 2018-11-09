update  cc_ptprepare set 
  	preparetime= (${fld:hour} ||':'||${fld:minute})::time,
    created={ts '${def:timestamp}'},
	starttime=(${fld:hour} ||':'||${fld:minute})::time,
	endtime=	(select ((${fld:hour} ||':'||${fld:minute})::time+ (times||' minutes')::interval) from cc_ptdef 
						left join cc_ptrest on  cc_ptdef.code=cc_ptrest.ptlevelcode and cc_ptdef.org_id = cc_ptrest.org_id 
						left join cc_ptprepare on  cc_ptprepare.ptrestcode=cc_ptrest.code and cc_ptprepare.org_id = cc_ptrest.org_id 
						where cc_ptprepare.code = ${fld:code} and cc_ptprepare.org_id = ${def:org})
where
  code = ${fld:code} and org_id = ${def:org}
