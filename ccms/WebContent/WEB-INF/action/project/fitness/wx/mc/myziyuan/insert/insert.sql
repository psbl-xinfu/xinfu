insert into cc_guest
(
    code,
	name,
	sex,
	mobile,
	type,
	created,
	org_id,
	updated,
	level,
	remark,
	initmc,
	age,
	mc
)
values 
(
	'XG'||to_char({ts'${def:date}'},'yy')||lpad(${seq:nextval@seq_cc_guest}::varchar, 6, '0'),
    ${fld:name},
	${fld:sex},
	${fld:mobile},
	${fld:type},
	{ts '${def:timestamp}'},
	${def:org},
	{ts '${def:timestamp}'},
	${fld:level},
	${fld:remark},
	'${def:user}',
	${fld:age},
	'${def:user}'
)
