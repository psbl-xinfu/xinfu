update cc_losscard set 
	status=2,
	enddate ={ts'${def:timestamp}'}, 
	updatedby = '${def:user}',
	updated = {ts'${def:timestamp}'},
	remark = ${fld:remark}
where
	code = ${fld:vc_code} and org_id = ${def:org} 
