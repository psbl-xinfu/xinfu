and
	(cust.name like concat('%', ${fld:searchpkvalue}, '%')
		or guest.name like concat('%', ${fld:searchpkvalue}, '%')
	)