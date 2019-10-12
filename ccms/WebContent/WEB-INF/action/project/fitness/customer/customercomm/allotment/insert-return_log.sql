insert into cc_return_log
(
	tuid,
    custtype,
	pk_value,
	followby,
	status,
	datatype,
	created,
	createdby,
	org_id
)
values 
(
	${seq:nextval@seq_cc_return_log},
	${fld:custtype},
    ${fld:pk_value},
    ${fld:mc},
    1,
    ${fld:codedatatype},
	{ts '${def:timestamp}'},
	'${def:user}',
	${def:org}
)