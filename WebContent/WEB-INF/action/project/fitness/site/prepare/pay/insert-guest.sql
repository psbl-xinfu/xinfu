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
		${seq:nextval@seq_cc_guest},
		${fld:customername},
		${fld:mobile},
		'${def:user}',
		'${def:timestamp}',
		${def:org}
	from dual 
	where ${fld:customertype}='3'
)
