and
	(card.code like concat('%', ${fld:cardall}, '%')
		or cust.name like concat('%', ${fld:cardall}, '%')
		or cust.mobile like concat('%', ${fld:cardall}, '%')
	)
