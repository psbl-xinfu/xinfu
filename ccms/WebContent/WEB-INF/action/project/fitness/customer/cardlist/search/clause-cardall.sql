and
	(card.code like concat('%', ${fld:cardall}, '%')
		or cust.name like concat('%', ${fld:cardall}, '%')
		or cust.mobile like concat('%', ${fld:cardall}, '%')
		or
		card.code in (select cardcode from cc_cardcode where incode = ${fld:cardall} and org_id = ${def:org})
	)
