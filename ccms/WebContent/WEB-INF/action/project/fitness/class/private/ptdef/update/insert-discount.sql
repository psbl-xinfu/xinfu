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
	${fld:code},
    ${fld:startcount},
    ${fld:endcount},
    ${fld:reate},
    ${def:org}
)
