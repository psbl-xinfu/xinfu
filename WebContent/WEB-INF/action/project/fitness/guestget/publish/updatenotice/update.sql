update cc_hkb_notice
set title = ${fld:title},
	content = ${fld:content},
	level = ${fld:level},
	status = ${fld:status},
	updatedby = '${def:user}',
	updated = {ts '${def:timestamp}'}
where tuid = ${fld:tuid} and org_id = ${def:org}

