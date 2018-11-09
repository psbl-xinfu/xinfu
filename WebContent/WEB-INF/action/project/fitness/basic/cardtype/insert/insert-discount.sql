insert into cc_cardtype_storage_discount
(
   cardtype,
   storage,
   discount,
   org_id
)
values 
(
	${seq:currval@seq_cc_cardtype},
    ${fld:storage},
   ${fld:discount},
	${def:org}
)
