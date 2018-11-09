insert into cc_cabinettemp_group
(
    tuid,
    groupname,
	groupcode,
	org_id
)
values 
(
	${seq:nextval@seq_cc_cabinettemp_group},
     ${fld:groupname},
    ${fld:groupcode},
    ${def:org}
)
