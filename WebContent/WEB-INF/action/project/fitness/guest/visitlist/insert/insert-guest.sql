insert into cc_guest
(
	code,
	type,
	sex,
	name,
	mobile,
	org_id,
	created,
	mc
)
(
	select
		'XG'||to_char({ts'${def:date}'},'yy')||lpad(${seq:nextval@seq_cc_guest}::varchar, 6, '0'),
		${fld:cc_type},
		${fld:sex},
		${fld:guest},
		${fld:mobile},
		${def:org},
		{ts '${def:timestamp}'},
		${fld:cc_mc}
	from dual where ${fld:guest_code} is null
)
