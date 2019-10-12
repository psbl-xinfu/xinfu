update cc_trainplan
set 
	status = 2
where code = ${fld:code} and org_id = ${def:org}
