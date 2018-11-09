insert into cc_cardtype_storage_discount
(
   cardtype,
   storage,
   discount,
   org_id
)
values 
(
	${fld:vc_code},
    ${fld:storage},
    ${fld:discount},
	${def:org}
)
