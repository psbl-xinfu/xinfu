update cc_siteusedetail set 
	status=${fld:status},
	starttime=(select to_char('${def:timestamp}'::timestamp, 'HH24:MI')::time),
	openuser='${def:user}',
	opentime={ts '${def:timestamp}'}
where code=${fld:code} and ${fld:status}='2'
and org_id = ${def:org}

	
