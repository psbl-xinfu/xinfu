insert into cc_site_timelimit
(
    code,
    sitecode,
    limittime,
    choose_way,
    createdby,
    created,
    org_id
)
values 
(
	${seq:nextval@seq_cc_site_timelimit},
    ${fld:sitecode},
    ${fld:sitecheckbox},
    ${fld:choose_way},
	'${def:user}',
	{ts '${def:timestamp}'},
    '${def:org}'
)
