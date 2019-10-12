insert into cc_guest
(
	code,
	type,
	sex,
	name,
	mobile,
	age, --zzn190319
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
		0,--zzn190319
		${def:org},
		{ts '${def:timestamp}'},
		${fld:cc_mc}
	from dual where ${fld:guest_code} is null
)
