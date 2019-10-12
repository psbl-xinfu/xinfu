and(
	card.code = ${fld:code}
	or  
		card.code in (select cardcode from cc_cardcode where incode = ${fld:code} and org_id = ${def:org})
	)