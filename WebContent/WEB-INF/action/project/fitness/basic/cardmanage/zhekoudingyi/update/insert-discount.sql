insert into cc_cardtype_storage_discount(
	cardtype,
	storage,
	discount,
	org_id
) values(
	${fld:in_vc_code},
	${fld:vc_storage},
	(
		case when ${fld:f_discount} is not null and ${fld:f_discount} != '' 
		then ${fld:f_discount}::numeric(10,2)/100.00 else null end
	)::numeric(10,2),
	${def:org}
)
