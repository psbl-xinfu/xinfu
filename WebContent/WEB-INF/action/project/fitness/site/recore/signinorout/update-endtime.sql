update cc_siteusedetail set 
	status=${fld:status},
	endtime=(select to_char('${def:timestamp}'::timestamp, 'HH24:MI')::time),
	times=((select to_char(((select to_char('${def:timestamp}'::timestamp, 'HH24:MI')::time)
		-starttime::time), 'HH'))::integer*60),
	closeuser='${def:user}',
	closetime={ts '${def:timestamp}'}
where code=${fld:code} and ${fld:status}='3'
and org_id = ${def:org}

	
