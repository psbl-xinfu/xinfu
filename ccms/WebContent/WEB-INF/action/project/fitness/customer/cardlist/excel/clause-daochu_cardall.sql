and
	(card.code like concat('%', ${fld:daochu_cardall}, '%')
		or cust.name like concat('%', ${fld:daochu_cardall}, '%')
		or cust.mobile like concat('%', ${fld:daochu_cardall}, '%')
		or
		card.code in (select cardcode from cc_cardcode where incode = ${fld:daochu_cardall} and org_id = ${def:org})
	)
