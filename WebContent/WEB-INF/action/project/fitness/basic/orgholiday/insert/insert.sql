insert into cc_label
(
    code,
    org_id,
    name,
    createdby,
    created
)
values 
(
	${seq:nextval@seq_cc_label},
	${def:org},
    ${fld:vc_lable},
    '${def:user}',
    {ts'${def:timestamp}'}
)
