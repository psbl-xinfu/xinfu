insert into cc_ptdef_discount
(
    code,
    ptdefcode,
    startcount,
    endcount,
    reate,
    org_id
)
values 
(
	${seq:nextval@seq_cc_ptdef_discount},
	${seq:currval@seq_cc_ptdef},
    ${fld:startcount},
    ${fld:endcount},
    ${fld:reate},
    ${def:org}
)
