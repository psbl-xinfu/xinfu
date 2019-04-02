insert into cc_guest_visit
(
	code,
	guestcode,
	visitdate,
	visittime,
	mc,
	status,
	posptid,
	createdby,
	created,
	org_id
)
values
(
	${seq:nextval@seq_cc_guest_visit},
	(case when ${fld:guest_code} is null then 
	'XG'||to_char({ts'${def:date}'},'yy')||lpad(${seq:currval@seq_cc_guest}::varchar, 6, '0')
	else ${fld:guest_code} end),
	'${def:date}',
	'${def:time}',
	--'${def:user}',
	${fld:cc_mc},--zzn190319
	1,
	${fld:posptid},
	'${def:user}',
	{ts'${def:timestamp}'},
	${def:org}
)
