and
	(card.code like concat('%', ${fld:daochu_cardall}, '%')
		or cust.name like concat('%', ${fld:daochu_cardall}, '%')
		or cust.mobile like concat('%', ${fld:daochu_cardall}, '%')
	)
