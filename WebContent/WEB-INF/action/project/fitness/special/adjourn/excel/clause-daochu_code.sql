and(
	card.code = ${fld:daochu_code}
		or  
		card.code in (select cardcode from cc_cardcode where incode = ${fld:daochu_code} and org_id = ${def:org})
	)