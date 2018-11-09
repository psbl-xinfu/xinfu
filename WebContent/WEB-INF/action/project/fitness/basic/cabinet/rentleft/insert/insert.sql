insert into cc_cabinet_group
(
    tuid,
    groupname,
	groupcode,
	org_id
)
values 
(
	${seq:nextval@seq_cc_cabinet_group},
     ${fld:groupname},
    ${fld:groupcode},
    ${def:org}
)
