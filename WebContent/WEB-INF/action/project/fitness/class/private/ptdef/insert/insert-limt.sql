insert into cc_ptdef_limit
(
    code,
    ptdefcode,
    pt,
    createdby,
    created,
    org_id
)
values 
(
	${seq:nextval@seq_cc_ptdef_limit},
	${seq:currval@seq_cc_ptdef},
    ${fld:pt},
	'${def:user}',
	'${def:timestamp}',
    ${def:org}
)
