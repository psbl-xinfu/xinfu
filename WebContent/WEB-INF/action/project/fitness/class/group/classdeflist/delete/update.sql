update cc_classlist
set
	status=0
where code = ${fld:code} and org_id= ${def:org}
and status = 1








