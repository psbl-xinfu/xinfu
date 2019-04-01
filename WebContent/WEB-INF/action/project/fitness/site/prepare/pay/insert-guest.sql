insert into cc_guest
(
	code,
	name,
	mobile,
	createdby,--
	created,--
	org_id
)

(
	select 
		'XG'||to_char({ts'${def:date}'},'yy')||lpad(${seq:nextval@seq_cc_guest}::varchar, 6, '0'),
		${fld:customername},
		${fld:mobile},
		'${def:user}',
		'${def:timestamp}',
		${def:org}
	from dual 
	where ${fld:customertype}='3'
)
