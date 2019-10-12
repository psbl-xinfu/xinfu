and 
	(
		con.code = ${fld:custall}
		or
		cust.name like concat('%', ${fld:custall}, '%')
		or
		cust.mobile like concat('%', ${fld:custall}, '%')
		or
		cust.code like concat('%', ${fld:custall}, '%')
	)
