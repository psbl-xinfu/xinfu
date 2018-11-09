update et_resource 
set 
	status = 0,
	updated = {ts '${def:timestamp}'},
	updatedby = '${def:user}' 
where fileid = ${fld:fileid}
