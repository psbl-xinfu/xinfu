update cc_hkb_faq
set title = ${fld:title},
	content = ${fld:content},
	status = ${fld:status},
	updatedby = '${def:user}',
	updated = {ts '${def:timestamp}'}
where tuid = ${fld:tuid} and org_id = ${def:org}
