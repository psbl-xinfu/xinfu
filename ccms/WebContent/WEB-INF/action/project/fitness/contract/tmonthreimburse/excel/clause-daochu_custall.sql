and 
	(
		con.code = ${fld:daochu_custall}
		or
		cust.name like concat('%', ${fld:daochu_custall}, '%')
		or
		cust.mobile like concat('%', ${fld:daochu_custall}, '%')
		or
		cust.code like concat('%', ${fld:daochu_custall}, '%')
	)
